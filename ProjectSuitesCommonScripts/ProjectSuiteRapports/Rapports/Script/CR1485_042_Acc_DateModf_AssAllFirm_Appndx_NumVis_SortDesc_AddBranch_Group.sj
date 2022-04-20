//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_042_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_042_Acc_DateModf_AssAllFirm_Appndx_NumVis_SortDesc_AddBranch_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 92);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 94);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 97, language);
        sortBy = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 98, language);
        currency = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 99, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 100, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 101, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 102, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 103, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 104, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 105, language);
        message = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 106, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 109, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 110, language);
        type = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 111, language);
        checkComparative = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 112, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 113, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 114, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 115, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 116, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 117, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 118, language);
        customAllocation = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 119, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 120, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 121, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 122, language);
        numbering = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 123, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 124, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 127);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 130, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "042_EVAL_AVAN_TL", 131, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}