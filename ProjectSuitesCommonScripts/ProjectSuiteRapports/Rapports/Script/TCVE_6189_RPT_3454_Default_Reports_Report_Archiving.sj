//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//CR1485_Common_functions



/**
    Description : En tant que TCVE, je veux automatiser le jira RPT-3454 pour l'inclure dans nos tests de régression du modules rapports
                  
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Philippe Maurice
    Version: 98.29-19
    Date: 5 novembre 2021
*/


function TCVE_6189_RPT_3454_Default_Reports_Report_Archiving()
{
    try {
      
        var userNameDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var passwordDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
        Log.Link("https://jira.croesus.com/browse/TCVE-6189", "Lien de la story");
        Log.Link("https://jira.croesus.com/browse/RPT-2972", "Lien du cas de test");
        
        
        Log.Message("Copy of the CroesusWeb Folder");
        CopyCroesusWebFolder();
        //Activate Prefs
        Log.Message("ACTIVATION DES PREFS");
        ActivatePrefs();
        
        
        Log.PopLogFolder();
        logEtape1_2 = Log.AppendFolder("Étapes 1 et 2:  Se connecter avec DARWIC, sélectionner les comptes '300010-NA', '800400-NA' et '800401-NA' et choisir les rapports par défaut.");
        // - Se loguer dans croesus avec l'user DARWIC
        Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);
        
        // - Comptes / Sélectionner les compte 300010-NA 
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
        
        var accounts = GetData(filePath_ReportsCR1485, "Anomalies", 35, language);
        var arrayOfAccounts = accounts.split("|");
        
        for (i = 0; i < arrayOfAccounts.length; i++ ) {
            
            Log.Message(arrayOfAccounts.length);
            
            SelectAccounts(arrayOfAccounts[i]);
        
            // - Info / Rapport par défaut
            Get_AccountsBar_BtnInfo().Click();
            Delay(1000);
            Get_WinAccountInfo_TabDefaultReports().Click();
        
            // - Déplacer vers la droite les rapports:
            //A. Page couverture - B. Sommaire du document - C. Évaluation du portefeuille (simple) - D. Performance du portefeuille - E. Transactions
            var reportNames = GetData(filePath_ReportsCR1485, "Anomalies", 37, language);
            var arrayOfReportsNames = reportNames.split("|");
            
            SelectReports(arrayOfReportsNames);

            // -  Cliquer sur OK
            Get_WinAccountInfo_BtnOK().Click();
        }
        
                    
        //Étape 3
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Création des rapports.");
        
        // - Sélectionner les comptes 300010-NA, 800400-NA et 800401-NA
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
        
        SelectAccounts(arrayOfAccounts);
        
        
        // - Rapports / Rapports sauvegardés
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        Get_Reports_GrpReports_TabSavedReports().Click();
        Get_Reports_GrpReports_TabSavedReports().WaitProperty("IsSelected", true, 20000);
        
        // - Déplacer vers la droite => Rapports par défaut
        Log.Message("sélectionner le package Steadyhand Statement et le déplacer au côté droite de la fenêtre avec la petite flèche")
        SelectFirmSavedReport("Rapports par défaut", true);    
        
        
        //Reports options values
        // - *Source*: Sélection courante
        // - Cliquer sur OK pour lancer la batch
        reportFileName = GetData(filePath_ReportsCR1485, "Anomalies", 39);
        destination = GetData(filePath_ReportsCR1485, "Anomalies", 42, language);           // - *Destination*: Aperçu
        archiveReports = GetData(filePath_ReportsCR1485, "Anomalies", 51, language);
        sortBy = GetData(filePath_ReportsCR1485, "Anomalies", 43, language);
        currency = GetData(filePath_ReportsCR1485, "Anomalies", 44, language);          // - *Devise*: USD
        reportLanguage = GetData(filePath_ReportsCR1485, "Anomalies", 45, language);          // - *Langue*: English
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "Anomalies", 46, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "Anomalies", 47, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "Anomalies", 48, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "Anomalies", 49, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "Anomalies", 50, language);
        message = GetData(filePath_ReportsCR1485, "Anomalies", 52, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        // - *Cocher*: Archiver les rapports
        var archiveName = GetData(filePath_ReportsCR1485, "Anomalies", 36, language);
        
        if (Get_WinReports_GrpOptions_ChkArchiveReports().IsEnabled) {
            Get_WinReports_GrpOptions_ChkArchiveReports().set_IsChecked(aqString.ToUpper(archiveReports) == "VRAI" || aqString.ToUpper(archiveReports) == "TRUE");
                
            if (Get_WinReports_GrpOptions_ArchiveName().IsVisible)
                Get_WinReports_GrpOptions_ArchiveName().Keys(archiveName);          // - *Nom de l'archive*: Quarter 4_2009
        }
                
        //Validate and save report
        Log.Message("Validation et sauvegarde des rapports");
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        Delay(5000);
        
        
        //Étapes 4 et 5
        Log.PopLogFolder();
        logEtape4_5 = Log.AppendFolder("Étapes 4 et 5:  Vérification du package " + archiveName + " dans l'onglet Documents.");
        
        var clients = GetData(filePath_ReportsCR1485, "Anomalies", 61, language);
        var arrayOfClients = clients.split("|");

        
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        
        for (i = 0; i < arrayOfClients.length; i++ ) {
            
            Log.Message(arrayOfClients.length);
            
            //Sélectionner le client / Info / Documents
            Log.Message("Sélection du client " + arrayOfClients[i]);
            SelectClients(arrayOfClients[i]);


            Get_ClientsBar_BtnInfo().Click();        
            Get_WinDetailedInfo().WaitProperty("IsVisible", true, 30000);            
            Get_WinDetailedInfo_TabDocuments().Click();
            Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 60000);
            
            //Un package sous le nom *Quarter 4_2009* a été sauvegardé dans l'onglet documents
            Log.Message("Un package sous le nom *Quarter 4_2009* a été sauvegardé dans l'onglet Documents");
            searchPDFFile(archiveName + ".pdf");
        }

        
        //Étapes 6 et 7
        Log.PopLogFolder();
        logEtape6_7 = Log.AppendFolder("Étapes 6 et 7:  ");
        
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        
        //Sélectionner le client  800400 / Info / Documents
        var client800400 = GetData(filePath_ReportsCR1485, "Anomalies", 60, language);
        var client800401 = GetData(filePath_ReportsCR1485, "Anomalies", 62, language);
        
        SelectClients(client800400);
        
        //Cliquer la racine dans l'espace Details et double-cliquer sur client 800401
        if (Get_RelationshipsClientsAccountsDetails().Find("Value", client800401, 100).Exists) {
            Get_RelationshipsClientsAccountsDetails().Find("Value", client800401, 100).DblClick();
        }
        
        Get_WinDetailedInfo().WaitProperty("IsVisible", true, 30000)
        Get_WinDetailedInfo_TabDocuments().Click();
        Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 60000);
        
        Log.Message("Trouver le document pdf dans l'onglet Documents");
        searchPDFFile(archiveName + ".pdf");

    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.Message("----- Désactivation des PREFS et Fermeture de Croesus -----");
        Terminate_CroesusProcess();
        DeactivatePrefs();        
    }
}




function CopyCroesusWebFolder()
{
    var CroesusWebDestinationFolder = "C:\\";
    var CroesusWebSourceFolder = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\CroesusWeb";
    var CroesusWebTargetFolder = CroesusWebDestinationFolder + aqFileSystem.GetFolderInfo(CroesusWebSourceFolder).Name;
    
    if (aqFileSystem.Exists(CroesusWebTargetFolder) && !aqFileSystem.DeleteFolder(CroesusWebTargetFolder, true))
        Log.Error("Folder not successfully deleted : " + CroesusWebTargetFolder);
    
    if (!aqFileSystem.CopyFolder(CroesusWebSourceFolder, CroesusWebDestinationFolder, false))
        Log.Error("Folder not successfully copied from '" + CroesusWebSourceFolder + "' to '" + CroesusWebTargetFolder + "'");
}



function ActivatePrefs()
{   
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_CROFT_COVERPAGE", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CROFT_COVER_PAGE", "YES", vServerReportsCR1485);
    
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_PORTFMAN_COVERPAGE", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ROGERS_COVER_PAGE", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_RPFL_COVERPAGE_ALONE", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_RPFL_COVER_PAGE", "NO", vServerReportsCR1485);

    RestartServices(vServerReportsCR1485);
}


function SelectReports(arrayOfReportsNames)
{
    if (GetVarType(arrayOfReportsNames) != varArray && GetVarType(arrayOfReportsNames) != varDispatch)
        arrayOfReportsNames = new Array(arrayOfReportsNames);

    if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();

    var reportsCount = Get_Reports_GrpReports_TabReports_LvwReports().Items.get_Count();
    var nbOfSelectedReports = 0;
    Get_Reports_GrpReports_TabReports_LvwReports().Keys("[Home]");
    for (var i = 1; i < reportsCount; i++){
        var currentReportName = VarToStr(Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).WPFControlText);
        var isFound = false;
        for (j = 0; j < arrayOfReportsNames.length; j++){
            if (currentReportName == arrayOfReportsNames[j]){
                isFound = true;
                nbOfSelectedReports ++;
                break;
            }
        }
            
        if (isFound)
            Get_Reports_GrpReports_BtnAddAReport().Click();
        
        if (nbOfSelectedReports == arrayOfReportsNames.length)
            break;
        
        Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).Keys("[Down]");
    }
}


function Get_WinReports_GrpOptions_ArchiveName() {
    return Get_WinReports_GrpOptions().FindChild("Uid", "CustomTextBox_5194", 10)
}


function searchPDFFile(filename)
{
    var j = 2;
    var found = false;
        
    if(Get_WinDetailInfo_TabDocu_LvwtDocu().HasItems){
        Log.Checkpoint("La partie Document n'est pas vide");

        Log.Message("Number of elements: " + Get_WinDetailInfo_TabDocu_LvwtDocu().Items.Count)
                
        while ((j <= Get_WinDetailInfo_TabDocu_LvwtDocu().Items.Count) && (found == false)) {
            if (Get_WinDetailInfo_TabDocu_LvwtDocu().WPFObject("ListBoxItem", "", j).WPFObject("fileSummary").Exists)
                if (Get_WinDetailInfo_TabDocu_LvwtDocu().WPFObject("ListBoxItem", "", j).WPFObject("fileSummary").WPFObject("NameLabel").Text == filename) {
                    found = true;
                    Log.Message("Le fichier " + filename + " est retrouvé dans la liste.");    
                }
        }
        j = j + 1;

    }     
    else {
        Log.Error("La partie Document est vide");
    }
    
    if((j > Get_WinDetailInfo_TabDocu_LvwtDocu().Items.Count) && (found == false))
        Log.Error("Fichier attendu (" + filename + ") ne se retrouve pas dans la liste.");
        
    Log.Message("Clic sur le bouton OK");
    Get_WinDetailedInfo_BtnOK().Click();
    Delay(1000);    
}


function DeactivatePrefs()
{   
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_CROFT_COVERPAGE", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CROFT_COVER_PAGE", "NO", vServerReportsCR1485);
    
    RestartServices(vServerReportsCR1485);
}