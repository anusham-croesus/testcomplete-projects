//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Transactions_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Tra_InfoBtn(){

            var StopWatchObj = HISUtils.StopWatch;
            var SoughtForValue = "Performance_Tra_InfoBtn";
//            var posTransaction = GetData(filePath_Performance, sheetName_DataBD, 22, language);
//            var account = GetData(filePath_Performance, sheetName_DataBD, 2, language); 
//            var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);  
            
            var account        = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AccountNumber", language+client);
            var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
            var posTransaction = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionTransaction20", language+client);                  
             
            try {
            // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);
    
            // Attend le module Transactions présente et active
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "7"], 30000);
            Get_ModulesBar_BtnTransactions().WaitProperty("Enabled", true, 15000);

            // Clique le module Transactions
            Get_ModulesBar_BtnTransactions().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", 30000);
            WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["BrowserCellTemplateSimple", 1], waitTimeShort);
            

            //if (DataType == "Position"){
                //****************************** position ***************************
                Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", posTransaction], 10).Click();
                Get_TransactionsBar_BtnInfo().WaitProperty("Enabled", true, 15000);
                //*******************************************************************
            /*} else if (DataType == "Data"){
            
                //********************************* Data ****************************
                // Recherche de transactions
                Search_Transactions_Account(account);
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "QuickSearchWindow_7bf0", waitTimeShort);
                WaitObject(Get_Transactions_ListView(), ["ClrClassName", "Text"], ["BrowserCellTemplateSimple", account]);
                Get_Transactions_ListView().FindChild(["ClrClassName", "Text", "WPFControlOrdinalNo"], ["BrowserCellTemplateSimple", account, 1], 100).Click(); 
                Get_TransactionsBar_BtnInfo().WaitProperty("Enabled", true, 15000);
                //*******************************************************************
            }*/
            
            // Mesure la performance boutton info
            StopWatchObj.Start();
            Get_TransactionsBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "ClrFullClassName"], ["UniDialog", "com.unigiciel.components.windows.UniDialog"], waitTimeShort);
            StopWatchObj.Stop();

            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
    
            // Ferme la fenetre
            Get_WinTransactionsInfo_BtnOK().Click();
            //WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", 1]);
            //WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", 30000);
            //Get_Transactions_ListView().WaitProperty("VisibleOnScreen", true, 15000);

        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}