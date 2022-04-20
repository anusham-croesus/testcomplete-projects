//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: CROES-11353
Analyste d'automatisation: Xian Wei */

function Performance_Acc_CROES_11353_SearchCriteriaNBC4415(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Acc_CROES_11353_SearchCriteriaNBC4415";
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
//        var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);
//        var searchCriterionName = GetData(filePath_Performance, sheetName_DataBD, 43, language);
        
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        var searchCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionName", language+client);
        
        var waitTime = 4800000;
        
        try {
        // Se connecte
        Login(vServerPerformance, userPerformanceBELAIRA, pswPerformanceBELAIRA, language);


        // Clique le module Comptes
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        // Vérifie le bouton est prêt
        Get_Toolbar_BtnManageSearchCriteria().WaitProperty("Enabled", true, 15000);
    
        // Clique le bouton gérer les critères de recherche
        Get_Toolbar_BtnManageSearchCriteria().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "Uid"], ["CriteriaManagerWindow", "ManagerWindow_efa9"]);
        Get_WinSearchCriteriaManager().Parent.Maximize();
        
        // Clique le critère de recherche
        var rowCount = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.get_Count();
        for (var i = 0; i < rowCount; i++){
            displayedCriterionName = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
              if (displayedCriterionName == searchCriterionName){
                Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
                Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
                break;
              }
        }
    
        // Mesuse la performance le critère de recherche
        StopWatchObj.Start();
        Get_WinSearchCriteriaManager_BtnRefresh().Click();
        //WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeLong);
        //Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "ManagerWindow_efa9", waitTime);//ProgressCroesusWindow_b5e1
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo","VisibleOnScreen"], ["ToggleButton", 1, true]);
        StopWatchObj.Stop();
    
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        //Fermer le critère de recherche     
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}