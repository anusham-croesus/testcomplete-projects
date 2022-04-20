//USEUNIT CR1485_108_Common_functions



/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\2.1 Clients\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_108_Cli_DateDef_RepCR1905()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\\2.1 Clients\\", "CR1485_108_Cli_DateDef_RepCR1905()");
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    Log.Message("CR1905");
    Log.Message("Bug JIRA CROES-11541");
    Log.Message("JIRA CROES-9989 / CROES-12024");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 154);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        EnablePerformanceFeesGroupBoxForUser(userNameKEYNEJ);
        
        //Select the client
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientsNumbers.split("|"));
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 156);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 159, language);
        sortBy = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 160, language);
        currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 161, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 162, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 163, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 164, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 165, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 166, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 167, language);
        message = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 168, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 171, language);
        startDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 172, language);
        endDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 173, language);
        period = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 174, language);
        period1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 175, language);
        period2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 176, language);
        period3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 177, language);
        period4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 178, language);
        period5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 179, language);
        period6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 180, language);
        period7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 181, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 182, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 183, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 184, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 185, language);
        customAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 186, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 187, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 188, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 189, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 190, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 191, language);
        numbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 192, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 193, language);
        checkGraphsRegionAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 194, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, performanceCalculations, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering, checkFundBreakdownClassBreakdown, startDate, checkGraphsRegionAllocation);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 197);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 200, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 201, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, performanceCalculations, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering, checkFundBreakdownClassBreakdown, startDate, checkGraphsRegionAllocation);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        RestoreToDefaultPerformanceFeesGroupBoxForUser(userNameKEYNEJ);
        Terminate_CroesusProcess();
    }
    
}
