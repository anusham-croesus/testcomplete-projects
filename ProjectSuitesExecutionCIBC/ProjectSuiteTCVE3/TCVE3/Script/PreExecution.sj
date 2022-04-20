//USEUNIT Global_variables
//USEUNIT Common_functions
//USEUNIT DBA


function PreExecution()
{
	Log.Message("Is project language JavaScript? " + isJavaScript());
    DisableDoubleAuthentication(vServerTCVE3, false);
	RestartServicesAndCheckVServer(vServerTCVE3); //Par défaut, toute l'exécution s'arrête en cas d'échec de la vérification du VServer
    //UpdateClientVserverAssembleScript(vServerTCVE3, true); //Désactivée car la MAJ de l'Assemble Script est faite par Jenkins
}