//USEUNIT CR1806_Helper




/**
    Description : Valider les droits d'accès et historique de l'extrait avec autres utilisateurs - Niveau Firme - Test positif
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4679
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4679_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_Firme_Test_Positif()
{
    Log.Message("CR1806_4679_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_Firme_Test_Positif()");
    CR1806_4679_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_Firme_Test_Positif_PourLeModule(aqFileSystem.GetFileNameWithoutExtension(Project.FileName));
}



function CR1806_4679_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_Firme_Test_Positif_PourLeModule(executionModuleName)
{
    if (executionModuleName != undefined) executionModuleName = aqString.ToUpper(Trim(executionModuleName));
    
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4679", "Pour ouvrir le cas de test, cliquer sur le lien dans la colonne 'Link'.");
    Log.Message("JIRA CROES-10234 : Le champ NB_RECORDS et IA_CODES de la table B_data_hub est vide lorsqu'on exporte vers le presse-papiers sans sélectionner aucune donnée.");
    
    try {
        NameMapping.TimeOutWarning = false;
        
        //Récupérer la liste des utilisateurs pour lesquels le test va être fait
        var step1_User = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4679_Step1_User", language + client);
        var otherUsersString = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4679_Others_Users", language + client);
        var arrayOfOtherUsers= otherUsersString.split("|");
        
        var prefValue = "YES";
        var prefLevel = "FIRM";
        var shouldExportSuccess = true;
        var isCfLoaderCommandToBeChecked = true;
        var arrayOfUsers = arrayOfOtherUsers.concat([step1_User]);
        
        //Mettre à jour la Pref
        UpdateDataHubPrefAtSameLevelForUsers(arrayOfUsers, prefValue, prefLevel);
        
        //Exécuter le cas Croes-4557
        Log.Message("");
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4557", "https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4557");
        CR1806_4557_Valider_les_parametres_pour_l_execution_du_plugin_DataHubExtractor();
        
        //Exécuter le cas Croes-4679
        Log.Message("");
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4679", "https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4679");

        //Étapes 1, 2
        ValidateExtractForUser_Steps_1_2_ForModule(step1_User, shouldExportSuccess, isCfLoaderCommandToBeChecked, executionModuleName);
        
        //Autres étapes : Executer le test pour les autres utilisateurs
        for (var j in arrayOfOtherUsers) ValidateExtractForUser_ForModule(arrayOfOtherUsers[j], shouldExportSuccess, isCfLoaderCommandToBeChecked, executionModuleName);

    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        if (arrayOfUsers != undefined) UpdateDataHubPrefAtSameLevelForUsers(arrayOfUsers, null, prefLevel); //Mettre la Pref à sa valeur par défaut
        Terminate_CroesusProcess();
        NameMapping.TimeOutWarning = true;
    }
}



/**
    Description : Valider les paramètres pour l'exécution du plugin DataHubExtractor
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4557
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4557_Valider_les_parametres_pour_l_execution_du_plugin_DataHubExtractor()
{
    
    try {        
        var fileName = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4557_FileName", language + client);
        var extractDate_step2 = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4557_Step2_ExtractDate", language + client);
        var extractDate_step3 = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4557_Step3_ExtractDate", language + client);
        
        //Étape 1 : Exécuter le plugin cfLoader -DataHubExtractor (Sans les parametres)
        Log.Message("****** Croes-4557, Étape 1 : Exécuter le plugin cfLoader -DataHubExtractor (Sans les parametres).");
        ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, null, null, vserverDefaultFolder);
        
        //Étape 2 : Exécuter le rapport avec un seul paramètre : --ExtractDate
        Log.Message("****** Croes-4557, Étape 2 : Exécuter le rapport avec un seul paramètre : --ExtractDate");
        ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, null, extractDate_step2, vserverDefaultFolder);
        
        //Étape 3 : Exécuter le plugincfLoader -DataHubExtractor (avec les paramètres) : --FileName et --ExtractDate
        Log.Message("****** Croes-4557, Étape 3 : Exécuter le plugincfLoader -DataHubExtractor (avec les paramètres) : --FileName et --ExtractDate");
        ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, fileName, extractDate_step3, vserverDefaultFolder);
    }
    catch(e_CR1806_4557) {
        Log.Error("Croes-4557 Exception !", e_CR1806_4557.message);
        e_CR1806_4557 = null;
    }
}



function ValidateExtractForUser_Steps_1_2_ForModule(testUser, shouldExportSuccess, isCfLoaderCommandToBeChecked, executionModuleName)
{
    if (executionModuleName != undefined) executionModuleName = aqString.ToUpper(Trim(executionModuleName));
    
    try {
        Log.AppendFolder(testUser, "Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_" + testUser);
        
        var testUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", testUser, "username");
        var testUserPwd = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", testUser, "psw");
        
        //Se connecter avec l'utilisateur
        Login(vServerDataHub, testUserName, testUserPwd, language);
        Delay(3000);
        
        //Step 1 : Pour les Rapports
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Relationships){
            var reportDisplayedName = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Report_SecurityIncomeAnalysis_DisplayedName", language + client);
            var reportName = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Report_SecurityIncomeAnalysis_ReportName", language + client);
            var exportMethodForReports = exportMethod_MenuBar_Reports;
            GotoModule(moduleName_Relationships);
            ExecuteManyExportsForReports(testUserName, moduleName_Relationships, reportDisplayedName, reportName, shouldExportSuccess, isCfLoaderCommandToBeChecked, exportMethodForReports);
        }
        
        //Step 2 : Pour les autres modules
        var arrayOfExportMethod = [exportMethod_ClickR_Copy, exportMethod_ClickR_CopyWithHeader, exportMethod_ClickR_ExportToFile, exportMethod_ClickR_ExportToMSExcel, exportMethod_ClickR_Print];
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Models){
            GotoModule(moduleName_Models);
            ExecuteManyExportsFromModule(testUserName, moduleName_Models, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Relationships){
            Log.Message("JIRA CROES-10587 : Il n'y a pas d'enregistrement sur la table b_data_hub lors de faire une copie ou exporter sur le module Relations, Clients et Comptes vides.");
            GotoModule(moduleName_Relationships);
            ExecuteManyExportsFromModule(testUserName, moduleName_Relationships, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Clients){
            Log.Message("JIRA CROES-10587 : Il n'y a pas d'enregistrement sur la table b_data_hub lors de faire une copie ou exporter sur le module Relations, Clients et Comptes vides.");
            GotoModule(moduleName_Clients);
            ExecuteManyExportsFromModule(testUserName, moduleName_Clients, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Accounts){
            Log.Message("JIRA CROES-10587 : Il n'y a pas d'enregistrement sur la table b_data_hub lors de faire une copie ou exporter sur le module Relations, Clients et Comptes vides.");
            GotoModule(moduleName_Accounts);
            ExecuteManyExportsFromModule(testUserName, moduleName_Accounts, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Portfolio){
            if (DragAccountsToPortfolio([]))
                ExecuteManyExportsFromModule(testUserName, moduleName_Portfolio, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Transactions){
            GotoModule(moduleName_Transactions);
            ExecuteManyExportsFromModule(testUserName, moduleName_Transactions, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Securities){
            GotoModule(moduleName_Securities);
            ExecuteManyExportsFromModule(testUserName, moduleName_Securities, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Orders){
            Log.Message("JIRA CROES-10233 : Lorsqu'on exporte vers excel via le blotter du module Ordres, la FUNCTION_ID = OrdreAccumulatorDataGrid au lieu de FUNCTION_ID = OrdreBlotterDataGrid qui est le comportement attendu.");
            Log.Message("JIRA CROES-10231 : Crash de l'application lorsqu'on fait une copie sur le datagrille vide du module Ordres.");
            GotoModule(moduleName_Orders);
            ExecuteManyExportsFromModule(testUserName, moduleName_Orders, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
            
            GotoModule(moduleName_Orders_Accumulator);
            ExecuteManyExportsFromModule(testUserName, moduleName_Orders_Accumulator, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.PopLogFolder();
    }
}



function ValidateExtractForUser_ForModule(testUser, shouldExportSuccess, isCfLoaderCommandToBeChecked, executionModuleName)
{
    if (executionModuleName != undefined) executionModuleName = aqString.ToUpper(Trim(executionModuleName));
    
    try {
        Log.AppendFolder(testUser, "Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_" + testUser);
        
        //Se connecter avec l'utilisateur
        var testUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", testUser, "username");
        var testUserPwd = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", testUser, "psw");
        Login(vServerDataHub, testUserName, testUserPwd, language);
        
        Delay(3000);
        
        var arrayOfExportMethod = [exportMethod_MenuBar_Copy, exportMethod_MenuBar_CopyWithHeader, exportMethod_MenuBar_ExportToFile, exportMethod_MenuBar_ExportToMSExcel];
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Models){
            GotoModule(moduleName_Models);
            ExecuteManyExportsFromModule(testUserName, moduleName_Models, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Relationships){
            Log.Message("JIRA CROES-10587 : Il n'y a pas d'enregistrement sur la table b_data_hub lors de faire une copie ou exporter sur le module Relations, Clients et Comptes vides.");
            GotoModule(moduleName_Relationships);
            ExecuteManyExportsFromModule(testUserName, moduleName_Relationships, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Clients){
            Log.Message("JIRA CROES-10587 : Il n'y a pas d'enregistrement sur la table b_data_hub lors de faire une copie ou exporter sur le module Relations, Clients et Comptes vides.");
            GotoModule(moduleName_Clients);
            ExecuteManyExportsFromModule(testUserName, moduleName_Clients, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Accounts){
            Log.Message("JIRA CROES-10587 : Il n'y a pas d'enregistrement sur la table b_data_hub lors de faire une copie ou exporter sur le module Relations, Clients et Comptes vides.");
            GotoModule(moduleName_Accounts);
            ExecuteManyExportsFromModule(testUserName, moduleName_Accounts, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Portfolio){
            if (DragAccountsToPortfolio([]))
                ExecuteManyExportsFromModule(testUserName, moduleName_Portfolio, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Transactions){
            GotoModule(moduleName_Transactions);
            ExecuteManyExportsFromModule(testUserName, moduleName_Transactions, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Securities){
            GotoModule(moduleName_Securities);
            ExecuteManyExportsFromModule(testUserName, moduleName_Securities, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Orders){
            Log.Message("JIRA CROES-10233 : Lorsqu'on exporte vers excel via le blotter du module Ordres, la FUNCTION_ID = OrdreAccumulatorDataGrid au lieu de FUNCTION_ID = OrdreBlotterDataGrid qui est le comportement attendu.");
            Log.Message("JIRA CROES-10231 : Crash de l'application lorsqu'on fait une copie sur le datagrille vide du module Ordres.");
            GotoModule(moduleName_Orders);
            ExecuteManyExportsFromModule(testUserName, moduleName_Orders, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
            
            //The tested export methods are not available for Orders Accumulator
            //GotoModule(moduleName_Orders_Accumulator);
            //ExecuteManyExportsFromModule(testUserName, moduleName_Orders_Accumulator, shouldExportSuccess, isCfLoaderCommandToBeChecked, arrayOfExportMethod);
        }
        
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.PopLogFolder();
    }
}