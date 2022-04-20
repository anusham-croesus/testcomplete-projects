//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Relations_Get_functions
//USEUNIT Transactions_Get_functions

/* Analyste d'assurance qualité: JIRA BNC_1918
Analyste d'automatisation: Xian Wei */

function Performance_BNC_1918() {

          var StopWatchObj = HISUtils.StopWatch;
          var SoughtForValue = "Performance_BNC_1918";
          var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
          var critere = "1859 - Comptes";

          try {
                    // Se connecte
                    Login(vServerPerformance, userPerformanceBELAIRA, pswPerformanceBELAIRA, language);

                    // Attend le module Clients présente et active
                    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
                    Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
                    Get_ModulesBar_BtnAccounts().Click();
                    WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
                    Get_RelationshipsClientsAccountsGrid().WaitProperty("IsInitialized", true, 15000);

                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

                    
                    SelectSearchCriteria(critere);

                    // Clique le menu edit
                    Get_MenuBar_Edit().Click();
                    WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1]);
                    
                    StopWatchObj.Start();
                    Get_MenuBar_Edit_ExportToMsExcel().Click();
                    Sys.WaitProcess("EXCEL", waitTimeShort, 1);
                    Sys.FindChild("WndClass", "XLMAIN", 10).WaitProperty("Exists", true, waitTimeShort);
                    StopWatchObj.Stop();
                    CloseExcelProcess();

                    // Écrit le résultat dans le fichier excel
                    Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());
                    var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
                    WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);

          } catch (e) {
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