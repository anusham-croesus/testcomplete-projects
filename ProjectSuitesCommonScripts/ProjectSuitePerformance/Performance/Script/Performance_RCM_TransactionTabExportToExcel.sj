//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Performance_RCMBtn

/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

function Performance_RCM_TransactionTabExportToExcel(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_RCM_TransactionTabExportToExcel";
        var waitTimeLong   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        var waitTime = 5000;
        var column=FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue);
        
        try {
          // Se connecte
          Login(vServerPerformance, userNamePerformance, pswPerformance, language);
            
          // Attendre le boutton RQS présent et actif
          WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005",waitTime);
          // wait for loading grids 
          while(Get_CroesusApp().FindChild("Uid","ScrollViewer_0078",10).FindChild(["ClrClassName", "WPFControlName"],["VirtualizingDataRecordCellPanel","ContentItemGrid"],10).Exists==false){
            Delay(waitTime);
          };
          Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
          Get_Toolbar_BtnRQS().Click();
          
          // Attendre l'onglet 'Transaction' présent et actif
          WaitObject(Get_WinRQS(), "Uid", "TabItem_c461",waitTime);
          Get_WinRQS_TabTransactionBlotter().WaitProperty("Enabled", true, waitTime)                    
          Get_WinRQS_TabTransactionBlotter().Click();
          
          // Attendre le button 'Export to Excel' présent et actif dans l'onglet 'Transaction'
          WaitObject(Get_WinRQS_TabTransactionBlotter_BlotterControl(), ["ClrClassName", "WPFControlOrdinalNo"], ["Button", "3"],waitTime);
          Get_WinRQS_TabTransactionBlotter_BtnExportToExcel().WaitProperty("Enabled", true, waitTime)
          
          //Mesurer la performance de l'export
          Get_WinRQS_TabTransactionBlotter_BtnExportToExcel().Click();
          StopWatchObj.Start();          
          Sys.WaitProcess("EXCEL", waitTimeLong, 1);
          Sys.FindChild("WndClass","XLMAIN",10).WaitProperty("Exists", true, waitTimeLong);
          var timeSpotted=StopWatchObj.Split()/1000
          StopWatchObj.Stop();
          CloseExcelProcess();
          
          //fermer la fenêtre 
          Get_WinRQS().Close();
                
          // Écrit le résultat dans le fichier excel
          Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
          /*var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), timeSpotted);//StopWatchObj.ToString() */ 
          
          var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);   
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
          //Fermer Croesus
          TerminateProcess("CroesusClient"); 

        }
}