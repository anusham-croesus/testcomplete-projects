//USEUNIT CR1485_087_Common_functions



/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\87. ANALYSE RENDEMENTRISQUE\2. Clients\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_087_Cli_Exclu_DateModf_TWRNet_Gross_IndexNASDAQ_DJII_NumVis_AddBranch()
{
    Log.Message("CR1318");
    Log.Message("JIRA CROES-6336");
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\87. ANALYSE RENDEMENTRISQUE\\2. Clients\\", "CR1485_087_Cli_Exclu_DateModf_TWRNet_Gross_IndexNASDAQ_DJII_NumVis_AddBranch()");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 42);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 44);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 47, language);
        sortBy = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 48, language);
        currency = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 49, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 50, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 51, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 52, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 53, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 54, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 55, language);
        message = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 56, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 59, language);
        startDate = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 60, language);
        endDate = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 61, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 62, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 63, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 64, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 65, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 66, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 67, language);
        numbering = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 68, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 71);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 74, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 75, language);
        
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