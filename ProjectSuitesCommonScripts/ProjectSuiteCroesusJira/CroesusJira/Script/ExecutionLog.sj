//USEUNIT Global_variables
//USEUNIT Common_functions

function ExecutionLog()
{
    //Sauvegarder le log
    var referenceName = GetVServerReference(vServerCroesusJira);
    var executionEndDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S");
    var projectName = "CroesusJira";
    
    var logFolderPath = logRootFolderPath + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + "\\";
    Log.Message("Save Log to: " + logFolderPath);
    Log.SaveResultsAs(logFolderPath, lsXML);
    PublishDataLocation(logFolderPath, "TestComplete Log (format XML)", true);

    var logSummaryFilePath = logRootFolderPath + referenceName + "\\XML\\" + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + ".xml";
    Log.Message("Save Summary to: " + logSummaryFilePath);
	Log.SaveResultsAs(logSummaryFilePath, lsJUnit);
    
    //Envoyer un e-mail pour signaler la fin de l'exécution 
    if (SendMail("amine.alaoui@croesus.com", "mail.croesus.com", "TestComplete Execution", "testauto@croesus.com", client + " CroesusJira - exécution des scripts terminée", "L'exécution des scripts du projet CroesusJira est maintenant terminée."))
        Log.Message("Mail was sent");
    else
        Log.Warning("Mail was not sent");   
    
	Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".mht", lsMHT);
    Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".xml", lsJUnit);
    Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".zip", lsZip);
    TerminateProcess_TestExecute();
}