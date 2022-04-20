//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_115_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_115_Rel_DateDef_UndfSec_Diclaimer_NASDAQ100()
{
	Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\114. Annexe Anatomie du portefeuille\\Configuration indices MorningStar\\1. Configuration indices MorningStar.txt", "Pré-requis : CR1485_PreparationBD_Securities_Morningstar()");
    Log.Link("https://jira.croesus.com/browse/CALCUL-1002", "Bug JIRA CALCUL-1002");
    Log.Message("Bug JIRA CROES-7140 signalé sur la version Neo-59.");
    Log.Message("Bug JIRA CROES-11498");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        //userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        //passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 10, language);
        currency = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 17, language);
        message = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 21, language);
        checkReportUnidentifiedSecurities = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 22, language);
        checkMorningstarDisclaimer = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 23, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 24, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 25, language);
    
        SetReportParameters(asOfDate, checkReportUnidentifiedSecurities, checkMorningstarDisclaimer, checkDisplayDefaultIndices, indicesToBeChecked);

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 28);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 31, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "115_MSTAR_SNAPSHOT", 32, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkReportUnidentifiedSecurities, checkMorningstarDisclaimer, checkDisplayDefaultIndices, indicesToBeChecked);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}