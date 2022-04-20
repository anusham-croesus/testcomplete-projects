//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT Performance_RCMBtn

/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

      
function Performance_RCM_QueryLogStatusClosed(){
  
        var statusValue = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "StatusValueClosed", language+client);

        Performance_RCM_QueryLogStatus(statusValue,"Performance_RCM_QueryLogStatusClosed");     
}


function Performance_RCM_QueryLogStatus(status,SoughtForValue){
          
            var StopWatchObj     = HISUtils.StopWatch;           
            var waitTimeShort    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);  
            var queryLogFromDate = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "QueryLogFromDate", language+client); 
            var waitTimeLong     = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
            var messageQuery     = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "MessageQuery", language+client);       
            var waitTime = 3000;
            var column=FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue);
                  
        try {
          // Se connecte
          Login(vServerPerformance, userNamePerformance, pswPerformance, language);
           Log.Message("Status : "+status) ;
          // Attendre le boutton RQS présent et actif
          WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005",waitTime);
          Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
          Get_Toolbar_BtnRQS().Click();
          
          // Attendre l'onglet 'Transaction' présent et actif
          WaitObject(Get_WinRQS(), "Uid", "TabItem_c461",waitTime);
          Get_WinRQS_TabTransactionBlotter().WaitProperty("Enabled", true, waitTime)                    
          Get_WinRQS_TabTransactionBlotter().Click();
          
          // Ouvrir la fenêtre 'Query log' et modifier la date 'From'        
          Get_WinRQS_BtnQueryLog().Click();
          Get_WinQueryLog_GrpTransactionBlotterDate_DateFrom().Keys(queryLogFromDate);//Set_StringValue
          
          Get_WinQueryLog_GrpLastStatus_CmbStatus().Click();
          if(Get_SubMenus().Exists)
                  Get_SubMenus().Find("WPFControlText",status,10).Click();
          Get_WinQueryLog_GrpLastStatus_DateFrom().Click();
          Get_WinQueryLog_GrpLastStatus_DateFrom().Keys(queryLogFromDate);                      
          Get_WinQueryLog_BtnGenerate().Click();
          
          //Mesurer la performance de génération de querylog
          StopWatchObj.Start();
          //WaitObject(Get_WinRQS(), "Uid", "ProgressCroesusWindow_b5e1",waitTime);
          Get_CroesusApp().FindChild("Uid","ProgressBar_6991",10).WaitProperty("Value", "100", waitTimeLong)
          if(Get_CroesusApp().FindChild("Uid","ProgressBar_6991",10).DataContext.Message = messageQuery){
            Sys.WaitProcess("EXCEL", waitTimeLong, 1);
            Sys.FindChild("WndClass","XLMAIN",10).WaitProperty("Exists", true, waitTimeLong);
          }
          //WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_02d6");  
          //WaitObject(Get_CroesusApp(), "Uid", "TransactionList_6af9",waitTimeShort);
          var timeSpotted=StopWatchObj.Split()/1000        
          StopWatchObj.Stop();
                
          // Écrit le résultat dans le fichier excel
          Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
          /*var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), timeSpotted);*/
          
          var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);
          
          //fermer les fenêtres   
          Get_DlgProgressCroesus_BtnOK().Click();
                      
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
          //Fermer Croesus
          TerminateProcess("CroesusClient");
        }     

}
//
//function Get_WinRQS_BtnQueryLog(){
//        return Get_WinRQS().FindChild("Uid", "Button_02d6", 10)}
//
//function Get_WinQueryLog(){
//        return Get_CroesusApp().FindChild("Uid", "QuerylogView_b490", 10)}
//        
//function Get_WinQueryLog_BtnGenerate(){
//        return Get_WinQueryLog().FindChild("Uid", "Button_3c68", 10)}
//        
//function Get_WinQueryLog_BtnClose(){
//        return Get_WinQueryLog().FindChild("Uid", "Button_839a", 10)}
//
//function Get_WinQueryLog_GrpTransactionBlotterDate(){
//        return Get_WinQueryLog().FindChild("Uid", "GroupBox_06ba", 10)}
//
//function Get_WinQueryLog_GrpTransactionBlotterDate_DateFrom(){
//        return Get_WinQueryLog_GrpTransactionBlotterDate().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DateField",1], 10)}   
//        
//function Get_WinQueryLog_GrpLastStatus(){
//        return Get_WinQueryLog().FindChild("Uid", "GroupBox_fb84", 10)}
//
//function Get_WinQueryLog_GrpLastStatus_CmbStatus(){
//        return Get_WinQueryLog_GrpLastStatus().FindChild("Uid", "ComboBox_5794", 10)}