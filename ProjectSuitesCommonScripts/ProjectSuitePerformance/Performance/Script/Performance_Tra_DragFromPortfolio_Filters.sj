//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Portefeuille_Get_functions
//USEUNIT Transactions_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Tra_DragFromPortfolio_Filters(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Tra_DragFromPortfolio_Filters";
//        var criterionAccountsName = GetData(filePath_Performance, sheetName_DataBD, 29, language);
//        var posAccount = GetData(filePath_Performance, sheetName_DataBD, 21, language);
//        var posPortfolio = GetData(filePath_Performance, sheetName_DataBD, 24, language);
//        var posTransaction = GetData(filePath_Performance, sheetName_DataBD, 22, language);
//        var nom = GetData(filePath_Performance, sheetName_DataBD, 11, language);
//        var posTraFilter = GetData(filePath_Performance, sheetName_DataBD, 26, language);
//        var account = GetData(filePath_Performance, sheetName_DataBD, 2, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        
        var nom            = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "OptionFilterTrans", language+client); 
        var account        = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AccountNumber", language+client);
        var posAccount     = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionAccount6", language+client);
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
        var posTraFilter   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionTransFilter5", language+client); 
        var posTransaction = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionTransaction20", language+client); 
        var posPortfolio   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionPortfolio1", language+client);      
        var criterionAccountsName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceAccounts", language+client);        

        try {
    
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);
    
        // Clique le module Comptes
        Delay(1000);
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"], 30000);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
    
//        if (DataType == "Position"){
//            //******************************* position ******************************
//            SelectSearchCriteria(criterionAccountsName);
//    
//            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posAccount], 10).Click();
//  
//            // Maillage un comptes au module portefeuille
//            Drag(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posAccount], 10), Get_ModulesBar_BtnPortfolio());
//            WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4", 30000);
//            Get_Portfolio_PositionsGrid().WaitProperty("VisibleOnScreen", true, 15000);
//            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posPortfolio], 10).Click();
//   
//            // Maillage portefeuille au module transactions
//            Drag(Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posPortfolio], 10), Get_ModulesBar_BtnTransactions());
//            WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", 30000); 
//            Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
//               
//            // Vérifie le bouton est prêt
//            Get_Toolbar_BtnQuickFilters().Click();
//            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", 1], 30000);
//            //Get_Toolbar_BtnQuickFilters_ContextMenu_Item(nom).WaitProperty("Enabled", true, 15000);
//            Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckMenu", posTraFilter], 10).WaitProperty("Enabled", true, 15000);
//    
//            // Mesure la performance de filtre
//            StopWatchObj.Start();
//            //Get_Toolbar_BtnQuickFilters_ContextMenu_Item(nom).Click();
//            Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckMenu", posTraFilter], 10).Click();
//            Aliases.CroesusApp.winMain.barToolbar.WPFObject("QuickFilterWidgetContainer").WPFObject("ClickBox", nom, 1).WaitProperty("IsChecked", true, waitTimeShort);
//            StopWatchObj.Stop();
//            //***********************************************************************
//        } else if (DataType == "Data"){
        //******************************** Data *********************************
            // Recherche de comptes
            Search_Account(account);
            WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 30000);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account,1000).Click();
  
            // Maillage un compte au module portefeuille
            Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,1000), Get_ModulesBar_BtnPortfolio());
            WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4", 30000);
            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posPortfolio], 10).Click();
        
            // Maillage portefeuille au module transactions
            Drag(Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posPortfolio], 10), Get_ModulesBar_BtnTransactions());
            WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", 30000); 
            Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "2"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
            // Vérifie le bouton est prêt
            Get_Toolbar_BtnQuickFilters().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", 1], 30000);
            //Get_Toolbar_BtnQuickFilters_ContextMenu_Item(nom).WaitProperty("Enabled", true, 15000);
            Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckMenu", posTraFilter], 10).WaitProperty("Enabled", true, 15000);
    
            // Mesure la performance de filtre
            StopWatchObj.Start();
            Get_Toolbar_BtnQuickFilters_ContextMenu_Item(nom).Click();
            //Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckMenu", posTraFilter], 10).Click();
            Aliases.CroesusApp.winMain.barToolbar.WPFObject("QuickFilterWidgetContainer").WPFObject("ClickBox", nom, 1).WaitProperty("IsChecked", true, waitTimeShort);
            StopWatchObj.Stop();
            //***********************************************************************
//        }

        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        // Ferme la filtre de recherche
        //WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", 30000);
        //Get_Toolbar_BtnQuickFilters().Click();
        //Get_Toolbar_BtnQuickFilters_ContextMenu_NoFilter().Click();
        Aliases.CroesusApp.winMain.barToolbar.WPFObject("QuickFilterWidgetContainer").WPFObject("ClickBox", nom, 1).Click();
        Aliases.CroesusApp.winMain.barToolbar.WPFObject("QuickFilterWidgetContainer").WPFObject("ClickBox", nom, 1).WaitProperty("IsChecked", false);
        //Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        //Delay(3000);
        
        // Retourne l'état initiale
        //Get_ModulesBar_BtnAccounts().Click(); 
        //WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
        //Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        //Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
        Terminate_CroesusProcess();

        }
    
        catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
            Terminate_IEProcess();
        }
}



function Get_Toolbar_BtnQuickFilters_ContextMenu_Item(FilterName){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", FilterName], 10)}

function Get_Toolbar_BtnQuickFilters_ContextMenu_NoFilter() 
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", "< Aucun filtre >"], 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", "< No Filter >"], 10)}
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