//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Performance_RCMBtn

/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

function Performance_RCM_SwitchTransactionBlotterToSecurityAlertsTab(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_RCM_SwitchTransactionBlotterToSecurityAlertsTab";
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var waitTime = 5000;
        var column=FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue);

        try {
          // Se connecte
          Login(vServerPerformance, userNamePerformance, pswPerformance, language);
            
          // Attendre le boutton RQS présent et actif
          WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
          Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
          Get_Toolbar_BtnRQS().Click();
          
          // Attendre l'onglet 'Transaction' présent et actif
          WaitObject(Get_WinRQS(), "Uid", "TabItem_c461", waitTime);
          Get_WinRQS_TabTransactionBlotter().WaitProperty("Enabled", true, waitTime)                    
          Get_WinRQS_TabTransactionBlotter().Click();
          
          // Attendre l'onglet 'Security Alerts' présent et actif
          WaitObject(Get_CroesusApp(), "Uid", "TabItem_258c", waitTime);
          Get_WinRQS_TabSecurityAlerts().WaitProperty("Enabled", true, waitTime)                               
          
          // Mesurer la performance de l'onglet 'Security Alerts'       
          StopWatchObj.Start();
          Get_WinRQS_TabSecurityAlerts().Click(); 
          Get_WinRQS_TabSecurityAlerts().WaitProperty("IsSelected", true, waitTimeShort);
          var timeSpotted=StopWatchObj.Split()/1000
          StopWatchObj.Stop();
        
          // Écrit le résultat dans le fichier excel
          Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());
          /*var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), timeSpotted);*/
                   
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