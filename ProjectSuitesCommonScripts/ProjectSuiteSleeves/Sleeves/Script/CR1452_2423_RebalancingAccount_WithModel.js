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


function CR1452_2423_RebalancingAccount_WithModel()
{
    try{                  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelTESTPOSBLOQ6=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTPOSBLOQ6", language+client);
        var modelTESTPOSBLOQ8=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTPOSBLOQ8", language+client);
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800058RE", language+client); 
        var securityRY = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolRY", language+client); 
        var securityDELL = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolDELL", language+client);
        var securityBCE = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolBCE", language+client);               
        var sleeveCanadianEquity = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);        
        var targetCanadianEquity =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargeCanadianEquity", language+client);        
        var sleeveAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_2421", language+client); 
        var targetAdhoc =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetAdhoc_2423", language+client);   
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        //Sélectionner la position 'RY' et mettre comme position bloquée dans Info Portefeuille et OK
        Search_Position(securityRY)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(securityRY),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        //Valider que la position est bloquée  
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityRY,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
        
        //Sélectionner la position 'DELL' et mettre comme position bloquée dans Info Portefeuille et OK
        Search_Position(securityDELL)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(securityDELL),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        //Valider que la position est bloquée  
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDELL,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
        
        //Sélectionner la position 'BCE' et mettre comme position bloquée dans Info Portefeuille et OK
        Search_Position(securityBCE)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(securityBCE),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        //Valider que la position est bloquée  
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityBCE,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
            
        //convertir le compte en UMA 
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        Get_Portfolio_AssetClassesGrid().Find("Value",sleeveCanadianEquity ,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
                                 
        //Ajouter un segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"",targetAdhoc,"","",modelTESTPOSBLOQ8) 
        
        //Modifier le segment 
        SelectSleeveWinSleevesManager(sleeveCanadianEquity)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager("","",targetCanadianEquity,"","",modelTESTPOSBLOQ6)  
      
        //transférer 100% de BCE 
        Get_WinManagerSleeves().Parent.Maximize();
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveCanadianEquity,100).Click();       
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",securityBCE,10).Click(); 
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
        
        //Valider que aucune trade ne sera générée sur la position BCE
        CheckPresenceOfPosition(securityBCE);
        CheckPresenceOfPositionbtBlock(securityBCE); 
        
        //Valider que aucune trade ne sera générée sur la position RY
        CheckPresenceOfPosition(securityRY);
        CheckPresenceOfPositionbtBlock(securityRY); 
              
        //Valider que aucune trade ne sera générée sur la position DELL
        CheckPresenceOfPosition(securityDELL);
        CheckPresenceOfPositionbtBlock(securityDELL); 
        
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les donnée*********************************************************
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();      
        ResetData(account,securityRY,securityBCE,securityDELL);        
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
        ResetData(account,securityRY,securityBCE,securityDELL);;

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function ResetData(account,securityRY,securityBCE,securityDELL){

     //Débloquer la position    
      Search_Position(securityRY)
      Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(securityRY),10).ClickR();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
      aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityRY,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
       
      //Débloquer la position    
      Search_Position(securityBCE)
      Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(securityBCE),10).ClickR();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
      aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityBCE,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
      
      //Débloquer la position    
      Search_Position(securityDELL)
      Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(securityDELL),10).ClickR();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
      aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDELL,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
             
      //Supprimer des segments 
      Get_ModulesBar_BtnPortfolio().Click()
      Delete_AllSleeves_WinSleevesManager();
} 