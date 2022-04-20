//USEUNIT CR1485_124_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-11--V9-croesus-co7x-1_5_550
*/

function CR1485_124_Acc_RepCR1905()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    Log.Message("CR1905");
    Log.Message("Bug JIRA CROES-11541");
    Log.Message("Bug JIRA CROES-10714 ; Performance du portefeuille (intermédiaire) : Crash du rapport");
    Log.Message("Bug JIRA CROES-11221 ; Performance du portefeuille (intermédiaire) version FR");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 172);
        
        
        //Activate Prefs
        ActivatePrefs(userNameReportsCR1485);
        EnablePerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
        
        //Login and goto Accounts module and Select the Account
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountNumber);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 174);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 177, language);
        sortBy = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 178, language);
        currency = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 179, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 180, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 181, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 182, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 183, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 184, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 185, language);
        message = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 186, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkExcludeDataPrecedingTheManagementStartDate = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 189, language));
        endDate = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 190, language);
        period = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 191, language);
        period1 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 192, language);
        period2 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 193, language);
        period3 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 194, language);
        period4 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 195, language);
        period5 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 196, language);
        checkDisplayDefaultIndices = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 197, language));
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 198, language);
        checkUseIndexBaseCurrency = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 199, language));
        checkGraphsAssetAllocation = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 200, language));
        checkGraphsInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 201, language));
        checkGraphsPortfolioPerformance = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 202, language));
        typeOfGraphs = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 203, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 204, language);
        customAllocation = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 205, language);
        checkUseTheSpecifiedInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 206, language));
        checkRiskMeasurementStandardDeviation = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 207, language));
        checkRiskMeasurement3YearStandardDeviation = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 208, language));
        checkRiskMeasurement3YearStandDevIndices = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 209, language));
        checkRiskMeasurementSharpeIndex = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 210, language));
        checkTimeWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 211, language));
        checkTimeWeightedGrossOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 212, language));
        checkMoneyWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 213, language));
        performanceCalculations = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 214, language);
        numbering = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 215, language);
    
        SetReportParameters(checkExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, typeOfGraphs, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 219);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 222, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 223, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, typeOfGraphs, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
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