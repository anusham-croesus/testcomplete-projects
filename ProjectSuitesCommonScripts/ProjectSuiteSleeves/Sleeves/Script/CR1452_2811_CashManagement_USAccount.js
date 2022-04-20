//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_282_CashManagement

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_2811_CashManagement_USAccount()
{
    try{              
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");       
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800049OB", language+client);
        var sleeveAdhoc1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveAdhoc1_2811", language+client);
        var targetAdhoc1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Target_Adhoc1", language+client);
        var sleeveAdhoc2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveAdhoc2_2811", language+client);
        var targetAdhoc2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Target_Adhoc2", language+client);
        var solde=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Solde1_2811", language+client);
        var modelAmericanEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelAmericanEqui", language+client);
        var modelUS=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "modelUSEQUI", language+client);
        var deposit=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Deposit_2811", language+client);
        var unallocated = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
        var balance=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Balance_USD", language+client);
        var message =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_2811", language+client);
        var sleeveMessage=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Sleeves_message_2811", language+client);
        
        Activate_Inactivate_Pref(user,"PREF_ENABLE_SUP_LOSS","NO",vServerSleeves);
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Execute_SQLQuery("delete from b_or_ou where no_compte = '"+account+"'", vServerSleeves) //EM : Requête fournit par Christine H. pour régler le prob de reéquilibrage rencontré. Selon Christine H. ce problème va être reglé avec le CR2160 car on aura la possibilité de multirééquilibrage avec multiuser
        RestartServices(vServerSleeves)  
        
		    Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //sélectionner un compte US
        Search_Account(account);        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();
        
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        Get_PortfolioBar_BtnSleeves().Click();        
        Get_WinManagerSleeves().Parent.Maximize();

        //Ajouter un segment  
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc1,"",targetAdhoc1,"","",modelAmericanEqui)  
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc2,"",targetAdhoc2,"","",modelUS)   
        
        //Transférer le sold
       DivideBalance(unallocated,balance,solde,sleeveAdhoc1) 
               
        //Transférer le sold
        DivideBalance(unallocated,balance,solde,sleeveAdhoc2)
               
        //Sauvgarder               
        Get_WinManagerSleeves_BtnSave().Click(); 
        Delay(1500);
                
        // cliquer sur 'Rééquilibrer' et sélectionner la méthode 'Rééquilibrer tous les segments '.
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click();
        
        // avancer à l'étape suivante par la flèche en-bas à droite .
        Get_WinRebalance_BtnNext().Click();
        
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();                  
        ChangeCashMgmt(sleeveAdhoc1,deposit,"portfolio");
        ChangeCashMgmt(sleeveAdhoc2,deposit,"portfolio");
        Get_WinCashManagement_BtnOk().Click();
        
        // avancer à l'étape suivante par la flèche en-bas à droite .
        Get_WinRebalance_BtnNext().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        //valider les message
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpContains, message);
        
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc1,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual, sleeveMessage);
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc2,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual, sleeveMessage);
        
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
        
        //Rééquilibrage d’un modèle   
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelUS);
        
        Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelUS,10).Click();
        Get_Toolbar_BtnRebalance().Click();
        
        // avancer à l'étape suivante par la flèche en-bas à droite .
        Get_WinRebalance_BtnNext().Click();
        
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();                  
        ChangeCashMgmt(sleeveAdhoc2,deposit,"model"); 
        Get_WinCashManagement_BtnOk().Click();
        // avancer à l'étape suivante par la flèche en-bas à droite .
        Get_WinRebalance_BtnNext().Click();
        Get_WinRebalance_BtnNext().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",sleeveAdhoc2,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpContains, sleeveMessage);
        
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
                
        //Restaurer les données
        //Supprimer des segments 
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account);        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();
        
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        Delete_AllSleeves_WinSleevesManager();
                
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account);        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();  
              
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        Delete_AllSleeves_WinSleevesManager();        
    }
    finally {    
      Terminate_CroesusProcess(); //Fermer Croesus
	  Activate_Inactivate_Pref(user,"PREF_ENABLE_SUP_LOSS","YES",vServerSleeves);
    }
}

function ChangeCashMgmt(sleeveDescription,cashMgmt, module)
{
    var count= Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Count;
    var found= false;
    var position;
    for (var i = 0; i < count; i++){   
      if(module=="model") {   
           if(VarToString(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SleeveName)==VarToString(sleeveDescription)){
             position=Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItemIndex
             found=true;
             //Modification suite au CR1990 le 18/02/2020 position 5 devenu 6 pour la gestion d'encaisse
              Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).Click()
              Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).WPFObject("XamNumericEditor", "", 1).Keys(cashMgmt)
              return;
          }
      } else{    
           if(VarToString(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description)==VarToString(sleeveDescription)){
             position=Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItemIndex
             found=true;
              Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).Click()
              Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).WPFObject("XamNumericEditor", "", 1).Keys(cashMgmt)
              return;
           }
      }
    }
    if(found==false){
      Log.Error("Le sleeve n’est pas dans la grille ")
    }     
}

function DivideBalance(unallocated,balance,solde,sleeveAdhoc){

    Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click(); 
    //Selectioner le solde
    Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",balance,10).Click();  
    Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();
    Get_WinMoveSecurities_GrpSecurities_DgvListView().Items.Item(0).set_QuantityToMove(solde)      
    Get_WinMoveSecurities_CmbToSleeve().Keys(sleeveAdhoc);                  
    Get_WinMoveSecurities().Click();
    Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
    Get_WinMoveSecurities_BtnOk().Click();
    //Validation
    Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveAdhoc,100).Click();
    aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveAdhoc,100).DataContext.DataItem , "Cash", cmpEqual, solde)
} 