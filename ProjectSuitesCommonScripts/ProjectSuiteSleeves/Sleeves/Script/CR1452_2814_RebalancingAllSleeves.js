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


function CR1452_2814_RebalancingAllSleeves()
{
    try{      
                     
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
        var unallocated=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
        var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationFinancialInstrument", language+client);
        var balance=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "PositionBalance", language+client);  
        var modelAmericanEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelAmericanEqui", language+client); 
        var modelBonds=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "modelBonds", language+client);       
        var modelCanadianEqui =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client); 
        var modelCan2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_CHCAN2", language+client);                   
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account 800252RE", language+client);                
        var sleeveAdhoc1= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescription1CR1452_2814", language+client); 
        var sleeveAdhoc2= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescription2CR1452_2814", language+client); 
        var sleeveEquity= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveCmbAssetClassMaturityEquity", language+client);         
        var sleeveBond= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionBond", language+client); 
        var balanceEquity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CashBalanceEquity_2814", language+client);
        var balanceAdhoc1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CashAdhoc1_2814", language+client);
        var balanceAdhoc2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CashAdhoc2_2814", language+client);
        var depositEquity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "DepositEquity_2814", language+client);
        var depositAdhoc1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "DepositAdhoc1_2814", language+client);
        var depositAdhoc2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "DepositAdhoc2_2814", language+client);
        var depositBond=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "DepositBond_2814", language+client);
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderTypeSell", language+client);
        
        var BMO=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecurityBMO", language+client);
        var N49627=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecurityN49627", language+client);
        var BCE=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolBCE", language+client);
        var Apple=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolAAPL", language+client);
        var DIS=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolDIS", language+client);
        var Microsoft=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecurityMicrosoft", language+client);
        var RONA=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecurityRona", language+client);
        
        var quantityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityEquity_BMO", language+client);
        var quantityN49627=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityBond_N49627", language+client);
        var quantityBCE=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityAdhoc1_BCE", language+client);
        var quantityApple=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityAdhoc2_Apple", language+client);
        var quantityDIS=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityAdhoc2_DIS", language+client);
        var quantityMicrosoft=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityAdhoc2_Microsoft", language+client);
        var quantityRONA=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityEquity_Rona ", language+client);
                                               
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        
        //Grouper par classe d'actifs
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Set_Text(assetAllocation);          
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",sleeveEquity,10).Click();
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",sleeveBond,10).Click(10, 10, skCtrl);        
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",sleeveBond,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
        
        //Ajouter un segment Adhoc1
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc1,"","","","",modelCan2)

        //Ajouter un segment Adhoc2
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc2,"","","","",modelAmericanEqui)

        //Modifier le segment 
        SelectSleeveWinSleevesManager(sleeveEquity)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager("","","","","",modelCanadianEqui);
        
        //Modifier le segment 
        SelectSleeveWinSleevesManager(sleeveBond)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager("","","","","",modelBonds);   

        //Transférer une quantité du solde = 497.91  vers 'Action'
        DivideBalance(unallocated,balance,balanceEquity,sleeveEquity);
        //Transférer une quantité du solde = 995.81  vers 'Adhoc1'
        DivideBalance(unallocated,balance,balanceAdhoc1,sleeveAdhoc1);
        //Transférer une quantité du solde = 995.91  vers 'Adhoc1'
        DivideBalance(unallocated,balance,balanceAdhoc2,sleeveAdhoc2);
        Get_WinManagerSleeves_BtnSave().Click();       
        Delay(1500)
                                                                 
        //Rééquilibrer  tous les segments
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click(); 
                                                                  
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance().Parent.Maximize();
        Get_WinRebalance_BtnNext().Click();
        
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();                  
        ChangeCashMgmt(sleeveEquity,depositEquity,""); 
        ChangeCashMgmt(sleeveBond,depositBond,"");
        ChangeCashMgmt(sleeveAdhoc1,depositAdhoc1,"");
        ChangeCashMgmt(sleeveAdhoc2,depositAdhoc2,"");
        Get_WinCashManagement_BtnOk().Click();
               
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
              
        //Valider que dans le segment 'Action': Achat 1190 Rona, Achat 635 BMO et Vente des autres positions
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveEquity,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",RONA,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",RONA,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityRONA);          
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityBMO);
        
        var count=Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Count
        for(var i=0; i<count;i++){
          if(i<2){
            aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "OrderType", cmpEqual, orderType);
          } 
          else{
            aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "OrderType", cmpEqual, orderTypeSell);
          }          
        } 
        
        //Valider que dans le segment 'Adhoc1': Achat 5 BCE 
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc1,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BCE,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BCE,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityBCE);  
         
        //Valider que dans le segment 'Adhoc2': Achat 2 Apple, Achat 18 Dis & Achat 12 Microsoft 
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc2,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",DIS,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",DIS,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityDIS);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",Microsoft,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",Microsoft,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityMicrosoft); 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",Apple,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",Apple,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityApple); 
        
        //Valider que dans le segment  'Obligation': Achat 228600 N49627  
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveBond,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",N49627,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",N49627,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityN49627); 
           
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les données*********************************************************    
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

