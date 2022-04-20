//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Clients_Get_functions
//USEUNIT ExcelUtils

/* Analyste d'assurance qualité: Xian Wei
Analyste d'automatisation: Xian Wei */

function Performance_Ord_SumBtn(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Ord_SumBtn";
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);

        try {
            // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);

            // Attend le module ordres présente et active
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", 9]);
            Get_ModulesBar_BtnOrders().WaitProperty("Enabled", true, 15000);

            // Clique le module ordres
            Get_ModulesBar_BtnOrders().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_e262");
            Get_OrderGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

        
            // Vérifie le bouton est prêt
            Get_Toolbar_BtnSum().WaitProperty("Enabled", true, 15000);
             Get_Toolbar_BtnSum().Click(); 

            // Mesure la performance clique le boutton sommation
            StopWatchObj.Start();
        
            Get_WinOrdersSum_BtnClose().WaitProperty("VisibleOnScreen", true,waitTimeShort);          
//            WaitObject(Get_CroesusApp(), "Uid", "OrderEntrySumWindow_c8ca", waitTimeShort);
            StopWatchObj.Stop();

            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

            // Ferme la fenêtre sommation
            Get_WinOrdersSum_BtnClose().Click(); 
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "OrderEntrySumWindow_c8ca");
            
        }
        catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
            Terminate_CroesusProcess(); //Fermer Croesus
            Terminate_IEProcess();
        }

}
