//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Transactions_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Tra_SumIcon() {

            var StopWatchObj = HISUtils.StopWatch;
            var SoughtForValue = "Performance_Tra_SumIcon";
            var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
    
            try {
            // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);
    
            // Attend le module Transactions présente et active
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "7"]);
            Get_ModulesBar_BtnTransactions().WaitProperty("Enabled", true, 15000);

            // Clique le module Transactions
            Get_ModulesBar_BtnTransactions().Click(); 
            WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "12"]);
            Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "12"], 10).WaitProperty("VisibleOnScreen", true, 15000);
            // Vérifie le bouton est prêt
            Get_Toolbar_BtnSum().WaitProperty("Enabled", true, 15000);
            
            Get_CroesusApp().WaitProperty("CPUUsage", 10, 5000); //Ajouté par Christophe lors de la conversion du projet de JScript à JavaScript
            Get_CroesusApp().WaitProperty("CPUUsage", 0, 50000); //Ajouté par Christophe lors de la conversion du projet de JScript à JavaScript
            Sys.Refresh(); //Ajouté par Christophe lors de la conversion du projet de JScript à JavaScript
    
            // Mesure la performance clique le boutton sommation  
            StopWatchObj.Start();
            Get_Toolbar_BtnSum().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", 1], waitTimeShort);
            Get_WinTransactionsSum().WaitProperty("VisibleOnScreen", true, 15000);
            StopWatchObj.Stop();

            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

            // Ferme la fenêtre sommation
            Get_WinTransactionsSum_BtnClose().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", 1]);
    
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}