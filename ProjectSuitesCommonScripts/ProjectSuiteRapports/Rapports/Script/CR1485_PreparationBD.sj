//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1485_Common_functions
//USEUNIT WebConfigurator_Get_functions
//USEUNIT SmokeTest_ConfigurateurWeb



function CR1485_PreparationBD()
{
    
    try {
        NameMapping.TimeOutWarning = false;
        
        ConfigureCorporateAssetAllocationReport();
    
        ActivatePrefsForPerformanceFeesAndBillingAndMorningstarIntegration();
        
        ExecuteSSHScriptForPerformanceSummary();
        
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        var Excel = Sys.OleObject("Excel.Application");
        Sys.WaitProcess("excel", 10000);
        Excel.DisplayAlerts = false;
    
        //Créer les relations utilisées pour les rapports
        Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_Relations").Activate();
        var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    
        for (var i = 2; i <= RowCount; i++){
            var relationshipName = VarToStr(Excel.Cells.Item(i, 1));
            var IACode = VarToStr(Excel.Cells.Item(i, 3));
            var currency = VarToStr(Excel.Cells.Item(i, 4));
            var relationshipLanguage = (language == "french")? VarToStr(Excel.Cells.Item(i, 5)): VarToStr(Excel.Cells.Item(i, 6));
            var isBillable = (client != "CIBC" && client != "VMBL"&& client != "VMD")? (aqString.ToUpper(VarToStr(Excel.Cells.Item(i, 7))) == "VRAI" || aqString.ToUpper(VarToStr(Excel.Cells.Item(i, 7))) == "TRUE"): null;
            
            var clientNumber = VarToStr(Excel.Cells.Item(i, 2));
        
            CreateRelationship(relationshipName, IACode, currency, relationshipLanguage, isBillable);
            JoinClientToRelationship(clientNumber, relationshipName);
        }
    
        //Ajouter adresse aux relations utilisées pour les rapports
        Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_AdressesRelations").Activate();
        var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    
        for (var i = 2; i <= RowCount; i++){
            var relationshipName = VarToStr(Excel.Cells.Item(i, 1));
            var street1 = VarToStr(Excel.Cells.Item(i, 2));
            var street2 = VarToStr(Excel.Cells.Item(i, 3));
            var street3 = VarToStr(Excel.Cells.Item(i, 4));
            var cityProv = VarToStr(Excel.Cells.Item(i, 5));
            var postalCode = VarToStr(Excel.Cells.Item(i, 6));
            var country = VarToStr(Excel.Cells.Item(i, 7));
        
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
            SearchRelationshipByName(relationshipName);
            Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
            
            Get_RelationshipsBar_BtnInfo().Click();
            Get_WinDetailedInfo_TabAddresses().Click();
            Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 60000);
            
            DeleteAllRelationshipAddresses();
            
            Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
            
            Get_WinCRUAddress_CmbType().set_IsDropDownOpen(true);
            Get_WinCRUAddress_CmbType_ItemOffice().Click();
            Get_WinCRUAddress_TxtStreet1().set_Text(street1);
            Get_WinCRUAddress_TxtStreet2().set_Text(street2);
            Get_WinCRUAddress_TxtStreet3().set_Text(street3);
            Get_WinCRUAddress_TxtCityProv().set_Text(cityProv);
            Get_WinCRUAddress_TxtPostalCode().set_Text(postalCode);
            Get_WinCRUAddress_TxtCountry().set_Text(country);
        
            Get_WinCRUAddress_BtnOK().Click();
            Get_WinDetailedInfo_BtnOK().Click();
        }
    
        //Créer les modèles utilisés pour les rapports
        Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_Models").Activate();
        var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    
        for (var i = 2; i <= RowCount; i++){
            var modelName = VarToStr(Excel.Cells.Item(i, 1));
            var modelType = "";
            var IACode = VarToStr(Excel.Cells.Item(i, 2));
            var currencyValue = VarToStr(Excel.Cells.Item(i, 3));
            var relationshipName = VarToStr(Excel.Cells.Item(i, 4));
        
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 100000);
        
            Create_Model(modelName, modelType, IACode, currencyValue);
            AssignRelationshipToModelByName(relationshipName, modelName);
        }
    
        //Renseigner dans le profil de certains comptes le numéro de compte du courtier et le numéro de compte de l'intervenant (pour le rapport 118)
        //DisplayOnlyDefaultProfilesForAccounts(); //ligne Commentée depuis la version Co ref90-07-22--V9-Be_1-co6x car l'affichage du groupe Default se fait désormais dans la fonction SetBrokerAndMiddlemanAccountsNumbersForAccount
    
        Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_Rapport118").Activate();
        var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    
        for (var i = 2; i <= RowCount; i++){
            accountNumber = VarToStr(Excel.Cells.Item(i, 1));
            brokerAccountNumber = VarToStr(Excel.Cells.Item(i, 2));
            middlemanAccountNumber = VarToStr(Excel.Cells.Item(i, 3));
            SetBrokerAndMiddlemanAccountsNumbersForAccount(accountNumber, brokerAccountNumber, middlemanAccountNumber);
        }
    
        Excel.Quit();
        TerminateExcelProcess();
    
        //Faire la configuration de la facturation (pour les rapports 33 et 46)
        if (client != "CIBC" && client != "VMBL" && client != "VMD")
            SetBillingConfiguration();
    
        //Ajouter l'objectif de placement pour certains clients (pour les rapports 3, 12, 20, 43, 51, 61, 77 et 98)
        AddInvestmentObjectiveToClients();
        ExecuteSSHScriptForInvestmentObjectives();
    
        //Ajouter l'objectif de placement pour certains comptes (pour les rapports 3, 27, 42, 97 et 102)
        AddInvestmentObjectiveToAccounts();
    
        //Ajouter l'objectif de placement pour certaines relations (pour les rapports 5, 44, 49 et 61)
        AddInvestmentObjectiveToRelationships();
    
        //Fermer Croesus
        Terminate_CroesusProcess();
    
        //Préparer les titres pour les rapports 114 et 115
        SetSecuritiesForReports114And115();
        
        //Configurer l'indice PROBAL pour les rapports 137, 138, 139
        ConfigureSecurityIndexPROBAL();
        
        //CR1905 : Création d'une Répartition d'actifs nombreuses et configuration des valeurs recommandées et assignation des objectifs de placement aux client et aux comptes
        CR1905_PreparationBD();
        
        //Configuration du CR2008 pour le rapport 150 suivant : CR1485_150_Rel_2005_NumVis
        CR2008_PreparationBD();
        
        //Configuration pour CR2008 / CR1880 (des rapports : 2, 107, 149, 150)
        CR2008_CR1880_PreparationBD();
    
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
    
        ///Configurer le fichier etc/finansoft/ChartServer.exe.config en mode DEBUG afin de recueillir toutes les données de l'exécution
        SetDebugModeForChartServer(vServerReportsCR1485);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        var resultPreparationBDFilePath = "\\\\srvfs1\\pub\\aq\\Conseillers QA\\Christophe\\Rapports\\Rapports_PreparationBD_" + client + ".txt";
        var logPreparationBDPath = "\\\\srvfs1\\pub\\aq\\Conseillers QA\\Christophe\\Rapports\\" + "Rapports_PreparationBD_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S") + "\\";
        
        if (Log.ErrCount > 0)
            var messaPreparationBDResult = "Il y a eu erreur dans la préparation pour l'exécution des Rapports. Pour le log, voir le dossier : " + logPreparationBDPath;
        else
            var messaPreparationBDResult = "La préparation de la BD pour l'exécution des Rapports s'est passée correctement, sans erreur. Pour le log, voir le dossier : " + logPreparationBDPath
        
        //Créer le fichier qui renseigne sur le résultat de la Préparation de la BD
        aqFileSystem.DeleteFile(resultPreparationBDFilePath);
        CreateFileAndWriteText(resultPreparationBDFilePath, messaPreparationBDResult);
        
        //Sauvegarder le Log
        Log.SaveResultsAs(logPreparationBDPath, 0, 0);
            
        Terminate_CroesusProcess();
    }
}



function CR1485_RestoreBD()
{
    try {
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
    
        var Excel = Sys.OleObject("Excel.Application");
        Sys.WaitProcess("excel", 10000);
        Excel.DisplayAlerts = false;
    
        //Supprimer les relations créées pour les rapports
        Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_Relations").Activate();
        var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    
        for (var i = 2; i <= RowCount; i++){
            var relationshipName = VarToStr(Excel.Cells.Item(i, 1));
            DeleteRelationship(relationshipName);
        }
    
        //Supprimer du profil de certains comptes le numéro de compte du courtier et le numéro de compte de l'intervenant (utilisés pour le rapport 118)
        //DisplayOnlyDefaultProfilesForAccounts(); //ligne Commentée depuis la version Co ref90-07-22--V9-Be_1-co6x car l'affichage du groupe Default se fait désormais dans la fonction SetBrokerAndMiddlemanAccountsNumbersForAccount
    
        Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_Rapport118").Activate();
        var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    
        for (var i = 2; i <= RowCount; i++){
            var accountNumber = VarToStr(Excel.Cells.Item(i, 1));
            var brokerAccountNumber = "";
            var middlemanAccountNumber = "";
            SetBrokerAndMiddlemanAccountsNumbersForAccount(accountNumber, brokerAccountNumber, middlemanAccountNumber);
        }
    
        Excel.Quit();
        TerminateExcelProcess();
    
        //Supprimer la configuration de la facturation (pour les rapports 33 et 46)
        if (client != "CIBC" && client != "VMBL" && client != "VMD")
            RestoreBillingConfiguration();
    
        //Supprimer l'objectif de placement pour certains clients (pour les rapports 3, 12, 20, 43, 51, 61, 77 et 98)
        RemoveInvestmentObjectiveFromClients();
    
        //Supprimer l'objectif de placement pour certains comptes (pour les rapports 3, 27, 42, 97 et 102)
        RemoveInvestmentObjectiveFromAccounts();
    
        //Supprimer l'objectif de placement pour certaines relations (pour les rapports 5, 44, 49 et 61)
        RemoveInvestmentObjectiveFromRelationships();
    
        //Fermer Croesus
        Terminate_CroesusProcess();
    
        //Restaurer les titres utilisées pour les rapports 114, 115, 137, 138, 139
        RestoreSecurities();
    
        //Supprimer les entrées des dictionnaires 63, 64 et 65 en roulant le script RPFL70-dictionaries (5)_restore.sql
        //Commenté car mis dans le dump
        //SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\RPFL70-dictionaries (5)_restore.sql";
        //ExecuteSQLFile(SQLFilePath, vServerReportsCR1485);
    
        //Restaurer le code de CP du client 800053 de BD88 à 0AED
        var updateClientSQLQuery = "update b_client set no_rep = '0AED', REP_ID = (select REP_ID from b_rep where no_rep = '0AED') where no_client = '800053'";
        Log.Message(updateClientSQLQuery);
        Execute_SQLQuery(updateClientSQLQuery, vServerReportsCR1485);
    
        var updateCompteSQLQuery = "update b_compte set no_rep = '0AED', REP_ID = (select REP_ID from b_rep where no_rep = '0AED') where no_client = '800053'";
        Log.Message(updateCompteSQLQuery);
        Execute_SQLQuery(updateCompteSQLQuery, vServerReportsCR1485);
    
        //Restaurer le code de CP du client 800056 de BD88 à AC42
        var updateClientSQLQuery = "update b_client set no_rep = 'AC42', REP_ID = (select REP_ID from b_rep where no_rep = 'AC42') where no_client = '800056'";
        Log.Message(updateClientSQLQuery);
        Execute_SQLQuery(updateClientSQLQuery, vServerReportsCR1485);
    
        var updateCompteSQLQuery = "update b_compte set no_rep = 'AC42', REP_ID = (select REP_ID from b_rep where no_rep = 'AC42') where no_client = '800056'";
        Log.Message(updateCompteSQLQuery);
        Execute_SQLQuery(updateCompteSQLQuery, vServerReportsCR1485);
    
        //Vider le contenu des tables B_SYSTEMATIC_PLAN et B_SYSTEMATIC_PLAN_DETAILS
        //Commenté car mis dans le dump
        //SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\Donnees_RPT_PlanSyst_restore.sql";
        //ExecuteSQLFile(SQLFilePath, vServerReportsCR1485);
    
        //Supprimer les restrictions en roulant le script ViderRestrictions_rapport_81.sql (pour le rapport 81)
        var SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\ViderRestrictions_rapport_81.sql";
        ExecuteSQLFile(SQLFilePath, vServerReportsCR1485);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //Renommer le dossier des rapports générés (ajouter la date et l'heure au nom du dossier)
        var executionEndDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S");
        var newReportsPath = REPORTS_FILES_FOLDER_PATH + "_" + executionEndDateTimeString;
        Log.Message("Rename the generated reports folder.", "from : " + REPORTS_FILES_FOLDER_PATH + "\nto : " + newReportsPath);
        if (!aqFileSystem.RenameFolder(REPORTS_FILES_FOLDER_PATH, newReportsPath))
            Log.Error("An error occurred while renaming the generated reports folder.");
    
        //Renommer le dossier Backup des rapports générés (ajouter la date et l'heure au nom du dossier)
        var newReportsBackupPath = REPORTS_FILES_BACKUP_FOLDER_PATH + "_" + executionEndDateTimeString;
        Log.Message("Rename the generated reports backup folder.", "from : " + REPORTS_FILES_BACKUP_FOLDER_PATH + "\nto : " + newReportsBackupPath);
        if (!aqFileSystem.RenameFolder(REPORTS_FILES_BACKUP_FOLDER_PATH, newReportsBackupPath))
            Log.Error("An error occurred while renaming the generated reports folder.");
            
        //Fermer Croesus
        Terminate_CroesusProcess();
    }
}




/**
    Configure le rapport 103 (Répartition d'actifs de l'entreprise)
    https://confluence.croesus.com/pages/viewpage.action?pageId=5908384
*/
function ConfigureCorporateAssetAllocationReport()
{
    //1) Activer (ou ajouter) la clé de FD_ASSET_MIX dans B_CONFIG:
    updateConfigSQLQuery = "update b_config set note = 'YES' where cle = 'FD_ASSET_MIX'";
    Log.Message(updateConfigSQLQuery);
    Execute_SQLQuery(updateConfigSQLQuery, vServerReportsCR1485);

    //2) Rouler la commande pour populer la table B_ASS_REP et générer les données pour le rapport:
    //Create SSH commands file
    SSHCmdlines = "#!/bin/bash";
    SSHCmdlines += "\r\n" + "cfLoader -CorpAssetMixCalculator '2009.12.31' -Firm=FIRM_1";
    SSHCmdFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\ssh_script_103.txt";
    CreateFileAndWriteText(SSHCmdFilePath, SSHCmdlines);
    
    //Create PLINK batch file
    var hostname = GetVserverHostName(vServerReportsCR1485);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_script_103.txt > ssh_script_output_103.txt";
    plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\plink_103.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
}



function SetBrokerAndMiddlemanAccountsNumbersForAccount(accountNumber, brokerAccountNumber, middlemenAccountNumber)
{
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
    Search_Account(accountNumber);
    Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
    
    Get_AccountsBar_BtnInfo().Click();
    Get_WinAccountInfo_TabProfile().Click();
    Get_WinAccountInfo_TabProfile().WaitProperty("IsSelected", true, 60000);
    
    
    //Cette partie est une adaptation qui fait suite à une différence de comportement de la sauvegarde des profils
    //constatée depuis la version Co depuis : ref90-07-22--V9-Be_1-co6x
    
    //Ouvrir la fenêtre de configuration des profils, Cocher les cases à cocher du groupe Défaut et Cliquer sur Sauvegarder
    Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false);
    Get_WinInfo_TabProfile_BtnSetup().Click();
    
    if (client != "RJ" && client != "US" && client != "TD"){
        //Scroll
        var height = Get_WinVisibleProfilesConfiguration().get_ActualHeight();
        var width = Get_WinVisibleProfilesConfiguration().get_ActualWidth();
        Get_WinVisibleProfilesConfiguration().Click(width - 25, height - 105);
    }
    
    Set_IsCheckedForAllChecboxes(Get_WinVisibleProfilesConfiguration_DefaultExpander(), true);
    Get_WinVisibleProfilesConfiguration_BtnSave().Click();

    //Fin version Co depuis : ref90-07-22--V9-Be_1-co6x
    
    
    Get_WinAccountInfo_TabProfile_DefaultExpander().set_IsExpanded(true);
    
    Get_WinAccountInfo_TabProfile_DefaultExpander_TxtBrokerAccountNumber().Click();
    Get_WinAccountInfo_TabProfile_DefaultExpander_TxtBrokerAccountNumber().SetText(brokerAccountNumber);
    
    Get_WinAccountInfo_TabProfile_DefaultExpander_TxtMiddlemanAccountNumber().Click();
    Get_WinAccountInfo_TabProfile_DefaultExpander_TxtMiddlemanAccountNumber().SetText(middlemenAccountNumber);
    
    Get_WinAccountInfo_BtnOK().Click();
} 



function DisplayOnlyDefaultProfilesForAccounts()
{
    
    //Afficher seulement les éléments du groupe Défaut des profils
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
    
    Get_AccountsBar_BtnInfo().Click();
    Get_WinAccountInfo_TabProfile().Click();
    Get_WinAccountInfo_TabProfile().WaitProperty("IsSelected", true, 60000);
    
    //Ouvrir la fenêtre de configuration des profils, Décocher toutes les cases à cocher et Cliquer sur Sauvegarder
    Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false);
    Get_WinInfo_TabProfile_BtnSetup().Click();
    
    windowHeight = Get_WinVisibleProfilesConfiguration().get_Height();
    windowTop = Get_WinVisibleProfilesConfiguration().get_Top();
    //Get_WinVisibleProfilesConfiguration().set_Height(1050);
    Get_WinVisibleProfilesConfiguration().set_Height(Sys.Desktop.Height);
    Get_WinVisibleProfilesConfiguration().set_Top(0);
    
    Set_IsCheckedForAllChecboxes(Get_WinVisibleProfilesConfiguration(), false);
    
    Get_WinVisibleProfilesConfiguration().set_Height(windowHeight);
    Get_WinVisibleProfilesConfiguration().set_Top(windowTop);
    
    Get_WinVisibleProfilesConfiguration_BtnSave().Click();
    
    //Ouvrir la fenêtre de configuration des profils, Cocher toutes les cases à cocher du groupe Défaut et Cliquer sur Sauvegarder
    Get_WinInfo_TabProfile_BtnSetup().Click();
    
    if (client != "RJ" && client != "US" && client != "TD"){
        //Scroll
        var height = Get_WinVisibleProfilesConfiguration().get_ActualHeight();
        var width = Get_WinVisibleProfilesConfiguration().get_ActualWidth();
        Get_WinVisibleProfilesConfiguration().Click(width - 25, height - 105);
    }
    
    //Cocher les cases à cocher du groupe Défaut
    Set_IsCheckedForAllChecboxes(Get_WinVisibleProfilesConfiguration_DefaultExpander(), true);
    
    //Cliquer sur Sauvegarder
    Get_WinVisibleProfilesConfiguration_BtnSave().Click();
    
    //Cliquer sur OK
    Get_WinAccountInfo_BtnOK().Click();
}



function Set_IsCheckedForAllChecboxes(parentComponentObject, booleanValue)
{
    var arrayOfCheckboxes = parentComponentObject.FindAllChildren(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["XamCheckEditor", true, 1], 100).toArray();
    parentComponentObject.Click();
    Sys.Keys("[End][End]");
    
    for (var i = 0; i < arrayOfCheckboxes.length; i++){
        if (booleanValue != arrayOfCheckboxes[i].get_IsChecked())
            arrayOfCheckboxes[i].Click();
        Sys.Keys("[Up][Up]");
    }
}



function DeleteAllRelationshipAddresses()
{
    Delay(1000);
    while (Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete().IsEnabled){
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        Delay(1000);
    }
}



function SetBillingConfiguration()
{
    try {
        Get_MenuBar_Tools().OpenMenu();
        Delay(1000);
        Get_MenuBar_Tools_Configurations().Click();
        Delay(1000);
        Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
        Delay(1000);
        Get_WinConfigurations_LvwListView_LlbManageValidationGrid().DblClick();
    
        //Get_WinFeeMatrixConfiguration().Parent.Maximize();
        EmptyBillingFeeMatrix();
        FillBillingFeeMatrix(filePath_ReportsCR1485, "PreparationBD_Rapport033", 2, 3);
        //Get_WinFeeMatrixConfiguration().Parent.Restore();
        Get_WinFeeMatrixConfiguration_BtnOK().Click();
        Log.Message("Bug JIRA CROES-8999");
    
        Get_WinConfigurations_LvwListView_LlbManageBilling().DblClick();
    
        //DeleteCR1485FeeSchedule();
    
        Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd().Click();
    
        name = GetData(filePath_ReportsCR1485, "PreparationBD_Rapport033", 46, language);
        access = GetData(filePath_ReportsCR1485, "PreparationBD_Rapport033", 47, language);
        ratePattern = GetData(filePath_ReportsCR1485, "PreparationBD_Rapport033", 48, language);
        tieredCalculationMethod = GetData(filePath_ReportsCR1485, "PreparationBD_Rapport033", 49, language);
        showMinMax = GetData(filePath_ReportsCR1485, "PreparationBD_Rapport033", 50, language);
    
        Get_WinFeeTemplateEdit_TxtName().Keys(name);
        SelectComboBoxItem(Get_WinFeeTemplateEdit_CmbAccess(), access);
        SelectComboBoxItem(Get_WinFeeTemplateEdit_CmbRatePattern(), ratePattern);
        Get_WinFeeTemplateEdit_ChkTieredCalculationMethod().set_IsChecked(tieredCalculationMethod == "VRAI" || tieredCalculationMethod == "TRUE");
        Get_WinFeeTemplateEdit_ChkShowMinMax().set_IsChecked(showMinMax == "VRAI" || showMinMax == "TRUE");
    
        Get_WinFeeTemplateEdit_BtnOK().Click();
        Get_WinBillingConfiguration_BtnOK().Click();
        Get_WinConfigurations().Close();
    }
    catch(e) {
        Log.Error("Bug JIRA CROES-8999");
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
    }
}



function RestoreBillingConfiguration()
{
    Get_MenuBar_Tools().OpenMenu();
    Delay(1000);
    Get_MenuBar_Tools_Configurations().Click();
    Delay(1000);
    Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
    Delay(1000);
    Get_WinConfigurations_LvwListView_LlbManageBilling().DblClick();
    
    DeleteCR1485FeeSchedule();
    Get_WinBillingConfiguration_BtnOK().Click();
    
    Get_WinConfigurations_LvwListView_LlbManageValidationGrid().DblClick();
    RestoreBillingFeeMatrixForUS();
    Get_WinConfigurations().Close();
}



/**
    excelFilePath : chemin d'accès du fichier de données Excel
    excelSheetName : nom de la feuille Excel
    nbrLignes : nombre de lignes de la matrice de frais
    j : offset des données du fichier Excel (première ligne moins un)
*/
function FillBillingFeeMatrix(excelFilePath, excelSheetName, nbrLignes, j)
{
    // boucler sur la grille selon le nombre de ligne de la grille
    for (k = 1; k <= nbrLignes; k++){
        //boucler sur les cellules de la grille selon la ligne
        i = 3;
        while (i < 31){
            for (p = 1; p <= 2; p++){
                j++;
                i = (p == 2)? i + 1 : i;
                excelValue = GetData(excelFilePath, excelSheetName, j, language);
                CellValuePresenter = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", k], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", i], 10);
                CellValuePresenter.Click();
                XamMaskedEditor = CellValuePresenter.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
                XamMaskedEditor.Keys(excelValue);
                i = (p == 2)? i + 2 : i;
            }
        }
    }
}



function RestoreBillingFeeMatrixForUS()
{
    try {
        //Get_WinFeeMatrixConfiguration().Parent.Maximize();
    
        EmptyBillingFeeMatrix();
    
        //Click on the first row
        TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange.OleValue;
        Get_WinFeeMatrixConfiguration_DgvFeeMatrix().Find("Value", TotalValueRange, 100).Click();
    
        //Create ranges (rows)
        for(j = 0; j < 5; j++){
            tailleGrille = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
            Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(tailleGrille - 2).set_IsSelected(true);
            Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(tailleGrille - 2).set_IsActive(true);
            Delay(1000);
            Get_WinFeeMatrixConfiguration_BtnSplit().Click();
            Delay(1000);
            Get_WinAddRange_TxtSplitRangeAt().set_Text(GetData(filePath_Billing, "CR885", j + 303, language));
            Delay(1000);
            Get_WinAddRange_BtnOK().Click();
        }
    
        //Remplir les valeurs de la grille
        nbrLignes = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
        FillBillingFeeMatrix(filePath_Billing, "CR885", nbrLignes, 111);
    
        //Get_WinFeeMatrixConfiguration().Parent.Restore();
        Get_WinFeeMatrixConfiguration_BtnOK().Click();
        Log.Message("Bug JIRA CROES-8999");
    }
    catch(e) {
        Log.Error("Bug JIRA CROES-8999");
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
    }
} 



function EmptyBillingFeeMatrix()
{
    TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange.OleValue;
    Get_WinFeeMatrixConfiguration_DgvFeeMatrix().Find("Value", TotalValueRange, 100).Click();
    Delay(1000);
    
    while (Get_WinFeeMatrixConfiguration_BtnMerge().IsEnabled){
        Get_WinFeeMatrixConfiguration_BtnMerge().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        Delay(1000);
        TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange.OleValue;
        Get_WinFeeMatrixConfiguration_DgvFeeMatrix().Find("Value", TotalValueRange, 100).Click();
        Delay(1000);
    } 
} 



function DeleteCR1485FeeSchedule()
{
    feeScheduleName = GetData(filePath_ReportsCR1485, "PreparationBD_Rapport033", 46, language);
    searchResult = Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild("Value", feeScheduleName, 10);
    
    if (!searchResult.Exists)
        Log.Message("Fee Schedule '" + feeScheduleName + "' not found.");
    else {
        searchResult.Click();
        Delay(500);
        if (!Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().IsEnabled)
            Log.Error("The Delete button of the fee schedule tab is disabled!")
        else {
            Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().Click();
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }
    }
}



function ActivatePrefsForPerformanceFeesAndBillingAndMorningstarIntegration()
{
    var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
    
    //Activer les prefs pour avoir toutes les cases à cocher du groupbox "Performance - Frais" activées
    EnablePerformanceFeesGroupBoxForUser(userNameReportsCR1485);
    
    //Activer les prefs pour Performance Summary (rapports 76 et 78)
    Activate_Inactivate_Pref(userNameGP1859, "PREF_REPORT_SUMMARY_PERF_OBJINV", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameGP1859, "PREF_REPORT_SHOW_PERFSUMMARY", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameGP1859, "PREF_REPORT_SHOW_PERFSUMMARY_OBJ", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameGP1859, "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
    
    //Activer les prefs pour le billing (rapports 33 et 46)
    if (client != "CIBC" && client != "VMBL" && client != "VMD"){
        Activate_Inactivate_PrefBranch("0", "PREF_REPORT_BILLING_SUMMARY", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefBranch("0", "PREF_BILLING", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefBranch("0", "PREF_BILLING_FEESCHEDULE", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefBranch("0", "PREF_BILLING_GRID", "SYSADM,FIRMADM,BRMAN", vServerReportsCR1485);
        Activate_Inactivate_PrefBranch("0", "PREF_BILLING_PROCESS", "SYSADM,FIRMADM,BRMAN", vServerReportsCR1485);
    }
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerReportsCR1485);
    
    //Activer la pref pour l'intégration avec Morningstar (rapports 114 et 115)
    Activate_Inactivate_Pref(userNameGP1859, "PREF_ENABLE_INTEGRATIONS_TAB", "YES", vServerReportsCR1485);
    
    //redémarrer les services
    RestartServices(vServerReportsCR1485);
}


//For Performance Summary (Reports 76 and 78)
function ExecuteSSHScriptForPerformanceSummary()
{
    //Create SSH commands file
    SSHCmdlines = "#!/bin/bash";
    SSHCmdlines += "\r\n" + "cfLoader -PerformanceSummary -Firm=FIRM_1";
    SSHCmdFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\ssh_script_076_078.txt";
    CreateFileAndWriteText(SSHCmdFilePath, SSHCmdlines);
    
    //Create PLINK batch file
    var hostname = GetVserverHostName(vServerReportsCR1485);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_script_076_078.txt > ssh_script_output_076_078.txt";
    plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\plink_076_078.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
}



function AddInvestmentObjectiveToClients()
{
    //Récupérer du fichier Excel le nombre de clients concernés
    var Excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 10000);
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_InvObj_Clients").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    Excel.Quit();
    TerminateExcelProcess();
    
    NbOfClients = Math.round((RowCount - 1)/4);
    Log.Message("Nombre de clients pour l'ajout d'objectif de placement : " + NbOfClients);
    
    //Ajouter les objectifs de placement renseignés dans le fichier Excel
    for (i = 0; i < NbOfClients; i++){
        offset = 3 + (4*i);
        clientNumber = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_Clients", offset + 1, language);
        investmentObjective = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_Clients", offset + 2, language);
        
        Log.Message("Add '" + investmentObjective + "' investment objective to client '" + clientNumber + "'");
        
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 100000);
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabProductsAndServices().Click();
        Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", true, 60000);
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().Click();
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
        
        SelectInvestmentObjectiveForClientAndAccount(investmentObjective);
        
        Get_WinDetailedInfo_BtnOK().Click();
    } 
}



function AddInvestmentObjectiveToAccounts()
{
    //Récupérer du fichier Excel le nombre de comptes concernés
    var Excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 10000);
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_InvObj_Accounts").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    Excel.Quit();
    TerminateExcelProcess();
    
    NbOfAccounts = Math.round((RowCount - 1)/4);
    Log.Message("Nombre de comptes pour l'ajout d'objectif de placement : " + NbOfAccounts);
    
    //Ajouter les objectifs de placement renseignés dans le fichier Excel
    for (i = 0; i < NbOfAccounts; i++){
        offset = 3 + (4*i);
        accountNumber = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_Accounts", offset + 1, language);
        investmentObjective = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_Accounts", offset + 2, language);
        
        Log.Message("Add '" + investmentObjective + "' investment objective to account '" + accountNumber + "'");
        
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabInvestmentObjective().Click();
        Get_WinAccountInfo_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
        
        SelectInvestmentObjectiveForClientAndAccount(investmentObjective);
        
        Get_WinAccountInfo_BtnOK().Click();
    } 
}


function SelectInvestmentObjectiveForClientAndAccount(investmentObjective)
{
    Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
        
    if (investmentObjective == "De la firme - Global - Equilibre" || investmentObjective == "Firm - Global - Balanced")
        Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_Balanced().Parent.set_IsSelected(true);
    else if (investmentObjective == "De la firme - Global - Croissance Plus" || investmentObjective == "Firm - Global - Croissance Plus")
        Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_CroissancePlus().Parent.set_IsSelected(true);
    else if (investmentObjective == "De la firme - Global - Revenu et croissance" || investmentObjective == "Firm - Global - Income and Growth")
        Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_IncomeAndGrowth().Parent.set_IsSelected(true);
    else if (investmentObjective == "De la firme - Global - Croissance maximale" || investmentObjective == "Firm - Global - Maximum Growth")
        Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_MaximumGrowth().Parent.set_IsSelected(true);
    else if (investmentObjective == "De base - Global - Equilibre" || investmentObjective == "Basic - Global - Balanced")
        Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_Balanced().Parent.set_IsSelected(true);
    else if (investmentObjective == "De la firme - Global - Revenu maximum" || investmentObjective == "Firm - Global - Maximum Income")
        Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_MaximumIncome().Parent.set_IsSelected(true);
    else if (investmentObjective == "De base - Global - Revenu maximum" || investmentObjective == "Basic - Global - Maximum Income")
        Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_MaximumIncome().Parent.set_IsSelected(true);
    else
        Log.Error("'" + investmentObjective + "' investment objective not covered!");
        
    if (Get_WinSelectAnObjective_BtnOK().WaitProperty("Enabled", true, 5000))
        Get_WinSelectAnObjective_BtnOK().Click();
    else {
        Log.Message("Bug JIRA CROES-10474, RJ-CO : Les objectifs de placement (firme) ne sont plus visibles après de migrer à la version CO-15");
        Log.Error("Investment objective selection cancelled.");
        Get_WinSelectAnObjective_BtnCancel().Click();
    } 
} 



function AddInvestmentObjectiveToRelationships()
{
    //Récupérer du fichier Excel le nombre de relations concernées
    var Excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 10000);
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_InvObj_rel").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    Excel.Quit();
    TerminateExcelProcess();
    
    NbOfRelationships = Math.round((RowCount - 1)/4);
    Log.Message("Nombre de relations pour l'ajout d'objectif de placement : " + NbOfRelationships);
    
    //Ajouter les objectifs de placement renseignés dans le fichier Excel
    for (i = 0; i < NbOfRelationships; i++){
        offset = 3 + (4*i);
        relationshipName = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_rel", offset + 1, language);
        investmentObjective = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_rel", offset + 2, language);
        
        Log.Message("Add '" + investmentObjective + "' investment objective to relationship '" + relationshipName + "'");
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        Get_RelationshipsBar_BtnInfo().Click();
        Delay(1000);
        Get_WinDetailedInfo_TabProductsAndServices().Click();
        Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", true, 60000);
        
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().Click();
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
        
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_BtnInvestmentObjectiveForRelationship().Click();
        
        if (investmentObjective == "De base - Global - Croissance" || investmentObjective == "Basic - Global - Growth")
            Get_LstInvestmentObjectivesForRelationship_ItemBasic_Growth().set_IsActive(true);
        else
            Log.Error("'" + investmentObjective + "' investment objective not covered !");
        

        Get_WinDetailedInfo_BtnOK().Click();
    } 
}



function RemoveInvestmentObjectiveFromClients()
{
    //Récupérer du fichier Excel le nombre de clients concernés
    var Excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 10000);
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_InvObj_Clients").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    Excel.Quit();
    TerminateExcelProcess();
    
    NbOfClients = Math.round((RowCount - 1)/4);
    Log.Message("Nombre de clients pour la suppression de l'objectif de placement : " + NbOfClients);
    
    //Supprimer l'objectif de placement pour les clients renseignés dans le fichier Excel
    for (i = 0; i < NbOfClients; i++){
        offset = 3 + (4*i);
        clientNumber = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_Clients", offset + 1, language);
        
        Log.Message("Remove investment objective from client '" + clientNumber + "'");
        
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 100000);
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        Get_ClientsBar_BtnInfo().Click();
        Delay(1000);
        Get_WinDetailedInfo_TabProductsAndServices().Click();
        Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", true, 60000);

        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().Click();
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
        
        Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount().set_IsChecked(false);
        
        Get_WinDetailedInfo_BtnOK().Click();
    } 
}



function RemoveInvestmentObjectiveFromAccounts()
{
    //Récupérer du fichier Excel le nombre de comptes concernés
    var Excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 10000);
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_InvObj_Accounts").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    Excel.Quit();
    TerminateExcelProcess();
    
    NbOfAccounts = Math.round((RowCount - 1)/4);
    Log.Message("Nombre de comptes pour la suppression de l'objectif de placement : " + NbOfAccounts);
    
    //Supprimer l'objectif de placement pour les comptes renseignés dans le fichier Excel
    for (i = 0; i < NbOfAccounts; i++){
        offset = 3 + (4*i);
        accountNumber = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_Accounts", offset + 1, language);
        
        Log.Message("Remove investment objective from account '" + accountNumber + "'");
        
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        Get_AccountsBar_BtnInfo().Click();
        Delay(1000);
        Get_WinAccountInfo_TabInvestmentObjective().Click();
        Get_WinAccountInfo_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
        
        Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount().set_IsChecked(false);
        
        Get_WinAccountInfo_BtnOK().Click();
    } 
}



function RemoveInvestmentObjectiveFromRelationships()
{
    //Récupérer du fichier Excel le nombre de relations concernées
    var Excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 10000);
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_InvObj_rel").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    Excel.Quit();
    TerminateExcelProcess();
    
    NbOfRelationships = Math.round((RowCount - 1)/4);
    Log.Message("Nombre de relations pour la suppression de l'objectif de placement : " + NbOfRelationships);
    
    //Supprimer l'objectif de placement pour les relations renseignées dans le fichier Excel
    for (i = 0; i < NbOfRelationships; i++){
        offset = 3 + (4*i);
        relationshipName = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_rel", offset + 1, language);
        
        Log.Message("Remove investment objective from relationship '" + relationshipName + "'");
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        SearchRelationshipByName(relationshipName);
        
        if (Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Exists){
            Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
            Get_RelationshipsBar_BtnInfo().Click();
            Delay(1000);
            Get_WinDetailedInfo_TabProductsAndServices().Click();
            Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", true, 60000);

            Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().Click();
            Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
            
            Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_ChkInvestmentObjectiveForRelationship().set_IsChecked(false);
        
            Get_WinDetailedInfo_BtnOK().Click();
        }
    } 
}



function ExecuteSSHScriptForInvestmentObjectives()
{
    //Create SSH commands file
    SSHCmdlines = "#!/bin/bash";
    SSHCmdlines += "\r\n" + "cfLoader -AsmInvObjCalculator -Firm=FIRM_1";
    SSHCmdFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\ssh_script_051.txt";
    CreateFileAndWriteText(SSHCmdFilePath, SSHCmdlines);
    
    //Create PLINK batch file
    var hostname = GetVserverHostName(vServerReportsCR1485);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_script_051.txt > ssh_script_output_051.txt";
    plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\plink_051.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
}



function SetIndexComposition(indexContentControlObject, indexDescription, indexPercentValue)
{
    var txtSecurityDescription = indexContentControlObject.FindChild("Uid", Get_WinInfoSecurity_TabIndexComposition_TxtIndex1Value().Uid.OleValue, 10);
    txtSecurityDescription.Clear();
    txtSecurityDescription.Keys(indexDescription + "[Tab]");
    SetAutoTimeOut(5000);
    if (Get_SubMenus().Exists) Get_SubMenus().FindChild(["ClrClassName", "Uid", "Value"], ["CellValuePresenter", "Description", indexDescription], 10).DblClick();
    RestoreAutoTimeOut();
    if (indexContentControlObject.DataContext.Security != null && CompareProperty(indexContentControlObject.DataContext.Security.Description.OleValue, cmpEqual, indexDescription, true, lmError)){
        Sys.Keys(indexPercentValue + "[Tab]");
        CompareProperty(indexContentControlObject.DataContext.get_PercentValue(), cmpEqual, indexPercentValue, true, lmError);
    }
}



function SetSecuritiesForReports114And115()
{
    //Se connecter avec l'utilisateur GP1859
    userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
    passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
    
    //Login
    Login(vServerReportsCR1485, userNameGP1859, passwordGP1859, language);
    
    //Créer le titre 'GLOBAL BLEND'
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    ClickOnToolbarAddButton();
    
    Get_WinCreateSecurity_LstCategories_ItemIndex().set_IsSelected(true);
    Get_WinCreateSecurity_BtnOK().Click();
    
    subcategory = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 4, language);
    frenchDescription = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 5, language);
    englishDescription = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 6, language);
    country = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 7, language);
    currency = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 8, language);
    calculationFactor = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 9, language);
    mainSymbol = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 10, language);
    foreignProperty = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 11, language);
    
    SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbSubCategory(), subcategory);
    if (client == "US")
        Get_WinInfoSecurity_GrpDescription_TxtDescription().Keys(englishDescription);
    else {
        Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription().Keys(frenchDescription);
        Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription().Keys(englishDescription);
    }
    SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbCountry(), country);
    SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbCurrency(), currency);
    SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbCalculationFactor(), calculationFactor);
    Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol().Keys(mainSymbol);
    SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_CmbForeignProperty(), foreignProperty);
    
    Get_WinInfoSecurity_BtnOK().Click();
    
    
    //Composition de l'index du titre 'GLOBAL BLEND'
    Search_SecurityBySymbol(mainSymbol);
    Get_SecurityGrid().FindChild("Value", mainSymbol, 10).Click();
    Get_SecuritiesBar_BtnInfo().Click();
    Get_WinInfoSecurity_TabIndexComposition().Click();
    Get_WinInfoSecurity_TabIndexComposition().WaitProperty("IsSelected", true, 60000);
    
    index1Description = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 14, language);
    index1PercentValue = StrToFloat(GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 15, language));
    SetIndexComposition(Get_WinInfoSecurity_TabIndexComposition_Index1ContentControl(), index1Description, index1PercentValue);
    
    index2Description = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 16, language);
    index2PercentValue = StrToFloat(GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 17, language));
    SetIndexComposition(Get_WinInfoSecurity_TabIndexComposition_Index2ContentControl(), index2Description, index2PercentValue);
    
    
    //Intégration du titre 'GLOBAL BLEND'
    Get_WinInfoSecurity_TabIntegrations().Click();
    Get_WinInfoSecurity_TabIntegrations().WaitProperty("IsSelected", true, 60000);
    
    integrationPartner = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 20, language);
    identifierType = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 21, language);
    identifierValue = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 22, language);
    SelectComboBoxItem(Get_WinInfoSecurity_TabIntegrations_CmbIntegrationPartner(), integrationPartner);
    SelectComboBoxItem(Get_WinInfoSecurity_TabIntegrations_CmbIndentifierType(), identifierType);
    Get_WinInfoSecurity_TabIntegrations_TxtIndentifierValue().SetText(identifierValue);
    Get_WinInfoSecurity_TabIntegrations_TxtIndentifierValue().Keys("[Tab]");
    
    Get_WinInfoSecurity_BtnOK().Click();
    
    
    //Intégration des titres MS EAFE, S&P 500 et NASDAQ-100
    for (i = 0; i < 3; i++){
        offset = 24 + (i*6);
        securityDescription = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", offset + 1, language);
        integrationPartner = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", offset + 2, language);
        identifierType = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", offset + 3, language);
        identifierValue = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", offset + 4, language);
    
        SetIntegrationForSecurity(securityDescription, integrationPartner, identifierType, identifierValue);
    }
    
    //Fermer Croesus
    Terminate_CroesusProcess();
    
    
    //Copier le fichier morningstar.pfx dans le dossier /etc/finansoft/ du vserveur (la copie est désormais faite via l'Assemble Script)
    /*
    //Create SSH commands file
    SSHCmdlines = "#!/bin/bash";
    SSHCmdlines += "\r\n" + "rm -f /etc/finansoft/morningstar.pfx";
    SSHCmdlines += "\r\n" + "cp -f /home/christophep/rapports/rapports_114_115/morningstar.pfx /etc/finansoft/";
    SSHCmdFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\ssh_script_114_115.txt";
    CreateFileAndWriteText(SSHCmdFilePath, SSHCmdlines);
    
    //Create PLINK batch file
    var hostname = GetVserverHostName(vServerReportsCR1485);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_script_114_115.txt > ssh_script_output_114_115.txt";
    plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\plink_114_115.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
    */
}



//Configure l'indice PROBAL pour les rapports 137, 138, 139
function ConfigureSecurityIndexPROBAL()
{   
    //1. Créer le titre 'PROBAL'
    
    //Se connecter avec l'utilisateur UNI00
    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
    
    Login(vServerReportsCR1485, userNameUNI00, passwordUNI00, language);
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    ClickOnToolbarAddButton();
    
    Get_WinCreateSecurity_GrpFinancialInstrument_RdoReal().set_IsChecked(true);
    Get_WinCreateSecurity_LstCategories_ItemIndex().set_IsSelected(true);
    Get_WinCreateSecurity_BtnOK().Click();
    
    var subcategory = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 43, language);
    var frenchDescription = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 44, language);
    var englishDescription = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 45, language);
    var country = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 46, language);
    var currency = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 47, language);
    var calculationFactor = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 48, language);
    var mainSymbol = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 49, language);
    
    SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbSubCategory(), subcategory);
    if (client == "US")
        Get_WinInfoSecurity_GrpDescription_TxtDescription().Keys(englishDescription);
    else {
        Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription().Keys(frenchDescription);
        Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription().Keys(englishDescription);
    }
    SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbCountry(), country);
    SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbCurrency(), currency);
    SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbCalculationFactor(), calculationFactor);
    Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol().Keys(mainSymbol);
    
    Get_WinInfoSecurity_BtnOK().Click();
    
    
    //2. Composition de l'index du titre 'PROBAL'
    Search_SecurityBySymbol(mainSymbol);
    Get_SecurityGrid().FindChild("Value", mainSymbol, 10).Click();
    Get_SecuritiesBar_BtnInfo().Click();
    Get_WinInfoSecurity_TabIndexComposition().Click();
    Get_WinInfoSecurity_TabIndexComposition().WaitProperty("IsSelected", true, 60000);
    
    var index1Description = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 52, language);
    var index1PercentValue = StrToFloat(GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 53, language));
    SetIndexComposition(Get_WinInfoSecurity_TabIndexComposition_Index1ContentControl(), index1Description, index1PercentValue);
    
    var index2Description = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 54, language);
    var index2PercentValue = StrToFloat(GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 55, language));
    SetIndexComposition(Get_WinInfoSecurity_TabIndexComposition_Index2ContentControl(), index2Description, index2PercentValue);
    
    var index3Description = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 56, language);
    var index3PercentValue = StrToFloat(GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 57, language));
    SetIndexComposition(Get_WinInfoSecurity_TabIndexComposition_Index3ContentControl(), index3Description, index3PercentValue);
    
    Get_WinInfoSecurity_BtnOK().Click();
    
    //Fermer Croesus
    Terminate_CroesusProcess();
    
    
    //3. Valider que l'indice appartient à la catégorie 54 : select * from b_titre where catego=54
    var nbOfProbalRecords = Execute_SQLQuery_GetField("select count(*) as NB_RECORDS from B_TITRE where CATEGO = 54 and DESC_L1 = '" + frenchDescription + "'", vServerReportsCR1485, "NB_RECORDS");
    if (nbOfProbalRecords != 1)
        return Log.Error("Expected to found 1 PROBAL record of Category 54, found : " + nbOfProbalRecords);
    
    
    //4. Mettre à jour le symbole de l'indice : update b_titre set symbole = 'ProBal' where DESC_L1='PROBAL'
    Execute_SQLQuery("update B_TITRE set SYMBOLE = '" + mainSymbol + "' where DESC_L1 = '" + frenchDescription + "'", vServerReportsCR1485);
    
    
    //5. Rouler le script "Performance sommaire (CR395)" afin de mettre à jour les paramètres des packages : https://confluence.croesus.com/pages/viewpage.action?pageId=3440650
    ExecuteSQLFile_ThroughISQL(folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\CR395.sql", vServerReportsCR1485);
    
    
    //6. Avec l'user GP1859 valider que l'indice "PROBAL" et l'indice de référence "PROBAL" soient cochés dans les rapports concernés
    var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
    var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
    var indexDescription = (language == "french")? frenchDescription: englishDescription;
    var report_PerformanceSummarizedIA = GetData(filePath_ReportsCR1485, "137_Summarized_IA", 2, language);
    var report_PerformanceSummarizedRegion = GetData(filePath_ReportsCR1485, "138_Summarized_Region", 2, language);
    var report_PerformanceSummarizedBranch = GetData(filePath_ReportsCR1485, "139_Summarized_Branch", 2, language);
    
    //Login
    Login(vServerReportsCR1485, userNameGP1859, passwordGP1859, language);
    
    Log.Message("Validate Index selection in Accounts module.");
    Get_ModulesBar_BtnAccounts().Click();
    Get_Toolbar_BtnReportsAndGraphs().Click();
    WaitReportsWindow();
    ValidateThatIndexIsSelectedInReports(report_PerformanceSummarizedIA, indexDescription);
    ValidateThatIndexIsSelectedInReports(report_PerformanceSummarizedRegion, indexDescription);
    ValidateThatIndexIsSelectedInReports(report_PerformanceSummarizedBranch, indexDescription);
    Get_WinReports_BtnClose().Click();
    
    Log.Message("Validate Index selection in Clients module.");
    Get_ModulesBar_BtnClients().Click();
    Get_Toolbar_BtnReportsAndGraphs().Click();
    WaitReportsWindow();
    ValidateThatIndexIsSelectedInReports(report_PerformanceSummarizedIA, indexDescription);
    ValidateThatIndexIsSelectedInReports(report_PerformanceSummarizedRegion, indexDescription);
    ValidateThatIndexIsSelectedInReports(report_PerformanceSummarizedBranch, indexDescription);
    Get_WinReports_BtnClose().Click();
    
    //Fermer Croesus
    Terminate_CroesusProcess();
}



function ValidateThatIndexIsSelectedInReports(reportName, indexDescription)
{
    Log.Message("Validate that Index '" + indexDescription + "' is selected in reports '" + reportName + "'.");
    SelectFirmSavedReport(reportName);
    Get_Reports_GrpReports_BtnRemoveAllReports().WaitProperty("IsEnabled", true, 30000);
    var currentReportsCount = Get_Reports_GrpReports_LvwCurrentReports().Items.get_Count();
    for (var currentReportIndex = 1; currentReportIndex <= currentReportsCount; currentReportIndex++){
        var currentReport = Get_Reports_GrpReports_LvwCurrentReports().WPFObject("ListBoxItem", "", currentReportIndex);
        var currentReportName = VarToStr(currentReport.WPFControlText);
        currentReport.set_IsSelected(true);
        WaitObject(Get_Reports_GrpReports_GrpCurrentParameters_TxtCurrentParameters(), ["ClrClassName", "IsVisible"], ["UniLabel", true], 60000); //Attendre que les paramètres courants soient affichés pour le rapport sélectionné
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
        WaitReportParametersWindow();
        
        //valider que l'indice est coché
        if (!Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", indexDescription], 10).IsChecked.OleValue)
            Log.Error("Index '" + indexDescription + "' is not checked for report at Position " + currentReportIndex + " (" + currentReportName + ").");
        
        //valider que l'indice est sélectionné comme Indice de référence
        if (Get_WinParameters_GrpComparative_CmbReferentialIndex().Text.OleValue != indexDescription)
            Log.Error("Index '" + indexDescription + "' is not selected as Comparative Referential Index for report at Position " + currentReportIndex + " (" + currentReportName + ").");
        
        Get_WinParameters_BtnCancel().Click();
    }
    Get_Reports_GrpReports_BtnRemoveAllReports().Click();
}



//Restaurer les titres utilisés pour les rapports 114, 115, 137, 138, 139
function RestoreSecurities()
{
    //Se connecter avec l'utilisateur GP1859
    var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
    var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
    
    //Login
    Login(vServerReportsCR1485, userNameGP1859, passwordGP1859, language);

    //Restaurer les Intégrations des titres MS EAFE, S&P 500 et NASDAQ-100
    for (i = 0; i < 3; i++){
        offset = 24 + (i*6);
        var securityDescription = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", offset + 1, language);
        var integrationPartner = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", offset + 2, language);
        var identifierType = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", offset + 3, language);
        var identifierValue = "";
    
        SetIntegrationForSecurity(securityDescription, integrationPartner, identifierType, identifierValue);
    }
    
    //Supprimer les titres 'GLOBAL BLEND' et 'PROBAL'
    var GlobalBlendSymbol = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 10, language);
    var PROBALSymbol = GetData(filePath_ReportsCR1485, "PreparationBD_Titres", 49, language);
    var arrayOfSecuritySymbol = [GlobalBlendSymbol, PROBALSymbol];
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    for (var i in arrayOfSecuritySymbol){
        Search_SecurityBySymbol(arrayOfSecuritySymbol[i]);
        var securitySymbolCell = Get_SecurityGrid().FindChild("Value", arrayOfSecuritySymbol[i], 10);
        if (securitySymbolCell.Exists){
            securitySymbolCell.Click();
            Get_Toolbar_BtnDelete().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }
        else
            Log.Warning("'" + arrayOfSecuritySymbol[i] + "' security symbol not found!");
    }

    //Fermer Croesus
    Terminate_CroesusProcess();
}



function SetIntegrationForSecurity(securityDescription, integrationPartner, identifierType, identifierValue)
{
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Search_SecurityByDescription(securityDescription);
    Get_SecurityGrid().FindChild("Value", securityDescription, 10).Click();
    Get_SecuritiesBar_BtnInfo().Click();
    Get_WinInfoSecurity_TabIntegrations().Click();
    Get_WinInfoSecurity_TabIntegrations().WaitProperty("IsSelected", true, 60000);
    
    SelectComboBoxItem(Get_WinInfoSecurity_TabIntegrations_CmbIntegrationPartner(), integrationPartner);
    SelectComboBoxItem(Get_WinInfoSecurity_TabIntegrations_CmbIndentifierType(), identifierType);
    Get_WinInfoSecurity_TabIntegrations_TxtIndentifierValue().SetText(identifierValue);
    Get_WinInfoSecurity_TabIntegrations_TxtIndentifierValue().Keys("[Tab]");
    
    Get_WinInfoSecurity_BtnOK().Click();
}


/**  
    Configuration du CR2008 pour le rapport 150 suivant : CR1485_150_Rel_2005_NumVis
    Ref : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\150. Feuillets d'impôt attendus (comptes non enregistrés)\1. Relations
*/
function CR2008_PreparationBD()
{
    try {
        Log.Message("CR2008_PreparationBD()");
        
        //Récupérer les données du fichier Excel
        var CR2008_Relationship_Name = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008", "CR2008_Relationship_Name", language);
        var CR2008_Relationship_IACode = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008", "CR2008_Relationship_IACode", language);
        var CR2008_Relationship_Language = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008", "CR2008_Relationship_Language", language);
        var CR2008_Relationship_Currency = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008", "CR2008_Relationship_Currency", language);
        var CR2008_Relationship_IsBillable = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008", "CR2008_Relationship_IsBillable", language);
        var CR2008_Relationship_AccountsNumbers = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008", "CR2008_Relationship_AccountsNumbers", language);
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        
        //Créer la relation
        CreateRelationship(CR2008_Relationship_Name, CR2008_Relationship_IACode, CR2008_Relationship_Currency, CR2008_Relationship_Language, GetBooleanValue(CR2008_Relationship_IsBillable));
        
        //Associer les comptes à la relation
        var arrayOfRelationshipAccountsNumbers = CR2008_Relationship_AccountsNumbers.split("|");
        for (var i in arrayOfRelationshipAccountsNumbers)
            JoinAccountToRelationship(arrayOfRelationshipAccountsNumbers[i], CR2008_Relationship_Name);
        
        //Fermer Croesus
        Close_Croesus_MenuBar();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);

    }
    catch(exceptionCR2008_PreparationBD){
        Log.Error("Exception in CR2008_PreparationBD()", exceptionCR2008_PreparationBD.message);
        exceptionCR2008_PreparationBD = null;
    }
    finally {
        Terminate_CroesusProcess();
    }
}



/**
    Ref : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\3. Évaluation du portefeuille (simple)\3.4. Comptes\Répartition et Objectif\
    
    Configuration du CR1905 pour les rapports suivants :
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\3. Évaluation du portefeuille (simple)\3.4. Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\5. PERFORMANCE DU PORTEFEUILLE\3.2 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\9. Sommaire du portefeuille\2.2 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\12. Répartition d'actifs (graphique par catégorie)\2.2 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\20. Évaluation du portefeuille (avancé)\3.3 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\27. Répartition d'actifs (détaillée)\3.2 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\48. Analyse de revenu des titres\2.1 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\55. ACTIFS SOUS GESTION\2.1 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\61. Évaluation du portefeuille (intermédiaire)\3.2 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\74. PERFORMANCE DU PORTEFEUILLE (HISTORIQUE)\2.1 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\77. PERFORMANCE DU PORTEFEUILLE (SIMPLE)\3.1 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\97. ÉVALUATION DU PORTEFEUILLE (VALEUR ACCUMULÉE)\3.3 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\102. PERFORMANCE DU PORTEFEUILLE (SOMMAIRE DES COMPTES)\2.1 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\2.1 Clients
    ...
*/
function CR1905_PreparationBD()
{
    //Récupérer les données du fichier Excel
    var inner_DataSeparatorChar = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "Inner_DataSeparatorChar", language);
    var outer_DataSeparatorChar = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "Outer_DataSeparatorChar", language);
    var arrayOfUsers = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "CR1905_Users", language).split(inner_DataSeparatorChar);
    var arrayOfInvestmentObjective_ClientsNumbers = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "InvestmentObjective_ClientsNumbers", language).split(outer_DataSeparatorChar);
    var arrayOfInvestmentObjective_AccountsNumbers = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "InvestmentObjective_AccountsNumbers", language).split(outer_DataSeparatorChar);
    var myAssetAllocationsItem_englishDescription = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "MyAssetAllocation_Description", "english");
    var myAssetAllocationsItem_frenchDescription = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "MyAssetAllocation_Description", "french");
    var myAssetAllocationsItemName = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "MyAssetAllocation_Description", language);
    var investmentObjective_Description = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "InvestmentObjective_Description", language);
    var investmentObjective_AutomaticMinMaxAdjustment = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "InvestmentObjective_AutomaticMinMaxAdjustment", language);
    
    //Récupérer les noms des objectifs de placement ainsi que leur pourcentage
    var offset_InvestmentObjectiveIDs = FindExcelRow(filePath_ReportsCR1485, "PreparationBD_CR1905", "InvestmentObjectives_List");
    var Excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 10000);
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_CR1905").Activate();
    var excelRowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    Excel.Quit();
    TerminateProcess("excel");
    
    var arrayOfArrayOfInvestmentObjectiveNamesAndValues = [];
    if (offset_InvestmentObjectiveIDs !== null){
        var investmentObjectiveID_MaxNum = excelRowCount - offset_InvestmentObjectiveIDs;
        for (var i = 1; i <= investmentObjectiveID_MaxNum; i++){
            var investmentObjectiveID = "InvestmentObjective_" + IntToStr(i);
            var investmentObjectiveName = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", investmentObjectiveID, language);
            var recommendedPercentage = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", investmentObjectiveID, "InvestmentObjective_Percent");
            arrayOfArrayOfInvestmentObjectiveNamesAndValues.push([investmentObjectiveName, recommendedPercentage]);
        }
    }
    
    //Faire la préparation pour chacun des utilisateurs mentionnés par arrayOfUsers 
    for (var u in arrayOfUsers){
        if (Trim(arrayOfUsers[u]) == ""){
            Log.Warning("The user name ID is empty.");
            continue;
        }
        
        try {
            //Login
            var testUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", arrayOfUsers[u], "username");
            var testUserPswd = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", arrayOfUsers[u], "psw");
            var arrayOfCurrentUserClientsNumbers = arrayOfInvestmentObjective_ClientsNumbers[u].split(inner_DataSeparatorChar);
            var arrayOfCurrentUserAccountsNumbers = arrayOfInvestmentObjective_AccountsNumbers[u].split(inner_DataSeparatorChar);
            Log.Message("CR1905_PreparationBD() for user " + testUserName);
            Login(vServerReportsCR1485, testUserName, testUserPswd, language);

            //Ouvrir la fenêtre de Configurations
            Get_MenuBar_Tools().OpenMenu();
            Get_MenuBar_Tools_Configurations().Click();
            Get_WinConfigurations().Parent.Maximize();
        
            //CRÉATION D'UNE RÉPARTITION D'ACTIFS NOMBREUSE ET CRÉATION DES OBJECTIFS DE PLACEMENT POUR LA RÉPARTITION D'ACTIFS
            if (CreateMyAssetAllocationBasedOnSubcategories(myAssetAllocationsItem_englishDescription, myAssetAllocationsItem_frenchDescription))
                SetInvestmentObjectiveNamesValues(myAssetAllocationsItemName, arrayOfArrayOfInvestmentObjectiveNamesAndValues, investmentObjective_Description, investmentObjective_AutomaticMinMaxAdjustment);
            
            //Fermer la fenêtre de Configurations et Croesus
            Get_WinConfigurations().Close();
            
            //Configurer l'objectif de placement pour les clients relatifs à l'utilisateur       
            for (var c in arrayOfCurrentUserClientsNumbers){
                var clientNumber = arrayOfCurrentUserClientsNumbers[c];
                if (Trim(clientNumber) == "")
                    continue;
                
                Log.Message("Add My Asset Allocation '" + myAssetAllocationsItemName + "' > '"+ investmentObjective_Description + "' investment objective to client '" + clientNumber + "'");
                SelectClients(clientNumber);
                Get_ClientsBar_BtnInfo().Click();
                Get_WinDetailedInfo_TabProductsAndServices().Click();
                Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", true, 60000);
                Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().Click();
                Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
                Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
                Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations_TvwMyAssetAllocationsItem_TvwMyObjectives_TvwMyObjectivesItem(myAssetAllocationsItemName, investmentObjective_Description).Click();
                if (Get_WinSelectAnObjective_BtnOK().WaitProperty("Enabled", true, 5000))
                    Get_WinSelectAnObjective_BtnOK().Click();
                else {
                    Log.Error("Investment objective selection cancelled.");
                    Get_WinSelectAnObjective_BtnCancel().Click();
                }
                Get_WinDetailedInfo_BtnOK().Click();
            }

            //Configurer l'objectif de placement pour les comptes relatifs à l'utilisateur
            for (var a in arrayOfCurrentUserAccountsNumbers){
                var accountNumber = arrayOfCurrentUserAccountsNumbers[a];
                if (Trim(accountNumber) == "")
                    continue;
                
                Log.Message("Add My Asset Allocation '" + myAssetAllocationsItemName + "' > '"+ investmentObjective_Description + "' investment objective to account '" + accountNumber + "'");
                SelectAccounts(accountNumber);
                Get_AccountsBar_BtnInfo().Click();
                Get_WinAccountInfo_TabInvestmentObjective().Click();
                Get_WinAccountInfo_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
                Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
                Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations_TvwMyAssetAllocationsItem_TvwMyObjectives_TvwMyObjectivesItem(myAssetAllocationsItemName, investmentObjective_Description).Click();
                if (Get_WinSelectAnObjective_BtnOK().WaitProperty("Enabled", true, 5000))
                    Get_WinSelectAnObjective_BtnOK().Click();
                else {
                    Log.Error("Investment objective selection cancelled.");
                    Get_WinSelectAnObjective_BtnCancel().Click();
                }
                Get_WinAccountInfo_BtnOK().Click();
            }
            
            //Fermer Croesus
            Close_Croesus_MenuBar();
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        
        }
        catch(exceptionCR2008_PreparationBD){
            Log.Error("CR2008_PreparationBD() : Exception for user " + testUserName, exceptionCR2008_PreparationBD.message);
            exceptionCR2008_PreparationBD = null;
        }
        finally {
            Terminate_CroesusProcess();
        }
    }
}



function CreateMyAssetAllocationBasedOnSubcategories(myAssetAllocationsItem_englishDescription, myAssetAllocationsItem_frenchDescription)
{
    var myAssetAllocationsItemName = (language == "french")? myAssetAllocationsItem_frenchDescription: myAssetAllocationsItem_englishDescription;
    Get_WinConfigurations_TvwTreeview_LlbAssetAllocationsAndObjectives().Click();
    Get_WinConfigurations_LvwListView_LlbMyAssetAllocations().DblClick();
    
    if (Get_WinConfigurations_LvwListView_LlbItem(myAssetAllocationsItemName).Exists){
        Log.Warning("Il y a une répartition existante de même nom '" + myAssetAllocationsItemName + "'.", "", pmHigher, null, Sys.Desktop.Picture());
        return false;
    }
    else {
        Get_WinConfigurations_ToolBar_BtnAddAssetAllocation().Click();
        Get_WinAssetAllocation_BtnLanguages().Click();
        Get_WinDescription_TxtEnglishCanada().Keys(myAssetAllocationsItem_englishDescription);
        Get_WinDescription_TxtFrancaisCanada().Keys(myAssetAllocationsItem_frenchDescription);
        Get_WinDescription_BtnOK().Click();
        Get_WinAssetAllocation_BtnOK().Click();
        Get_WinConfigurations_TvwTreeview_LlbAssetAllocationsAndObjectives().Click();
        Get_WinConfigurations_LvwListView_LlbMyAssetAllocations().DblClick();
        Get_WinConfigurations_LvwListView_LlbItem(myAssetAllocationsItemName).DblClick();
        Get_WinConfigurations_LvwListView_LlbBasedOn().Parent.Parent.set_IsSelected(true);
        Get_WinConfigurations_ToolBar_BtnMapClassification().Click();
        Get_WinMapAClassification_LvwAccessLevel_LlbGlobalClassifications().Click();
        Get_WinMapAClassification_LvwAvailableClassifications_LlbSubcategories().Click();
        Get_WinMapAClassification_BtnOK().Click();
    }

    Get_WinConfigurations_TvwTreeview_LlbAssetAllocationsAndObjectives().Click();
    Get_WinConfigurations_LvwListView_LlbMyAssetAllocations().DblClick();
    return Get_WinConfigurations_LvwListView_LlbItem(myAssetAllocationsItemName).Exists;
}



function SetInvestmentObjectiveNamesValues(myAssetAllocationsItemName, arrayOfArrayOfInvestmentObjectiveNamesAndValues, investmentObjective_Description, investmentObjective_AutomaticMinMaxAdjustment)
{    
    Get_WinConfigurations_TvwTreeview_LlbAssetAllocationsAndObjectives().Click();
    Get_WinConfigurations_LvwListView_LlbMyAssetAllocations().DblClick();
    Get_WinConfigurations_LvwListView_LlbItem(myAssetAllocationsItemName).DblClick();
    Get_WinConfigurations_LvwListView_LlbMyObjectives().Parent.Parent.set_IsSelected(true);
    Get_WinConfigurations_ToolBar_BtnAddInvestmentObjective().Click();
    Get_WinInvestmentObjective_GrpInformation_TxtDescription().Clear();
    Get_WinInvestmentObjective_GrpInformation_TxtDescription().Keys(investmentObjective_Description);
    Get_WinInvestmentObjective_GrpInformation_TxtAutomaticMinMaxAdjustment().Clear();
    Get_WinInvestmentObjective_GrpInformation_TxtAutomaticMinMaxAdjustment().Keys(investmentObjective_AutomaticMinMaxAdjustment);
    
    for (var i in arrayOfArrayOfInvestmentObjectiveNamesAndValues){
        var investmentObjectiveName = arrayOfArrayOfInvestmentObjectiveNamesAndValues[i][0];
        var recommendedPercentage = arrayOfArrayOfInvestmentObjectiveNamesAndValues[i][1];
        
        if (recommendedPercentage == 0) continue; //OK pour la phase de création
        
        if (aqString.StrMatches("[^0-9]", recommendedPercentage)){
            Log.Error("The Recommended value '" + recommendedPercentage + "' is not an Integer (for Item '" + investmentObjectiveName + "' setting.)");
            continue;   
        }
        
        if (!Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective_Item(investmentObjectiveName).Exists){
            Log.Error("Item '" + investmentObjectiveName + "' was not found in the grid");
            continue;   
        }
        
        Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective_Item(investmentObjectiveName).set_IsActive(true);;
        Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages_TxtRecommended().Keys("[Del]" + recommendedPercentage + "[Tab]");
        if (StrToInt(recommendedPercentage) != Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages_TxtRecommended().Text.OleValue)
            Log.Error("The Recommended value " + recommendedPercentage + " setting was not successful for item : " + investmentObjectiveName);
    }
    
    Get_WinInvestmentObjective_BtnOK().Click();
}



/**
    Préparation pour les CR2008 / CR1880 relatifs aux cas suivants :
    
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\2. GAINS ET PERTES RÉALISÉS\3.1 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\2. GAINS ET PERTES RÉALISÉS\2.3 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\107. BIENS ÉTRANGERS (SIMPLIFIÉ)\1.1 Relations
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\149. Page couverture (Déclaration de revenus)
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\150. Feuillets d'impôt attendus (comptes non enregistrés)
*/
function CR2008_CR1880_PreparationBD()
{
    try {
        //Retrieve data from Excel file
        var dataSeparatorChar = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008_CR1880", "DataSeparatorChar", language);
        var arrayOfUsers = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008_CR1880", "CR2008_CR1880_Users", language).split(dataSeparatorChar);
        var firmCode = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008_CR1880", "CR2008_CR1880_FirmCode", language);
        var value_PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008_CR1880", "PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY", language));
        var value_TAX_REPORT_NON_REGISTERED_ACCOUNTS = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008_CR1880", "TAX_REPORT_NON_REGISTERED_ACCOUNTS", language));
        var value_ACCOUNT_TYPE_NON_REGISTERED = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008_CR1880", "ACCOUNT_TYPE_NON_REGISTERED", language);
        var value_SECURITY_TAX_SLIP_NON_REGISTERED = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR2008_CR1880", "SECURITY_TAX_SLIP_NON_REGISTERED", language);
        
        //Restore pref PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY to default for Users
        for (var u in arrayOfUsers)
            UpdatePrefAtLevelForUser(arrayOfUsers[u], "PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY", null, "BRANCH", vServerReportsCR1485);
        
        //Web Configurator Login
        var webConfiguratorUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        var webConfiguratorUserPswd = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
        browserName = "iexplore";
        Login_WebConfigurator(vServerReportsCR1485, webConfiguratorUserName, webConfiguratorUserPswd, language, browserName);
        
        //Update 1 : Pref PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY
        var prefConfigName = "PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY";
        var prefConfigValue = value_PREF_REPORT_INCLUDE_NON_REGISTERED_ACCOUNTS_ONLY;
        Get_WebConfigurator_LnkFirm(vServerReportsCR1485, firmCode).Click();
        Get_WebConfigurator_BtnPreferencesAndConfigurations(vServerReportsCR1485).WaitProperty("Enabled", true, 5000);
        Get_WebConfigurator_BtnPreferencesAndConfigurations(vServerReportsCR1485).Click();
        PrefConfigLookUp(vServerReportsCR1485, prefConfigName);
        Get_WebConfigurator_LnkPrefConfig(vServerReportsCR1485, prefConfigName).Click();
        Get_WebConfigurator_PnlEditPrefsFirm_ChkUseTheGlobalFirmValue(vServerReportsCR1485).ClickChecked((prefConfigValue == undefined));
        if (prefConfigValue != undefined){
            if (language == "french")
                var itemYesOrNo = (prefConfigValue == true)? "Oui": "Non";
            else
                var itemYesOrNo = (prefConfigValue == true)? "Yes": "No";
        }
        
        Get_WebConfigurator_PnlEditPrefsFirm_CmbValue(vServerReportsCR1485).ClickItem(itemYesOrNo);
        Get_WebConfigurator_PnlEditPrefsFirm_BtnApply(vServerReportsCR1485).WaitProperty("Enabled", true, 5000);
        Get_WebConfigurator_PnlEditPrefsFirm_BtnApply(vServerReportsCR1485).Click();
        CheckEquals(Get_WebConfigurator_PnlEditPrefsSuccessMessage(vServerReportsCR1485).Exists, true, "Is '" + prefConfigName + "' Pref Update successfullness");
        CompareProperty(Get_WebConfigurator_PnlEditPrefsFirm_ChkUseTheGlobalFirmValue(vServerReportsCR1485).checked, cmpEqual, (prefConfigValue == undefined), true, lmError);
        if (prefConfigValue != undefined)
            CompareProperty(Get_WebConfigurator_PnlEditPrefsFirm_CmbValue(vServerReportsCR1485).wText, cmpEqual, itemYesOrNo, true, lmError);
        Get_WebConfigurator(vServerReportsCR1485).Keys("[Esc]");
        
        //Update 2 : Config TAX_REPORT_NON_REGISTERED_ACCOUNTS
        var mainConfigName = "TAX_REPORT_NON_REGISTERED_ACCOUNTS";
        var mainConfigValue = value_TAX_REPORT_NON_REGISTERED_ACCOUNTS;
        Get_WebConfigurator_LnkFirm(vServerReportsCR1485, firmCode).Click();
        Get_WebConfigurator_BtnPreferencesAndConfigurations(vServerReportsCR1485).WaitProperty("Enabled", true, 5000);
        Get_WebConfigurator_BtnPreferencesAndConfigurations(vServerReportsCR1485).Click();
        PrefConfigLookUp(vServerReportsCR1485, mainConfigName);
        Get_WebConfigurator_LnkPrefConfig(vServerReportsCR1485, mainConfigName).WaitProperty("Enabled", true, 5000);
        Get_WebConfigurator_LnkPrefConfig(vServerReportsCR1485, mainConfigName).Click();
        Get_WebConfigurator_PnlEditConfig_ChkUseTheGlobalFirmValue(vServerReportsCR1485).WaitProperty("Enabled", true, 5000);
        Get_WebConfigurator_PnlEditConfig_ChkUseTheGlobalFirmValue(vServerReportsCR1485).ClickChecked(mainConfigValue);
        Get_WebConfigurator_PnlEditConfig_BtnApply(vServerReportsCR1485).WaitProperty("Enabled", true, 5000);
        Get_WebConfigurator_PnlEditConfig_BtnApply(vServerReportsCR1485).Click();
        CheckEquals(Get_WebConfigurator_PnlEditConfigSuccessMessage(vServerReportsCR1485).Exists, true, "Is '" + mainConfigName + "' Config Update successfullness");
        CompareProperty(Get_WebConfigurator_PnlEditConfig_ChkUseTheGlobalFirmValue(vServerReportsCR1485).checked, cmpEqual, mainConfigValue, true, lmError);
        Get_WebConfigurator(vServerReportsCR1485).Keys("[Esc]");
        
        //Updates 2.1 / 2.2 : Configs ACCOUNT_TYPE_NON_REGISTERED / SECURITY_TAX_SLIP_NON_REGISTERED
        var arrayOfConfigNameAndValue = new Array();
        arrayOfConfigNameAndValue.push(["ACCOUNT_TYPE_NON_REGISTERED", value_ACCOUNT_TYPE_NON_REGISTERED]);
        arrayOfConfigNameAndValue.push(["SECURITY_TAX_SLIP_NON_REGISTERED", value_SECURITY_TAX_SLIP_NON_REGISTERED]);
        for (var i in arrayOfConfigNameAndValue){
            var configName = arrayOfConfigNameAndValue[i][0];
            var configValue = arrayOfConfigNameAndValue[i][1];
            Get_WebConfigurator_LnkFirm(vServerReportsCR1485, firmCode).Click();
            Get_WebConfigurator_BtnPreferencesAndConfigurations(vServerReportsCR1485).WaitProperty("Enabled", true, 5000);
            Get_WebConfigurator_BtnPreferencesAndConfigurations(vServerReportsCR1485).Click();
            PrefConfigLookUp(vServerReportsCR1485, mainConfigName);
            Get_WebConfigurator_LnkPrefConfig(vServerReportsCR1485, mainConfigName).WaitProperty("Enabled", true, 5000);
            Get_WebConfigurator_LnkPrefConfig(vServerReportsCR1485, mainConfigName).DblClick();
            Get_WebConfigurator_LnkPrefConfig(vServerReportsCR1485, configName).WaitProperty("Enabled", true, 5000);
            Get_WebConfigurator_LnkPrefConfig(vServerReportsCR1485, configName).Click();
            Get_WebConfigurator_PnlEditConfig_TxtValue(vServerReportsCR1485).WaitProperty("Enabled", true, 5000);
            Get_WebConfigurator_PnlEditConfig_TxtValue(vServerReportsCR1485).Click();
            Get_WebConfigurator_PnlEditConfig_TxtValue(vServerReportsCR1485).Keys("^a[Del]" + configValue);
            Get_WebConfigurator_PnlEditConfig_BtnApply(vServerReportsCR1485).WaitProperty("Enabled", true, 5000);
            Get_WebConfigurator_PnlEditConfig_BtnApply(vServerReportsCR1485).Click();
            CheckEquals(Get_WebConfigurator_PnlEditConfigSuccessMessage(vServerReportsCR1485).Exists, true, "Is '" + configName + "' Config Update successfullness");
            CompareProperty(Get_WebConfigurator_PnlEditConfig_TxtValue(vServerReportsCR1485).value, cmpEqual, configValue, true, lmError);
            Get_WebConfigurator(vServerReportsCR1485).Keys("[Esc]");
        }
        
        //Disconnect
        Get_WebConfigurator_BarHeader_LnkUsername(vServerReportsCR1485, webConfiguratorUserName).Click();
        Get_WebConfigurator_BarHeader_LnkDisconnect(vServerReportsCR1485).Click();
        Get_WebConfigurator_WebPageLogin(vServerReportsCR1485).Wait();
    }
    catch (exceptionCR2008_CR1880_PreparationBD){
        Log.Error("Exception in CR2008_CR1880_PreparationBD()", exceptionCR2008_CR1880_PreparationBD.message);
        exceptionCR2008_CR1880_PreparationBD = null;
    }
    finally {
        //Restart services
        RestartServices(vServerReportsCR1485);
    }
}




/*Brouillon pour le rapport 26*/
function Rapport026_BrouillonSQL()
{
    SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\AvancementBD1Jour.sql";
    SQLFileContent = aqFile.ReadWholeTextFile(SQLFilePath, aqFile.ctANSI);
    Execute_SQLQuery(SQLFileContent, vServerReportsCR1485);
}



/*Brouillon pour le rapport 26*/
function Rapport026_BrouillonSSH()
{
    //Create SSH script file
    var BDNum = aqString.SubString(vServerURL, 19, 2);
    
    SSHCmdlines = "#!/bin/bash";
    SSHCmdlines += "\r\n" + "rm -f /home/yaminal/alberto/CR1485/*.xml";
    SSHCmdlines += "\r\n" + "cp -f /home/yaminal/alberto/CR1485/Xml_vides/* /home/yaminal/alberto/CR1485/";
    SSHCmdlines += "\r\n" + "sed -i 's/.*WCRESUS_DB:.*/WCRESUS_DB:           qa_auto" + BDNum + "/' /home/yaminal/.loader";
    SSHCmdlines += "\r\n" + "cd /home/yaminal/alberto/CR1485/";
    SSHCmdlines += "\r\n" + "loader -FULL=1 -LOG2STDOUT";
    
    SSHCmdFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\ssh_script_026.txt";
    
    CreateFileAndWriteText(SSHCmdFilePath, SSHCmdlines);
}



function UpdateAssembleScript_old(vServerURL)
{   
    assembleScriptFileName = "AssembleScript_" + client + ".txt";
    
    assembleScriptFilePath = folderPath_ProjectSuiteCommonScripts + "AssembleScript_" + client + ".txt";
    if (!aqFile.Exists(assembleScriptFilePath)){
        Log.Error("The Assemble Script file was not found : " + assembleScriptFilePath);
        return;
    }
    
    //Create PLINK batch file
    var hostname = GetVserverHostName(vServerURL);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m " + assembleScriptFileName + " > " + "Output_" + assembleScriptFileName;
    plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "plinkBatchFile.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
}


function ExecuteCommandOnPowerShell(strCommand)
{
    var oExec = WshShell.Exec("powershell -command " + strCommand);
    oExec.StdIn.Close(); // Close standard input before reading output
    var strOutput = oExec.StdOut.ReadAll();
    var strError = oExec.StdErr.ReadAll();
    
    if (Trim(strError) != ""){
        Log.Error("There was an error running this command on PowerShell : " + strCommand);
        Log.Error(strError, strError);
    }
    
    return strOutput;
}


function ExecuteScriptOnPowerShell(commandsFilePath)
{
    ExecuteCommandOnPowerShell("Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force"); //Permettre l'execution de scripts (pour l'utilisateur courant)
    
    var oExec = WshShell.Exec("powershell -file " + "\"" + commandsFilePath + "\"");
    oExec.StdIn.Close(); // Close standard input before reading output
    var strOutput = oExec.StdOut.ReadAll();
    var strError = oExec.StdErr.ReadAll();
    
    if (Trim(strError) != ""){
        Log.Error("There was an error running this file on PowerShell : " + commandsFilePath);
        Log.Error(strError, strError);
    }
    
    return strOutput;
}



function StartVserver_old(vServerURL)
{
    var vServerHostname = GetVserverHostName(vServerURL);
    Log.Message("Starting the Vserver '" + vServerHostname + "' ...");
    var APICommand = "curl http://qaref/api/vserver.cgi/start/" + vServerHostname;
    var isVserverStarted = (aqString.Find(ExecuteCommandOnPowerShell(APICommand), '"status" : "200 OK"') != -1 );
    
    if (isVserverStarted)
        Log.Message("The Vserver '" + vServerHostname + "' was successfully started.");
    else
        Log.Error("The Vserver '" + vServerHostname + "' was not successfully started.");
    
    return isVserverStarted;
}



function StopVserver_old(vServerURL)
{
    var vServerHostname = GetVserverHostName(vServerURL);
    Log.Message("Stopping the Vserver '" + vServerHostname + "' ...");
    var APICommand = "curl http://qaref/api/vserver.cgi/stop/" + vServerHostname;
    var isVserverStopped = (aqString.Find(ExecuteCommandOnPowerShell(APICommand), '"status" : "200 OK"') != -1 );
    
    if (isVserverStopped)
        Log.Message("The Vserver '" + vServerHostname + "' was successfully stopped.");
    else
        Log.Error("The Vserver '" + vServerHostname + "' was not successfully stopped.");
    
    return isVserverStopped;
}


function RestartVserver_old(vServerURL)
{
    Log.Message("Restarting the Vserver '" + vServerURL + "' ...");
    var isVserverRestarted =(StopVserver(vServerURL) && StartVserver(vServerURL));
    
    if (isVserverRestarted)
        Log.Message("The Vserver '" + vServerURL + "' was successfully restarted.");
    else
        Log.Error("The Vserver '" + vServerURL + "' was not successfully restarted.");
    
    return isVserverRestarted;
}
