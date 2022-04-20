//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA

/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

function Performance_RCMBtn(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_RCMBtn";
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var waitTime = 3000;
        var column=FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue);
        
        try {
          // Se connecte
          Login(vServerPerformance, userNamePerformance, pswPerformance, language);
            
          // Attendre le boutton RQS présent et actif
          WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
          
          // wait for loading grids 
          do {Delay(waitTime);      
          } while (!Get_CroesusApp().FindChild("ClrClassName","UpperCashBalanceSummaryBoard",10).FindChild(["ClrClassName", "WPFControlName"],["VirtualizingDataRecordCellPanel","ContentItemGrid"],10).Exists)

          Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);
                
          // Mesurer la performance boutton RQS
          Get_Toolbar_BtnRQS().Click();
          StopWatchObj.Start();               
          //WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["AlertsManagementWindow", "_activityBlotterManagerWindow"], waitTimeShort);
          Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter","1"], 10).WaitProperty("VisibleOnScreen", true, waitTime);
          Get_WinRQS().WaitProperty("VisibleOnScreen", true, waitTime);
          var timeSpotted=StopWatchObj.Split()/1000
          StopWatchObj.Stop();
          
          //fermer la fenêtre 
          Get_WinRQS().Close();
        
          // Écrit le résultat dans le fichier excel
          Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());
          Log.Message(timeSpotted)
          /*var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), timeSpotted);//StopWatchObj.ToString() */          

          // Écrit le résultat dans le fichier excel
        
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

function FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue){
  

    switch(numberOfUsers) {

      case 50:
            var column=14;
            for(i=1;i<11;i++){
               if(aqString.GetLength(aqConvert.VarToStr(ReadDataFromExcelByRowIDColumnID(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue, column)))== 0  ){//ReadDataFromExcelByRowIDColumnID(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue, cell)=="" ||                              
                 break;   
               }else{
                  column++      
               }
            }
            return column;
            break;
     case 75:
            var column=27;
            for(i=1;i<11;i++){
               if(aqString.GetLength(aqConvert.VarToStr(ReadDataFromExcelByRowIDColumnID(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue, column)))== 0  ){//ReadDataFromExcelByRowIDColumnID(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue, cell)=="" ||                              
                 break;   
               }else{
                  column++      
               }
            }           
           return column;
           break;
           
      default:
            var column=1;
            for(i=1;i<11;i++){
               if(aqString.GetLength(aqConvert.VarToStr(ReadDataFromExcelByRowIDColumnID(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue, column)))== 0  ){//ReadDataFromExcelByRowIDColumnID(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue, cell)=="" ||                              
                 break;   
               }else{
                  column++      
               }
            }
            return column;
            break;
           
    }    
}


function FindRow(filePath, sheetName, SoughtForValue, displayErrorIfNotFound)
{
    var Driver = DDT.ExcelDriver(filePath, sheetName, true);
    var i=1;
    var rowNum;
    var isFound = false;
    
        // Iterates through records
        while (! Driver.EOF()) {
            i++;
            if (Driver.Value(0)==SoughtForValue){
                rowNum = i;
                isFound = true;
                break; 
            }
            
            Driver.Next();
        }
    
    // Closes the driver
    DDT.CloseDriver(Driver.Name);
    
    if (isFound)
        return rowNum;
    
    if (displayErrorIfNotFound == undefined || displayErrorIfNotFound == true)
        Log.Error("la valeur de recherche n'existe pas");
    
    return null;
}
