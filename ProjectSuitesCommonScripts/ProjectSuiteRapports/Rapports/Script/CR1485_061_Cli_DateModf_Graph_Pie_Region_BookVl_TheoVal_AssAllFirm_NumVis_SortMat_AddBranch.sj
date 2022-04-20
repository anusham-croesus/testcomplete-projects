//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_061_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_061_Cli_DateModf_Graph_Pie_Region_BookVl_TheoVal_AssAllFirm_NumVis_SortMat_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 96);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 98);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 101, language);
        sortBy = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 102, language);
        currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 103, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 104, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 105, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 106, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 107, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 108, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 109, language);
        message = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 110, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 113, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 114, language);
        type = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 115, language);
        checkComparative = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 116, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 117, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 118, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 119, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 120, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 122, language): GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 121, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 123, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 124, language);
        customAllocation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 125, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 126, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 127, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 128, language);
        numbering = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 129, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 130, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 133);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 136, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 137, language);
        
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