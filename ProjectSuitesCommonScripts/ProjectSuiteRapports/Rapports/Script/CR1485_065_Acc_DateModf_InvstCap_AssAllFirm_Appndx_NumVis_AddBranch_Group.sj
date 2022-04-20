//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_065_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_065_Acc_DateModf_InvstCap_AssAllFirm_Appndx_NumVis_AddBranch_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 88);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 90);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 93, language);
        sortBy = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 94, language);
        currency = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 95, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 96, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 97, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 98, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 99, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 100, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 101, language);
        message = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 102, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 105, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 106, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 107, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 108, language);
        costCalculation = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 109, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 110, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 111, language);
        customAllocation = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 112, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 113, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 114, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 115, language);
        numbering = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 116, language);
        checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 117, language);
        
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 120);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 123, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 124, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
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