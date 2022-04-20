//USEUNIT CR1485_126_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_126_Acc_DateMod_DefPer_2Graphs_TWR_MWR_AllInd_NumVis()
{
    Log.Message("CR1986");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 1, language);
        var accountsNumbers = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 108);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and goto the module and Select elements
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountsNumbers.split("|"));
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 110);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 113, language);
        var sortBy = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 114, language);
        var currency = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 115, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 116, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 117, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 118, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 119, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 120, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 121, language);
        var message = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 122, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 125, language);
        var endDate = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 126, language);
        var period = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 127, language);
        var period1 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 128, language);
        var period2 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 129, language);
        var period3 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 130, language);
        var period4 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 131, language);
        var period5 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 132, language);
        var period6 = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 133, language);
        var checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 134, language);
        var indicesNotToBeChecked = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 135, language);
        var indicesToBeChecked = GetIndicesToBeCheckedFromIndicesNotToBeChecked(indicesNotToBeChecked);
        var checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 136, language);
        var checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 137, language);
        var checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 138, language);
        var checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 139, language);
        var type = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 140, language);
        var assetAllocation = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 141, language);
        var customAllocation = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 142, language);
        var checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 143, language);
        var checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 144, language);
        var checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 145, language);
        var checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 146, language);
        var performanceCalculations = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 147, language);
        var numbering = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 148, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 151);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 154, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "126_PERF_ACC_SUMM2", 155, language);
        
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
