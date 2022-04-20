//USEUNIT Common_functions
//USEUNIT DBA


function PreExecution()
{
	Log.Message("Is project language JavaScript? " + isJavaScript());
    Log.CallStackSettings.EnableStackOnWarning = true;
    if (projet == "General"){
        DisableDoubleAuthentication(vServerReportsCR1485, false);
		RestartServicesAndCheckVServer(vServerReportsCR1485); //Par défaut, toute l'exécution s'arrête en cas d'échec de la vérification du VServer
        //UpdateClientVserverAssembleScript(vServerReportsCR1485, true); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
    }
    else {
        DisableDoubleAuthentication(vServerReportsCR1485);
        //Log.Warning("Assemble Script non mis à jour pour le projet : " + projet); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
    }
    
    //Supprimer le fichier utilisé par Jenkins pour la publication des ressources distantes
    if (!aqFile.Delete(filePath_PublishedDataLocations)){
        Log.Error("Error while deleting file: " + filePath_PublishedDataLocations);
    }

    //Supprimer le dossier Backup des rapports
    if (aqFileSystem.Exists(REPORTS_FILES_BACKUP_FOLDER_PATH) && !aqFileSystem.DeleteFolder(REPORTS_FILES_BACKUP_FOLDER_PATH, true))
        Log.Error("Error while deleting the folder: " + REPORTS_FILES_BACKUP_FOLDER_PATH);
    
    //Supprimer le dossier Local des rapports
    if (aqFileSystem.Exists(REPORTS_FILES_FOLDER_PATH) && !aqFileSystem.DeleteFolder(REPORTS_FILES_FOLDER_PATH, true))
        Log.Error("Error while deleting the folder: " + REPORTS_FILES_FOLDER_PATH);
}
