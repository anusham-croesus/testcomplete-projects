//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_077_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_077_Cli_DateModf_PerDef_GraphAssAllInvstObj_Pie_AssAllBasic_MWR_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 116);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 118);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 121, language);
        sortBy = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 122, language);
        currency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 123, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 124, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 125, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 126, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 127, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 128, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 129, language);
        message = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 130, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 133, language);
        endDate = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 134, language);
        period = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 135, language);
        period1 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 136, language);
        period2 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 137, language);
        period3 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 138, language);
        period4 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 139, language);
        period5 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 140, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 141, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 142, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 143, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 144, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 145, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 146, language);
        type = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 147, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 148, language);
        customAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 149, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 150, language);
        checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 151, language);
        checkRiskMeasurement3YearStandardDeviation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 152, language);
        checkRiskMeasurement3YearStandDevIndices = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 153, language);
        checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 154, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 155, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 156, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 157, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 158, language);
        checkPerfStartEndValues = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 159, language);
        numbering = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 160, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkPerfStartEndValues, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 163);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 166, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 167, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkPerfStartEndValues, numbering);
        
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