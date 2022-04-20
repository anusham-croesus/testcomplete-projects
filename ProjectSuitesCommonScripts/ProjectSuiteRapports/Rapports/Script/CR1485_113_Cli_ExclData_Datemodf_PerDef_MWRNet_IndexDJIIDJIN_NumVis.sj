//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_113_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_113_Cli_ExclData_Datemodf_PerDef_MWRNet_IndexDJIIDJIN_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 48);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 50);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 53, language);
        sortBy = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 54, language);
        currency = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 55, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 56, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 57, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 58, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 59, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 60, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 61, language);
        message = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 62, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 65, language);
        endDate = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 66, language);
        period = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 67, language);
        period1 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 68, language);
        period2 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 69, language);
        period3 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 70, language);
        period4 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 71, language);
        period5 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 72, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 73, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 74, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 75, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 76, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 77, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 78, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 79, language);
        numbering = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 80, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 83);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 86, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 87, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
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