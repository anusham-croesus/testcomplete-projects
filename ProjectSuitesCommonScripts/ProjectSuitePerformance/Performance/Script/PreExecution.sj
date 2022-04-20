//USEUNIT Global_variables
//USEUNIT Common_functions


function PreExecution()
{
	Log.Message("Is project language JavaScript? " + isJavaScript());
    CheckVServer(vServerPerformance, true); //Par défaut, toute l'exécution s'arrête en cas d'échec de la vérification du VServer
    //RestartServicesAndCheckVServer(vServerPerformance); //Par défaut, toute l'exécution s'arrête en cas d'échec de la vérification du VServer
    //UpdateClientVserverAssembleScript(vServerPerformance); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
    
    //Supprimer le fichier utilisé par Jenkins pour la publication des ressources distantes
    if (!aqFile.Delete(filePath_PublishedDataLocations)){
        Log.Error("Error while deleting file: " + filePath_PublishedDataLocations);
    }
}



/**
    Description: Checks VServer and stops whole execution if not successful 
    Parameters:
        1. vServerURL
        2. checkLoginOnly: boolean 
            if true, only login will be checked, otherwise SSH connexions
            will be also checked through function RestartServicesAndCheckVServer()
        3. maxTriesForVServerCheck: max number of attempts
*/
function CheckVServer(vServerURL, checkLoginOnly, maxTriesForVServerCheck)
{
    if (!checkLoginOnly){
        RestartServicesAndCheckVServer(vServerURL, maxTriesForVServerCheck); //Par défaut, toute l'exécution s'arrête en cas d'échec de la vérification du VServer
        //UpdateClientVserverAssembleScript(vServerURL); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
    }
    else {
        var isProjectPerformance = (aqString.Find(projet, "Performance") == 0);
        var loginTestUserName = (isProjectPerformance)? userNamePerformance: userName;
        var loginTestPassword = (isProjectPerformance)? pswPerformance: psw;
        var logAttributes = Log.CreateNewAttributes();
        logAttributes.Bold = true;
        
        Log.Message("Check Login on VServer '" + vServerURL + "'...", "", pmNormal, logAttributes);
        var isLoginSuccessful = Login(vServerURL, loginTestUserName, loginTestPassword, language, null, null, maxTriesForVServerCheck);
        
        Terminate_CroesusProcess();
        if (isLoginSuccessful === false){
            Log.Error("VServer Login check has failed. Stopping the whole execution...", "", pmNormal, logAttributes);
            Runner.Stop(false);
        }
        else if (isLoginSuccessful === true){
            Log.Checkpoint("VServer Login check was successful.", "", pmNormal, logAttributes);
        }
        else {
            Log.Error("VServer Login check was: " + isLoginSuccessful, "", pmNormal, logAttributes);
        }
    }
}
