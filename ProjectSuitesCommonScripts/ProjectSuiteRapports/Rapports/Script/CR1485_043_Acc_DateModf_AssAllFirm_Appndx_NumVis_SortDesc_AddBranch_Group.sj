//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_043_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_043_Acc_DateModf_AssAllFirm_Appndx_NumVis_SortDesc_AddBranch_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 136);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 138);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 141, language);
        sortBy = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 142, language);
        currency = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 143, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 144, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 145, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 146, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 147, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 148, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 149, language);
        message = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 150, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 153, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 154, language);
        type = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 155, language);
        checkComparative = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 156, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 157, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 158, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 159, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 160, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 161, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 162, language);
        customAllocation = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 163, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 164, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 165, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 166, language);
        numbering = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 167, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 168, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 171);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 174, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "043_EVAL_INTER_TL", 175, language);
        
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