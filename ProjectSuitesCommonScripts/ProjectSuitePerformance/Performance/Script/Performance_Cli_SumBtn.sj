//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Clients_Get_functions
//USEUNIT ExcelUtils

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Cli_SumBtn(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Cli_SumBtn";
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
//        var cliFilterValueGreat = GetData(filePath_Performance, sheetName_DataBD, 56, language);
//        var filterValue3 = GetData(filePath_Performance, sheetName_DataBD, 59, language);

        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var filterValue3 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ValueFilter3", language+client);        
        var cliFilterValueGreat = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PerformanceClientValueGreat", language+client);        
        
        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);


        // Attend le module Clients présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "4"]);
        Get_ModulesBar_BtnClients().WaitProperty("Enabled", true, 15000);

        // Mesure la performance clique le module Clients
        Get_ModulesBar_BtnClients().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "15"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        //Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        //WaitObject(Get_Toolbar_BtnQuickFilters_ContextMenu(), ["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1]);
        
        //Get_Toolbar_BtnQuickFilters_ContextMenu().Find("WPFControlText", " #PerformanceClients total value > 9000000", 10).Click();
        //WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
        
        // Vérifie le bouton est prêt
        Get_Toolbar_BtnSum().WaitProperty("Enabled", true, 15000);

        // Mesure la performance clique le boutton sommation
        StopWatchObj.Start();
        Get_Toolbar_BtnSum().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "CRMSumWindow_106e", waitTimeShort);
        StopWatchObj.Stop();

        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        // Ferme la fenêtre sommation
        Get_WinRelationshipsClientsAccountsSum_BtnClose().DblClick();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CRMSumWindow_106e");
        
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
