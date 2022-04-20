//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
        Module:                 Titres
        Auteur :                Mathieu Gagne/ corrigé par Amine A.
        Anomalie:               CROES-5760
        Version de scriptage:	90.13.In-6
        
        Script mis-à-jour par Philppe M.
        Versions: 90.27.2021.10-94 / 90.28.2021.12-50
    
        01 - Aller dans le configurateur et mettre au niveau Firme Croesus:  PREF_ENABLE_RISK_RATING=1   
        02 - Populer le dictionnaire 136 en exécutant la requête SQL suivante: CR1152-config_dict.sql'
        03 - Se loguer dans SSH ou Putty
        04 - Exécuter la comande suivante:  cfLoader -RiskRating=\"CNCOTI00_CR1152_20100125.CSV\"
        05 - Exécuter la requête SQL suivante: select SECURITY, SECUFIRME, SYMBOLE, DESC_L1, DESC_L2, CATEGO, RISK_RATING from b_titre where RISK_RATING !=null     
        06 - Remettre à la Pref à sa valeur initiale. Pour BNC :  PREF_ENABLE_RISK_RATING=2    
*/   

function CR1152_8926_PopulerColonneRiskRatingDu_b_titre() {

    try {
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6819", "Lien du Cas de test sur Testlink");
        Log.Link("https://jira.croesus.com/browse/TCVE-8382", "Lien du Cas de test sur XRay");

        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("01 - Aller dans le configurateur et mettre au niveau Firme Croesus:  PREF_ENABLE_RISK_RATING=1" );
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_RISK_RATING", "1", vServerTitre);
        RestartServices(vServerTitre);

        //02 *Insérer dans la bd un titre avec un secufirme qui contient le mot 'END':*
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("02 - Insérer dans la bd un titre avec un secufirme qui contient le mot 'END':" );
 
        
        Log.Message("* Copier les fichiers 'sec_DATA-TEST.xml' et 'CNCOTI00_CR1152_20100125.CSV' dans un répertoire du WinSCP");
        var Titres_REPOSITORY_SSH = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteTitres\\Titres\\SSH\\";
        var vserverFolder = "/home/philippema/loader/CR1152";
        var dataFile = "sec_DATA-TEST.xml";
        var csvFile = "CNCOTI00_CR1152_20100125.CSV";
        
        CopyFileToVserverThroughWinSCP(vServerTitre, vserverFolder, Titres_REPOSITORY_SSH + dataFile);
        CopyFileToVserverThroughWinSCP(vServerTitre, vserverFolder, Titres_REPOSITORY_SSH + csvFile);
        
        // * Lancer la commande: loader sec_DATA-TEST.xml -FORCE -LOG2STDOUT
        Log.Message("* Lancer la commande: loader sec_DATA-TEST.xml -FORCE -LOG2STDOUT")
        ExecuteSSHCommandCFLoader("CR1152", vServerTitre, "loader sec_DATA-TEST.xml -FORCE -LOG2STDOUT", "philippema");



        // 03 - Populer le dictionnaire 136 en exécutant la requête SQL suivante: CR1152-config_dict.sql'
        //ExecuteSQLFile_ThroughISQL(folderPath_ProjectSuiteCommonScripts + "\ProjectSuiteTitres\\Titres\\" + "CR1152-config_dict.sql", vServerTitre);
        //Ne pas exécuter avec la nouvelle BD de VMD

        
        // 04 - Se loguer dans SSH et Exécuter la comande suivante:  cfLoader -RiskRating=\"CNCOTI00_CR1152_20100125.CSV\"
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("04 - Se loguer dans SSH et Exécuter la comande suivante:  cfLoader -RiskRating=\"CNCOTI00_CR1152_20100125.CSV\" " );
    
        var loaderSSHCommand = "cfLoader -RiskRating=\\"  + "\"CNCOTI00_CR1152_20100125.CSV\\"+"\"";
        Log.Message(loaderSSHCommand);
        ExecuteSSHCommandCFLoader("CR1152", vServerTitre, loaderSSHCommand, "philippema");

        
        // 05 - Exécuter la requête SQL suivante:  select SECURITY, SECUFIRME, SYMBOLE, DESC_L1, DESC_L2, CATEGO, RISK_RATING from b_titre where RISK_RATING !=null
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("05 - Exécuter la requête SQL suivante:  'select SECURITY, SECUFIRME, SYMBOLE, DESC_L1, DESC_L2, CATEGO, RISK_RATING from b_titre where RISK_RATING !=null " );
        var query = "select SECURITY, SECUFIRME, SYMBOLE, DESC_L1, DESC_L2, CATEGO, RISK_RATING from b_titre where RISK_RATING !='null'";
        var fieldName = "SECURITY"
        var arrayOfValues = Execute_SQLQuery_GetFieldAllValues(query, vServerTitre, fieldName);

        
        // CHECK - La requête est exécutée et retourne 14 rangées
        Log.Message("Nombre de rangées: " + arrayOfValues.length);
        var valeureAttendue = 14;
        
        if (arrayOfValues.length == valeureAttendue) {
            Log.Checkpoint(" La requête est exécutée et  affiche " + valeureAttendue + " rangées");
        } else {
            Log.Error(" La requête SQL ne retourne pas le résultat attendu");
        }
    } catch (e) {
        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    } finally {
        // 06 - Remettre à la Pref à sa valeur initiale. Pour BNC :  PREF_ENABLE_RISK_RATING=2
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("06 - Remettre à la Pref à sa valeur initiale. Pour BNC :  PREF_ENABLE_RISK_RATING=2" );
        
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_RISK_RATING", "2", vServerTitre);
        RestartServices(vServerTitre);
    }
}