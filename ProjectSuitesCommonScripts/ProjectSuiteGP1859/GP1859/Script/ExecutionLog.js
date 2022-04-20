//USEUNIT Common_functions
//USEUNIT GP1859_Helper



function ExecutionLog()
{
    try {
        DATA_PERFORMANCE_COLUMN_NUM = null;
        Global_variables.vServerReportsCR1485 = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 1, 12);
        Global_variables.REPORTS_FILES_FOLDER_PATH = folderPath_Data + client + "\\CR1485\\ResultFolder\\" + PROJECTSUITE_NAME + "\\Temp_Reports\\";
        Global_variables.REPORTS_FILES_BACKUP_FOLDER_PATH = "\\\\srvfs1\\pub\\aq\\Rapport\\" + client + "\\" + PROJECTSUITE_NAME + "\\Temp_BackupFromComputer_" + executionComputerName + "\\";
        Global_variables.CR1485_REPORTS_LANGUAGE = (client == "US")? "english" : VarToStr(GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 4, 12));
        Global_variables.CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE = (typeof Global_variables.CR1485_REPORTS_LANGUAGE != 'undefined' && (Global_variables.CR1485_REPORTS_LANGUAGE == "english" || Global_variables.CR1485_REPORTS_LANGUAGE == "french"));
        
        //Envoyer un e-mail pour signaler la fin de l'exécution
        SendMail("christophe.paring@croesus.com;youlia.raisper@croesus.com;sana.ayaz@croesus.com;xian.wei@croesus.com;emna.ibn.hadj.mohamed@croesus.com", "mail.croesus.com", "TestComplete Execution", "testauto@croesus.com", client + " GP1859 - exécution des scripts terminée", "L'exécution des scripts du projet GP1859 est maintenant terminée.");    
    }
    catch(e_ExecutionLog) {
        Log.Warning("Exception : " + e_ExecutionLog.message, VarToStr(e_ExecutionLog.stack));
        e_ExecutionLog = null;
    }
    
    //Sauvegarder le log
    SaveLog();
    
    TerminateProcess_TestExecute();
}



function SaveLog(executionEndDateTimeString, referenceName)
{
    if (executionEndDateTimeString == undefined)
        executionEndDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S");
    
    if (referenceName == undefined)
        referenceName = GetVServerReference(vServerGP1859);
    
    var projectName = "GP1859";
    
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
}



function ExecutionLog_GP1859_Theme(themeID)
{
    UpdatePaths(themeID);
    
    //Date et heure de la fin de l'exécution et Référence
    var executionEndDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S");
    var referenceName = GetVServerReference(vServerGP1859);
    
    //Renommer le dossier des rapports générés (ajouter la référence, la date et l'heure au nom du dossier)
    var newReportsPath = folderPath_Data + client + "\\CR1485\\ResultFolder\\" + PROJECTSUITE_NAME + "_" + GP1859_FOLDER_SUFFIX_THEME_ID + "\\" + Trim(referenceName.split("--")[0]) + "--" + aqString.Replace(executionEndDateTimeString, " ", "-") + "\\";
    Log.Message("Rename the generated reports folder.", "from : " + REPORTS_FILES_FOLDER_PATH + "\nto : " + newReportsPath);
    if (!aqFileSystem.Exists(REPORTS_FILES_FOLDER_PATH))
        Log.Message("Reports folder not found: " + REPORTS_FILES_FOLDER_PATH);
    else if (!aqFileSystem.RenameFolder(aqFileSystem.ExcludeTrailingBackSlash(REPORTS_FILES_FOLDER_PATH), aqFileSystem.ExcludeTrailingBackSlash(newReportsPath)))
        Log.Error("An error occurred while renaming the generated reports folder.");
    
    //Renommer le dossier Backup des rapports générés (ajouter la référence, la date et l'heure au nom du dossier)
    var newReportsBackupPath = "\\\\srvfs1\\pub\\aq\\Rapport\\" + client + "\\" + PROJECTSUITE_NAME + "_" + GP1859_FOLDER_SUFFIX_THEME_ID + "\\" + Trim(referenceName) + "--" + aqString.Replace(executionEndDateTimeString, " ", "-") + "\\";
    Log.Message("Rename the generated reports backup folder.", "from : " + REPORTS_FILES_BACKUP_FOLDER_PATH + "\nto : " + newReportsBackupPath);
    if (!aqFileSystem.Exists(REPORTS_FILES_BACKUP_FOLDER_PATH))
        Log.Message("Reports backup folder not found: " + REPORTS_FILES_BACKUP_FOLDER_PATH);
    else if (!aqFileSystem.RenameFolder(aqFileSystem.ExcludeTrailingBackSlash(REPORTS_FILES_BACKUP_FOLDER_PATH), aqFileSystem.ExcludeTrailingBackSlash(newReportsBackupPath)))
        Log.Error("An error occurred while renaming the generated reports backup folder.");
    
    //Pour Jenkins, publier le chemin d'accès au dossier distant de Backup des Rapports
    PublishDataLocation(newReportsBackupPath, "Backup des Rapports GP1859 " + themeID, false);
    
    //Sauvegarder le log
    //SaveLog(executionEndDateTimeString, referenceName);
}