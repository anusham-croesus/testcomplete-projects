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


function CR1452_2420_RebalancingAccount_WithModel()
{
    try{                  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTP", language+client);
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800075RE", language+client);        
        var positionXCB =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolXCB", language+client);            
        var positionECA =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionECA", language+client);               
        var positionAEM =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionAEM", language+client);         
        var sleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);  
        var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Target_2420", language+client);    
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client); 
        var quantityDIS=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "quantityDIS", language+client); 
        var securityDIS = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolDIS", language+client);
        var positionECA =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionECA", language+client);                      
        var positionCVE =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionCVE", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
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
        
        //Non rachetables :Car dans la BD, il y a deux positions Non rachetables pour lw compte utilisé dans le cas de test. Le cas demande de ne pas avoir les positions  Non rachetables.    
        ChangeNonRedeemable(positionECA,false)
        ChangeNonRedeemable(positionCVE,false)
        
        //Valider que non reedeemable a été enlevé
        Get_ModulesBar_BtnAccounts().Click()
        Search_Account(account);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        //chainer vers le module Portefeuille,
        Search_Position(positionECA)        
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionECA,10).DataContext.DataItem, "IsBlockedSecurity", cmpEqual,false);
        Search_Position(positionCVE) 
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionCVE,10).DataContext.DataItem, "IsBlockedSecurity", cmpEqual,false);
            
        //convertir le compte en UMA 
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
                 
        //select une classe d'actif 'Titre de croissance', clique droit, créer des segments
        Get_Portfolio_AssetClassesGrid().Find("Value",sleeveDescription ,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
         
        //Modifier le segment 
        SelectSleeveWinSleevesManager(sleeveDescription)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager("","",target,"","",model)                  
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
        CheckPresenceOfPosition(positionXCB);
        CheckPresenceOfPositionbtBlock(positionXCB); 
           
        /*Validation:Dans le segment Long term: un ordre d'achat de 2301 Dis"*/        
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveDescription,10).Click();         
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityDIS,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityDIS,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityDIS);
           
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les donnée*********************************************************
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click(); 
        Get_ModulesBar_BtnAccounts().Click()      
        ResetData(account,positionXCB,positionECA,positionCVE)           
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        ResetData(account,positionXCB,positionECA,positionCVE)

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function ResetData(account,positionXCB,positionECA,positionCVE){

      Search_Account(account);
      //chainer vers le module Portefeuille,
      Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
      //*********************************************Réinitialiser les données*******************************************************
      //Débloquer la position    
      Search_Position(positionXCB)
      Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionXCB),10).ClickR();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
      aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionXCB,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
         
      //Remettre non reedeemable   
      ChangeNonRedeemable(positionECA,true)
      ChangeNonRedeemable(positionCVE,true)
                
      //Valider que non reedeemable a true
      Get_ModulesBar_BtnAccounts().Click()
      Search_Account(account);
      //chainer vers le module Portefeuille,           
      Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
      Search_Position(positionECA)   
      aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionECA,10).DataContext.DataItem, "IsBlockedSecurity", cmpEqual,true);
      Search_Position(positionCVE)
      aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionCVE,10).DataContext.DataItem, "IsBlockedSecurity", cmpEqual,true);
        
      //Supprimer des segments 
      Get_ModulesBar_BtnPortfolio().Click()
      Delete_AllSleeves_WinSleevesManager();
} 