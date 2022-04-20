//USEUNIT CR1485_108_Common_functions



/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\1. Relations
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_108_Rel_Exclu_DateDef_PerDef_AssAllFirm_TWRNet_NumVis()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\\1. Relations\\", "CR1485_108_Rel_Exclu_DateDef_PerDef_AssAllFirm_TWRNet_NumVis()");
    Log.Message("JIRA CROES-9989 / CROES-12024");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 10, language);
        currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 17, language);
        message = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 21, language);
        startDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 43, language);
        endDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 22, language);
        period = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 23, language);
        period1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 24, language);
        period2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 25, language);
        period3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 26, language);
        period4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 27, language);
        period5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 28, language);
        period6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 29, language);
        period7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 30, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 31, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 32, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 33, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 34, language);
        customAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 35, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 36, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 37, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 38, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 39, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 40, language);
        numbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 41, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 42, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, performanceCalculations, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering, checkFundBreakdownClassBreakdown, startDate);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 45);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 48, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 49, language);
        
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