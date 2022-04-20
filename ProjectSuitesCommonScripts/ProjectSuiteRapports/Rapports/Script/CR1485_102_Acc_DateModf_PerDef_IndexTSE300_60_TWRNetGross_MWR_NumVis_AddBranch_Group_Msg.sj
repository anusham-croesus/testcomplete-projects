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

function CR1485_102_Acc_DateModf_PerDef_IndexTSE300_60_TWRNetGross_MWR_NumVis_AddBranch_Group_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 106);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        EnablePerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 108);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 111, language);
        sortBy = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 112, language);
        currency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 113, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 114, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 115, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 116, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 117, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 118, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 119, language);
        message = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 120, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 123, language);
        endDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 124, language);
        period = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 125, language);
        period1 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 126, language);
        period2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 127, language);
        period3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 128, language);
        period4 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 129, language);
        period5 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 130, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 131, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 132, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 133, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 134, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 135, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 136, language);
        type = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 137, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 138, language);
        customAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 139, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 140, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 141, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 142, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 143, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 144, language);
        numbering = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 145, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 148);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 151, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 152, language);
        
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