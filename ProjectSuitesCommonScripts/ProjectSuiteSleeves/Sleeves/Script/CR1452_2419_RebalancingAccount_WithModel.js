//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_2416_RebalancingAccount_BlockedPosition
//USEUNIT CR1452_2417_RebalancingAllSleeves_BlockedPosition

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_2419_RebalancingAccount_WithModel()
{
    try{
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","YES",vServerSleeves)   
        RestartServices(vServerSleeves)
                       
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var model1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTREEQ", language+client);
        var model2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_TESTREEQ2", language+client);
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800086RE", language+client);               
        var positionTD =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionTD", language+client);          
        var targetAdhoc1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetAdhoc1_2419", language+client); 
        var targetAdhoc2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetAdhoc2_2419", language+client);
        var adhoc1= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveAdhoc1CR1452_2419", language+client);
        var adhoc2= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveAdhoc2CR1452_2419", language+client);      
        var unallocated =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client); 
        var positionECA =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionECA", language+client);               
        var percentageTD=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageTD", language+client);
        var positionCVE =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionCVE", language+client);        
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);        
        var AEM=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolAEM", language+client);
        var NA=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionNA", language+client);
        var SAP=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolSAP", language+client);        
        var messageAccount=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MessageAccount_2419", language+client);
        var accountAEMquantity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "AccountAEMquantity", language+client);
        var accountNAquantity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "AccountNAquantity", language+client);
        var accountSAPquantity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "AccountSAPquantity", language+client);        
        var messageAdhoc1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MessageAdhoc1_2419", language+client);
        var adhoc1AEMquantity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Adhoc1AEMquantity", language+client);
        var adhoc1NAquantity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Adhoc1NAquantity", language+client);
        var adhoc1SAPquantity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Adhoc1SAPquantity", language+client);        
        var messageAdhoc2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MessageAdhoc2_2419", language+client);
        var adhoc2AEMquantity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Adhoc2AEMquantity", language+client);
        var adhoc2NAquantity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Adhoc2NAquantity", language+client);
        var adhoc2SAPquantity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Adhoc2SAPquantity", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        //Sélectionner la position 'TD' et mettre comme position bloquée dans Info Portefeuille et OK
        Search_Position(positionTD)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionTD),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        //Valider que la position est bloquée  
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionTD,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
        
        //Non rachetables :Car dans la BD, il y a deux positions Non rachetables pour lw compte utilisé dans le cas de test. Le cas demande de ne pas avoir les positions  Non rachetables.    
        ChangeNonRedeemable(positionECA,false)
        ChangeNonRedeemable(positionCVE,false)
        
        //Valider que non reedeemable a été enlevé
        Get_ModulesBar_BtnAccounts().Click()
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());   
        Search_Position(positionECA)        
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionECA,10).DataContext.DataItem, "IsBlockedSecurity", cmpEqual,false);
        Search_Position(positionCVE) 
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionCVE,10).DataContext.DataItem, "IsBlockedSecurity", cmpEqual,false);
           
        //convertir le compte en UMA 
        Get_PortfolioBar_BtnSleeves().Click();           
        Get_WinManagerSleeves().Parent.Maximize(); 
        
        //ajouter un segment Adhoc1
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(adhoc1,"",targetAdhoc1,"","",model1) 
        
        //ajouter un segment Adhoc2
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(adhoc2,"",targetAdhoc2,"","",model2)   
        
        //Transférer toutes les positions du compte du segment Non-attribués vers le segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click(); 
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Keys("^a"); 
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();       
        Get_WinMoveSecurities_CmbToSleeve().Keys(adhoc1);
        Get_WinMoveSecurities_BtnOk().Click();
        
        //f) Transférer une quantité de 50% de TD du segment Adhoc vers Adhoc 2
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",adhoc1,100).Click();         
        if(!Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",positionTD,10).Exists){
          Scroll();  
        } 
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",positionTD,10).Click(); 
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();                    
        Get_WinMoveSecurities_CmbToSleeve().Keys(adhoc2);
        Get_WinMoveSecurities_GrpSecurities_DgvListView().Items.Item(0).set_PercentageToMove(percentageTD)                    
        Get_WinMoveSecurities().Click();
        Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
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
        
        //aucun ordre pour la position bloquée à partir du segment 'Non-attribués'        
        CheckPresenceOfPosition(positionTD);      
        //Cliquer sur le btn Grouper
        CheckPresenceOfPositionbtBlock(positionTD);
               		              
        //Au niveau compte: Le message qui nous avise qu'il y a une exclusion affiche une valeur théorique = 154418.66$, exclusion = 2873.16$ de TD
        var message = aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg().Text,Chr(160),"")       
        if(aqObject.CompareProperty(message,cmpContains, messageAccount)){
          Log.Checkpoint("Les valeurs sont bonnes ")
        } 
        else{
          Log.Error("Les valeurs ne sont pas bonnes ")
        }
                                
        //Achat Agnico: 550 Achat NA: 541 Achat Sap: 1083
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",AEM,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",AEM,10).DataContext.DataItem, "EditableQuantity", cmpEqual, accountAEMquantity);
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem, "EditableQuantity", cmpEqual, accountNAquantity);
        
         aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",SAP,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",SAP,10).DataContext.DataItem, "EditableQuantity", cmpEqual, accountSAPquantity);
                    
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",adhoc1,10).Click();
        
        /*Validation:Dans Adh1: Achat Agnico: 330 Achat NA: 325 Achat Sap: 650*/        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",AEM,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",AEM,10).DataContext.DataItem, "EditableQuantity", cmpEqual, adhoc1AEMquantity);
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem, "EditableQuantity", cmpEqual, adhoc1NAquantity);
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",SAP,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",SAP,10).DataContext.DataItem, "EditableQuantity", cmpEqual, adhoc1SAPquantity);
         
        //Validation du message dans adhoc1: valeur théoritque = 92651.20, exclusion = 1436.58$ de TD
        var message = aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg().Text,Chr(160),"")       
        if(aqObject.CompareProperty(message,cmpContains, messageAdhoc1)){
          Log.Checkpoint("Les valeurs sont bonnes ")
        } 
        else{
          Log.Error("Les valeurs ne sont pas bonnes ")
        }
            
        /*Dans Adh2: Achat Agnico: 220 (Valeur au marché projetée/ valeur théorique du segment= % cible du modèle 12342/61767.46*100)= 19.98% ~20% et si on divise par la valeur théorique du compte ça donne 8% ce qui est la valeur cible globale
         Achat NA: 216 Achat Sap: 433*/
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",adhoc2,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",AEM,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",AEM,10).DataContext.DataItem, "EditableQuantity", cmpEqual, adhoc2AEMquantity);
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem, "EditableQuantity", cmpEqual, adhoc2NAquantity);
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",SAP,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",SAP,10).DataContext.DataItem, "EditableQuantity", cmpEqual, adhoc2SAPquantity);
        
        //Validation du message : valeur théoritque = 61767.46 exclusion = 1436.58$ de TD
        var message = aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg().Text,Chr(160),"")       
        if(aqObject.CompareProperty(message,cmpContains, messageAdhoc2)){
          Log.Checkpoint("Les valeurs sont bonnes ")
        } 
        else{
          Log.Error("Les valeurs ne sont pas bonnes ")
        }
    
        Get_WinRebalance_BtnClose().Click(); 
        if (Get_DlgConfirmation().Exists) Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //if(Get_DlgWarning().Exists){ //CP : Changé pour CO
        //  var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //  Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
        //} //CP : Changé pour CO
               
        //*************************************************Réinitialiser les données*********************************************************
        ResetData(account,positionTD,positionECA,positionCVE)         
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
        
        //*********************************************Réinitialiser les données*******************************************************
        ResetData(account,positionTD,positionECA,positionCVE)
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","NO",vServerSleeves)   
      RestartServices(vServerSleeves)
    }
}

function Scroll()
{
  var ControlWidth=Get_WinManagerSleeves_GrpUnderlyingSecurities().get_ActualWidth()
  var ControlHeight=Get_WinManagerSleeves_GrpUnderlyingSecurities().get_ActualHeight()
  Get_WinManagerSleeves_GrpUnderlyingSecurities().Click(ControlWidth-5, ControlHeight-25)
}