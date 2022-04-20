//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT Performance_RCMBtn


/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

function Performance_RCM_SwitchTransactionBlotterToAlertsTab(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_RCM_SwitchTransactionBlotterToAlertsTab";
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var waitTime = 3000;
        var alertStatusDate = "2019";
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
          
          // Attendre l'onglet 'Alerts' présent et actif
          WaitObject(Get_CroesusApp(), "Uid", "TabItem_a70d", waitTime);
          Get_WinRQS_TabAlerts().WaitProperty("Enabled", true, waitTime)                   
          Get_WinRQS_TabAlerts().Click(); 
          
          //Fermer la fenêtre de dialogue
          SetAutoTimeOut();
          if(Get_DlgWarning().Exists){
               Get_DlgWarning_BtnOK().Click();} 
          WaitObject(Get_CroesusApp(), "Uid", "AlertsControl_53a1", waitTime);
          Get_WinRQS_TabAlerts().WaitProperty("IsSelected", true, waitTime);
              
          /* Changer la date du filte à 2019
          Get_WinRQS_TabAlerts_CmbAlertStatusDatePicker().Click();
          if(Get_SubMenus().Exists){
              Get_SubMenus().Find("Text",alertStatusDate,10).Click();}  
          RestoreAutoTimeOut();*/
          
          //Adaptation des scripts cas le filter 2019 n'existe plus 
          var dateFrom ="";
          var dateTo ="";
          if(language=="french"){
                dateFrom="20190101";
                dateTo ="20191231";
          }else{
                dateFrom="01012019";
                dateTo ="12312019";
          };
          ChangeDateOfLastAlertStatus(dateFrom,dateTo);
          
          // Mesurer la performance de l'onglet 'Alerts'       
          StopWatchObj.Start();
          WaitObject(Get_CroesusApp(), "Uid", "AlertsControl_53a1", waitTimeShort);   //Attendre la grille des Alerts
          Get_WinRQS_TabAlerts().WaitProperty("IsSelected", true, waitTime);
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