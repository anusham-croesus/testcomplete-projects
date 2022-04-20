//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_2416_RebalancingAccount_BlockedPosition
//USEUNIT CR1452_2416_RebalancingAccount_BlockedPosition
//USEUNIT CR1452_2514_RebalancingAccount
//USEUNIT CR1452_2811_CashManagement_USAccount
//USEUNIT CR1452_222_RebalancingAllSleeves
//USEUNIT DBA


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_2216_RebalancingAccount()
{
    try{       
                     
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");          
        var sleeveAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_2216", language+client);        
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800046RE", language+client); 
        var modelCHCAN2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_CHCAN2", language+client);  
        var modelCanadianEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client); 
        var sleeveCanadianEquity =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);         
        var targetAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetAdhoc_2216", language+client);
        var targetCanadianEquity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetCanadianEquity_2216", language+client);
        var RONA=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecurityRona", language+client);
        var BMO=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecurityBMO", language+client);
        var BCE=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolBCE", language+client);
        var GPC=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecurityGPC", language+client);
        var unallocated=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderTypeSell", language+client);        
        var accountQuantityRona=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "AccountQuantityRONA", language+client);
        var accountQuantityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "AccountQuantityBMO", language+client);
        var accountQuantityBCE=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "AccountQuantityBCE", language+client);        
        var canadianEquityQuantityRONA=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CanadianEquityQuantityRONA", language+client);
        var canadianEquityQuantityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CanadianEquityQuantityBMO", language+client);
        var canadianEquityQuantityBCE=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CanadianEquityQuantityBCE", language+client);        
        var adhocQuantityBCE=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "AdhocQuantityBCE", language+client);
        var unallocatedQuantityGPC=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "UnallocatedQuantityGPC", language+client);
                                       
        Login(vServerSleeves, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 

        //convertir le compte en UMA 
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        Get_Portfolio_AssetClassesGrid().Find("Value",sleeveCanadianEquity ,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
                                 
        //Ajouter un segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"",targetAdhoc,"","",modelCHCAN2)
        CheckThatModelBindedToSleeve( sleeveAdhoc,modelCHCAN2)
               
        //Modifier le segment 
        SelectSleeveWinSleevesManager(sleeveCanadianEquity)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager("","",targetCanadianEquity,"","",modelCanadianEqui) 
        CheckThatModelBindedToSleeve( sleeveCanadianEquity,modelCanadianEqui)                 
        Get_WinManagerSleeves_BtnSave().Click(); 
        Delay(1500)
                                                                      
        //Rééquilibrer le compte
        Get_Toolbar_BtnRebalance().Click();
       //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click(); 
                                                  
        Get_WinRebalance().Parent.Maximize();        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();       
        // avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        
        /*Au niveau Compte: ordre d'Achat 941 Rona, Achat 502 BMO et Achat 8613 BCE et d'autres ordres de vente*/      
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",RONA,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",RONA,10).DataContext.DataItem, "EditableQuantity", cmpEqual, accountQuantityRona);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BCE,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BCE,10).DataContext.DataItem, "EditableQuantity", cmpEqual, accountQuantityBCE);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem, "EditableQuantity", cmpEqual, accountQuantityBMO);
        
        var count=Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Count
        for(var i=0; i<count;i++){
          if(i<3){
            aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "OrderType", cmpEqual, orderType);
          } 
          else{
            aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "OrderType", cmpEqual, orderTypeSell);
          }          
        }
        
        /*Au niveau du segment 'Non attribués': ordre de vente -200 GPC (Genuine Parts CO) et d'autres ordres de vente*/
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",unallocated,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",GPC,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",GPC,10).DataContext.DataItem, "EditableQuantity", cmpEqual, unallocatedQuantityGPC); 
        
        var count=Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Count
        for(var i=0; i<count;i++){
            aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "OrderType", cmpEqual, orderTypeSell);         
        }  
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpNotEqual, "1"); 
        
        /*Au niveau du segment 'Actions canadiennes': ordre d'Achat 941 Rona, Achat 502 BMO, Vente de -12 BCE et d'autres ordres de vente*/
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveCanadianEquity,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",RONA,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",RONA,10).DataContext.DataItem, "EditableQuantity", cmpEqual, canadianEquityQuantityRONA);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BCE,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BCE,10).DataContext.DataItem, "EditableQuantity", cmpEqual,canadianEquityQuantityBCE);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem, "EditableQuantity", cmpEqual, canadianEquityQuantityBMO);   
        
        var count=Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Count
        for(var i=0; i<count;i++){
          if(i<2){
            aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "OrderType", cmpEqual, orderType);
          } 
          else{
            aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "OrderType", cmpEqual, orderTypeSell);
          }          
        }
        
        /*Au niveau du segment 'Adhoc': ordre d'Achat 8625 BCE*/
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BCE,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BCE,10).DataContext.DataItem, "EditableQuantity", cmpEqual, adhocQuantityBCE);
        
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
                  
        //*************************************************Réinitialiser les données*********************************************************  
        //Supprimer des segments 
        Delete_AllSleeves_WinSleevesManager();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        //Supprimer des segments 
        Delete_AllSleeves_WinSleevesManager();  

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}