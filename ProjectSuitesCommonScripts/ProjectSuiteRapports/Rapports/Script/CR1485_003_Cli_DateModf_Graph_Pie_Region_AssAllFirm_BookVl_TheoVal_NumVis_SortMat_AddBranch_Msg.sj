//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_003_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_003_Cli_DateModf_Graph_Pie_Region_AssAllFirm_BookVl_TheoVal_NumVis_SortMat_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 10, language);
        currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 17, language);
        message = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 21, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 22, language);
        type = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 23, language);
        checkComparative = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 24, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 25, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 26, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 27, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 28, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 30, language): GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 29, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 31, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 32, language);
        customAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 33, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 34, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 35, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 36, language);
        numbering = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 37, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 38, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 41);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 44, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 45, language);
        
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