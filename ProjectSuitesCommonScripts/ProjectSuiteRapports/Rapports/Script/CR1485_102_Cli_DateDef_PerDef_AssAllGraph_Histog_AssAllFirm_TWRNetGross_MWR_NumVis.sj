//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_102_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_102_Cli_DateDef_PerDef_AssAllGraph_Histog_AssAllFirm_TWRNetGross_MWR_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 55);
        
        
        //Activate Prefs
        ActivatePrefs();
        EnablePerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 57);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 60, language);
        sortBy = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 61, language);
        currency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 62, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 63, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 64, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 65, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 66, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 67, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 68, language);
        message = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 69, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 72, language);
        endDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 73, language);
        period = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 74, language);
        period1 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 75, language);
        period2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 76, language);
        period3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 77, language);
        period4 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 78, language);
        period5 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 79, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 80, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 81, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 82, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 83, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 84, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 85, language);
        type = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 86, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 87, language);
        customAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 88, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 89, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 90, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 91, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 92, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 93, language);
        numbering = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 94, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 97);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 100, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 101, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        RestoreToDefaultPerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        Terminate_CroesusProcess();
    }
    
}