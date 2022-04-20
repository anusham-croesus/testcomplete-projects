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

function CR1485_114_Portf_DateDef_UndfSec_Diclaimer_NASDAQ100()
{
	Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\114. Annexe Anatomie du portefeuille\\Configuration indices MorningStar\\1. Configuration indices MorningStar.txt", "Pré-requis : CR1485_PreparationBD_Securities_Morningstar()");
    Log.Link("https://jira.croesus.com/browse/CALCUL-1002", "Bug JIRA CALCUL-1002");
    Log.Message("Bug JIRA CROES-7140 signalé sur la version Neo-59.");
    Log.Message("Bug JIRA CROES-11498");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 103);
        
        
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
        
        //Drag the accounts to Portfolio module
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 105);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 110, language);
        asOfDate = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 120, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 108, language);
        sortBy = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 109, language);
        //currency = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 110, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 111, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 112, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 113, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 114, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 115, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 116, language);
        message = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 117, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 120, language);
        checkReportUnidentifiedSecurities = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 121, language);
        checkMorningstarDisclaimer = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 122, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 123, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 124, language);
        
        SetReportParameters(asOfDate, checkReportUnidentifiedSecurities, checkMorningstarDisclaimer, checkDisplayDefaultIndices, indicesToBeChecked);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 127);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 130, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 130, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 131, language);
        
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