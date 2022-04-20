//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT Performance_RCMBtn

/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

function Performance_RCM_BlotterDateChange(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_RCM_BlotterDateChange";
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var lastYearDate   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "LastYear", language+client);
        var waitTime = 3000;
        var column=FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue);
        
        try {
          // Se connecte
          Login(vServerPerformance, userNamePerformance, pswPerformance, language); 
           
          // Attendre le boutton RQS présent et actif
          WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
          Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
          Get_Toolbar_BtnRQS().Click();
          
          // Attendre l'onglet 'Transaction' présent et actif
          WaitObject(Get_WinRQS(), "Uid", "TabItem_c461",waitTime);
          Get_WinRQS_TabTransactionBlotter().WaitProperty("Enabled", true, waitTime)                    
          Get_WinRQS_TabTransactionBlotter().Click();
          
          // Vérifier la date du Blotter et l'absence de filtre
          Log.Message("Vérifier la date du Blotter et l'absence de filtre");
          var toDay = aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y")  
          if (Get_WinRQS_TabTransactionBlotter_BlotterControl_DateField().StringValue != toDay){
                    Get_WinRQS_TabTransactionBlotter_BlotterControl_DateField().Click(130,5);
                    WaitObject(Get_CroesusApp(), "WPFControlName","monthCalendar", waitTime);
                    Get_WinRQS_MonthCalendar_BtnToDay().Click();
                    Get_WinRQS_MonthCalendar_BtnOK().Click();
          }                   
          //Enlever tout les filtres appliqués
          var nbAcliveFilter = Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("ItemsControl", "", 1).DataContext.NbConditionInList;
          while(nbAcliveFilter > 0){
            Get_WinRQS_TabTransactionBlotter_BtnFilter(nbAcliveFilter).WPFObject("Button", "", 2).Click();
            nbAcliveFilter -= 1;
          }
          
          //Changer la date du blotter au 12/20/2018
          Log.Message("Modifier la date du Blotter au 12/20/2018");
          Get_WinRQS_TabTransactionBlotter_BlotterControl_DateField().Set_StringValue(lastYearDate);
          
          
          //Mesurer la performance de l'affichage des résultats
          StopWatchObj.Start();
          Get_WinRQS_TabTransactionBlotter_BlotterControl_DateField().Keys("[Enter]");
          WaitObject(Get_CroesusApp(), "Uid", "TransactionList_6af9", waitTimeShort);
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

function Get_WinRQS_TabTransactionBlotter_BtnFilter(WPFControlOrdinalNo){
        return Get_WinRQS_TabTransactionBlotter_BlotterControl().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["ToggleButton", WPFControlOrdinalNo, true], 10)}



