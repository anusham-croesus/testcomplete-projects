//USEUNIT Global_variables
//USEUNIT Common_functions


function ExecutionLog()
{
    //ExecutionLog seulement pour le dernier projet
    var arrayOfEnabledProjects = GetProjectSuiteEnabledProjectsNamesList();
    if (arrayOfEnabledProjects[arrayOfEnabledProjects.length - 1] != aqFileSystem.GetFileNameWithoutExtension(Project.FileName)){
        Log.Message("Discard ExecutionLog.");
        return;
    }
    
    Log.Message("ExecutionLog...");
    
    //Envoyer un e-mail pour signaler la fin de l'exécution
    try {
        SendMail("xian.wei@croesus.com", "mail.croesus.com", "TestComplete Execution", "testauto@croesus.com", "Performance - exécution des scripts terminée", "L'exécution des scripts du projet Performance est maintenant terminée.");    
        Log.Message("Mail was sent");
    }
    catch(e) {
        Log.Error("Unable to send e-mail: " + e.message, VarToStr(e.stack));
        e = null;
    }
    
    var referenceName = GetRef(true);
    var projectName = GetExecutionLogProjectName();
    var executionEndDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S");
    var logRootFolderPath = "\\\\srvfs1\\pub\\aq\\Tests Automatisés\\Execution\\Performance_Croesus\\Performance\\" + client + "\\";
    var logFolderPath = logRootFolderPath + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + "\\";
    
    //Copier le fichier de données de performance
    var dataBackupFilePath = aqFileSystem.ExcludeTrailingBackSlash(logFolderPath) + ".xlsx";
    Log.Message("Copy Performance data file: from '" + filePath_Performance + "' to '" + dataBackupFilePath + "'");
    aqFileSystem.CopyFile(filePath_Performance, dataBackupFilePath);
    PublishDataLocation(dataBackupFilePath, "Fichier de données de Performance", true); //Pour Jenkins, publier le chemin d'accès au fichier de données de Performance
    
    //Sauvegarder le log
    Log.Message("Save Log to: " + logFolderPath);
    Log.SaveResultsAs(logFolderPath, lsXML);
    PublishDataLocation(logFolderPath, "TestComplete Log (format XML)", true); //Pour Jenkins, publier le chemin d'accès au dossier distant du log
    
    Log.Message("Save .mht, .xml and .zip log to ProjectSuite folder (" + ProjectSuite.Path + ")");
	Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".mht", lsMHT);
    Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".xml", lsJUnit);
    Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".zip", lsZip);
    
    TerminateProcess_TestExecute();
}



function GetRef(getFullRefName)
{
    var refText = "undefined";
    
    try {
        var vServerName = GetVserverHostName(vServerPerformance);
        if (aqString.Find(vServerName, "nfr", 0, false) != 0){
            refText = GetVServerReference(vServerPerformance);
        }
        else {
            var url = "https://nfrref.croesus.local/cgi-bin/index.cgi?group=nfr";
            Browsers.Item("iexplore").Run(url);
            Sys.Browser(browserName).Page("*").Wait();
            var browser = Sys.Browser("iexplore");
            aqUtils.Delay(1000);
            var page = browser.Page("*");
            var RowIndex = page.Table(0).Find("contentText", vServerName, 500).Parent.RowIndex
            //var ref = page.Table(0).Find("Id","74",500).contentText;  //la case de la référence de nfrTestQA2 ou nfrTestQA1
            refText = page.Table(0).Cell(RowIndex, 2).contentText;  //la case de la référence de nfrTestQA2 ou nfrTestQA1
        }
        
        if (!getFullRefName){
            refText = aqString.Remove(refText, aqString.Find(refText, "--"), (aqString.GetLength(refText)) - (aqString.Find(refText, "--")));
        }
    }
    catch (exc_GetRef){
        Log.Error("Exception from GetRef(): " + exc_GetRef.message, VarToStr(exc_GetRef.stack));
        exc_GetRef = null;
    }
    
    Log.Message("The vserver reference name is: " + refText);
    return refText;
}
