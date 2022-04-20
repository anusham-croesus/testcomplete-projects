//USEUNIT CR1485_009_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_009_Rel_ExclData_DateDef_TWRNetGross_MWR_IndiceTSE35_TSE60_NumVis_AddBranch()
{
    Log.Message("Bug JIRA CROES-6464");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 4);
        
        
        //Activate Prefs
        ActivatePrefs(userNameReportsCR1485);
        RestoreToDefaultPerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 10, language);
        currency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 17, language);
        message = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 22, language);
        period = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 23, language);
        period1 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 24, language);
        period2 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 25, language);
        period3 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 26, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 27, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 28, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 29, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 30, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 31, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 32, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 33, language);
        numbering = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 34, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 37);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 40, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 41, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        EnablePerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        Terminate_CroesusProcess();
    }
    
}