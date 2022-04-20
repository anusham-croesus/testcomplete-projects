//USEUNIT Common_functions
//USEUNIT DBA
//USEUNIT GP1859_Helper


function PreExecution()
{
	Log.Message("Is project language JavaScript? " + isJavaScript());
    DATA_PERFORMANCE_COLUMN_NUM = null;
    Log.CallStackSettings.EnableStackOnWarning = true;
    if (projet == "General"){
        DisableDoubleAuthentication(vServerGP1859, false);
		RestartServicesAndCheckVServer(vServerGP1859); //Par défaut, toute l'exécution s'arrête en cas d'échec de la vérification du VServer
        //UpdateClientVserverAssembleScript(vServerGP1859, true); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
    }
    else {
        DisableDoubleAuthentication(vServerGP1859);
        //Log.Warning("Assemble Script non mis à jour pour le projet : " + projet); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
    }
    
    //Supprimer le fichier utilisé par Jenkins pour la publication des ressources distantes
    if (!aqFile.Delete(filePath_PublishedDataLocations)){
        Log.Error("Error while deleting file: " + filePath_PublishedDataLocations);
    }
    
    var arrAllThemesIDs = [GP1859_DEFAULT_THEMES_ID, GP1859_WHITELABELS_THEMES_ID];
    for (var themeIndex = 0; themeIndex < arrAllThemesIDs.length; themeIndex++){
        UpdatePaths(arrAllThemesIDs[themeIndex]);
        //Supprimer le dossier Backup des rapports
        if (aqFileSystem.Exists(Global_variables.REPORTS_FILES_BACKUP_FOLDER_PATH) && !aqFileSystem.DeleteFolder(Global_variables.REPORTS_FILES_BACKUP_FOLDER_PATH, true))
            Log.Error("Error while deleting the folder: " + Global_variables.REPORTS_FILES_BACKUP_FOLDER_PATH);
    
        //Supprimer le dossier Local des rapports
        if (aqFileSystem.Exists(Global_variables.REPORTS_FILES_FOLDER_PATH) && !aqFileSystem.DeleteFolder(Global_variables.REPORTS_FILES_FOLDER_PATH, true))
            Log.Error("Error while deleting the folder: " + Global_variables.REPORTS_FILES_FOLDER_PATH);
    }
}

