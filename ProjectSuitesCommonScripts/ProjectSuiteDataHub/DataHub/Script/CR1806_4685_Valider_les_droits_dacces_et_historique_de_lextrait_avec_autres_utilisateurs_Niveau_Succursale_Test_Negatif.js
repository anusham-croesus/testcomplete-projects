//USEUNIT CR1806_4679_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_Firme_Test_Positif




/**
    Description : Valider les droits d'accès et historique de l'extrait avec autres utilisateurs - Niveau Succursale - Test négatif
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4685
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4685_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_Succursale_Test_Negatif()
{
    Log.Message("CR1806_4685_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_Succursale_Test_Negatif()");
    CR1806_4685_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_Succursale_Test_Negatif_PourLeModule(aqFileSystem.GetFileNameWithoutExtension(Project.FileName));
}



function CR1806_4685_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_Succursale_Test_Negatif_PourLeModule(executionModuleName)
{
    if (executionModuleName != undefined) executionModuleName = aqString.ToUpper(Trim(executionModuleName));
    
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4685", "Pour ouvrir le cas de test, cliquer sur le lien dans la colonne 'Link'.");
    
    try {
        NameMapping.TimeOutWarning = false;
        
        //Récupérer la liste des utilisateurs pour lesquels le test va être fait
        var usersString = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4685_NegativeTest_User", language + client);
        var arrayOfUsers= usersString.split("|");
        
        var prefValue = "NO";
        var prefLevel = "BRANCH";
        var shouldExportSuccess = false;
        var isCfLoaderCommandToBeChecked = true;
        
        //Mettre à jour la Pref
        UpdateDataHubPrefAtSameLevelForUsers(arrayOfUsers, prefValue, prefLevel);
        
        //Executer le test pour les utilisateurs
        for (var j in arrayOfUsers) 
            ValidateExtractForUser_ForModule(arrayOfUsers[j], shouldExportSuccess, isCfLoaderCommandToBeChecked, executionModuleName);

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