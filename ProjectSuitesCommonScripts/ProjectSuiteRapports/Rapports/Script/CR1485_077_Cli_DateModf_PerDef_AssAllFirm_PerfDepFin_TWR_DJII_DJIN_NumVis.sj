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

function CR1485_077_Cli_DateModf_PerDef_AssAllFirm_PerfDepFin_TWR_DJII_DJIN_NumVis()
{
    Log.Message("CR1126");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 228);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 230);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 233, language);
        sortBy = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 234, language);
        currency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 235, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 236, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 237, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 238, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 239, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 240, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 241, language);
        message = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 242, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 245, language);
        endDate = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 246, language);
        period = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 247, language);
        period1 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 248, language);
        period2 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 249, language);
        period3 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 250, language);
        period4 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 251, language);
        period5 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 252, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 253, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 254, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 255, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 256, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 257, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 258, language);
        type = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 259, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 260, language);
        customAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 261, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 262, language);
        checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 263, language);
        checkRiskMeasurement3YearStandardDeviation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 264, language);
        checkRiskMeasurement3YearStandDevIndices = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 265, language);
        checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 266, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 267, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 268, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 269, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 270, language);
        checkPerfStartEndValues = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 271, language);
        numbering = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 272, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkPerfStartEndValues, numbering);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 275);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 278, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 279, language);
        
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