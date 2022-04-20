//USEUNIT Global_variables
//USEUNIT Common_functions
//USEUNIT DBA


function PreExecution()
{
	Log.Message("Is project language JavaScript? " + isJavaScript());
    RestartServicesAndCheckVServer(vServerCR1755, 0); //0 => pas de vérification du VServer
    if (!(TestSSHConnexions(vServerCR1755))){
        var logAttributes = Log.CreateNewAttributes();
        logAttributes.Bold = true;
        Log.Error("VServer SSH Connexions check has failed. Stopping the whole execution...", "", pmNormal, logAttributes);
        Runner.Stop(false);
    }
    //UpdateClientVserverAssembleScript(vServerCR1755); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
    ExecuteSQLFile(folderPath_ProjectSuiteCommonScripts + "ProjectSuiteTransitionWeb\\TransitionWeb\\" + "sql_UNI00.sql", vServerCR1755);
    
    //Supprimer le fichier utilisé par Jenkins pour la publication des ressources distantes
    if (!aqFile.Delete(filePath_PublishedDataLocations)){
        Log.Error("Error while deleting file: " + filePath_PublishedDataLocations);
    }
}