//USEUNIT CR1806_4679_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_Firme_Test_Positif




/**
    Description : Valider les droits d'accès et historique de l'extrait avec autres utilisateurs - Niveau User - Test positif
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4686
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4686_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_User_Test_Positif()
{
    Log.Message("CR1806_4686_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_User_Test_Positif()");
    CR1806_4686_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_User_Test_Positif_PourLeModule(aqFileSystem.GetFileNameWithoutExtension(Project.FileName));
}


function CR1806_4686_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_User_Test_Positif_PourLeModule(executionModuleName)
{
    if (executionModuleName != undefined) executionModuleName = aqString.ToUpper(Trim(executionModuleName));
    
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4686", "Pour ouvrir le cas de test, cliquer sur le lien dans la colonne 'Link'.");
    
    Log.Message("JIRA CROES-10234 : Le champ NB_RECORDS et IA_CODES de la table B_data_hub est vide lorsqu'on exporte vers le presse-papiers sans sélectionner aucune donnée.");
    
    try {
        NameMapping.TimeOutWarning = false;
        
        //Récupérer la liste des utilisateurs pour lesquels le test va être fait
        var step1_User = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4686_Step1_User", language + client);
        var otherUsersString = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4686_Others_Users", language + client);
        var arrayOfOtherUsers = otherUsersString.split("|");
        
        var helpDeskUser = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4686_HelpDesk_User", language + client);
        var helpDeskUserIACodesString = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4686_HelpDesk_IACodes", language + client);
        var arrayOfHelpDeskUserIACodes = helpDeskUserIACodesString.split("|");
        
        var prefValue = "YES";
        var prefLevel = "USER";
        var shouldExportSuccess = true;
        var isCfLoaderCommandToBeChecked = true;
        var arrayOfUsers = arrayOfOtherUsers.concat([step1_User]);
        
        //Configurer les Codes CP pour le Help Desk
        AddIACodesToUser(helpDeskUser, arrayOfHelpDeskUserIACodes, vServerDataHub);
        
        //Mettre à jour la Pref
        UpdateDataHubPrefAtSameLevelForUsers(arrayOfUsers, prefValue, prefLevel);
        
        //Étapes 1, 2
        ValidateExtractForUser_Steps_1_2_ForModule(step1_User, shouldExportSuccess, isCfLoaderCommandToBeChecked, executionModuleName);
        
        //Autres étapes : Executer le test pour les autres utilisateurs
        for (var j in arrayOfOtherUsers)
            ValidateExtractForUser_ForModule(arrayOfOtherUsers[j], shouldExportSuccess, isCfLoaderCommandToBeChecked, executionModuleName);

    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        if (arrayOfHelpDeskUserIACodes != undefined) DeleteIACodesForUser(helpDeskUser, arrayOfHelpDeskUserIACodes, vServerDataHub); //Supprimer les Codes CP pour le help Desk
        if (arrayOfUsers != undefined) UpdateDataHubPrefAtSameLevelForUsers(arrayOfUsers, null, prefLevel); //Mettre la Pref à sa valeur par défaut
        Terminate_CroesusProcess();
        NameMapping.TimeOutWarning = true;
    }
}