//USEUNIT Common_functions

function ExecutionLog()
{
    //Date et heure de la fin de l'exécution et Référence
    var executionEndDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S");
    var referenceName = GetVServerReference(vServerReportsCR1485);
    
    //Nom du projet
    var projectName = GetExecutionLogProjectName();
    
    //Renommer le dossier des rapports générés (ajouter la référence, la date et l'heure au nom du dossier)
    var newReportsPath = folderPath_Data + client + "\\CR1485\\ResultFolder\\" + PROJECTSUITE_NAME + "\\" + Trim(referenceName.split("--")[0]) + "--" + aqString.Replace(executionEndDateTimeString, " ", "-") + "\\";
    Log.Message("Rename the generated reports folder.", "from : " + REPORTS_FILES_FOLDER_PATH + "\nto : " + newReportsPath);
    if (!aqFileSystem.Exists(REPORTS_FILES_FOLDER_PATH))
        Log.Error("Reports folder not found: " + REPORTS_FILES_FOLDER_PATH);
    else if (!aqFileSystem.RenameFolder(aqFileSystem.ExcludeTrailingBackSlash(REPORTS_FILES_FOLDER_PATH), aqFileSystem.ExcludeTrailingBackSlash(newReportsPath)))
        Log.Error("An error occurred while renaming the generated reports folder.");
    
    //Renommer le dossier Backup des rapports générés (ajouter la référence, la date et l'heure au nom du dossier)
    var newReportsBackupPath = "\\\\srvfs1\\pub\\aq\\Rapport\\" + client + "\\" + PROJECTSUITE_NAME + "\\" + Trim(referenceName) + "--" + aqString.Replace(executionEndDateTimeString, " ", "-") + "\\";
    Log.Message("Rename the generated reports backup folder.", "from : " + REPORTS_FILES_BACKUP_FOLDER_PATH + "\nto : " + newReportsBackupPath);
    if (!aqFileSystem.Exists(REPORTS_FILES_BACKUP_FOLDER_PATH))
        Log.Error("Reports backup folder not found: " + REPORTS_FILES_BACKUP_FOLDER_PATH);
    else if (!aqFileSystem.RenameFolder(aqFileSystem.ExcludeTrailingBackSlash(REPORTS_FILES_BACKUP_FOLDER_PATH), aqFileSystem.ExcludeTrailingBackSlash(newReportsBackupPath)))
        Log.Error("An error occurred while renaming the generated reports backup folder.");
    
    //Pour Jenkins, publier le chemin d'accès au dossier distant de Backup des Rapports
    PublishDataLocation(newReportsBackupPath, "Backup des Rapports", true);
    
    if (aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName) != "ProjectSuiteMiniRegression"){
        //Envoyer un e-mail pour signaler la fin de l'exécution
        try {
            SendMail("christophe.paring@croesus.com;youlia.raisper@croesus.com;sana.ayaz@croesus.com;xian.wei@croesus.com;emna.ibn.hadj.mohamed@croesus.com", "mail.croesus.com", "TestComplete Execution", "testauto@croesus.com", client + " Rapports - exécution des scripts terminée", "L'exécution des scripts du projet Rapports est maintenant terminée.");    
        }
        catch(e) {
            Log.Warning("Unable to send e-mail.", e.message);
        }
        
        //Sauvegarder le log
        if (projet != "General")
            var logFolderPath = "\\\\srvfs1\\pub\\aq\\Tests Automatisés\\Execution\\Performance_Croesus\\" + projectName + projet + "\\Log_" + executionEndDateTimeString + "\\";
        else
            var logFolderPath = logRootFolderPath + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + "\\";
        
        Log.Message("Save Log to: " + logFolderPath);
        Log.SaveResultsAs(logFolderPath, lsXML);
        PublishDataLocation(logFolderPath, "TestComplete Log (format XML)", true);
        
        var logSummaryFilePath = logRootFolderPath + referenceName + "\\XML\\" + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + ".xml";
        Log.Message("Save Summary to: " + logSummaryFilePath);
    	Log.SaveResultsAs(logSummaryFilePath, lsJUnit);
        
		Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".mht", lsMHT);
		Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".xml", lsJUnit);
		Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".zip", lsZip);
        TerminateProcess_TestExecute();
    }
}
