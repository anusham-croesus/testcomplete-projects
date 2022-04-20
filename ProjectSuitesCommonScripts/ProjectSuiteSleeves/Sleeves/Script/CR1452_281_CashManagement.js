//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_281_CashManagement()
{
    try{              
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
        
        var account1= GetData(filePath_Sleeves, "DataPool_WithModel", 3); //800045-FS
        var account2= GetData(filePath_Sleeves, "DataPool_WithModel", 4); //800291-GT
        var account3= GetData(filePath_Sleeves, "DataPool_WithModel", 5); //800022-HU
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
                  
        CheckAccountPresence(account1);
        CheckAccountPresence(account2);
        CheckAccountPresence(account3);
        
        Get_WinCashManagement_BtnOk().Click();
        Get_WinRebalance_BtnClose().Click();
        
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


function CheckColumnsStep2WinCashManagement(){
    Get_WinCashManagement().Parent.Maximize();
    aqObject.CheckProperty(Get_WinCashManagement_ChName().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_WinCashManagement_ChName", language+client));
    aqObject.CheckProperty(Get_WinCashManagement_ChAccountNo().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_WinCashManagement_ChAccountNo", language+client));
    aqObject.CheckProperty(Get_WinCashManagement_ChTotalValue().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_WinCashManagement_ChTotalValue", language+client));
    aqObject.CheckProperty(Get_WinCashManagement_ChCashMgmt().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_WinCashManagement_ChCashMgmt", language+client));
    aqObject.CheckProperty(Get_WinCashManagement_ChIACode().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_WinCashManagement_ChIACode", language+client));
    aqObject.CheckProperty(Get_WinCashManagement_ChCurrency().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_WinCashManagement_ChCurrency", language+client));
    aqObject.CheckProperty(Get_WinCashManagement_ChBalance().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_WinCashManagement_ChBalance", language+client));
} 

function CheckAccountPresence(account)
{
    var count= Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Count;
    var found= false;
    for (var i = 0; i < count-1; i++){    
       if(VarToString(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber)==VarToString(account)){
         found=true;
     }
    }
    return found;
}