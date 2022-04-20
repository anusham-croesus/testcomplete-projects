//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_2416_RebalancingAccount_BlockedPosition

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Rééquilibrage d'un compte UMA avec un modèle qui détient une position bloquée du compte assigné. 
Analyste d'automatisation: Youlia Raisper */


function CR1452_2426_RebalancingAccount_WithModel()
{
    try{                  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelTESTPOSBLOQ3=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTPOSBLOQ3", language+client);
        var modelTESTPOSBLOQ1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTP", language+client);        
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800206FS", language+client); 
        var positionXCB =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolXCB", language+client);     
        var unallocated =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
        var sleeveLongTerm = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client); 
        var targetLongTerm =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetLongTerm", language+client); 
        var sleeveAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_2426", language+client); 
        var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Target2426", language+client);  
        var balanceLongTerm= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "BalanceLongTerme_2426", language+client);   
        var marketValue= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MarketValue_2426", language+client);     
        var balanceAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "BalanceAdhoc_2426", language+client);   
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client); 
        var positionDIS =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolDIS", language+client);
        var quantityDIS=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityDIS_2426", language+client);
        var marketValueLongTerm= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MarketValueLongTerm_2426", language+client); 
        
        Login(vServerSleeves, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnAccounts().Click()
               
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        //Sélectionner la position 'XCB' et mettre comme position bloquée dans Info Portefeuille et OK
        Search_Position(positionXCB)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionXCB),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        //Valider que la position est bloquée  
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionXCB,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
                            
        //convertir le compte en UMA 
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        Get_Portfolio_AssetClassesGrid().Find("Value",sleeveLongTerm ,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
                                 
        //Ajouter un segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"",target,"","",modelTESTPOSBLOQ1) 
        
        //Modifier le segment 
        SelectSleeveWinSleevesManager(sleeveLongTerm)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager("","",target,"","",modelTESTPOSBLOQ3)  
      
        //toutes les positions existantes dans le segment 'Non attribués' vers le segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click();
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Keys("^a"); 
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();        
        Get_WinMoveSecurities_CmbToSleeve().Keys(sleeveAdhoc);
        Get_WinMoveSecurities_BtnOk().Click();       
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
        
        //Valider que aucune trade ne sera générée sur la position XCB
        //Aucun ordre pour XCB
        CheckPresenceOfPosition(positionXCB);
        CheckPresenceOfPositionbtBlock(positionXCB); 
        
        //dans portefeuille projeté, segment 'Long terme': solde= 170452.08, valeur projetée= 183623.28
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveLongTerm,10).Click(); 
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(), "Text", cmpEqual,marketValueLongTerm); //YR 78CX BNC avant Content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBalance(), "Text", cmpEqual,balanceLongTerm);//YR 78CX BNC avant Content
        
        //segment 'adhoc':Achat Dis= 288 solde= 174617.77, valeur projetée= 183738.82
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc,10).Click(); 
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionDIS,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionDIS,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityDIS);
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(), "Text", cmpEqual,marketValue); //YR 78CX BNC avant Content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBalance(), "Text", cmpEqual,balanceAdhoc);//YR 78CX BNC avant Content
        
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les donnée*********************************************************
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();      
        ResetData(account,positionXCB);        
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
        ResetData(account,positionXCB);

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function ResetData(account,positionXCB){

     //Débloquer la position    
      Search_Position(positionXCB)
      Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionXCB),10).ClickR();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
      aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionXCB,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
                   
      //Supprimer des segments 
      Get_ModulesBar_BtnPortfolio().Click()
      Delete_AllSleeves_WinSleevesManager();
} 