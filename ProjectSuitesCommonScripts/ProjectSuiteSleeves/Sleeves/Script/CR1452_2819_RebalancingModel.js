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


function CR1452_2819_RebalancingModel()
{
    try{      
                     
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
        var unallocated=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
        var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationFinancialInstrument", language+client);
        var balance=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Balance_USD", language+client);  
        var modelAmericanEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelAmericanEqui", language+client); 
        var modelBonds=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "modelBonds", language+client);       
        var modelCanadianEqui =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client);        
        var modelFund1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_CHFUND1", language+client); 
        var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "target_2819", language+client);                                  
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800063OB", language+client);                        
        var sleeveAdhoc1= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescription1CR1452_2819", language+client); 
        var sleeveAdhoc2= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescription2CR1452_2819", language+client); 
        var sleeveCash= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveCash", language+client);       
        var sleeveMutualFund= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveMutualFund", language+client);              
        var balanceMutualFund=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "BalanceMutualFund_2819", language+client);
        var balanceAdhoc1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "BalanceAdhoc1_2819", language+client);
        var balanceAdhoc2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "BalanceAdhoc2_2819", language+client);
        var balanceCash=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "BalanceCash_2819", language+client);       
        var deposit=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Deposit_2819", language+client);
        var BMO=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecurityBMO", language+client);
        var RONA=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecurityRona", language+client);
        var quantityRONA=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityRona_2819", language+client);       
        var quantityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityBMO_2819", language+client);
        var messageAccount=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_2819", language+client);        
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var marketValue=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MarketValue_2819", language+client);
        var balanceValue=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "BalanceValue_2819", language+client);
                                             
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
          
        //Grouper par classe d'actifs
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Set_Text(assetAllocation);          
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",sleeveMutualFund,10).Click();
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",sleeveCash,10).Click(10, 10, skCtrl);        
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",sleeveCash,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
          
        //Ajouter un segment Adhoc1
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc1,"",target,"","",modelAmericanEqui)
  
        //Ajouter un segment Adhoc2
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc2,"",target,"","",modelCanadianEqui)
  
        //Modifier le segment 
        SelectSleeveWinSleevesManager(sleeveMutualFund)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager("","",target,"","",modelFund1);
          
        //Modifier le segment 
        SelectSleeveWinSleevesManager(sleeveCash)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager("","",target,"","",modelBonds);   
  
        //Segment 'Fonds d'investissement': solde = 39122.74
        DivideBalance(unallocated,balance,balanceMutualFund,sleeveMutualFund);
        //Segment 'Encaisse':solde = 52163.64
        DivideBalance(unallocated,balance,balanceCash,sleeveCash);
        //Segment 'S1': solde = 55889.62
        DivideBalance(unallocated,balance,balanceAdhoc1,sleeveAdhoc1);
        //Segment 'S2':solde = 79842.31
        DivideBalance(unallocated,balance,balanceAdhoc2,sleeveAdhoc2);
        
        Get_WinManagerSleeves_BtnSave().Click();       
        Delay(1500)
                                                                 
        //Rééquilibrer le modèle
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelCanadianEqui);
        Get_Toolbar_BtnRebalance().Click();        
        if(!Get_WinRebalance().Exists){
          Get_Toolbar_BtnRebalance().Click();
        }    
                                                                       
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance().Parent.Maximize();
        Get_WinRebalance_BtnNext().Click();
        
        //Désélectionner tout et sélectionner le segment Adhoc2
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll().Click();
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value",sleeveAdhoc2,10).Click();
               
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();                  
        ChangeCashMgmt(sleeveAdhoc2,deposit,"model"); 
        Get_WinCashManagement_BtnOk().Click();
               
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        Get_WinRebalance_BtnNext().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        /*Dans l'onglet 'Ordres proposés':Ordre d'achat de 1015 RonaOrdre d'achat de 541 BMO*/
        Log.Message(" MOD-1070")
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",RONA,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",RONA,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityRONA);          
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityBMO);
        
        /*Un message qui s'affiche 'Ce segment fait état d'un dépôt de 10000$'*/
        var message = aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg().Text,Chr(160),"")       
        if(aqObject.CompareProperty(message,cmpContains, messageAccount)){
          Log.Checkpoint("Les valeurs sont bonnes ")
        } 
        else{
          Log.Error("Les valeurs ne sont pas bonnes ")
        }
              
        /*Dans l'onglet 'Portefeuille projeté', section sommaire en bas: Valeur de marché = 89842.31 Solde = 35987.66*/
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(), "Text", cmpEqual,marketValue);// YR 78CX avant Content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBalance(), "Text", cmpEqual,balanceValue);  // YR 78CX avant Conent 
           
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les données*********************************************************  
        Get_ModulesBar_BtnPortfolio().Click();  
        //Supprimer des segments 
        Delete_AllSleeves_WinSleevesManager(); 
 
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
        Delete_AllSleeves_WinSleevesManager();  

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

