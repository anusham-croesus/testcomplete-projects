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

function CR1485_113_Acc_DateModf_PerDef_TWRNetBrut_IndexTSE35_60_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 92);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 94);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 97, language);
        sortBy = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 98, language);
        currency = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 99, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 100, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 101, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 102, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 103, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 104, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 105, language);
        message = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 106, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 109, language);
        endDate = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 110, language);
        period = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 111, language);
        period1 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 112, language);
        period2 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 113, language);
        period3 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 114, language);
        period4 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 115, language);
        period5 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 116, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 117, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 118, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 119, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 120, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 121, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 122, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 123, language);
        numbering = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 124, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 127);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 130, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 131, language);
        
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