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

function CR1485_114_Acc_DateDef_UndfSec_Diclaimer_IndexCustom()
{
	Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\114. Annexe Anatomie du portefeuille\\Configuration indices MorningStar\\1. Configuration indices MorningStar.txt", "Pré-requis : CR1485_PreparationBD_Securities_Morningstar()");
    Log.Link("https://jira.croesus.com/browse/CALCUL-1002", "Bug JIRA CALCUL-1002");
    Log.Message("Bug JIRA CROES-7140 signalé sur la version Neo-59.");
    Log.Message("Bug JIRA CROES-11498");
    
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 70);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        //userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        //passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 72);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 75, language);
        sortBy = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 76, language);
        currency = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 77, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 78, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 79, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 80, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 81, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 82, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 83, language);
        message = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 84, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 87, language);
        checkReportUnidentifiedSecurities = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 88, language);
        checkMorningstarDisclaimer = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 89, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 90, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 91, language);
        
        SetReportParameters(asOfDate, checkReportUnidentifiedSecurities, checkMorningstarDisclaimer, checkDisplayDefaultIndices, indicesToBeChecked);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 94);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 97, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "114_MSTAR_XRAY", 98, language);
        
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