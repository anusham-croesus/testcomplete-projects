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

function CR1485_074_Rel_DateDef_PerdDef_AssAllBasic_TWRNet_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 10, language);
        currency = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 17, language);
        message = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 22, language);
        period = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 23, language);
        period1 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 24, language);
        period2 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 25, language);
        period3 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 26, language);
        period4 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 27, language);
        period5 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 28, language);
        period6 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 29, language);
        period7 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 30, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 31, language);
        customAllocation = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 32, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 33, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 34, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 35, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 36, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 37, language);
        numbering = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 38, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 41);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 44, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 45, language);
        
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