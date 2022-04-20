//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Common_functions


/*
      
      Analyste d'automatisation: Sana Ayaz*/

function CopyFileDataPerformanceToPAfterEndOfExecution(){
    try{
      var localFolderPath="\\\\srvfs1\\pub\\aq\\Tests Automatisés\\Execution\\Performance_Croesus\\Performance\\"+ client + "\\"
       //Copier le fichier de résultats :data_Performance.xlsx dans P
   
        var newFilePerformanceResult="data_PerformanceBNC_"+aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S")+".xlsx";
        var PathToNewFile= localFolderPath + "PerformanceBNC_"+aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S")+".xlsx";        
        aqFileSystem.CopyFile(filePath_Performance, PathToNewFile)
        
        //Add ref
        var ref=GetRefPerfo()
        //var newFilePerformanceResult_1= ref+"_" + newFilePerformanceResult
        if(numberOfUsers!="Default"){aqFileSystem.RenameFile(localFolderPath+newresultLogFile,localFolderPath+ref+"_"+newresultLogFile );}        
        aqFileSystem.RenameFile(PathToNewFile,localFolderPath +ref+"_" + newFilePerformanceResult);
           
        
          
    }        
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {        
              
    }
}



function GetRefPerfo(){  
   var url = "https://nfrref.croesus.local/cgi-bin/index.cgi?group=nfr"        
   Log.Message("Launch the specified browser and opens the specified URL in it.");
   Browsers.Item("iexplore").Run(url);
   Sys.Browser(browserName).Page("*").Wait(); 
   var browser = Sys.Browser("iexplore");
   aqUtils.Delay(1000);
   var page = browser.Page("*");
   var RowIndex = page.Table(0).Find("contentText","nfrTestQA1",500).Parent.RowIndex
   //var ref = page.Table(0).Find("Id","74",500).contentText  //la case de la référence de nfrTestQA2
   var refText = page.Table(0).Cell(RowIndex,2).contentText  //la case de la référence de nfrTestQA2
   
   refText = aqString.Remove(refText, aqString.Find(refText, "--"),(aqString.GetLength(refText))-(aqString.Find(refText, "--")))
   return refText
}