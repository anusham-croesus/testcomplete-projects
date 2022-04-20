//USEUNIT Global_variables
//USEUNIT Common_functions
//USEUNIT DBA

function PreExecution()
{
    Log.Message("Is project language JavaScript? " + isJavaScript());
    
    //Si pas ProjectSuiteMiniRegression ou en tête de liste de ProjectSuiteMiniRegression ou dans un projet ayant pour nom "PreExecution"
    if (aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName) != "ProjectSuiteMiniRegression" || GetIndexOfItemInArray(["PreExecution", (GetProjectSuiteEnabledProjectsNamesList()[0])], aqFileSystem.GetFileNameWithoutExtension(Project.FileName)) != -1){
        DisableDoubleAuthentication(vServerTitre, false);//Désactiver la double authentification
        if (!aqFile.Delete(filePath_PublishedDataLocations)){//Supprimer le fichier utilisé par Jenkins pour la publication des ressources distantes
            Log.Error("Error while deleting file: " + filePath_PublishedDataLocations);
        }
    }
    
    RestartServicesAndCheckVServer(vServerTitre); //Par défaut, toute l'exécution s'arrête en cas d'échec de la vérification du VServer
    //UpdateClientVserverAssembleScript(vServerTitre, true); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
}