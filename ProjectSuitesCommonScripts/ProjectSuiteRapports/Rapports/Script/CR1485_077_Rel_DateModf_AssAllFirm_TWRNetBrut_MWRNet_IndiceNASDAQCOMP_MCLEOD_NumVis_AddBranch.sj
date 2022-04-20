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

function CR1485_077_Rel_DateModf_AssAllFirm_TWRNetBrut_MWRNet_IndiceNASDAQCOMP_MCLEOD_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 1, language);
        relationshipsNames = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 4);
        arrayOfRelationshipsNames = relationshipsNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select relationships
        SelectRelationships(arrayOfRelationshipsNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 10, language);
        currency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 17, language);
        message = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 22, language);
        period = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 23, language);
        period1 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 24, language);
        period2 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 25, language);
        period3 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 26, language);
        period4 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 27, language);
        period5 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 28, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 29, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 30, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 31, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 32, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 33, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 34, language);
        type = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 35, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 36, language);
        customAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 37, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 38, language);
        checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 39, language);
        checkRiskMeasurement3YearStandardDeviation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 40, language);
        checkRiskMeasurement3YearStandDevIndices = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 41, language);
        checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 42, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 43, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 44, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 45, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 46, language);
        checkPerfStartEndValues = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 47, language);
        numbering = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 48, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkPerfStartEndValues, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 51);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 54, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 55, language);
        
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