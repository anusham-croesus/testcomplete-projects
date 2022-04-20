//USEUNIT Global_variables
//USEUNIT Common_functions
//USEUNIT DBA


function PreExecution()
{
	Log.Message("Is project language JavaScript? " + isJavaScript());
    DisableDoubleAuthentication(vServerTCVE2, false);
	RestartServicesAndCheckVServer(vServerTCVE2); //Par défaut, toute l'exécution s'arrête en cas d'échec de la vérification du VServer
    //UpdateClientVserverAssembleScript(vServerTCVE2, true); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
    
    //Supprimer le fichier utilisé par Jenkins pour la publication des ressources distantes
    if (!aqFile.Delete(filePath_PublishedDataLocations)){
        Log.Error("Error while deleting file: " + filePath_PublishedDataLocations);
    }
}