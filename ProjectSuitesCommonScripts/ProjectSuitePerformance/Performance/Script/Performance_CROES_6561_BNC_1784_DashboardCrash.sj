//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Correspond au jira BNC-1784 Crash tableau de bord
    À AUTOMAISER DANS L'ENVIRONNEMENT NFR
    
    Lien sur TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6561
    Lien sur Jira : https://jira.croesus.com/browse/BNC-1784
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-19
*/

function Performance_CROES_6561_BNC_1784_DashboardCrash() {

    try {
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "NFRUNI00", "username");
        var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "NFRUNI00", "psw");
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6561","Cas de test TestLink : Croes-6561") 
        Log.Link("https://jira.croesus.com/browse/BNC-1784", "Cas de tests JIRA BNC-1784");
        
        // Se connecter
        Log.Message("*** Login ***")
        Login(vServerPerformance, user, psw, language);
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);
        Get_MainWindow().Maximize();
        
        //Tester le crash
        Log.Message("Aller dans Tableau de bord et cliquer dans le browser Sommaire de l'encaisse postive ");
        Get_Dashboard_PositiveCashBalanceSummaryBoard_DgvDashboardGrid().Click();
        
        if(Get_DlgError().Exists)
          Log.Error("Jira BNC-1784 : DashboardCrash")
        else
          Log.Checkpoint("Aucun crash détecté")

        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();             

    } catch (e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {

        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
    }

}