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

function CR1485_077_Acc_DateModf_PerDef_AssAllFirm_AllIndex_TWRNetBrut_TotPerf_NumVis_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 172);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 174);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 177, language);
        sortBy = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 178, language);
        currency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 179, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 180, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 181, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 182, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 183, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 184, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 185, language);
        message = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 186, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 189, language);
        endDate = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 190, language);
        period = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 191, language);
        period1 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 192, language);
        period2 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 193, language);
        period3 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 194, language);
        period4 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 195, language);
        period5 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 196, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 197, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 198, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 199, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 200, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 201, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 202, language);
        type = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 203, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 204, language);
        customAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 205, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 206, language);
        checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 207, language);
        checkRiskMeasurement3YearStandardDeviation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 208, language);
        checkRiskMeasurement3YearStandDevIndices = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 209, language);
        checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 210, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 211, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 212, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 213, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 214, language);
        checkPerfStartEndValues = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 215, language);
        numbering = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 216, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkPerfStartEndValues, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 219);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 222, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 223, language);
        
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