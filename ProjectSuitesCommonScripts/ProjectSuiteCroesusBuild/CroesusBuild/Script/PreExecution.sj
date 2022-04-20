//USEUNIT Global_variables
//USEUNIT Common_functions
//USEUNIT DBA

function PreExecution()
{
	Log.Message("Is project language JavaScript? " + isJavaScript());
	DisableDoubleAuthentication(vServerCroesusBuild, false);
    RestartServicesAndCheckVServer(vServerCroesusBuild); //Par défaut, toute l'exécution s'arrête en cas d'échec de la vérification du VServer
    //UpdateClientVserverAssembleScript(vServerCroesusBuild, true); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
    
    Log.CallStackSettings.EnableStackOnWarning = true;
    
    //Supprimer le fichier utilisé par Jenkins pour la publication des ressources distantes
    if (!aqFile.Delete(filePath_PublishedDataLocations)){
        Log.Error("Error while deleting file: " + filePath_PublishedDataLocations);
    }
}
