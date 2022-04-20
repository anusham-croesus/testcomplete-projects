//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Acc_ReportBtn(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Acc_ReportBtn";
//        var posAccount = GetData(filePath_Performance, sheetName_DataBD, 21, language);
//        var account = GetData(filePath_Performance, sheetName_DataBD, 2, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
      
        var account       = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AccountNumber", language+client);
        var posAccount    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionAccount6", language+client); 
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
        
        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);
   
        
        // Attend le module Comptes présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);

        //*********************************** Data ******************************
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().WaitProperty("VisibleOnScreen", true, 15000);
        
        Get_Toolbar_BtnReportsAndGraphs().Click();
        // Mesure la performance boutton info
        StopWatchObj.Start();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", "1"], waitTimeShort);
        Get_WinReports().WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Stop();
        
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());   
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        Get_WinReports_BtnClose().DblClick();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", "1"]);
        //WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        //Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "15"], 10).WaitProperty("VisibleOnScreen", true, 15000);

        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}

