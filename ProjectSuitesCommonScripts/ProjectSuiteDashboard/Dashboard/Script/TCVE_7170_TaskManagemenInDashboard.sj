//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/**
    Jira Xray                 : https://jira.croesus.com/browse/TCVE-7170
    Description               : Réinitialiser les tâches qui ne respectent pas les critères d'un board (grace period)
    Version de scriptage      : ref90-27-77
    Date:                     : 22 septembre 2021

    Analyste d'automatisation : Abdel.m
    Analyste QA               : Karima.Mo
**/

function TCVE_7170_TaskManagemenInDashboard()
{
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-7169","Lien du cas de test dans Jira");
        Log.Link("https://jira.croesus.com/browse/TCVE-7170","Lien de la story dans Jira");
        
        var userNameREAGAR     = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
        var passwordREAGAR     = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
        
        
        var SSHUser   = "aminea";
        var SSHFolder = "CR1958.2.6644";
        var sshCommand = "cfLoader -DashboardRegenerator -FIRM=FIRM_1";
        
        var ModelTCVE7170 = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "TCVE", "ModelTCVE7170", language+client);
        var equity = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "TCVE", "equity", language+client);
        var account800049RE = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "TCVE", "account800049RE", language+client);
        var lincoa = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "TCVE", "lincoa", language+client);

        //******************************************* Étape 1***************************************************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Pré-condition pour ajouter le board Objectif de placement- Écarts- Modèle.");
        
        // Se connecter à croesus
        Log.Message("Se connecter à croesus");
        Login(vServerDashboard, userNameREAGAR, passwordREAGAR, language);
        
        Log.Message("Aller dans le module Modeles");
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
        
        //Rechercher le modèle 'CH CANADIAN EQUI' et aller à l'onglet 'Objectif de placement'
        Log.Message("Rechercher le modèle 'CH CANADIAN EQUI' et aller à l'onglet 'Objectif de placement'");
        SearchModelByName(ModelTCVE7170);
        Get_ModelsGrid().Find("Value",ModelTCVE7170,10).DblClick();
        WaitObject(Get_CroesusApp(), "Uid", "GroupBox_2d83");
        Get_WinModelInfo_TabInvestmentObjective().Click();
        Get_WinModelInfo_TabInvestmentObjective_BtnInvestmentObjective().Click();
        Get_SubMenus().Find("Value",equity,10).Click();
        Get_WinModelInfo_BtnOK().Click();
        
        Log.Message("Associer le compte 800049-RE au modèle");
        AssociateAccountWithModel(ModelTCVE7170, account800049RE);
        
        Log.message("Aller au module Dashboard et ajouter le board Objectif de placement- Écarts- Modèle");
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 30000);
         
        //Vider Dashboard
        Clear_Dashboard();
        //Ajouter la grille sommaire d'encaisse positif
        Add_PositiveCashBalanceSummaryBoard();
        //Ajouter la grille Objectif de placement- Écarts- Modèle
        Get_Toolbar_BtnAdd().Click();
        Get_DlgAddBoard_TvwSelectABoard_InvestmentObjectiveVariationModels().Click();
        Get_DlgAddBoard_BtnOK().Click();
        
        //Cliquer sur le petit crayon, puis Sauvegarder et actualiser 
        Log.Message("Cliquer sur le petit crayon, puis Sauvegarder et actualiser ");
        Get_DashboardPlugin().Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("ScrollViewer").WPFObject("UnsynchronizedModelsBoard", "", 1).WPFObject("PART_BoardToolbar").WPFObject("ToolBar", "", 1).WPFObject("Button", "", 3).Click();
        WaitObject(Get_CroesusApp(), "Uid", "BasicCriteriaEditor_6401");
        Get_Dashboard_InvestmentObjectiveVariationModels_BtnSaveAndRefresh().Click();
        if (Get_DlgConfirmation().Exists) Get_DlgConfirmation_BtnOk().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "BasicCriteriaEditor_6401");
        
        Log.message("Valider que le modele "+ModelTCVE7170+" est affiché dans le board");
        if (Get_Dashboard_InvestmentObjectiveVariationModelsBoard().Find("Text", ModelTCVE7170, 10))
            Log.Checkpoint("le modele "+ModelTCVE7170+" est affiché dans le board Objectif de placement- Écarts- Modèle");
        
                                    
        //******************************************* Étape 2***************************************************

        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Valider que les tâches ne sont pas renitialisés si la pref=7 et la date Dernière mise à jour+7> date actuel.");
        
        Log.Message("Dans le board Sommaire de l'encaisse positive, mettre la tâche 800216-NA à complétée");
        var checkbox = Get_DashboardPlugin().Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("ScrollViewer").WPFObject("UpperCashBalanceSummaryBoard", "", 1).WPFObject("_dashboardGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1)
        if (checkbox.IsChecked == false) checkbox.Click();
        
        //Dans le board Objectif de placement- écarts- Modèles avec un click droit assigner le modèle CH CANADIAN EQUI à LINCOA
        Log.Message("Dans le board Objectif de placement- écarts- Modèles avec un click droit assigner le modèle CH CANADIAN EQUI à LINCOA");
        Get_Dashboard_InvestmentObjectiveVariationModelsBoard().Find("Text", ModelTCVE7170, 10).ClickR();
        Get_SubMenus().FindChild("Uid", "MenuItem_bb66", 10).OpenMenu();
        Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find("Text", lincoa, 10).Click();
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
       
        //******************************************* Étape 3***************************************************

        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Rouler le plugin: cfLoader -DashboardRegenerator -FIRM=FIRM_1.");
        
        Log.Message("Execution de la commande cfLoader");
        ExecuteSSHCommandCFLoader(SSHFolder, vServerDashboard, sshCommand, SSHUser);
        
        
        //******************************************* Étape 4***************************************************

        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Valider que les tâches sont réinitialisés si la pref=7 et la date Dernière mise à jour+7 < date actuel.");
        
        // Obtain the current date
        var CurrentDate = aqDateTime.Today();

        // Convert the date/time value to a string and post it to the log
        Today = aqConvert.DateTimeToStr(CurrentDate);
        Log.Message("Today is " + Today);

        // Trouver la date de la semaine passée
        LastWeekDate = aqDateTime.AddDays(CurrentDate, -8);
        ConvertedLastWeekDate = aqConvert.DateTimeToStr(LastWeekDate);
        Log.Message("Last Week was " + ConvertedLastWeekDate);
        LastWeekDate = aqConvert.DateTimeToFormatStr(ConvertedLastWeekDate, "%Y-%m-%d");
        Log.Message(LastWeekDate);
        
        //Exécuter la requête update b_task_account set last_update = 'date actuel - 8'
        Log.Message("Exécuter la requête update b_task_account set last_update = 'date actuel - 8'");
        queryString = "update b_task_account set last_update = '"+ LastWeekDate+"'";
        Execute_SQLQuery(queryString, vServerDashboard);
        
        //Rouler le plugin: cfLoader -DashboardRegenerator -FIRM=FIRM_1
        
        Log.Message("Rouler le plugin: cfLoader -DashboardRegenerator -FIRM=FIRM_1");
        ExecuteSSHCommandCFLoader(SSHFolder, vServerDashboard, sshCommand, SSHUser);
        
        //******************************************* Étape 5***************************************************

        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Valider que les tâches ne sont pas renitialisés si la pref=7 et la date Dernière mise à jour+7> date actuel.");
                
        // Se connecter à croesus
        Log.Message("Se connecter à croesus");
        Login(vServerDashboard, userNameREAGAR, passwordREAGAR, language);
        
        //Valider que les deux taches sont réinitialisées
        Log.Message("Valider que les deux taches sont réinitialisées");
        if (checkbox.IsChecked == false) 
            Log.Checkpoint("La tache du compte 800216-NA est réinitialisée");
        else  
            Log.Error("La tache du compte 800216-NA n'est pas réinitialisée");
            
        var grid = Get_DashboardPlugin().Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("ScrollViewer").WPFObject("UnsynchronizedModelsBoard", "", 1).WPFObject("_dashboardGrid").WPFObject("RecordListControl", "", 1)
        var count = grid.Items.Count;
        for (i=0; i<count; i++){
            if (grid.Items.Item(i).DataItem.ModelName == ModelTCVE7170)
                aqObject.CheckProperty(grid.Items.Item(i).DataItem, "Owner", cmpEqual, null);
        }
            
        
        Log.Message("Dans le board Sommaire de l'encaisse positive, mettre la tâche 800216-NA à complétée");
        var checkbox = Get_DashboardPlugin().Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("ScrollViewer").WPFObject("UpperCashBalanceSummaryBoard", "", 1).WPFObject("_dashboardGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1)
        if (checkbox.IsChecked == false) checkbox.Click();
        
        //Dans le board Objectif de placement- écarts- Modèles avec un click droit assigner le modèle CH CANADIAN EQUI à LINCOA
        Log.Message("Dans le board Objectif de placement- écarts- Modèles avec un click droit assigner le modèle CH CANADIAN EQUI à LINCOA");
        Get_Dashboard_InvestmentObjectiveVariationModelsBoard().Find("Text", ModelTCVE7170, 10).ClickR();
        Get_SubMenus().FindChild("Uid", "MenuItem_bb66", 10).OpenMenu();
        Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find("Text", lincoa, 10).Click();
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        
        //******************************************* Étape 6***************************************************

        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Valider que les tâches sont réinitialisés si la pref=0 et la date Dernière mise à jour < date actuel.");
        
        // Obtain the current date
        var CurrentDate = aqDateTime.Today();

        // Convert the date/time value to a string and post it to the log
        Today = aqConvert.DateTimeToStr(CurrentDate);
        Log.Message("Today is " + Today);

        // Trouver la date d'hier
        LastWeekDate = aqDateTime.AddDays(CurrentDate, -1);
        ConvertedLastWeekDate = aqConvert.DateTimeToStr(LastWeekDate);
        Log.Message("Last Week was " + ConvertedLastWeekDate);
        LastWeekDate = aqConvert.DateTimeToFormatStr(ConvertedLastWeekDate, "%Y-%m-%d");
        Log.Message(LastWeekDate);
        
        //Exécuter la requête update b_task_account set last_update = 'date actuel - 1'
        Log.Message("Exécuter la requête update b_task_account set last_update = 'date actuel - 1'");
        queryString = "update b_task_account set last_update = '"+ LastWeekDate+"'";
        Execute_SQLQuery(queryString, vServerDashboard);
        
        //Rouler le plugin: cfLoader -DashboardRegenerator -FIRM=FIRM_1
        
        Log.Message("Rouler le plugin: cfLoader -DashboardRegenerator -FIRM=FIRM_1");
        ExecuteSSHCommandCFLoader(SSHFolder, vServerDashboard, sshCommand, SSHUser);    
        
        // Se connecter à croesus
        Log.Message("Se connecter à croesus");
        Login(vServerDashboard, userNameREAGAR, passwordREAGAR, language);
        

    }
    catch(e) {

        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
        
        //supprimer l'objectif de placement 
        Log.Message("Aller dans le module Modeles");
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
        Log.Message("supprimer l'objectif de placement ");
        SearchModelByName(ModelTCVE7170);
        Get_ModelsGrid().Find("Value",ModelTCVE7170,10).DblClick();
        WaitObject(Get_CroesusApp(), "Uid", "GroupBox_2d83");
        Get_WinModelInfo_TabInvestmentObjective().Click();
        Get_WinModelInfo_TabInvestmentObjective_ChkInvestmentObjective().Click();
        Get_WinModelInfo_BtnOK().Click();
        
        //Retirer le compte du modele
        Log.Message("Retirer le compte du modele")
        Get_Models_Details().Find("Value", account800049RE, 10).Click();
        Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
        Get_DlgConfirmation_BtnYes().Click();
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Log.Message("Remettre la pref à 7");
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DASHBOARD_TASK_GRACE_PERIOD", "7", vServerDashboard);
        RestartServices(vServerDashboard);
       
    }
}



