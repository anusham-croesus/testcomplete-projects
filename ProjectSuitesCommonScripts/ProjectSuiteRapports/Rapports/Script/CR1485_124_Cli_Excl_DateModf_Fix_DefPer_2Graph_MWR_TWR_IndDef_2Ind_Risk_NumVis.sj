//USEUNIT CR1485_124_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_124_Cli_Excl_DateModf_Fix_DefPer_2Graph_MWR_TWR_IndDef_2Ind_Risk_NumVis()
{
    Log.Message("CR1900");
    Log.Message("Bug JIRA CROES-10714 ; Performance du portefeuille (intermédiaire) : Crash du rapport");
    
    try {
        var arrayOfClientsNumbers = null;
        var reportName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 1, language);
        var arrayOfClientsNumbers = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 60).split("|");
        var arrayOfDefaultIndicesDescriptions = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 104, language).split("|");
        var targetReturnPercentValueForDefaultIndices = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 105, language);
        
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and goto CLients module and Select the Client
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        //SelectClients(arrayOfClientsNumbers);
        
        //Préalable : Configuration des Indices par défaut
        SelectDefaultIndicesForClients(arrayOfClientsNumbers, arrayOfDefaultIndicesDescriptions, targetReturnPercentValueForDefaultIndices);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 62);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 65, language);
        var sortBy = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 66, language);
        var currency = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 67, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 68, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 69, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 70, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 71, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 72, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 73, language);
        var message = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 74, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var checkExcludeDataPrecedingTheManagementStartDate = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 77, language));
        var endDate = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 78, language);
        var period = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 79, language);
        var period1 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 80, language);
        var period2 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 81, language);
        var period3 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 82, language);
        var period4 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 83, language);
        var period5 = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 84, language);
        var checkDisplayDefaultIndices = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 85, language));
        var indicesToBeChecked = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 86, language);
        var checkUseIndexBaseCurrency = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 87, language));
        var checkGraphsAssetAllocation = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 88, language));
        var checkGraphsInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 89, language));
        var checkGraphsPortfolioPerformance = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 90, language));
        var typeOfGraphs = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 91, language);
        var assetAllocation = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 92, language);
        var customAllocation = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 93, language);
        var checkUseTheSpecifiedInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 94, language));
        var checkRiskMeasurementStandardDeviation = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 95, language));
        var checkRiskMeasurement3YearStandardDeviation = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 96, language));
        var checkRiskMeasurement3YearStandDevIndices = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 97, language));
        var checkRiskMeasurementSharpeIndex = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 98, language));
        var checkTimeWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 99, language));
        var checkTimeWeightedGrossOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 100, language));
        var checkMoneyWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 101, language));
        var performanceCalculations = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 102, language);
        var numbering = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 103, language);
    
        SetReportParameters(checkExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, typeOfGraphs, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 107);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 110, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "124_PERF_INTERM", 111, language);
        
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
        //Restauration des Indices par défaut
        if (arrayOfClientsNumbers != undefined){
            var SQLQuery = "delete from B_CLIENT_INDEX where CLIENT_ID in (select CLIENT_ID from B_CLIENT where NO_CLIENT in (LIST_OF_NO_CLIENT_TO_BE_RESTORED)) \r\n";
            SQLQuery += "update B_CLIENT set TARGET_RETURN = null where NO_CLIENT  in (LIST_OF_NO_CLIENT_TO_BE_RESTORED) \r\n";
            SQLQuery = aqString.Replace(SQLQuery, 'LIST_OF_NO_CLIENT_TO_BE_RESTORED', "'" + arrayOfClientsNumbers.join("', '") + "'");
            Log.Message(SQLQuery, SQLQuery);
            Execute_SQLQuery(SQLQuery, vServerReportsCR1485);
        }
        
        Terminate_CroesusProcess();
    }
    
}
