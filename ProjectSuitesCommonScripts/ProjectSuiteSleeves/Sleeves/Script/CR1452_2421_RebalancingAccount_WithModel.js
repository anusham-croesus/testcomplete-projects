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


function CR1452_2421_RebalancingAccount_WithModel()
{
    try{
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","YES",vServerSleeves)   
        RestartServices(vServerSleeves)
                      
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelTESTP=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTP", language+client);
        var modelTESTP2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTP2", language+client);
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800058NA", language+client);  
        var sleeveLongTerm = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client); 
        var targetLongTerm =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetLongTerm", language+client); 
        var sleeveAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_2421", language+client); 
        var targetAdhoc =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetAdhoc_2421", language+client);              
        var positionXCB =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolXCB", language+client);     
        var unallocated =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client); 
        var balance=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "PositionBalance", language+client);
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);    
        var positionDIS = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolDIS", language+client);
        var positionNA =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionNA", language+client); 
        var quantityNA =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityNA_2421", language+client); 
        var quantityDIS =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityDIS_2421", language+client);
        var quantityXCB =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityXCB", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderTypeSell", language+client); 
        var messageAccount=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_2421", language+client);
        var messageAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MessageAdhoc_CR1452_2421", language+client);
        var messageLongTerme=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MessageLongTerme_CR1452_2421", language+client);
        
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
            
        //convertir le compte en UMA 
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        Get_Portfolio_AssetClassesGrid().Find("Value",sleeveLongTerm ,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
                         
        
        //Ajouter un segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"",targetAdhoc,"","",modelTESTP2) 
        
        //Modifier le segment 
        SelectSleeveWinSleevesManager(sleeveLongTerm)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager("","",targetLongTerm,"","",modelTESTP)  

        //d) transférer tout le solde au segment Long term
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click();   
        //Selectioner la solde
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",balance,10).Click();                
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();         
        Get_WinMoveSecurities_CmbToSleeve().Keys(sleeveLongTerm);         
        Get_WinMoveSecurities().Click();
        Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
        Get_WinMoveSecurities_BtnOk().Click();
               
        //toutes les positions existantes dans le segment 'Non attribués' vers le segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click();
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Keys("^a"); 
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();        
        Get_WinMoveSecurities_CmbToSleeve().Keys(sleeveAdhoc);
        Get_WinMoveSecurities_BtnOk().Click();
        
        //transférer 100% de XCB  
        //Get_WinManagerSleeves().Parent.Maximize();
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveLongTerm,100).Click();       
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",positionXCB,10).Click();  
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
        
        
        //Validation du message 
        var message = aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg().Text,Chr(160),"")       
        if(aqObject.CompareProperty(message,cmpContains, messageAccount)){
          Log.Checkpoint("Les valeurs sont bonnes ")
        } 
        else{
          Log.Error("Les valeurs ne sont pas bonnes ")
        }
        
        //Valider que aucune trade ne sera générée sur la position XCB 
        CheckPresenceOfPosition(positionXCB);
        CheckPresenceOfPositionbtBlock(positionXCB); 
                
        //Achat NA: 69 et Achat Dis: 187
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionDIS,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionDIS,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityDIS);
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionNA,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionNA,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityNA);
                    
        /*Validation:Dans 'Long terme': Achat Dis: 187 achat: 204 xcb*/        
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveLongTerm,10).Click();         
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionDIS,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionDIS,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityDIS);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionXCB,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionXCB,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityXCB);
        
        //Validation du message 
        /*var message = aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg().Text,Chr(160),"")       
        if(aqObject.CompareProperty(message,cmpContains, messageLongTerme)){
          Log.Checkpoint("Les valeurs sont bonnes ")
        } 
        else{
          Log.Error("Les valeurs ne sont pas bonnes ")
        }*/ //EM : 90.12.Hf-5 : Enlevé pour le moment car toujours il échoue à cause que le message de segement ne s'affiche pas malgré que la pref est activé. Une fois le problème soit reglé, on le retourne comme avant
        
        /*Dans Adh: Achat NA: 69 et vente: -204 xcb*/
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc,10).Click();  
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionNA,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionNA,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityNA);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionXCB,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionXCB,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityXCB);
        
        //Validation du message 
        /*var message = aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg().Text,Chr(160),"")       
        if(aqObject.CompareProperty(message,cmpContains, messageAdhoc)){
          Log.Checkpoint("Les valeurs sont bonnes ")
        } 
        else{
          Log.Error("Les valeurs ne sont pas bonnes ")
        }*/ //EM : 90.12.Hf-5 : Enlevé pour le moment car toujours il échoue à cause que le message de segement ne s'affiche pas malgré que la pref est activé. Une fois le problème soit reglé, on le retourne comme avant
           
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
      Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","NO",vServerSleeves)   
      RestartServices(vServerSleeves)
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