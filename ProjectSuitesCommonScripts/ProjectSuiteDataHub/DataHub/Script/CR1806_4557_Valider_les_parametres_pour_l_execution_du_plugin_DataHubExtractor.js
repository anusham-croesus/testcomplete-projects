//USEUNIT CR1806_Helper




/**
    Description : Valider les paramètres pour l'exécution du plugin DataHubExtractor
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4557
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4557_Valider_les_parametres_pour_l_execution_du_plugin_DataHubExtractor()
{
    /////////////////////
    return Log.Message("Ce script sera supprimé car désormais intégré à : CR1806_4679_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_Firme_Test_Positif()", "Voir : CR1806_4679_Valider_les_droits_dacces_et_historique_de_lextrait_avec_autres_utilisateurs_Niveau_Firme_Test_Positif()");

    Log.Message("CR1806_4557_Valider_les_parametres_pour_l_execution_du_plugin_DataHubExtractor()");
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4557", "Pour ouvrir le cas de test, cliquer sur le lien dans la colonne 'Link'.");
    
    try {
        NameMapping.TimeOutWarning = false;
        
        var fileName = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4557_FileName", language + client);
        var extractDate_step2 = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4557_Step2_ExtractDate", language + client);
        var extractDate_step3 = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4557_Step3_ExtractDate", language + client);
        
        //Étape 1 : Exécuter le plugin cfLoader -DataHubExtractor (Sans les parametres)
        Log.Message("****** Étape 1 : Exécuter le plugin cfLoader -DataHubExtractor (Sans les parametres).");
        ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, null, null, vserverDefaultFolder);
        
        //Étape 2 : Exécuter le rapport avec un seul paramètre : --ExtractDate
        Log.Message("****** Étape 2 : Exécuter le rapport avec un seul paramètre : --ExtractDate");
        ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, null, extractDate_step2, vserverDefaultFolder);
        
        //Étape 3 : Exécuter le plugincfLoader -DataHubExtractor (avec les paramètres) : --FileName et --ExtractDate
        Log.Message("****** Étape 3 : Exécuter le plugincfLoader -DataHubExtractor (avec les paramètres) : --FileName et --ExtractDate");
        ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, fileName, extractDate_step3, vserverDefaultFolder);
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        NameMapping.TimeOutWarning = true;
    }
}
