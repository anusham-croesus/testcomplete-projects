//USEUNIT Global_variables
//USEUNIT Common_functions

function ExecutionLog()
{
    //Sauvegarder le log
    var referenceName = GetVServerReference(vServerTCVE3);
    var executionEndDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S");
    var projectName = "TCVE3";
    
    var logFolderPath = logRootFolderPath + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + "\\";
    Log.Message("Save Log to: " + logFolderPath);
    Log.SaveResultsAs(logFolderPath, lsXML);
    PublishDataLocation(logFolderPath, "TestComplete Log (format XML)", true);

    var logSummaryFilePath = logRootFolderPath + referenceName + "\\XML\\" + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + ".xml";
    Log.Message("Save Summary to: " + logSummaryFilePath);
	Log.SaveResultsAs(logSummaryFilePath, lsJUnit);
    
    //Envoyer un e-mail pour signaler la fin de l'exécution 
    if (SendMail("youlia.raisper@croesus.com;amine.alaoui@croesus.com;alhassane.diallo@croesus.com;ibrahim.diaf@croesus.com", "mail.croesus.com", "TestComplete Execution", "testauto@croesus.com", client + " TCVE3 - exécution des scripts terminée", "L'exécution des scripts du projet TCVE3 est maintenant terminée."))
        Log.Message("Mail was sent");
    else
        Log.Warning("Mail was not sent");

	Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".mht", lsMHT);
    Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".xml", lsJUnit);
    Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".zip", lsZip);
	TerminateProcess_TestExecute();
}