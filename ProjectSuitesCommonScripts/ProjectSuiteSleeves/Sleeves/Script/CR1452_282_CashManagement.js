//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_281_CashManagement

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_282_CashManagement()
{
    try{              
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
        
        var account1= GetData(filePath_Sleeves, "DataPool_WithModel", 8); //800040-RE
        var account2= GetData(filePath_Sleeves, "DataPool_WithModel", 9); //800048-JW
        var account3= GetData(filePath_Sleeves, "DataPool_WithModel", 10); //800286-SF
        var cashMgmtCheck1= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_WinCashManagement_CashMgmtCheck1", language+client);
        var cashMgmtCheck2= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_WinCashManagement_CashMgmtCheck2", language+client);
        var cashMgmtCheck3= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_WinCashManagement_CashMgmtCheck3", language+client);
        var filter=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "filter_UnifiedManagedAccounts", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        // sélectionner plusieurs comptes UMA
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click()
        Get_SubMenus().WPFObject("ContextMenu", "", 1).Find("WPFControlText",filter).Click();
        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click();
        Get_RelationshipsClientsAccountsGrid().Find("Value",account2,10).Click(10,10,skCtrl);
        Get_RelationshipsClientsAccountsGrid().Find("Value",account3,10).Click(10,10,skCtrl);
        
        // cliquer sur 'Rééquilibrer' et sélectionner la méthode 'Rééquilibrer le compte'.
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click();
        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();
        
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
        //Les colonnes qui s'affichent à ce niveau
        
        CheckColumnsStep2WinCashManagement();   
        aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual, "3");
        aqObject.CheckProperty(Get_WinCashManagement_ChMargin().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_WinCashManagement_ChMargin", language+client)); 
                    
        ChangeCashMgmt(account1,cashMgmtCheck1)
        ChangeCashMgmt(account2,cashMgmtCheck2)
        ChangeCashMgmt(account3,cashMgmtCheck3)
        
        Get_WinCashManagement_BtnOk().Click();
        
        //Consulter la colonne 'Gest. encaisse' pour s'assurer qu'elle a été mise à jour
        CheckCashMgmt(account1,cashMgmtCheck1)
        CheckCashMgmt(account2,cashMgmtCheck2)
        CheckCashMgmt(account3,cashMgmtCheck3)
        
        //*****************************************************************CR1452_283*******************************************************************
        // avancer à l'étape suivante par la flèche en-bas 
        Get_WinRebalance_BtnNext().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_d123",40000); 
        
        CheckCashMgmtInDgvNavigator(account1,cashMgmtCheck1)
        CheckCashMgmtInDgvNavigator(account2,cashMgmtCheck2)
        CheckCashMgmtInDgvNavigator(account3,cashMgmtCheck3)
        
        Get_WinRebalance_BtnClose().Click();
        if (Get_DlgConfirmation().Exists) Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //if(Get_DlgWarning().Exists){ //CP : Changé pour CO
        //  var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //  Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
        //} //CP : Changé pour CO
        
        //Annuler le filtre
        Get_ModulesBar_BtnAccounts().Click(); 
        if(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists){
           var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
           Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13)
        } 
                 
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        //Annuler le filtre 
        if(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists){
           var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
           Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13)
        }         
    }
    finally {    
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function ChangeCashMgmt(account,cashMgmt)
{
    var count= Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Count;
    var found= false;
    var position;
    for (var i = 0; i < count; i++){    
       if(VarToString(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber)==VarToString(account)){
         position=Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItemIndex
         found=true;
         // Modification le 18/02/2020 suite au CR1990 la position de Gestion d'encaisse est devenu 5 au lieu de 4
          Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 5).Click()
          Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 5).WPFObject("XamNumericEditor", "", 1).Keys(cashMgmt)
     }
    }
    if(found==false){
      Log.Error("Le compte n’est pas dans la grille ")
    } 
    
}

function CheckCashMgmt(account,cashMgmt)
{
    var count= Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Items.Count;
    var found= false;
    for (var i = 0; i < count; i++){    
       if(VarToString(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber)==VarToString(account)){
        var checkCashMgmt=VarToString(Math.round(cashMgmt))
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "DepositWithdrawalAmount", cmpEqual, (Math.round(checkCashMgmt)));
        found=true;
     }
    }
    if(found==false){
      Log.Error("Le compte n’est pas dans la grille ")
    }
} 

function CheckCashMgmtInDgvNavigator(account,cashMgmt)
{
    var count= Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Items.Count;
    var found= false;
    for (var i = 0; i < count; i++){    
       if(VarToString(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber)==VarToString(account)){
        var checkCashMgmt=VarToString(Math.round(cashMgmt))
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "DepositWithdrawalAmount", cmpEqual, (Math.round(checkCashMgmt)));
        found=true;
     }
    }
    if(found==false){
      Log.Error("Le compte n’est pas dans la grille ")
    }
} 
