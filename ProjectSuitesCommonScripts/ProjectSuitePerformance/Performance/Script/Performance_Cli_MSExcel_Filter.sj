//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Relations_Get_functions
//USEUNIT Transactions_Get_functions

/* Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Xian Wei */

function Performance_Cli_MSExcel_Filter() {

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Cli_MSExcel_Filter";
//        var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);
//        var cliFilterValueGreat = GetData(filePath_Performance, sheetName_DataBD, 56, language);
//        var filterValue3 = GetData(filePath_Performance, sheetName_DataBD, 59, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var waitTimeLong = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        var filterValue3 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ValueFilter3", language+client);        
        var cliFilterValueGreat = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PerformanceClientValueGreat", language+client);        

        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);
   
        // Attend le module Clients présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "4"]);
        Get_ModulesBar_BtnClients().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnClients().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);

        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        WaitObject(Get_Toolbar_BtnQuickFilters_ContextMenu(), ["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1]);
        
        Get_Toolbar_BtnQuickFilters_ContextMenu().Find("WPFControlText", "#PerformanceClients total value > 9000000", 10).Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);

        // Clique le menu edit
        Get_MenuBar_Edit().Click();
        
        StopWatchObj.Start();
        Get_MenuBar_Edit_ExportToMsExcel().Click();
        Sys.WaitProcess("EXCEL", waitTimeLong, 1);
        Sys.FindChild("WndClass","XLMAIN",10).WaitProperty("Exists", true, waitTimeLong);
        StopWatchObj.Stop();
        CloseExcelProcess();
            
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
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