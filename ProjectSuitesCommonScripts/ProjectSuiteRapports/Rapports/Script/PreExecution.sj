//USEUNIT Common_functions
//USEUNIT DBA


function PreExecution()
{
    Log.Message("Is project language JavaScript? " + isJavaScript());
    
    //Si pas ProjectSuiteMiniRegression ou en tête de liste de ProjectSuiteMiniRegression ou dans un projet ayant pour nom "PreExecution"
    if (aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName) != "ProjectSuiteMiniRegression" || GetIndexOfItemInArray(["PreExecution", (GetProjectSuiteEnabledProjectsNamesList()[0])], aqFileSystem.GetFileNameWithoutExtension(Project.FileName)) != -1){
        DisableDoubleAuthentication(vServerReportsCR1485, false);//Désactiver la double authentification
        if (!aqFile.Delete(filePath_PublishedDataLocations)){//Supprimer le fichier utilisé par Jenkins pour la publication des ressources distantes
            Log.Error("Error while deleting file: " + filePath_PublishedDataLocations);
        }
    }
    
    RestartServicesAndCheckVServer(vServerReportsCR1485); //Par défaut, toute l'exécution s'arrête en cas d'échec de la vérification du VServer
    Log.CallStackSettings.EnableStackOnWarning = true;
    
    /*
    if (projet == "General"){
        DisableDoubleAuthentication(vServerReportsCR1485, false);
        //UpdateClientVserverAssembleScript(vServerReportsCR1485, true); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
    }
    else {
        DisableDoubleAuthentication(vServerReportsCR1485);
        //Log.Warning("Assemble Script non mis à jour pour le projet : " + projet); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
    }
    */
    
    //Supprimer le dossier Backup des rapports
    if (aqFileSystem.Exists(REPORTS_FILES_BACKUP_FOLDER_PATH) && !aqFileSystem.DeleteFolder(REPORTS_FILES_BACKUP_FOLDER_PATH, true))
        Log.Error("Error while deleting the folder: " + REPORTS_FILES_BACKUP_FOLDER_PATH);
    
    //Supprimer le dossier Local des rapports
    if (aqFileSystem.Exists(REPORTS_FILES_FOLDER_PATH) && !aqFileSystem.DeleteFolder(REPORTS_FILES_FOLDER_PATH, true))
        Log.Error("Error while deleting the folder: " + REPORTS_FILES_FOLDER_PATH);
}
