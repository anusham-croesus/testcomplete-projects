//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Clients_Get_functions

/* Analyste d'assurance qualité: Julie Lamarche
Analyste d'automatisation: Xian Wei */

function Performance_Cli_ToAccount_ToPortfolio_ToTransaction_ToTitre(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue1 = "Performance_Cli_ClientToAccount";
        var SoughtForValue2 = "Performance_Cli_AccountToPortfolio";
        var SoughtForValue3 = "Performance_Cli_PortfolioToTransaction";
        var SoughtForValue4 = "Performance_Cli_TransactionToTitre";
        
        var posPortfolio = 1 //GetData(filePath_Performance, sheetName_DataBD, 24, language);
        var posTransaction = 1 //GetData(filePath_Performance, sheetName_DataBD, 22, language);
        var posTitre = 1 //GetData(filePath_Performance, sheetName_DataBD, 23, language);
        var posAccount = 1 //GetData(filePath_Performance, sheetName_DataBD, 21, language);
//        var criterionClientsName = GetData(filePath_Performance, sheetName_DataBD, 30, language);
        var posClient = 2 //GetData(filePath_Performance, sheetName_DataBD, 20, language);
//        var client = GetData(filePath_Performance, sheetName_DataBD, 3, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);

        var clientNo      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ClientNumber", language+client);
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
        var criterionClientsName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceClients", language+client);       
        
        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);


        // Clique le module Clients
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "4"]);
        Get_ModulesBar_BtnClients().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnClients().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "25"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
//        if (DataType == "Position"){
//            // ********************************* position *****************************    
//            SelectSearchCriteria(criterionClientsName);
//
//            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posClient], 10).Click();   
//            //*************************************************************************
//        } else if (DataType == "Data"){     
            // ********************************* Data *********************************
            // Recherche de clients
            Search_Client(clientNo);
            WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
            Get_RelationshipsClientsAccountsGrid().Find("Value",clientNo,1000).Click(); 
            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("IsLoaded", true, 15000);
            // *************************************************************************
//        }
        // ****************** Maillage un client au module comptes *****************
        StopWatchObj.Start();
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posClient], 10), Get_ModulesBar_BtnAccounts());
        //Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",clientNo,1000), Get_ModulesBar_BtnAccounts());
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Split();
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue1 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue1);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
        
        // **************** Maillage un compte au module portefeuille **************
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posAccount], 10).Click();
        StopWatchObj.Start();
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posAccount], 10), Get_ModulesBar_BtnPortfolio());
        WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4", waitTimeShort);
        Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Split();
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue2 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue2);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
        
        // ***************** Maillage un portefeuille au module transaction *********
        Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posPortfolio], 10).Click();
        // Maillage portefeuille au module transactions
        StopWatchObj.Start();
        Drag(Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posPortfolio], 10), Get_ModulesBar_BtnTransactions());
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", waitTimeShort); 
        Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Split();
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue3 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue3);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
        
        // ******************* Maillage transaction au module titre *******************
        Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", posTransaction], 10).Click();
        // Maillage un transactions au module titres
        StopWatchObj.Start();
        Drag(Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", posTransaction], 10), Get_ModulesBar_BtnSecurities());
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b", waitTimeShort);
        Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Split();
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue4 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue4);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
        // Retourne l'état initiale
        Get_ModulesBar_BtnClients().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "25"], 10).WaitProperty("VisibleOnScreen", true, 15000);
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