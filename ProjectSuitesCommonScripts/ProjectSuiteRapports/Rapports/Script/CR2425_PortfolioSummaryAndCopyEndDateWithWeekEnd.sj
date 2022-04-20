//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT PDFUtils
//USEUNIT RPT_2671_Crash_In_The_ReportConfigurationWindow
//USEUNIT ReportCommander_Commonfunctions

/**
    Jira Xray    :https://jira.croesus.com/browse/TCVE-2503
    Description : Valider la date de fin dans les rapports Sommaire de portefeuille, Sommaire de portefeuille (sans réferences), copie de Sommaire de portefeuille,
                  et copie de Sommaire de portefeuille (sans réferences), avec les niveaux Firm, user et workgroup 
                  
    Analyste d'assurance qualité : M. Gasin
    Analyste d'automatisation : A.A
    
    Version : ref90-19-2020-09-36
**/

function CR2425_PortfolioSummaryAndCopyEndDateWithWeekEnd(){
    
        var logEtape1, logEtape2, logRetourEtatInitial;
        try {
            Log.Link("https://jira.croesus.com/browse/TCVE-2503","Lien du Cas de test sur Jira Xray");
      
            var userNameDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
            var passwordDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
            var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
            var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");        
            
            var BDNewDate    = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2425", "CR2425_BDNewDate",    language+client);
            var client800249 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2425", "CR2425_Client800249", language+client);
            var ReportNames  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2425", "CR2425_ReportNames",  language+client);
            var levelsList   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2425", "CR2425_LevelsList",   language+client);
            var endDatesList = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2425", "CR2425_EndDatesList", language+client);
            var periodsList  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2425", "CR2425_PeriodsList",  language+client);
            
            var arrayOfReportNames = ReportNames.split("|");
            var arrayOflevels      = levelsList.split("|");
            var arrayOfEndDates    = endDatesList.split("|");
            var arrayOfPeriods     = periodsList.split("|");
            
//            arrayOfReportNames = ["Portfolio Summary","Portfolio Summary (without References)","Copy of Portfolio Summary","Copy of Portfolio Summary (without References)","Copy of Portfolio Summary"]
//            arrayOflevels      = ["Global","Global","Firm","Workgroup","User"];
//            arrayOfEndDates    = ["09/30/2007","09/30/2007","10/19/2007","09/30/2007","12/31/2006"];
//            arrayOfPeriods     = ["Last business day", "End of last month", "End of last year"]
           
            //Changer la date de la BD
//            var BDNewDate   = "2007.10.19";
            var ArrayOfCle  = ["FD_LAST_PROCESS","FD_LASTPERF_DAILY","FD_NEXT_PROCESS_DATE"];
            var queryString = "update b_config set note = '" + BDNewDate + "' where cle='";
        
            Log.PopLogFolder();
            logEtape0 = Log.AppendFolder("Étape 0: Préparation de la BD et activation des Prefs");
            for(i=0; i<ArrayOfCle.length; i++)
    //            Log.Message(queryString + ArryOfCle[i] + "'")
                Execute_SQLQuery(queryString + ArrayOfCle[i] + "'", vServerReportsCR1485);
            
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_PORTFOLIO",   "YES", vServerReportsCR1485);
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_PORT_WO_REF", "YES", vServerReportsCR1485);
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_FBN_GP",                     "YES", vServerReportsCR1485);
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_REPORT_GROUPING",     "2",   vServerReportsCR1485);
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CONFIGURE_REPORTS",          "YES", vServerReportsCR1485);
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_RPT_CONFIG_SAC",             "YES", vServerReportsCR1485);        
            Activate_Inactivate_Pref(userNameDARWIC, "PREF_EDIT_FIRM_FUNCTIONS",      "YES", vServerReportsCR1485);
      
            // Étape 1
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Connexion avec DARWIC, Changer la date de fin 'End date' des rapports");
        
            //Login avec DARWIC
            Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);
                
            //Changer les End Date des rapports: Portfolio Summary et Portfolio Summary (without References), niveau Firm et Workgroup
            ReportEndDateChange(arrayOfReportNames[0], userNameDARWIC, arrayOflevels[2], arrayOfPeriods[0]);
            ReportEndDateChange(arrayOfReportNames[1], userNameDARWIC, arrayOflevels[3], arrayOfPeriods[1]);
        
            //Fermer Croesus
            Close_Croesus_X();
        
            // Étape 2
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: connexion avec Copern "); 
                  
            //Login avec COPERN
            Login(vServerReportsCR1485, userNameCOPERN, passwordCOPERN, language);
            
            //Changer la date de fin du rapport Portfolio Summary niveau User
            ReportEndDateChange(arrayOfReportNames[0], userNameCOPERN, arrayOflevels[4], arrayOfPeriods[2]);
        
            //Aller au module Clients   
            Get_ModulesBar_BtnClients().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000);
            
            //Selectionner le client 800249
            Search_Client(client800249);
            Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", client800249, 10, true, 30000).Click();
            
            //Ouvrir la fenêtre Rapports           
            Get_Toolbar_BtnReportsAndGraphs().Click();            
            WaitReportsWindow();
            
            //Selectionner les rapports Portfolio Summary, Portfolio Summary (without References) pour different niveau et valider les dates de fin (End Date)
            // et générer les rapports
            for(i=0; i<arrayOfReportNames.length; i++ )
                SelectReportAndCheckEndDate(arrayOfReportNames[i], arrayOflevels[i], arrayOfEndDates[i]); 

            
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3: générer le rapport et valider les dates affichées");
//            var reportFolderPath = REPORTS_FILES_FOLDER_PATH;
//            aqFileSystem.CreateFolder(REPORTS_FILES_FOLDER_PATH);
            var reportFolderPath = folderPath_Data + client + "\\CR1485\\ResultFolder\\";
            var reportFileName  = "CR2425_Rapport"+ "_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d_%H%M%S");
            var reportFilePath = reportFolderPath + reportFileName;
            
            //Sauvegarder le rapport généré
            ValidateAndSaveReportAsPDF(reportFilePath, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
            
            //Valider les dates afichées dans les rapports
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3: Valider les dates afichées dans les rapports");
            var arrayOfString = ["Au 30 septembre 2007", "Pour la période du 1 juillet 2007 au 30 septembre 2007", "Au 19 octobre 2007", "Au 31 décembre 2006"];
            
            CheckStringOccurenceInPdfFile(reportFilePath + ".pdf", null, arrayOfString);
            CheckStringOccurenceInPdfFile(reportFilePath + ".pdf", 4, ["Pour la période du 1 juillet 2007 au 30 septembre 2007"]) 
                        
            //Fermer Croesus
            Close_Croesus_X();             
    }
    catch(e) {
            //S'il y a exception, en afficher le message
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {  
            //Fermer le processus Croesus
            Terminate_CroesusProcess();
    }
}

function SelectReportAndCheckEndDate(reportName, level, endDateString){
    
        Log.Message("Valider la date de fin rapport: "+reportName+ ", level: "+level+", date de fin: "+ endDateString)
        switch (level){
            case "Global":
                Get_Reports_GrpReports_TabSavedReports_TvwReports_TvwGlobal().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", reportName], 10).Click();
                break;
            case "Firm":
                Get_Reports_GrpReports_TabSavedReports_TvwReports_TvwFirm().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", reportName], 10).Click();
                break;
            case "User":
                Get_Reports_GrpReports_TabSavedReports_TvwReports_TvwUser().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", reportName], 10).Click();
                break;
            case "Workgroup":
                Get_Reports_GrpReports_TabSavedReports_TvwReports_TvwWorkgroup().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", reportName], 10).Click();
                break; 
            }
        
        Get_Reports_GrpReports_BtnAddAReport().Click();
		    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
        WaitReportParametersWindow(50000);
        Log.Message( Get_WinParameters_DtpEndDate().StringValue)
        aqObject.CheckProperty(Get_WinParameters_DtpEndDate(), "StringValue", cmpEqual, endDateString);
        Get_WinParameters().Close();        
}

function ReportEndDateChange(ReportName, userName, reportCopy, endDate){
    
            //Outils / Configurations / Rapports / Configuration des rapports
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Configurations().Click();        
            Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 15000);
            Get_WinConfigurations_TvwTreeview_LlbReports().DblClick();
            Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
            
            //Selectionner le rapport
            Log.Message("Selectionner le rapport: "+ ReportName)
            WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
            SelectOneReport1(ReportName, userName); 
            Get_WinReportConfiguration_BtnCopyTo().Click();
            Get_WinCopyReport().WaitProperty("VisibleOnScreen", true, 30000);
            
            Log.Message("Choisir le bouton radio : "+ reportCopy);            
            switch (reportCopy){
                case "Firm":
                    Get_WinCopyReport_RdoFirm().set_IsChecked(true);
                    break;
                case "User":
                    Get_WinCopyReport_CmbUser().set_IsChecked(true);
                    break;
                case "Workgroup":
                    Get_WinCopyReport_RdoWorkgroup().set_IsChecked(true);
                    break; 
                } 
            Get_WinCopyReport_BtnOK().Click();
         
            Log.Message("Aller dans l'onglet paramètres")
            Get_WinReportConfigurationCopy_TabParameters().Click(); 
            Get_WinReportConfigurationCopy_TabParameters_ChkReportUsesDefault().set_IsChecked(false);
            SelectComboBoxItem(Get_WinReportConfigurationCopy_TabParameters_CmbEndDate(), endDate)
            
            Get_WinReportConfigurationCopy_BtnOK().Click();
            
            Get_WinReportConfiguration().Close();
            Get_WinConfigurations().Close();        
}