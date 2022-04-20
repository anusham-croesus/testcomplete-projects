//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_097_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_097_Acc_DateDef_Graph_Histog_IndCode_BookVl_AssAllBasic_NumVis_SortMat_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 96);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 98);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 101, language);
        sortBy = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 102, language);
        currency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 103, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 104, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 105, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 106, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 107, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 108, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 109, language);
        message = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 110, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 113, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 114, language);
        type = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 115, language);
        checkComparative = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 116, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 117, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 118, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 119, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 120, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "097_EVAL_VC", 122, language): GetData(filePath_ReportsCR1485, "097_EVAL_VC", 121, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 123, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 124, language);
        customAllocation = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 125, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 126, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 127, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 128, language);
        numbering = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 129, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 130, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 133);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 136, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 137, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
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