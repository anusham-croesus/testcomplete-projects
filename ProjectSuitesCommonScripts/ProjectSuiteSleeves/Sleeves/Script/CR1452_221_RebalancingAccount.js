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


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_221_RebalancingAccount()
{
    try{       
                     
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MOD800204JW", language+client);  
        var sleeveAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_221", language+client); 
        var sleeveCanadianEquity =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);          
        var targetAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetMOD1800291RE", language+client);
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800204JW", language+client); 
        var message= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "InfoMessage_221", language+client);        
        var cashBalanceAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CashBalanceAdhoc_221", language+client);
        var marketValueAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MarketValueAdhoc_221", language+client);
        var cashBalance=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CashBalance_221", language+client);
        var marketValue=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MarketValue_221", language+client);
        var unallocated=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
                                       
        Login(vServerSleeves, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        
        //Créer un Modèle
        Get_PortfolioBar_BtnWhatIf().Click();    
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");      
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["VirtualizingDataRecordCellPanel", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);    
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_GrpAccountInformation_RdoNewFirmModel().Click();
        Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(modelName);
        Get_WinWhatIfSave_BtnOK().Click();
        Log.Message("Réponse de Karima A confirme avec Doc parce que avant le titre du message durant la sauvegarde du modéle était information mais sur CX c'est Croesus")
        Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        
        //Activers les Modèles
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
        
        //rendre le modèle inactif
        SearchModelByName(modelName);
        ActivateDeactivateModel(modelName,true);

        //convertir le compte en UMA 
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        Get_Portfolio_AssetClassesGrid().Find("Value",sleeveCanadianEquity ,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
                                 
        //Ajouter un segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"",targetAdhoc,"","",modelName)        
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
        
        //Aucun ordre ne devrait s'afficher
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0");
        
        //Cliquer sur le btn Grouper
        Log.Message( "Anomalie: aucun ordre ne devrait s'afficher dans ce niveau")
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0");
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
 
        aqObject.CompareProperty( CheckCashMovements(),cmpEqual, 0);
  
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnGenerate().Click();
         
        //Validation du  Message
        aqObject.CheckProperty(Get_DlgConfirmation() , "CommentTag", cmpEqual, message);                      
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73) 
        
        //remailler le compte vers Portefeuille et consulter le gestionnaire des segments
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();       
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());  
                      
        /* le solde et la valeur au marché des segments 'Non attribués' et 'Canadian Equity' est = 0
        Le solde du segment 'Adhoc' = 5108.43
        Valeur au marché du segment 'Adhoc' = 1178.43*/
        Get_PortfolioBar_BtnSleeves().Click();
        Get_WinManagerSleeves().Parent.Maximize();
        
        aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).DataContext.DataItem, "Cash", cmpEqual, cashBalance);
        aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).DataContext.DataItem, "MarketValue", cmpEqual, marketValue);
        aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveCanadianEquity,100).DataContext.DataItem, "Cash", cmpEqual, cashBalance);
        aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveCanadianEquity,100).DataContext.DataItem, "MarketValue", cmpEqual, marketValue); 
        aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveAdhoc,100).DataContext.DataItem, "Cash", cmpEqual, cashBalanceAdhoc);
        aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveAdhoc,100).DataContext.DataItem, "MarketValue", cmpEqual, marketValueAdhoc);   
        Get_WinManagerSleeves().Close();
               
        //*************************************************Réinitialiser les données*********************************************************  
        ResetData(account,modelName);     
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
        ResetData(account,modelName);

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function ResetData(account,modelName){
         
    //Supprimer des segments 
    Get_ModulesBar_BtnPortfolio().Click()
    Delete_AllSleeves_WinSleevesManager();
    
    //Supprimer les modèles
    DeleteModelByName(modelName);
               
}