//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_271_Rebalance_Account_WithInactiveModel
//USEUNIT CR1452_264_BlockedRestriction
//USEUNIT CR1452_2611_BlockedRestriction_Model
//USEUNIT CR1452_2416_RebalancingAccount_BlockedPosition
//USEUNIT DBA

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_2428_RebalancingAccount()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C8", language+client);
        var BCE=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolBCE", language+client);          
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "modelUSEQUI", language+client); 
        var sleeveAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_2821", language+client); 
        var targetAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetAdhocCR1452_2821", language+client); 
        var RY=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolRY", language+client);
        var TD=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionTD", language+client);
        var unallocated=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
        var errorMessage=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ErrorMessage", language+client);
                
        Login(vServerSleeves, user, psw, language); 
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        //Sélectionner la position 'BCE' et mettre comme position bloquée dans Info Portefeuille et OK
        Search_Position(BCE)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(BCE),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        //Valider que la position est bloquée  
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",BCE,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
               
        //cliquer sur le bouton segment et créer un segment Adhoc
        Get_PortfolioBar_BtnSleeves().Click();
        Get_WinManagerSleeves().Parent.Maximize();                
                         
        //Ajout de segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"",targetAdhoc,"","",modelName); 
        
        //Transférer TD et RY 
        Get_WinManagerSleeves().Parent.Maximize();
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click();       
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value","T",10).Click(); 
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value","AGU",10).Click(10, 10, skCtrl);       
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
        
        //Valider que le message ne contient pas le mot erreur     
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(), "Text", cmpNotContains, errorMessage); 
        Log.Message("CROES-4665");
                
        //on devrait voir des ordres proposés
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpNotEqual,"0");
        //On ne devrait pas voir des ordres proposés pour BCE
        CheckPresenceOfPosition(BCE);       
        //Cliquer sur le btn Grouper
        CheckPresenceOfPositionbtBlock(BCE);
                
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
        
        //***********************************************************Remettre les données************************************************ 
        ResetData(account,BCE)              
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
        ResetData(account,BCE)         

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function ResetData(account,BCE)
{      
    //Réinitialiser les données 
    Search_Position(BCE)
    Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(BCE),10).ClickR();
    Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
    Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
    aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",BCE,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
    //Supprimer des segments 
    Delete_AllSleeves_WinSleevesManager();
} 
