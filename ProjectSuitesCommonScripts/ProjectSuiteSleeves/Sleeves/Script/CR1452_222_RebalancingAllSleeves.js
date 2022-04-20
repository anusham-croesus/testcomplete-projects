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
//USEUNIT DBA


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_222_RebalancingAllSleeves()
{
    try{       
                     
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelName1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MOD1800291RE", language+client);   
        var modelName2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MOD2800291RE", language+client); 
        var targetmodel1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetMOD1800291RE", language+client);
        var targetmodel2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetMOD2800291RE", language+client);
        var sleeveCanadianEquity =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);               
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800291RE", language+client); 
        var unallocated=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var sleeveAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_222", language+client); 
        var balance=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "PositionBalance", language+client);
        var position=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionHJU", language+client);
        var soldToTransfer =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "BalanceToTransfer_221", language+client);
        var quantityHJU =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityHJU_221", language+client);   
        var message= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message2_CR1452_2622", language+client);
                               
        Login(vServerSleeves, user, psw, language);        
        //Modèle  1
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        ChangeTargetOfPosition(modelName1,targetmodel1,position);
        
        //Modèle  2
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        ChangeTargetOfPosition(modelName2,targetmodel2,position);
        
        //Activers les Modèles
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
        
        //rendre le modèle inactif
        SearchModelByName(modelName1);
        ActivateDeactivateModel(modelName1,true);
        SearchModelByName(modelName2);
        ActivateDeactivateModel(modelName2,true);
                
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
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"","","","",modelName1)
        CheckThatModelBindedToSleeve( sleeveAdhoc,modelName1) 
        
        //Modifier le segment 
        SelectSleeveWinSleevesManager(sleeveCanadianEquity)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager("","","","","",modelName2) 
        CheckThatModelBindedToSleeve( sleeveCanadianEquity,modelName2) 
        
        //Transférer une quantité du solde = 2325.60 (la valeur au marché du titre dans le segment 'Actions Canadiennes') de 'Divers' vers 'Adhoc'
        DivideBalance(unallocated,balance,soldToTransfer,sleeveAdhoc)
        Get_WinManagerSleeves_BtnSave().Click();       
        Delay(1500)
                                                                 
        //Rééquilibrer tous les segments
        Get_Toolbar_BtnRebalance().Click();
       //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().set_IsChecked(true)
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
               
        //Validation du  Message(s) du rééquilibrage
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual, message);
               
        //Valider que le titre HJU se retrouve dans le segment ad, quantité = 180 
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc,10).Click();     
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityHJU);       

        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les données*********************************************************  
        ResetData(account,modelName1,modelName2);     
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
        ResetData(account,modelName1,modelName2)

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function ChangeTargetOfPosition(modelName,targetmodel,position)
{
    Get_PortfolioBar_BtnWhatIf().Click();
    
    WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");      
    Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["VirtualizingDataRecordCellPanel", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
    
    Get_PortfolioBar_BtnSave().Click();
    Get_WinWhatIfSave_GrpAccountInformation_RdoNewFirmModel().Click();
    Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(modelName);
    Get_WinWhatIfSave_BtnOK().Click();
    Log.Message("Réponse de Karima A confirme avec Doc parce que avant le titre du message durant la sauvegarde du modéle était information mais sur CX c'est Croesus")
    Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
       
    Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DblClick();
    Get_WinPositionInfo_GrpPositionInformation_TxtTargetValue().Keys(targetmodel);
    Get_WinPositionInfo_BtnOK().Click();
    
    //Valider que la cible était changée
    aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DataContext.DataItem, "ModelTargetPercent", cmpEqual, aqString.Replace(targetmodel, ",", ".")); 
    Get_PortfolioBar_BtnSave().Click(); 
    Get_WinWhatIfSave_BtnOK().Click();              
} 

function ResetData(account,modelName1,modelName2){
         
    //Supprimer des segments 
    Get_ModulesBar_BtnPortfolio().Click()
    Delete_AllSleeves_WinSleevesManager();
    
    //Supprimer les modèles
    DeleteModelByName(modelName1);
    DeleteModelByName(modelName2);
}
