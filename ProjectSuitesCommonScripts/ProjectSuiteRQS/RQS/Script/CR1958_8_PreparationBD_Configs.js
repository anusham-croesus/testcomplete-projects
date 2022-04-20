//USEUNIT CR1483_Common_functions



function CR1958_8_PreparationBD_Configs()
{
    Log.Message("");
    Log.Message("************* CR1958_8_PreparationBD_Configs() *************");
    ExecuteSQLFile_ThroughISQL(folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SQL\\CR1958_PreparationBD.sql", vServerRQS);
    RestartServices(vServerRQS);
}
