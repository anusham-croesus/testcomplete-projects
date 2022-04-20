//USEUNIT CR1485_Common_functions



function CR1485_PreparationBD_SQL()
{
    try {
        //Populer les dictionnaires 63, 64 et 65 en roulant le script RPFL70-dictionaries (5).sql (pour le rapport 23)
        //Commenté car mis dans le dump
        //SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\RPFL70-dictionaries (5).sql";
        //ExecuteSQLFile(SQLFilePath, vServerReportsCR1485);
        
        //Mettre à jour des Représentants en roulant le script MettreAJour_Reps.sql (pour les rapports 38, 100, 109, 144, 149)
        ExecuteSQLFile_ThroughISQL(folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\MettreAJour_Reps.sql", vServerReportsCR1485);
    
        //Populer les tables B_SYSTEMATIC_PLAN et B_SYSTEMATIC_PLAN_DETAILS en roulant le script Donnees_RPT_PlanSyst.sql (pour le rapport 118)
        //Commenté car mis dans le dump
        //SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\Donnees_RPT_PlanSyst.sql";
        //ExecuteSQLFile(SQLFilePath, vServerReportsCR1485);
        
        //Populer les tables B_AGENDA et B_AGUSER en roulant le script PopulerAgenda.sql (pour les rapports 19, 35, 39, 40 et 68)
        ExecuteSQLFile_ThroughISQL(folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\PopulerAgenda.sql", vServerReportsCR1485);
        
        //Ajouter des restrictions en roulant le script AjouterRestrictions_rapport_81.sql (pour le rapport 81)
        var SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\AjouterRestrictions_rapport_81.sql";
        ExecuteSQLFile(SQLFilePath, vServerReportsCR1485);
        
        //Exécuter la requête : update b_icset set no_succ='H-O' (JIRA CROES-8424)
        Execute_SQLQuery("update B_ICSET set NO_SUCC = 'H-O' where NO_SUCC = 'H-0'", vServerReportsCR1485);
        
        //redémarrer les services
        RestartServices(vServerReportsCR1485);
    }
    catch(exception_CR1485_PreparationBD_SQL) {
        Log.Error("Exception from CR1485_PreparationBD_SQL(): " + exception_CR1485_PreparationBD_SQL.message, VarToStr(exception_CR1485_PreparationBD_SQL.stack));
        exception_CR1485_PreparationBD_SQL = null;
    }
}
