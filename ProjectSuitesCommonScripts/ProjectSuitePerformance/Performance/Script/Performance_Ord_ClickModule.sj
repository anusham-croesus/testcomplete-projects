//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: Xian Wei
Analyste d'automatisation: Xian Wei */

function Performance_Ord_ClickModule(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Ord_ClickModule";
        //var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);

        try {
            // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);
            
            // Attend le module ordres présente et active
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", 9]);
            Get_ModulesBar_BtnOrders().WaitProperty("Enabled", true, 15000);
    
            // Mesure la performance clique le module Ordres
            StopWatchObj.Start();
            Get_ModulesBar_BtnOrders().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_e262");
            Get_OrderGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
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