//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Titres_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Tit_SearchCriteria(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Tit_SearchCriteria";
        var searchCriterionName = GetData(filePath_Performance, sheetName_DataBD, 32, language);
        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);

        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);

        // Attend le module Titres présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "8"]);
        Get_ModulesBar_BtnSecurities().WaitProperty("Enabled", true, 15000);

        // Clique le module Titres
        Get_ModulesBar_BtnSecurities().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b");
        Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "25"], 10).WaitProperty("VisibleOnScreen", true, 15000);
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
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b", waitTimeShort);
        Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Stop();
    
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
       
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}