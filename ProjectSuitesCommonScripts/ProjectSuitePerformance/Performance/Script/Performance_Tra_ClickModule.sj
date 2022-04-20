//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Transactions_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Tra_ClickModule(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Tra_ClickModule";
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);  
    
        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);
    
        // Attend le module Transactions présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "7"]);
        Get_ModulesBar_BtnTransactions().WaitProperty("Enabled", true, 15000);

        // Mesure la performance clique le module Transactions
        StopWatchObj.Start();
        Get_ModulesBar_BtnTransactions().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", waitTimeShort);
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "12"], waitTimeShort);
        Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "12"], 10).WaitProperty("VisibleOnScreen", true, 15000);
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