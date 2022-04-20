//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT RunSimulator_TCVE_969

/*
      
      Analyste d'automatisation: Youlia R*/

function StopSimulator_TCVE_969(){
    try{
      
           var remoteDestinationFolder="/root/";
           var localFolderPath="\\\\srvfs1\\pub\\aq\\Tests Automatisés\\Execution\\Performance_Croesus\\Performance\\"+ client + "\\"
           var resultLogFile="loadsimulator.csv" // le nom de fichier log généré sur le vserveur âpres le lancement de simulateur           
          
                      
           if(numberOfUsers!="Default"){
               
                Log.Message("copier le fichier de resultat (LOG- loadsimulator.csv)");                
                CopyFileFromVserverThroughWinSCP(vServerPerformance, remoteDestinationFolder+resultLogFile, localFolderPath);
                
                Log.Message("'STOP' le vserveur ");  
                StopStartVserveurNFRTestQA2("stop stop remove");
                Log.Message("'START' le vserveur "); 
                StopStartVserveurNFRTestQA2("push assemble start");
           
                /* supprimer le fichier log de vserveur 
                ExeSSHCommand("", vServerPerformance, "rm loadsimulator.csv ", "root")*/

                Log.Message("Renomer le fichier 'loadsimulator.csv'")                
                var newresultLogFile="loadsimulator_"+numberOfUsers+"USERS_"+userNamePerformance+"_"+aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "_%Y%m%d_%H%M%S")+".csv"
                var OldPath =localFolderPath+resultLogFile
                var NewPath = localFolderPath+newresultLogFile                  
                aqFileSystem.RenameFile(OldPath,NewPath);
                   
           }
           else{
             Log.Message("l'exécution a été faite sans le plugin -SIMULATOR ");             
           };

    }        
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally { 
        Log.Message("Copier le fichier qui contient de résultats");
        var newFilePerformanceResult="Perf_"+userNamePerformance+"_Simulator_"+numberOfUsers+"_Users_"+aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S")+".xlsx";
        var PathToNewFile= localFolderPath + "Perf_"+userNamePerformance+"_Simulator_"+numberOfUsers+"_Users_"+aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S")+".xlsx";        
        aqFileSystem.CopyFile(filePath_Performance_simulateur, PathToNewFile)
        
        
        Log.Message("Récupère la référence de vsevrveur");
        var ref=GetRef();
        
        Log.Message("Ajouter la référence aux noms de fichiers");
        //var newFilePerformanceResult_1= ref+"_" + newFilePerformanceResult
        if (numberOfUsers != "Default"){
            var newresultLogFileWithRef = localFolderPath + ref + "_" + newresultLogFile;
            aqFileSystem.RenameFile(localFolderPath+newresultLogFile,newresultLogFileWithRef);
            //Pour Jenkins, publier le chemin d'accès à la ressource distante
            PublishDataLocation(newresultLogFileWithRef, aqFileSystem.GetFileName(newresultLogFileWithRef), true);
        }
        
        var newFilePerformanceResultWithRef = localFolderPath + ref + "_" + newFilePerformanceResult;
        aqFileSystem.RenameFile(PathToNewFile,newFilePerformanceResultWithRef);
        //Pour Jenkins, publier le chemin d'accès à la ressource distante
        PublishDataLocation(newFilePerformanceResultWithRef, aqFileSystem.GetFileName(newFilePerformanceResultWithRef), true);
    }
}



function StopStartVserveurNFRTestQA2(action){ //stop stop remove or push assemble start
  
    if(aqString.Contains(action, "stop", 0, false)!=-1){
      
        var url = "https://nfrref.croesus.local/cgi-bin/index.cgi?group=nfr"        
        Log.Message("Launch the specified browser and opens the specified URL in it.");
        Browsers.Item("iexplore").Run(url);
        Sys.Browser(browserName).Page("*").Wait();            
    }
       
    var browser = Sys.Browser("iexplore");
    aqUtils.Delay(1000);
    var page = browser.Page("*");
    page.contentDocument.Script.eval("rvserver('nfrTestQA2', 'testnfrapp1', '"+action+"')");
    
    aqUtils.Delay(2000);
    var ActionPage="https://nfrref.croesus.local/cgi-bin/rvserver.cgi?master=testnfrapp1&group=nfr&vserver=nfrTestQA2&action=";
    var stopActionPage = browser.Page(ActionPage+action);
    if (stopActionPage.Exists)
        WaitObject(stopActionPage, "ObjectIdentifier", "Ok", 150000);

    var j = 1;
    do {
        j++;
        aqUtils.Delay(2000);
        obj = Sys.Browser("iexplore").Page(ActionPage+action).FindChild("ObjectIdentifier", "Ok");
        if (j == 90) {
            Log.Error("L'élément button OK n'est pas présent sur la page");
            break;
        }
    } while (!obj.Exists);

    //Click on OK button
    Sys.Browser("iexplore").Page(ActionPage+action).Button("Ok").Click();    
    aqUtils.Delay(1000);  
}


function GetRef(){  
  try{
       var url = "https://nfrref.croesus.local/cgi-bin/index.cgi?group=nfr"        
       Log.Message("Launch the specified browser and opens the specified URL in it.");
       Browsers.Item("iexplore").Run(url);
       Sys.Browser(browserName).Page("*").Wait(); 
       var browser = Sys.Browser("iexplore");
       aqUtils.Delay(1000);
       var page = browser.Page("*");
       var RowIndex = page.Table(0).Find("contentText","nfrTestQA2",500).Parent.RowIndex
       //var ref = page.Table(0).Find("Id","74",500).contentText  //la case de la référence de nfrTestQA2
       var refText = page.Table(0).Cell(RowIndex,2).contentText  //la case de la référence de nfrTestQA2
   
       refText = aqString.Remove(refText, aqString.Find(refText, "--"),(aqString.GetLength(refText))-(aqString.Find(refText, "--")))
   }
    catch (exc_GetRef){
        Log.Error("Exception from GetRef(): " + exc_GetRef.message, VarToStr(exc_GetRef.stack));
        exc_GetRef = null;
    }
    
   Log.Message("The vserver reference name is: " + refText);
   return refText
}


