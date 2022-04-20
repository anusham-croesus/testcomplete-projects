//USEUNIT Global_variables
//USEUNIT Common_functions

function ExecutionLog()
{
    //Pour ProjectSuiteMiniRegression
    var arrayOfEnabledProjects = GetProjectSuiteEnabledProjectsNamesList();
    var isProjectSuiteLastProject = (arrayOfEnabledProjects[arrayOfEnabledProjects.length - 1] == aqFileSystem.GetFileNameWithoutExtension(Project.FileName));
    var isProjectSuiteExecutionLog = (isProjectSuiteLastProject || aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName) != "ProjectSuiteMiniRegression");
    if (!isProjectSuiteExecutionLog){
        Log.Message("Discard ExecutionLog.");
        return;
    }
    
    //Sauvegarder le log
    Log.Message("ExecutionLog...");
    var referenceName = GetVServerReference(vServerBilling);
    var executionEndDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S");
    var projectName = GetExecutionLogProjectName("Billing");
    
    var logFolderPath = logRootFolderPath + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + "\\";
    Log.Message("Save Log to: " + logFolderPath);
    Log.SaveResultsAs(logFolderPath, lsXML);
    PublishDataLocation(logFolderPath, "TestComplete Log (format XML)", true);

    var logSummaryFilePath = logRootFolderPath + referenceName + "\\XML\\" + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + ".xml";
    Log.Message("Save Summary to: " + logSummaryFilePath);
	Log.SaveResultsAs(logSummaryFilePath, lsJUnit);
    
    //Envoyer un e-mail pour signaler la fin de l'exécution 
    if (SendMail("christophe.paring@croesus.com;youlia.raisper@croesus.com;sana.ayaz@croesus.com;xian.wei@croesus.com;emna.ibn.hadj.mohamed@croesus.com", "mail.croesus.com", "TestComplete Execution", "testauto@croesus.com", client + " Billing - exécution des scripts terminée", "L'exécution des scripts du projet Billing est maintenant terminée."))
        Log.Message("Mail was sent");
    else
        Log.Warning("Mail was not sent");

    var language = (client == "RJ" || client == "TD" || client == "US" || client == "CIBC" || client == "RGMP")? "english": "french";
   
	Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".mht", lsMHT);
    Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".xml", lsJUnit);
    Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".zip", lsZip);
    TerminateProcess_TestExecute();
}

