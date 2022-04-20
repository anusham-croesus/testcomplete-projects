//USEUNIT Global_variables
//USEUNIT Common_functions

function ExecutionLog()
{
    //Sauvegarder le log
    var referenceName = GetVServerReference(vServerRCMGenerique);
    var executionEndDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S");
    var projectName = "RCMGenerique";
    
    var logFolderPath = logRootFolderPath + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + "\\";
    Log.Message("Save Log to: " + logFolderPath);
    Log.SaveResultsAs(logFolderPath, lsXML);
    PublishDataLocation(logFolderPath, "TestComplete Log (format XML)", true);

    var logSummaryFilePath = logRootFolderPath + referenceName + "\\XML\\" + referenceName + "\\" + projectName + "_" + executionEndDateTimeString + ".xml";
    Log.Message("Save Summary to: " + logSummaryFilePath);
	Log.SaveResultsAs(logSummaryFilePath, lsJUnit);
    
    //Envoyer un e-mail pour signaler la fin de l'exécution 
    if (SendMail("christophe.paring@croesus.com;youlia.raisper@croesus.com;sana.ayaz@croesus.com;xian.wei@croesus.com;emna.ibn.hadj.mohamed@croesus.com", "mail.croesus.com", "TestComplete Execution", "testauto@croesus.com", client + " RCMGenerique - exécution des scripts terminée", "L'exécution des scripts du projet RCMGenerique est maintenant terminée."))
        Log.Message("Mail was sent");
    else
        Log.Warning("Mail was not sent");   
    
	Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".mht", lsMHT);
    Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".xml", lsJUnit);
    Log.SaveResultsAs(ProjectSuite.Path + referenceName + ".zip", lsZip);
    TerminateProcess_TestExecute();
}