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
Analyste d'automatisation: Youlia Raisper */


function CR1452_2432_RebalancingAccount_WithModel()
{
    try{   
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","YES",vServerSleeves)   
        RestartServices(vServerSleeves)
                   
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelTESTPOSBLOQ5=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTPOSBLOQ5", language+client);
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800246GT", language+client);                  
        var sleeveAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_2429", language+client); 
        var targetAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Target2429", language+client);                            
        var positionBCE=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolBCE", language+client);
        var quantityBCE=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityBCE_2432", language+client);                  
        var unallocated=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client); 
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderTypeSell", language+client);  
        var messageAccount=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_2432", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        //Sélectionner la position 'BCE' et mettre comme position bloquée dans Info Portefeuille et OK
        Search_Position(positionBCE)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionBCE),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        //Valider que la position est bloquée  
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionBCE,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
            
        //convertir le compte en UMA 
        Get_PortfolioBar_BtnSleeves().Click();
        Get_WinManagerSleeves().Parent.Maximize();                                 
        //Ajouter un segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"",targetAdhoc,"","",modelTESTPOSBLOQ5)
        Get_WinManagerSleeves_BtnSave().Click();
                                                         
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
        
        //Validation du message 
        var message = aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg().Text,Chr(160),"")       
        if(aqObject.CompareProperty(message,cmpContains, messageAccount)){
          Log.Checkpoint("Les valeurs sont bonnes ")
        } 
        else{
          Log.Error("Les valeurs ne sont pas bonnes ")
        }
        
        //Valider qu'au niveau du compte: Aucun ordre pour BCE
        CheckPresenceOfPosition(positionBCE);
        CheckPresenceOfPositionbtBlock(positionBCE); 
        
        //Si on clique sur le segment 'Non-attribués' dans le browser de gauche: on peut voir qu'il y a un ordre de vente de -500 BCE      
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",unallocated,10).Click();         
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionBCE,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionBCE,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityBCE);
        
        //Si on clique sur le segment 'S1' dans le browser de gauche: on peut voir qu'il y a un ordre d'Achat de 500 BCE
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc,10).Click();  
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionBCE,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionBCE,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityBCE);
           
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les donnée*********************************************************      
        ResetData(account,positionBCE);         
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
        ResetData(account,positionBCE);

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","NO",vServerSleeves)   
      RestartServices(vServerSleeves)
    }
}

function ResetData(account,positionBCE){

     //Débloquer la position    
      Search_Position(positionBCE)
      Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionBCE),10).ClickR();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
      aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionBCE,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
              
      //Supprimer des segments 
      Get_ModulesBar_BtnPortfolio().Click()
      Delete_AllSleeves_WinSleevesManager();
}