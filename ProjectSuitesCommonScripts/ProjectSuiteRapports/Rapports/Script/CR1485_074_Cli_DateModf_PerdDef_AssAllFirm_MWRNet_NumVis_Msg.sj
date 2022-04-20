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

function CR1485_074_Cli_DateModf_PerdDef_AssAllFirm_MWRNet_NumVis_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 50);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 52);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 55, language);
        sortBy = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 56, language);
        currency = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 57, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 58, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 59, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 60, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 61, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 62, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 63, language);
        message = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 64, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 67, language);
        endDate = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 68, language);
        period = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 69, language);
        period1 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 70, language);
        period2 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 71, language);
        period3 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 72, language);
        period4 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 73, language);
        period5 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 74, language);
        period6 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 75, language);
        period7 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 76, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 77, language);
        customAllocation = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 78, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 79, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 80, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 81, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 82, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 83, language);
        numbering = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 84, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 87);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 90, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 91, language);
        
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