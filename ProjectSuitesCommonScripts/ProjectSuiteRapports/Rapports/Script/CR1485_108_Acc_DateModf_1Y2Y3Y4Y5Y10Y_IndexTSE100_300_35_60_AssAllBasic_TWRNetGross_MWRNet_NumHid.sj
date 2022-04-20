//USEUNIT CR1485_108_Common_functions



/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\3. Comptes\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_108_Acc_DateModf_1Y2Y3Y4Y5Y10Y_IndexTSE100_300_35_60_AssAllBasic_TWRNetGross_MWRNet_NumHid()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\\3. Comptes\\", "CR1485_108_Acc_DateModf_1Y2Y3Y4Y5Y10Y_IndexTSE100_300_35_60_AssAllBasic_TWRNetGross_MWRNet_NumHid()");
    Log.Message("JIRA CROES-9989 / CROES-12024");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 104);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 106);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 109, language);
        sortBy = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 110, language);
        currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 111, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 112, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 113, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 114, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 115, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 116, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 117, language);
        message = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 118, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 121, language);
        startDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 143, language);
        endDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 122, language);
        period = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 123, language);
        period1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 124, language);
        period2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 125, language);
        period3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 126, language);
        period4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 127, language);
        period5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 128, language);
        period6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 129, language);
        period7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 130, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 131, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 132, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 133, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 134, language);
        customAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 135, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 136, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 137, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 138, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 139, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 140, language);
        numbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 141, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 142, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, performanceCalculations, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering, checkFundBreakdownClassBreakdown, startDate);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 145);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 148, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 149, language);
        
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