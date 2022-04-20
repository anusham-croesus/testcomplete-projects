//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Relations_Get_functions
//USEUNIT Transactions_Get_functions

/* Analyste d'assurance qualité: CROES-6694
Analyste d'automatisation: Xian Wei */

function Performance_CROES_6694() {

          var StopWatchObj = HISUtils.StopWatch;
          var SoughtForValue = "Performance_CROES_6694";
          var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 

          try {
                    // Se connecte
                    Login(vServerPerformance, userNamePerformance, pswPerformance, language);

                    // Attend le dashboard s'affiche
                    WaitObject(Get_CroesusApp(), ["Uid"], ["ScrollViewer_0078"], waitTimeShort);
                    Get_Dashboard_NegativeCashBalanceSummaryBoard().WaitProperty("IsDataGridLayoutInitialized", true, waitTimeShort);

                    Get_MenuBar_Users().Click();
                    WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"],["PopupRoot", 1]);
                    Get_MenuBar_Users_Selection().Click();

                    StopWatchObj.Start();
                    WaitObject(Get_CroesusApp(), ["Uid"], ["UserMultiSelectionWindow_e5eb"], waitTimeShort);
                    Get_WinUserMultiSelection().WaitProperty("VisibleOnScreen", true, 15000);
                    StopWatchObj.Stop();

                    // Écrit le résultat dans le fichier excel
                    Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());
                    var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
                    WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

          } catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
          }
          finally {

                    Terminate_CroesusProcess(); //Fermer Croesus
                    Terminate_IEProcess();
          }

}