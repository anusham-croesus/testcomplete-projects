//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT CR1452_2416_RebalancingAccount_BlockedPosition

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_249_Rebalance_All_Segments()
{
    try{              
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");        
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800215NA", language+client);
        var position=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionQ49490", language+client);
        var filter=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "filter_UnifiedManagedAccounts", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_249", language+client); //Le fichier Excel ne fonctionne pas dans ce cas  
                
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        Search_Account(account);
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
                        
        Search_Position(position);
        
        //bloquer une position
        Get_Portfolio_AssetClassesGrid().Find("Value",position,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        //Créer des segments  
        CreateSleeveByAssetClass();
        
         // cliquer sur 'Rééquilibrer' et sélectionner la méthode 'Rééquilibrer tous les segments'.
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceSelectedSleeves().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click();
               
        Get_WinRebalance().Parent.Maximize();        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();       
        // avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
    
         //Aucun ordre ne devrait s'afficher
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0");
        
        //Cliquer sur le btn Grouper
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0");
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();

        //Validation du message Le fichier Excel n’a pas fonctionné dans le cas 
        if(language=="french"){
          aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(), "Text", cmpEqual, "Ce compte détient une ou plusieurs positions bloquées.\nCe compte détient un ou plusieurs titres non rachetables.\r\nAucun ordre n\'est nécessaire au rééquilibrage.");
        } 
        else{
          aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(), "Text", cmpEqual, "This account holds one or more locked positions.\nThis account holds one or more non-redeemable securities.\r\nNo order is needed to rebalance.");
        }         
        Get_WinRebalance_BtnClose().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
                
        //Supprimer des segments 
        Delete_AllSleeves_WinSleevesManager();
        
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        Get_Portfolio_AssetClassesGrid().Find("Value",position,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();  
              
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
                
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        Search_Account(account);
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
           
        //Supprimer des segments 
        Delete_AllSleeves_WinSleevesManager();
        
        Get_Portfolio_AssetClassesGrid().Find("Value",position,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
               
    }
    finally {    
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

