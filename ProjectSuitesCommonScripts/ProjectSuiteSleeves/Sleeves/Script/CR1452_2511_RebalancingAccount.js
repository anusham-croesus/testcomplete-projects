//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1452_222_RebalancingAllSleeves
//USEUNIT DBA


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_2511_RebalancingAccount()
{
    try{                           
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_NONRACHETABLE1", language+client);          
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800027FS", language+client);
        var sleeveCanadianEquity =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);
        var sleeveAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_2511", language+client); 
        var modelTarget=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelTarget_2511", language+client); 
        var DIS = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolDIS", language+client);
        var FTS = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_FTS", language+client);       
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);              
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderTypeSell", language+client);        
        var accountQuantityFTS =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "AccountQuantityFTS", language+client); 
        var accountQuantityDIS =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "AccountQuantityDIS", language+client);        
        var canEquityQuantityFTS =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CanEquityQuantityFTS", language+client);         
        var adhocQuantityDIS =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "AdhocQuantityDIS", language+client); 
        var adhocQuantityFTS =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "AdhocQuantityFTS", language+client); 
                               
        Login(vServerSleeves, user, psw, language);          
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        
        //Valider que le titre 'Fortis' est Non rachetable
        Search_Position(FTS)        
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",FTS,10).DataContext.DataItem, "IsBlockedSecurity", cmpEqual,true);               
            
        //convertir le compte en UMA         
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        Get_Portfolio_AssetClassesGrid().Find("Value",sleeveCanadianEquity ,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
                                 
        //Ajouter un segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"",modelTarget,"","",modelName)       
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
               
        //Au niveau compte: Au niveau compte: Achat 212 Fortis et Achat 1091 Dis
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",FTS,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",FTS,10).DataContext.DataItem, "EditableQuantity", cmpEqual, accountQuantityFTS);
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",DIS,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",DIS,10).DataContext.DataItem, "EditableQuantity", cmpEqual, accountQuantityDIS);
        
        /*Validation:Segment 'Actions canadiennes': Vente 1000 Fortis*/
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveCanadianEquity,10).Click();        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",FTS,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",FTS,10).DataContext.DataItem, "EditableQuantity", cmpEqual, canEquityQuantityFTS);
         
        //Segment 'ad': Achat 1212 Fortis et Achat 1091 Dis
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",FTS,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",FTS,10).DataContext.DataItem, "EditableQuantity", cmpEqual, adhocQuantityFTS);       
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",DIS,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",DIS,10).DataContext.DataItem, "EditableQuantity", cmpEqual, adhocQuantityDIS);
        
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
        Delete_AllSleeves_WinSleevesManager(); 
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}