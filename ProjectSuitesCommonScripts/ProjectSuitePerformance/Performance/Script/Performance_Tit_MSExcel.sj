//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Relations_Get_functions
//USEUNIT Transactions_Get_functions

/* Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Xian Wei */

function Performance_Tit_MSExcel() {

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Tit_MSExcel";
        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);

        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);

        // Attend le module Clients présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "8"]);
        Get_ModulesBar_BtnSecurities().WaitProperty("Enabled", true, 15000);
        // Clique le module Titres
        Get_ModulesBar_BtnSecurities().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b");
        Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "25"], 10).WaitProperty("VisibleOnScreen", true, 15000);

        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

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
        
        Get_ModulesBar_BtnSecurities().Click(); 
        
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}