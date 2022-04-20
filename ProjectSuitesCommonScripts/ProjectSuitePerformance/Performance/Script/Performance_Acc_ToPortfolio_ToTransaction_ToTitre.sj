//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Clients_Get_functions

/* Analyste d'assurance qualité: Julie Lamarche
Analyste d'automatisation: Xian Wei */

function Performance_Acc_ToPortfolio_ToTransaction_ToTitre(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue1 = "Performance_Acc_AccountToPortfolio";
        var SoughtForValue2 = "Performance_Acc_PortfolioToTransaction";
        var SoughtForValue3 = "Performance_Acc_TransactionToTitre";
        var SoughtForValue4 = "Performance_Acc_AccountBtnInfo";
        var SoughtForValue5 = "Performance_Acc_PortfolioBtnInfo";
        var SoughtForValue6 = "Performance_Acc_TransactionBtnInfo";
        var SoughtForValue7 = "Performance_Acc_TitreBtnInfo";
        var posPortfolio = 2 //GetData(filePath_Performance, sheetName_DataBD, 24, language);
        var posTransaction = 1 //GetData(filePath_Performance, sheetName_DataBD, 22, language);
        var posTitre = 1 //GetData(filePath_Performance, sheetName_DataBD, 23, language);
//        var criterionAccountsName = GetData(filePath_Performance, sheetName_DataBD, 29, language);
        var posAccount = 1 //GetData(filePath_Performance, sheetName_DataBD, 21, language);
//        var account = GetData(filePath_Performance, sheetName_DataBD, 2, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        
        var account       = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AccountNumber", language+client); 
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var criterionAccountsName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceAccounts", language+client);
        
        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);


        // Clique le module Comptes
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
//        
//        if (DataType == "Position"){
//            // ********************************* position ***************************
//            SelectSearchCriteria(criterionAccountsName);
//        
//            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posAccount], 10).Click();
//            // **********************************************************************
//        } else if (DataType == "Data"){
            // ********************************* Data *******************************
            // Recherche de comptes
            Search_Account(account);
            WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account,100).Click();
            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("IsLoaded", true, 15000);
            // **********************************************************************
//        }
        // *************** Mesure la performance boutton info (compte) *************
        StopWatchObj.Start();
        Get_AccountsBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "ClrFullClassName"], ["UniDialog", "com.unigiciel.components.windows.UniDialog"], waitTimeShort);
        Get_WinDetailedInfo().WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Split();
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue4 + " finished. Execution time: " + StopWatchObj.ToString());   
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue4);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        // Ferme la fenetre
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "ClrFullClassName"], ["UniDialog", "com.unigiciel.components.windows.UniDialog"], waitTimeShort);
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        // **************** Maillage un compte au module portefeuille **************
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posAccount], 10).Click();
        //Get_RelationshipsClientsAccountsGrid().Find("Value",account,100).Click();
        StopWatchObj.Start();
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posAccount], 10), Get_ModulesBar_BtnPortfolio());
        //Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,100), Get_ModulesBar_BtnPortfolio());
        WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4", waitTimeShort);
        Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "2"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Split();
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue1 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue1);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
        
        // ***************** Mesure la performance boutton info (portefeuille) ******
        Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posPortfolio], 10).Click();
        StopWatchObj.Start();
        Get_PortfolioBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(), "Uid", "PositionInfo_75ee", waitTimeShort);
        Get_WinPositionInfo().WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Split();
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue5 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue5);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        // Ferme la fenetre
        Get_WinPositionInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "PositionInfo_75ee", waitTimeShort);
        WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4");
        Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        
        // ***************** Maillage un portefeuille au module transaction *********
        Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posPortfolio], 10).Click();
        // Maillage portefeuille au module transactions
        StopWatchObj.Start();
        Drag(Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posPortfolio], 10), Get_ModulesBar_BtnTransactions());
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", waitTimeShort); 
        //Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Split();
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue2 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue2);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
       
        
        // ****************** Mesure la performance boutton info (transaction) ********
        Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", posTransaction], 10).Click();
        StopWatchObj.Start();
        Get_TransactionsBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "ClrFullClassName"], ["UniDialog", "com.unigiciel.components.windows.UniDialog"], waitTimeShort);
        Get_WinTransactionsInfo().WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Split();
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue6 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue6);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        // Ferme la fenetre
        Get_WinTransactionsInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "ClrFullClassName"], ["UniDialog", "com.unigiciel.components.windows.UniDialog"], waitTimeShort);
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
        Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        
        // ******************* Maillage transaction au module titre *******************
        Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", posTransaction], 10).Click();
        // Maillage un transactions au module titres
        StopWatchObj.Start();
        Drag(Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", posTransaction], 10), Get_ModulesBar_BtnSecurities());
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b", waitTimeShort);
        Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Split();
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue3 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue3);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
        
        // ****************** Mesure la performance boutton info (titre) ***************
        Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posTitre], 10).Click();
        StopWatchObj.Start();
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448", waitTimeShort);
        Get_WinInfoSecurity().WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Split();
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue7 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue7);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        // Ferme la fenetre
        Get_WinInfoSecurity_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448", waitTimeShort);
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b", 30000);
        Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
         // Retourne l'état initiale
        Get_ModulesBar_BtnAccounts().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1], waitTimeShort);
        
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}







function SelectSearchCriteria(criterion){
    
    // Clique le bouton gérer les critères de recherche
    Get_Toolbar_BtnManageSearchCriteria().Click();
    WaitObject(Get_CroesusApp(), ["ClrClassName", "Uid"], ["CriteriaManagerWindow", "ManagerWindow_efa9"], 30000);
    Get_WinSearchCriteriaManager().Parent.Maximize();
        
    // Clique le critère de recherche
    var rowCount = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.get_Count();
    for (var i = 0; i < rowCount; i++){
        displayedCriterionName = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
          if (displayedCriterionName == criterion){
            Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
            Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
            break;
          }
    }
    
    Get_WinSearchCriteriaManager_BtnRefresh().Click();
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 15000);
}