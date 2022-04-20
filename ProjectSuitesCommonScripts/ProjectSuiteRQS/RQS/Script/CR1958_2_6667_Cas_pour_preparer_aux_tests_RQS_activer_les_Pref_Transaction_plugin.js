//USEUNIT CR1958_2_Helper


/**
    Description : Cas pour préparer aux tests RQS activer les Prefs + Transactions + plugins
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6667
    
    Ce cas sert à :
        1. Mettre à jour les configurations
        2. Mettre les préférences = Yes
        3. Ajouter les transactions pour valider les fenêtres
        4. Exécuter les plugins
    
    Pré-requis pour les scripts suivants :
    - CR1958_2_6645_Validate_RQS_DashboardGenerator_PREF_ENABLE_CLIENT_RELATIONSHIPS_equals_NO
    - CR1958_2_6653_6073_Validate_if_the_Plugin_and_the_new_column_added_in_Offside_Account_Report
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-10--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6667_Cas_pour_preparer_aux_tests_RQS_activer_les_Pref_Transaction_plugin()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6667", "CR1958_2_6667_Cas_pour_preparer_aux_tests_RQS_activer_les_Pref_Transaction_plugin()");
    
    try {
        //FROM EXCEL FOR SSH LOADER TOTALS
        var cmdLine_Loader_TOTALS                                                   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_TOTALS", language + client);
        var cmdLine_Loader_TOTALS_OutputSuccessRegEx_Part1                          = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_TOTALS_OutputSuccessRegEx_Part1", language + client);
        var cmdLine_Loader_TOTALS_OutputSuccessRegEx_Part2                          = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_TOTALS_OutputSuccessRegEx_Part2", language + client);
        var cmdLine_Loader_TOTALS_OutputSuccessRegEx_Part3                          = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_TOTALS_OutputSuccessRegEx_Part3", language + client);        
        var cmdLine_Loader_TOTALS_OutputSuccessRegEx = cmdLine_Loader_TOTALS_OutputSuccessRegEx_Part1 + cmdLine_Loader_TOTALS_OutputSuccessRegEx_Part2 + cmdLine_Loader_TOTALS_OutputSuccessRegEx_Part3;
        
        //FROM EXCEL FOR PRECONDITIONS
        var cmdLine_cfLoaderPlugin_ClientStatusProcessor                            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_Preconditions_cfLoaderPlugin_ClientStatusProcessor", language + client);
        var cmdLine_cfLoaderPlugin_ClientStatusProcessor_OutputSuccessRegEx         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_Preconditions_cfLoaderPlugin_ClientStatusProcessor_OutputSuccessRegEx", language + client);
        var cmdLine_cfLoaderPlugin_ClientLink                                       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_Preconditions_cfLoaderPlugin_ClientLink", language + client);
        var cmdLine_cfLoaderPlugin_ClientLink_OutputSuccessRegEx                    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_Preconditions_cfLoaderPlugin_ClientLink_OutputSuccessRegEx", language + client);
        
        //FROM EXCEL FOR STEP #1
        var cmdLine_Loader_800229_PRO                                               = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_800229_PRO", language + client);
        var cmdLine_Loader_800229_PRO_OutputSuccessRegEx_Part1                      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_800229_PRO_OutputSuccessRegEx_Part1", language + client);
        var cmdLine_Loader_800229_PRO_OutputSuccessRegEx_Part2                      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_800229_PRO_OutputSuccessRegEx_Part2", language + client);
        var cmdLine_Loader_800229_PRO_OutputSuccessRegEx_Part3                      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_800229_PRO_OutputSuccessRegEx_Part3", language + client);
        var cmdLine_Loader_800229_PRO_OutputSuccessRegEx = cmdLine_Loader_800229_PRO_OutputSuccessRegEx_Part1 + cmdLine_Loader_800229_PRO_OutputSuccessRegEx_Part2 + cmdLine_Loader_800229_PRO_OutputSuccessRegEx_Part3;

        var cmdLine_Loader_Transactions_ajout                                       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_Transactions_ajout", language + client);
        var cmdLine_Loader_Transactions_ajout_OutputSuccessRegEx_Part1              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_Transactions_ajout_OutputSuccessRegEx_Part1", language + client);
        var cmdLine_Loader_Transactions_ajout_OutputSuccessRegEx_Part2              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_Transactions_ajout_OutputSuccessRegEx_Part2", language + client);
        var cmdLine_Loader_Transactions_ajout_OutputSuccessRegEx_Part3              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_Transactions_ajout_OutputSuccessRegEx_Part3", language + client);
        var cmdLine_Loader_Transactions_ajout_OutputSuccessRegEx_Part4              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_CmdLine_Loader_Transactions_ajout_OutputSuccessRegEx_Part4", language + client);
        var cmdLine_Loader_Transactions_ajout_OutputSuccessRegEx = cmdLine_Loader_Transactions_ajout_OutputSuccessRegEx_Part1 + cmdLine_Loader_Transactions_ajout_OutputSuccessRegEx_Part2 + cmdLine_Loader_Transactions_ajout_OutputSuccessRegEx_Part3 + cmdLine_Loader_Transactions_ajout_OutputSuccessRegEx_Part4;
        
        var loader_expectedNbOfTransactionsToBeAdded                                = VarToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_ExpectedNumberOfTransactions_ToBeAdded", language + client));
        var loader_expectedNbOfProfileClients                                       = VarToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_ExpectedNumberOfProfileClients", language + client));
        var loader_expectedNbOfProfileAccounts                                      = VarToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_ExpectedNumberOfProfileAccounts", language + client));
        
        //FROM EXCEL FOR STEP #2
        var cfLoaderPlugin_generateRQSPortfolio                                     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_generateRQSPortfolio", language + client);
        var cfLoaderPlugin_generateRQSPortfolio_OutputSuccessRegEx                  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_generateRQSPortfolio_OutputSuccessRegEx", language + client);
        var cfLoaderPlugin_ForceRegenGenerateAccountPortfolio                       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_ForceRegenGenerateAccountPortfolio", language + client);
        var cfLoaderPlugin_ForceRegenGenerateAccountPortfolio_OutputSuccessRegEx    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_ForceRegenGenerateAccountPortfolio_OutputSuccessRegEx", language + client);
        var cfLoaderPlugin_RQSActivityBlotter                                       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_RQSActivityBlotter", language + client);
        var cfLoaderPlugin_RQSActivityBlotter_OutputSuccessRegEx                    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_RQSActivityBlotter_OutputSuccessRegEx", language + client);
        var cfLoaderPlugin_RQSAlertGenerator                                        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_RQSAlertGenerator", language + client);
        var cfLoaderPlugin_RQSAlertGenerator_OutputSuccessRegEx                     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_RQSAlertGenerator_OutputSuccessRegEx", language + client);
        var cfLoaderPlugin_RiskRating_report                                        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_RiskRatingReport", language + client);
        var cfLoaderPlugin_RiskRating_report_OutputSuccessRegEx                     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_RiskRatingReport_OutputSuccessRegEx", language + client);
        
        //Téléverser sur le vserver les fichiers requis pour les commandes SSH
        TestSSHConnexions(vServerRQS);
        var vserverRemoteFolder = "/home/" + CR1958_2_SSH_USERNAME + "/loader/" + CR1958_2_SSH_FOLDERNAME + "/"; //Has to comply with function ExecuteSSHCommand()
        CopyFileToVserverThroughWinSCP(vServerRQS, vserverRemoteFolder, CR1958_2_REPOSITORY_SSH + "CR1142_FULL_CPMA.txt");
        CopyFileToVserverThroughWinSCP(vServerRQS, vserverRemoteFolder, CR1958_2_REPOSITORY_SSH + "800229_PRO.xml");
        CopyFileToVserverThroughWinSCP(vServerRQS, vserverRemoteFolder, CR1958_2_REPOSITORY_SSH + "Transactions_ajout.xml");
        
        //PRÉCONDITIONS
        Log.Message("PRECONDITIONS : Prefs & Configs.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        ExecuteSQLFile_ThroughISQL(CR1958_2_REPOSITORY_SQL + "CR1958_2_6667_PreConditions_SQL.sql", vServerRQS);
        RestartServices(vServerRQS);
        
        Log.Message("PRECONDITIONS : SSH Commands.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cmdLine_cfLoaderPlugin_ClientStatusProcessor,    CR1958_2_SSH_USERNAME, cmdLine_cfLoaderPlugin_ClientStatusProcessor_OutputSuccessRegEx);
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cmdLine_cfLoaderPlugin_ClientLink,               CR1958_2_SSH_USERNAME, cmdLine_cfLoaderPlugin_ClientLink_OutputSuccessRegEx);
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cmdLine_Loader_TOTALS,                           CR1958_2_SSH_USERNAME, cmdLine_Loader_TOTALS_OutputSuccessRegEx);
                
        /*
        ÉTAPE #1 : Ajouter les transactions par les commandes loader suivantes (Récupérer les fichiers en annexe):
        loader 800229_PRO.xml -FORCE -LOG2STDOUT
        loader Transactions_ajout.xml -FORCE -LOG2STDOUT
        loader -TOTALS -LOG2STDOUT -FORCE
        */
        Log.Message("STEP #1 : Add Transactions through loader commands.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        var nbOfTransactionsBeforeSSH = Execute_SQLQuery_GetField("select count(*) as nbOfRows from B_TRANS", vServerRQS, "nbOfRows");
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cmdLine_Loader_800229_PRO,           CR1958_2_SSH_USERNAME, cmdLine_Loader_800229_PRO_OutputSuccessRegEx);
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cmdLine_Loader_Transactions_ajout,   CR1958_2_SSH_USERNAME, cmdLine_Loader_Transactions_ajout_OutputSuccessRegEx);
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cmdLine_Loader_TOTALS,               CR1958_2_SSH_USERNAME, cmdLine_Loader_TOTALS_OutputSuccessRegEx);
        
        //Valider le nombre de transations ajoutées à l'issue de l'exécution des commandes SSH
        var nbOfTransactionsAfterSSH = Execute_SQLQuery_GetField("select count(*) as nbOfRows from B_TRANS", vServerRQS, "nbOfRows");
        var nbOfTransactionsAdded = nbOfTransactionsAfterSSH - nbOfTransactionsBeforeSSH;
        CheckEquals(nbOfTransactionsAdded, loader_expectedNbOfTransactionsToBeAdded, "The number of Transactions added upon loader commands");
        
        //Valider les informations du client 800229 à l'issue de l'exécution des commandes SSH
        var filePathSelectProfileClientsSQL = CR1958_2_REPOSITORY_SQL + "800229_PRO_ValidateClientInfos.sql";
        var nbOfProfileClientsSQL = aqString.Replace(aqFile.ReadWholeTextFile(filePathSelectProfileClientsSQL, aqFile.ctANSI), "select * from", "select count(*) as nbOfRows from");
        var nbOfProfileClients = Execute_SQLQuery_GetField(nbOfProfileClientsSQL, vServerRQS, "nbOfRows");
        if (!CheckEquals(nbOfProfileClients, loader_expectedNbOfProfileClients, "The number of Profile matched Clients upon loader commands"))
            Log.Message(filePathSelectProfileClientsSQL, nbOfProfileClientsSQL);
        
        //Valider les informations des comptes 800229-NA et 800229-FS à l'issue de l'exécution des commandes SSH
        var filePathSelectProfileAccountsSQL = CR1958_2_REPOSITORY_SQL + "800229_PRO_ValidateAccountsInfos.sql";
        var nbOfProfileAccountsSQL = aqString.Replace(aqFile.ReadWholeTextFile(filePathSelectProfileAccountsSQL, aqFile.ctANSI), "select * from", "select count(*) as nbOfRows from");
        var nbOfProfileAccounts = Execute_SQLQuery_GetField(nbOfProfileAccountsSQL, vServerRQS, "nbOfRows");
        if (!CheckEquals(nbOfProfileAccounts, loader_expectedNbOfProfileAccounts, "The number of Profile matched Accounts upon loader commands"))
            Log.Message(filePathSelectProfileAccountsSQL, nbOfProfileAccountsSQL);
        
        /*
        ÉTAPE #2 : Exécuter les plugins suivants:
        cfLoader -DashboardRegenerator "generateRQSPortfolio=CLIENT,LINK" -firm=FIRM_1
        cfLoader -DashboardRegenerator \"ForceRegenGenerateAccountPortfolio=False\" -firm=FIRM_1
        cfLoader -RQSActivityBlotter="StartDate:2009.01.17;EndDate:2010.01.25"
        cfLoader -RQSAlertGenerator
        cfLoader -RiskRating \"-report\"
        */
        Log.Message("STEP #2 : Execute plugins.", "", pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cfLoaderPlugin_generateRQSPortfolio,                CR1958_2_SSH_USERNAME, cfLoaderPlugin_generateRQSPortfolio_OutputSuccessRegEx);
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cfLoaderPlugin_ForceRegenGenerateAccountPortfolio,  CR1958_2_SSH_USERNAME, cfLoaderPlugin_ForceRegenGenerateAccountPortfolio_OutputSuccessRegEx);
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cfLoaderPlugin_RQSActivityBlotter,                  CR1958_2_SSH_USERNAME, cfLoaderPlugin_RQSActivityBlotter_OutputSuccessRegEx);
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cfLoaderPlugin_RQSAlertGenerator,                   CR1958_2_SSH_USERNAME, cfLoaderPlugin_RQSAlertGenerator_OutputSuccessRegEx);
        ExecuteSSHCommand(CR1958_2_SSH_FOLDERNAME, vServerRQS, cfLoaderPlugin_RiskRating_report,                   CR1958_2_SSH_USERNAME, cfLoaderPlugin_RiskRating_report_OutputSuccessRegEx);
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
}
