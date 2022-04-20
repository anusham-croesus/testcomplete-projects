//USEUNIT CR1485_009_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_009_Cli_DateDef_TWRNet_IndiceTSE35_TSE60_NumVis_Group()
{
    Log.Message("Bug JIRA CROES-6464");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 46);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        EnablePerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 48);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 51, language);
        sortBy = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 52, language);
        currency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 53, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 54, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 55, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 56, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 57, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 58, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 59, language);
        message = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 60, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 63, language);
        endDate = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 64, language);
        period = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 65, language);
        period1 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 66, language);
        period2 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 67, language);
        period3 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 68, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 69, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 70, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 71, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 72, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 73, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 74, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 75, language);
        numbering = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 76, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 79);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 82, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 83, language);

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
        RestoreToDefaultPerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        Terminate_CroesusProcess();
    }
    
}