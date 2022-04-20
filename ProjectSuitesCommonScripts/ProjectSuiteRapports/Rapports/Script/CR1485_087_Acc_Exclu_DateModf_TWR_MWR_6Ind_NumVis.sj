//USEUNIT CR1485_087_Common_functions



/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\87. ANALYSE RENDEMENTRISQUE\3.2 Comptes\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-12--V9-croesus-co7x-1_8_1_650
*/

function CR1485_087_Acc_Exclu_DateModf_TWR_MWR_6Ind_NumVis()
{
    Log.Message("CR1318");
    Log.Message("JIRA CROES-6336");
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\87. ANALYSE RENDEMENTRISQUE\\3.2 Comptes\\", "CR1485_087_Acc_Exclu_DateModf_TWR_MWR_6Ind_NumVis()");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 158);
        
        
        //Activate Prefs
        ActivatePrefs(true);
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 160);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 163, language);
        sortBy = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 164, language);
        currency = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 165, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 166, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 167, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 168, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 169, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 170, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 171, language);
        message = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 172, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 175, language);
        startDate = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 176, language);
        endDate = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 177, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 178, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 179, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 180, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 181, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 182, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 183, language);
        numbering = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 184, language);
        expectedIsEnabledForCheckIncludeNonAnnualizedReturns = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 185, language);
        CheckIncludeNonAnnualizedReturns = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 186, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, performanceCalculations, numbering, expectedIsEnabledForCheckIncludeNonAnnualizedReturns, CheckIncludeNonAnnualizedReturns);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 189);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 192, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 193, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, performanceCalculations, numbering, expectedIsEnabledForCheckIncludeNonAnnualizedReturns, CheckIncludeNonAnnualizedReturns);
        
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