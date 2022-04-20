//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_099_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_099_Acc_DateModf_Region_AssAllFirm_BookVl_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 4);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 10, language);
        currency = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 17, language);
        message = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 21, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 22, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 23, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 24, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 26, language): GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 25, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 27, language);
        customAllocation = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 28, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 29, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 30, language);
        numbering = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 31, language);
        
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 34);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 37, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "099_FBNFISC_GP_NON_REAL", 38, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
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