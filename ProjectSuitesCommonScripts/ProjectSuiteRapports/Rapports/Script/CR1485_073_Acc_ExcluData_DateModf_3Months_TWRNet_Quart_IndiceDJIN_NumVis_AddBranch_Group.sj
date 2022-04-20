//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_073_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_073_Acc_ExcluData_DateModf_3Months_TWRNet_Quart_IndiceDJIN_NumVis_AddBranch_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 84);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 86);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 89, language);
        sortBy = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 90, language);
        currency = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 91, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 92, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 93, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 94, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 95, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 96, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 97, language);
        message = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 98, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 101, language);
        endDate = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 102, language);
        period1 = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 103, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 104, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 105, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 106, language);
        data = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 107, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 108, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 109, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 110, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 111, language);
        numbering = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 112, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period1, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, data, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 115);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 118, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 119, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period1, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, data, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
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