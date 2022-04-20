//USEUNIT Global_variables
//USEUNIT Common_functions
//USEUNIT DBA


function PreExecution()
{
	Log.Message("Is project language JavaScript? " + isJavaScript());
    DisableDoubleAuthentication(vServerTCVE2, false);
	RestartServicesAndCheckVServer(vServerTCVE2); //Par défaut, toute l'exécution s'arrête en cas d'échec de la vérification du VServer
    //UpdateClientVserverAssembleScript(vServerTCVE2, true); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
}