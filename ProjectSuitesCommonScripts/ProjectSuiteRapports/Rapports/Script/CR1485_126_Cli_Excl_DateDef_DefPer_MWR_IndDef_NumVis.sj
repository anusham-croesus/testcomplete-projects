//USEUNIT CR1485_126_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_126_Cli_Excl_DateDef_DefPer_MWR_IndDef_NumVis()
{
    Log.Message("CR1986");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 1, language);
        var clientsNumbers = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 56);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and goto the module and Select elements
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientsNumbers.split("|"));
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 58);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 61, language);
        var sortBy = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 62, language);
        var currency = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 63, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 64, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 65, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 66, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 67, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 68, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 69, language);
        var message = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 70, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 73, language);
        var endDate = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 74, language);
        var period = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 75, language);
        var period1 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 76, language);
        var period2 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 77, language);
        var period3 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 78, language);
        var period4 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 79, language);
        var period5 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 80, language);
        var period6 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 81, language);
        var checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 82, language);
        var indicesToBeChecked = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 83, language);
        var checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 84, language);
        var checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 85, language);
        var checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 86, language);
        var checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 87, language);
        var type = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 88, language);
        var assetAllocation = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 89, language);
        var customAllocation = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 90, language);
        var checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 91, language);
        var checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 92, language);
        var checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 93, language);
        var checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 94, language);
        var performanceCalculations = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 95, language);
        var numbering = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 96, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 99);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 102, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 103, language);
        
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
