//USEUNIT CR1485_087_Common_functions




/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_087_Acc_DateModf_TWRGross_IndexSP500_TSE300_60_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 80);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 82);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 85, language);
        sortBy = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 86, language);
        currency = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 87, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 88, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 89, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 90, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 91, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 92, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 93, language);
        message = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 94, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 97, language);
        startDate = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 98, language);
        endDate = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 99, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 100, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 101, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 102, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 103, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 104, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 105, language);
        numbering = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 106, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 109);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 112, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 113, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        RestorePrefs();
        Terminate_CroesusProcess();
    }
    
}