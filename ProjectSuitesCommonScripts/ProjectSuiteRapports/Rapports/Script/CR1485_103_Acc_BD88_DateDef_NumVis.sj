//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_103_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_103_Acc_BD88_DateDef_NumVis()
{
    Log.Message("Bug JIRA CROES-6464");
    Log.Message("Bug JIRA CROES-6741.");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 35);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 37);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 40, language);
        sortBy = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 41, language);
        currency = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 42, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 43, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 44, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 45, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 46, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 47, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 48, language);
        message = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 49, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        codes = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 52, language);
        endDate = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 53, language);
        numbering = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 54, language);
        
        SetReportParameters(codes, endDate, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 57);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 60, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 61, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(codes, endDate, numbering);
        
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