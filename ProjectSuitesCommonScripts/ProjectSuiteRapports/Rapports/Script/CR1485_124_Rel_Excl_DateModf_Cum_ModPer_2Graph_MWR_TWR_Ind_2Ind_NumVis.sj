//USEUNIT CR1485_124_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_124_Rel_Excl_DateModf_Cum_ModPer_2Graph_MWR_TWR_Ind_2Ind_NumVis()
{
    Log.Message("CR1900");
    Log.Message("Bug JIRA CROES-10714 ; Performance du portefeuille (intermédiaire) : Crash du rapport");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 4);
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and goto Relationships module and Select the relationship
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        SelectRelationships(relationshipName);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 10, language);
        currency = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 17, language);
        message = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkExcludeDataPrecedingTheManagementStartDate = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 21, language));
        endDate = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 22, language);
        period = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 23, language);
        period1 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 24, language);
        period2 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 25, language);
        period3 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 26, language);
        period4 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 27, language);
        period5 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 28, language);
        checkDisplayDefaultIndices = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 29, language));
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 30, language);
        checkUseIndexBaseCurrency = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 31, language));
        checkGraphsAssetAllocation = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 32, language));
        checkGraphsInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 33, language));
        checkGraphsPortfolioPerformance = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 34, language));
        typeOfGraphs = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 35, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 36, language);
        customAllocation = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 37, language);
        checkUseTheSpecifiedInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 38, language));
        checkRiskMeasurementStandardDeviation = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 39, language));
        checkRiskMeasurement3YearStandardDeviation = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 40, language));
        checkRiskMeasurement3YearStandDevIndices = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 41, language));
        checkRiskMeasurementSharpeIndex = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 42, language));
        checkTimeWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 43, language));
        checkTimeWeightedGrossOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 44, language));
        checkMoneyWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 45, language));
        performanceCalculations = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 46, language);
        numbering = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 47, language);
    
        SetReportParameters(checkExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, typeOfGraphs, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 51);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 54, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 55, language);
        
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