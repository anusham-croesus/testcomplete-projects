//USEUNIT CR1958_2_Helper


/**
    Description : Validate RQS DashboardGenerator&PREF_ENABLE_CLIENT_RELATIONSHIPS=NO (Step #1 : Validate Plugin DashboardGenerator)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6645
    Step #1 : Validate Plugin DashboardGenerator
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-10--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_Plugin_DashboardGenerator()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6645", "Croes-6645 Step #1 - Validate Plugin DashboardGenerator : CR1958_2_6645_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO_Validate_Plugin_DashboardGenerator()");
    //Le script de préparation reltif au cas Croes-6667 a été désactivé car le nécessaire est désormais inclus dans le dump.
    //Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6667", "Pré-requis : CR1958_2_6667_Cas_pour_preparer_aux_tests_RQS_activer_les_Pref_Transaction_plugin()");
    
    try {
        var cfLoaderPlugin_generateRQSPortfolio = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_generateRQSPortfolio", language + client);
        var cfLoaderPlugin_generateRQSPortfolio_OutputSuccessRegEx  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_generateRQSPortfolio_OutputSuccessRegEx", language + client);
        
        //Precondition
        CR1958_2_6645_PrepareDB();
        
        /*
        STEP #1 : Se loguer dans SSH or Putty:
        cfLoader  -DashboardRegenerator "generateRQSPortfolio=CLIENT,LINK" -firm=FIRM_1
        Exécuter les requêtes suivantes:
        select * from  b_RQS_Client where  Entity_type  = 'LINK'
        select * from  b_RQS_Client
        */
        Log.Message("Croes-6645 STEP #1 : Execute SSH and then SQL queries.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cfLoaderPlugin_generateRQSPortfolio, CR1958_2_SSH_USERNAME);
        
        var nbOfRecordsWithEntityTypeIsLINK = Execute_SQLQuery_GetField("select count(*) as nbOfRows from B_RQS_CLIENT where ENTITY_TYPE = 'LINK'", vServerRQS, "nbOfRows");
        CheckEquals(nbOfRecordsWithEntityTypeIsLINK, 0, "The number of records of B_RQS_CLIENT where ENTITY_TYPE = 'LINK'");
        
        var nbOfRecordsWithEntityTypeIsNotCLIENT = Execute_SQLQuery_GetField("select count(*) as nbOfRows from B_RQS_CLIENT where ENTITY_TYPE != 'CLIENT'", vServerRQS, "nbOfRows");
        CheckEquals(nbOfRecordsWithEntityTypeIsNotCLIENT, 0, "The number of records of B_RQS_CLIENT where ENTITY_TYPE != 'CLIENT'");     
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        CR1958_2_6645_RestoreDB();
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cfLoaderPlugin_generateRQSPortfolio, CR1958_2_SSH_USERNAME); //, cfLoaderPlugin_generateRQSPortfolio_OutputSuccessRegEx); A.A: pour l'échec car le log de la commade est vide
    }
}



function CR1958_2_6645_PrepareDB()
{
    //PRECONDITIONS
    //Au niveau Firme :
    //PREF_ENABLE_CLIENT_RELATIONSHIPS=NO
    //FD_MANAGEMENT_LEVELS_MAPPING= <ManagementLevels><ManagementLevel MgtLevel='LINK' DictIndex='1' /><ManagementLevel MgtLevel='CLIENT' DictIndex='2' /></ManagementLevels>
    Log.Message("Croes-6645 PrepareDB : At Firm level --> PREF_ENABLE_CLIENT_RELATIONSHIPS=NO ; FD_MANAGEMENT_LEVELS_MAPPING= <ManagementLevels><ManagementLevel MgtLevel='LINK' DictIndex='1' /><ManagementLevel MgtLevel='CLIENT' DictIndex='2' /></ManagementLevels>", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_CLIENT_RELATIONSHIPS", "NO", vServerRQS);
    ExecuteSQLFile_ThroughISQL(CR1958_2_REPOSITORY_SQL + "CR1958_2_6645_PreConditions_SQL.sql", vServerRQS);
    RestartServices(vServerRQS);
}



function CR1958_2_6645_RestoreDB()
{
    Log.Message("Croes-6645 RestoreDB", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_CLIENT_RELATIONSHIPS", "YES", vServerRQS);
    ExecuteSQLFile_ThroughISQL(CR1958_2_REPOSITORY_SQL + "CR1958_2_6645_ConfigRestore_SQL.sql", vServerRQS);
    RestartServices(vServerRQS);
}