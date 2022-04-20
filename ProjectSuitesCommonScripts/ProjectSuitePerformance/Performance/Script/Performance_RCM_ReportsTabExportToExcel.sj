//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Performance_RCMBtn

/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

function Performance_RCM_ReportsTabExportToExcel(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_RCM_ReportsTabExportToExcel";
        var waitTimeLong   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        var waitTime = 3000;
        //Indice du type du rapport (Offside Account) dans la liste des types
        var reportTypeIndex = 4;
        var column=FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue);
        
        try {
          // Se connecte
          Login(vServerPerformance, userNamePerformance, pswPerformance, language);
            
          // Attendre le boutton RQS présent et actif
          WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005",waitTime);
          Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
          Get_Toolbar_BtnRQS().Click();
          
          // Attendre l'onglet 'Reports' présent et actif dans la fenêtre RQS
          WaitObject(Get_WinRQS(), "Uid", "TabItem_3a3b",waitTime);
          Get_WinRQS_TabReports().WaitProperty("Enabled", true, waitTime)                    
          Get_WinRQS_TabReports().Click();
          
          // Attendre le ComboBox 'Report Type' présent et actif dans l'onglet 'Reports'
          WaitObject(Get_WinRQS_TabReports(), "Uid", "ComboBox_7f10",waitTime);
          Get_WinRQS_TabReports_CmbReportType().WaitProperty("Enabled", true, waitTime);          
          Get_WinRQS_TabReports_CmbReportType().Click();
          
          //Choisir le type 'Offside Accounts' (numero 4) dans Report Type
          Delay(1500)
          Get_WinRQS_TabReports_CmbReportType_CmbItem(reportTypeIndex).Click();
          
          //Attendre le boutton 'Display Report'
          WaitObject(Get_CroesusApp(), "Uid", "Button_e946",waitTime);
          Get_WinRQS_TabReports_BtnDisplayReport().WaitProperty("Enabled", true, waitTime);
          Get_WinRQS_TabReports_BtnDisplayReport().Click();
          
          //Attendre le boutton 'Export To Excel'
          WaitObject(Get_WinRQS_TabReports_ReportsControl(), ["ClrClassName", "WPFControlOrdinalNo"], ["Button", "3"],waitTime);
          Get_WinRQS_TabReports_BtnExportToExcel().WaitProperty("Enabled", true, waitTime)
          
          //Mesurer la performance de l'export          
          Get_WinRQS_TabReports_BtnExportToExcel().Click();
          StopWatchObj.Start();
          Sys.WaitProcess("EXCEL", waitTimeLong, 1);
          Sys.FindChild("WndClass","XLMAIN",10).WaitProperty("Exists", true, waitTimeLong);
          var timeSpotted=StopWatchObj.Split()/1000
          StopWatchObj.Stop();
          CloseExcelProcess();
                
          // Écrit le résultat dans le fichier excel
          Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
          /*var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), timeSpotted); */ 
          
          var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);
          
          //fermer la fenêtre 
          Get_WinRQS().Close();   
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
         //Fermer Croesus
         TerminateProcess("CroesusClient");
        }
}
