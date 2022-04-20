//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_074_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_074_Acc_DateModf_PerYear_AssAllBasic_TWRNetBrutMWRNet_NumVis_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 96);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 98);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 101, language);
        sortBy = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 102, language);
        currency = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 103, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 104, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 105, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 106, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 107, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 108, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 109, language);
        message = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 110, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 113, language);
        endDate = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 114, language);
        period = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 115, language);
        period1 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 116, language);
        period2 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 117, language);
        period3 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 118, language);
        period4 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 119, language);
        period5 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 120, language);
        period6 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 121, language);
        period7 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 122, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 123, language);
        customAllocation = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 124, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 125, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 126, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 127, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 128, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 129, language);
        numbering = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 130, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 133);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 136, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 137, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
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