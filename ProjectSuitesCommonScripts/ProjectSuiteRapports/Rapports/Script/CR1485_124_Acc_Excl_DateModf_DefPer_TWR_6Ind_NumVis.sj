//USEUNIT CR1485_124_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_124_Acc_Excl_DateModf_DefPer_TWR_6Ind_NumVis()
{
    Log.Message("CR1900");
    Log.Message("Bug JIRA CROES-10714 ; Performance du portefeuille (intermédiaire) : Crash du rapport");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 116);
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and goto Accounts module and Select the Account
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountNumber);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 118);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 121, language);
        sortBy = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 122, language);
        currency = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 123, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 124, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 125, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 126, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 127, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 128, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 129, language);
        message = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 130, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkExcludeDataPrecedingTheManagementStartDate = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 133, language));
        endDate = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 134, language);
        period = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 135, language);
        period1 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 136, language);
        period2 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 137, language);
        period3 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 138, language);
        period4 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 139, language);
        period5 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 140, language);
        checkDisplayDefaultIndices = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 141, language));
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 142, language);
        checkUseIndexBaseCurrency = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 143, language));
        checkGraphsAssetAllocation = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 144, language));
        checkGraphsInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 145, language));
        checkGraphsPortfolioPerformance = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 146, language));
        typeOfGraphs = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 147, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 148, language);
        customAllocation = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 149, language);
        checkUseTheSpecifiedInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 150, language));
        checkRiskMeasurementStandardDeviation = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 151, language));
        checkRiskMeasurement3YearStandardDeviation = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 152, language));
        checkRiskMeasurement3YearStandDevIndices = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 153, language));
        checkRiskMeasurementSharpeIndex = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 154, language));
        checkTimeWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 155, language));
        checkTimeWeightedGrossOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 156, language));
        checkMoneyWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 157, language));
        performanceCalculations = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 158, language);
        numbering = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 159, language);
    
        SetReportParameters(checkExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, typeOfGraphs, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 163);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 166, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 167, language);
        
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