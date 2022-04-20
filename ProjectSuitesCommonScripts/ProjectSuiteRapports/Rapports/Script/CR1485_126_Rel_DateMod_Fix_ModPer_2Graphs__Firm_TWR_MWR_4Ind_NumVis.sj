//USEUNIT CR1485_126_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_126_Rel_DateMod_Fix_ModPer_2Graphs__Firm_TWR_MWR_4Ind_NumVis()
{
    Log.Message("CR1986");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 1, language);
        var relationshipsNames = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 4);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and goto  module and Select elements
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        SelectRelationships(relationshipsNames.split("|"));
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 9, language);
        var sortBy = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 10, language);
        var currency = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 11, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 12, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 13, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 14, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 15, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 16, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 17, language);
        var message = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 21, language);
        var endDate = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 22, language);
        var period = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 23, language);
        var period1 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 24, language);
        var period2 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 25, language);
        var period3 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 26, language);
        var period4 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 27, language);
        var period5 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 28, language);
        var period6 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 29, language);
        var checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 30, language);
        var indicesToBeChecked = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 31, language);
        var checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 32, language);
        var checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 33, language);
        var checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 34, language);
        var checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 35, language);
        var type = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 36, language);
        var assetAllocation = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 37, language);
        var customAllocation = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 38, language);
        var checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 39, language);
        var checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 40, language);
        var checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 41, language);
        var checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 42, language);
        var performanceCalculations = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 43, language);
        var numbering = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 44, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 47);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 50, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 51, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
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
