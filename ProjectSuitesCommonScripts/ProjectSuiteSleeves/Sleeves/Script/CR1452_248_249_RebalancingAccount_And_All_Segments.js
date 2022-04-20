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


/* Description :Ce script regroupe les scripts :CR1452_248_RebalancingAccount, CR1452_248_RebalancingAccount 
  Pour plus de details consulter le Fichier Excel 'Cas de test du CR1452 à automatiser
Analyste d'automatisation: Alhassane Diallo */



function CR1452_248_249_RebalancingAccount_And_All_Segments()
{
    try{  
        
    
    /**************************************************************Variables***********************************************************/
                     
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");          
        var sleeveAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_2216", language+client);        
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800214JW", language+client); 
        var sleeveAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_248", language+client);
        var targetAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetAdhoc_248", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TypePickerDescription", language+client);        
        var securityQ70791 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecuritySymbolQ70791", language+client);
        var model800214GT=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_800214GT", language+client); 
        var sleeveDescriptionCash=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCash", language+client);        
        var quantity =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Quantity_248", language+client);  
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderTypeSell", language+client);
        
           
        var account1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800215NA", language+client);
        var position=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionQ49490", language+client);
        var filter=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "filter_UnifiedManagedAccounts", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_249", language+client); //Le fichier Excel ne fonctionne pas dans ce cas  
         
        
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Etape 1: Se connecter avec Keynej'");                                            
        Login(vServerSleeves, user, psw, language); 
        
        
        /**************************************************************Validation CR1452_248_RebalancingAccount***********************************************************/
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Etape 2: Validation  du rééquilibrage qui peut générer des achats/ventes d’accommodations avec la methode reequilibrer le compte, : CR1452_248_RebalancingAccount'");  
         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        
        //Sélectionner la position 'Q70791' et mettre comme position bloquée dans Info Portefeuille et OK
        Search_Position(securityQ70791)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(securityQ70791),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        //Valider que la position est bloquée  
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityQ70791,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);

        //convertir le compte en UMA
        CreateSleeveByAssetClass();
                                 
        //Ajouter un segment Adhoc
        Get_PortfolioBar_BtnSleeves().Click();
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"",targetAdhoc,"","",model800214GT)                 
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
        
        /*aucun ordre ne s'en va sur le marché pour le titre St-Sauveur mais qu'il y en a d'autres ordres pour autres titres.*/ 
        CheckPresenceOfPosition(securityQ70791);        
        //Cliquer sur le btn Grouper
        CheckPresenceOfPositionbtBlock(securityQ70791);
        
        /*Consulter les segments 'Encaisse..' et Adhoc et vérifier qu'il y a un ordre de vente de -18000 de St-Sauveur dans le segment 'Encaisse..' */
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveDescriptionCash,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityQ70791,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityQ70791,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantity);
        
        /*et un ordre d'achat de +18000 de St-Sauveur dans le segment 'Adhoc'.*/  
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc,10).Click();    
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityQ70791,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityQ70791,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantity);
                
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
             
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();  
        ResetData(account,securityQ70791)
        
        
        
        //*************************************************CR1452_248_RebalancingAccount*********************************************************
      
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Etape 2: Validation  du rééquilibrage qui peut générer des achats/ventes d’accommodations avec la methode reequilibrer les segments, : CR1452_249_Rebalance_All_Segments'");  
         
        //CR1452_248_RebalancingAccount
        Get_ModulesBar_BtnAccounts().Click();
        
        Search_Account(account1);
        Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click();
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10), Get_ModulesBar_BtnPortfolio());
                        
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
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());        
        ResetData(account,securityQ70791) 
        
        
        Get_ModulesBar_BtnAccounts().Click();
        
        Search_Account(account1);
        Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click();
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10), Get_ModulesBar_BtnPortfolio());
           
        //Supprimer des segments 
        Delete_AllSleeves_WinSleevesManager();
        
        
        //Debloquer la position
        Get_Portfolio_AssetClassesGrid().Find("Value",position,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function ResetData(account,securityQ70791){
       
      //*********************************************Réinitialiser les données*******************************************************
      //Débloquer la position    
      Search_Position(securityQ70791)
      Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(securityQ70791),10).ClickR();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
      aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityQ70791,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
         
      //Supprimer des segments 
      Get_ModulesBar_BtnPortfolio().Click()
      Delete_AllSleeves_WinSleevesManager();
}