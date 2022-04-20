//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_102_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Amine A.
*/

function CR1485_102_Acc_DateModf_Fix_PerDef_GraphPortfPerf_Histo_AssAllFirm_TWRN_MWR_4Ind_NumVis()
{
    
    try {
        reportName       = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 1, language);
        accountNumber    = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 504);
        
        Log.Message(REPORTS_FILES_FOLDER_PATH);
        
        //Activate Prefs
        ActivatePrefs();
        EnablePerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 506);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination                 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 509, language);
        sortBy                      = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 510, language);
        currency                    = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 511, language);
        reportLanguage              = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 512, language);
        checkAddBranchAddress       = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 513, language);
        checkGroupInTheSameReport   = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 514, language);
        checkConsolidatePositions   = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 515, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 516, language);
        checkIncludeMessage         = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 517, language);
        message                     = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 518, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);

        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 522, language);
        
        endDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 523, language);
        period  = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 524, language);
        period1 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 525, language);
        period2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 526, language);
        period3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 527, language);
        period4 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 528, language);
        period5 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 529, language);
        
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 530, language);
        
        indicesToBeChecked              = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 531, language);
        checkUseIndexBaseCurrency       = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 532, language);
        checkGraphsAssetAllocation      = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 533, language);
        checkGraphsInvestmentObjective  = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 534, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 535, language);
        
        type                                    = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 536, language);
        assetAllocation                         = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 537, language);
        customAllocation                        = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 538, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 539, language);
        checkTimeWeightedNetOfFees              = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 540, language);
        checkTimeWeightedGrossOfFees            = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 541, language);
        checkMoneyWeightedNetOfFees             = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 542, language);
        performanceCalculations                 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 543, language);
        numbering                               = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 544, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 546);
              
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency       = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 549, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 550, language);
        
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