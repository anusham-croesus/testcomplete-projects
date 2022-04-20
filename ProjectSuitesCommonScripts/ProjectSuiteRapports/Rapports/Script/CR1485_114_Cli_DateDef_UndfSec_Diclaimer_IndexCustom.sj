//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_114_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_114_Cli_DateDef_UndfSec_Diclaimer_IndexCustom()
{
	Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\114. Annexe Anatomie du portefeuille\\Configuration indices MorningStar\\1. Configuration indices MorningStar.txt", "Pré-requis : CR1485_PreparationBD_Securities_Morningstar()");
    Log.Link("https://jira.croesus.com/browse/CALCUL-1002", "Bug JIRA CALCUL-1002");
    Log.Message("Bug JIRA CROES-7140 signalé sur la version Neo-59.");
    Log.Message("Bug JIRA CROES-11498");  
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 37);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        //userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        //passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 39);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 42, language);
        sortBy = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 43, language);
        currency = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 44, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 45, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 46, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 47, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 48, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 49, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 50, language);
        message = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 51, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 54, language);
        checkReportUnidentifiedSecurities = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 55, language);
        checkMorningstarDisclaimer = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 56, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 57, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 58, language);
        
        SetReportParameters(asOfDate, checkReportUnidentifiedSecurities, checkMorningstarDisclaimer, checkDisplayDefaultIndices, indicesToBeChecked);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 61);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 64, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 65, language);
        
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