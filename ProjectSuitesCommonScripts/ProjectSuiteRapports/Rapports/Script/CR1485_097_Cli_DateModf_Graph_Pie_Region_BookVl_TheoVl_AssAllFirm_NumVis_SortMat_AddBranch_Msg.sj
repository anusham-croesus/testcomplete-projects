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

function CR1485_097_Cli_DateModf_Graph_Pie_Region_BookVl_TheoVl_AssAllFirm_NumVis_SortMat_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 50);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 52);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 55, language);
        sortBy = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 56, language);
        currency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 57, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 58, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 59, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 60, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 61, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 62, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 63, language);
        message = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 64, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 67, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 68, language);
        type = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 69, language);
        checkComparative = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 70, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 71, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 72, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 73, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 74, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "097_EVAL_VC", 76, language): GetData(filePath_ReportsCR1485, "097_EVAL_VC", 75, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 77, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 78, language);
        customAllocation = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 79, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 80, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 81, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 82, language);
        numbering = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 83, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 84, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 87);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 90, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 91, language);
        
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