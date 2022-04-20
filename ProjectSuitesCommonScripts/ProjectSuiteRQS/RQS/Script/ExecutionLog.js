//USEUNIT Global_variables
//USEUNIT Common_functions

function ExecutionLog()
{
    var executionEndDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S");
    
    try {
        //Envoyer un e-mail pour signaler la fin de l'exécution
        SendMail("taous.amalou@croesus.com;christophe.paring@croesus.com", client + " RQS - exécution des scripts terminée", "L'exécution des scripts du projet RQS est maintenant terminée.");    
    }
    catch(e) {
        Log.Message("Unable to send e-mail.", e.message);
    }
    
    //Sauvegarder le Log
    var referenceName = GetVServerReference(vServerRQS);
    var projectName = "RQS";
    
    var logFolderPath = logRootFolderPath + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + "\\";
    Log.Message("Save Log to: " + logFolderPath);
    Log.SaveResultsAs(logFolderPath, lsXML);
    PublishDataLocation(logFolderPath, "TestComplete Log (format XML)", true);
    Log.SaveResultsAs(logFolderPath + "MHT\\" + projectName + "_" + aqString.SubString(referenceName, 0, 20) + " " + executionEndDateTimeString + ".mht", lsMHT, true, lesCurrentProject);
    
    var logSummaryFilePath = logRootFolderPath + referenceName + "\\XML\\" + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + ".xml";
    Log.Message("Save Summary to: " + logSummaryFilePath);
	Log.SaveResultsAs(logSummaryFilePath, lsJUnit);
    
	Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".mht", lsMHT);
    Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".xml", lsJUnit);
    Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".zip", lsZip);
    TerminateProcess_TestExecute();
}
