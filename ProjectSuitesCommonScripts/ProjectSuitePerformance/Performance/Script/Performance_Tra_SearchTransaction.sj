//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Transactions_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Tra_SearchTransaction(){

            var StopWatchObj = HISUtils.StopWatch;
            var SoughtForValue = "Performance_Tra_SearchTransaction_CIBC";
//            var account = GetData(filePath_Performance, sheetName_DataBD, 2, language);
//            var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
            
            var account       = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AccountNumber", language+client);
            var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);             

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

            Get_Toolbar_BtnSearch().Click();
            Get_WinTransactionsQuickSearch_TxtSearch().SetText(account);
            Get_WinTransactionsQuickSearch_RdoAccountNo().set_IsChecked(true);
            // Vérifie le bouton est prêt
            Get_WinTransactionsQuickSearch_BtnOK().WaitProperty("Enabled", true, 15000);
    
            // Mesure la performance recherche de transactions
            StopWatchObj.Start();
            Get_WinTransactionsQuickSearch_BtnOK().Click();
            WaitObject(Get_Transactions_ListView(), ["ClrClassName", "Text"], ["BrowserCellTemplateSimple", account], waitTimeShort);
            Get_Transactions_ListView().WaitProperty("IsInitialized", true, 15000);
            //Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "2"], 10).WaitProperty("VisibleOnScreen", true, 15000);
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