//USEUNIT CR1485_108_Common_functions



/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\2. Clients\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_108_Cli_Exclu_DateDef_PerDef_IndexTSE35_60_AssAllFirm_TWRNetGrossMWRNet_NumVis_ClassBrk()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\\2. Clients\\", "CR1485_108_Cli_Exclu_DateDef_PerDef_IndexTSE35_60_AssAllFirm_TWRNetGrossMWRNet_NumVis_ClassBrk()");
    Log.Message("JIRA CROES-9989 / CROES-12024");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 54);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 56);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 59, language);
        sortBy = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 60, language);
        currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 61, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 62, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 63, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 64, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 65, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 66, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 67, language);
        message = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 68, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 71, language);
        startDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 93, language);
        endDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 72, language);
        period = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 73, language);
        period1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 74, language);
        period2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 75, language);
        period3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 76, language);
        period4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 77, language);
        period5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 78, language);
        period6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 79, language);
        period7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 80, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 81, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 82, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 83, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 84, language);
        customAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 85, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 86, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 87, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 88, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 89, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 90, language);
        numbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 91, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 92, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, performanceCalculations, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering, checkFundBreakdownClassBreakdown, startDate);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 95);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 98, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 99, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, performanceCalculations, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering, checkFundBreakdownClassBreakdown, startDate);
        
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