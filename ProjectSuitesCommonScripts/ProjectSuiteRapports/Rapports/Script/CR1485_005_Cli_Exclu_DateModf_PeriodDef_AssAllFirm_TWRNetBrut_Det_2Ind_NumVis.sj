//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_005_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_005_Cli_Exclu_DateModf_PeriodDef_AssAllFirm_TWRNetBrut_Det_2Ind_NumVis()
{
    Log.Message("Bug JIRA CROES-7706");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 228);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Activate pref for Bug JIRA CROES-7706
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_NON_ANNUALIZED_RETURN", "YES", vServerReportsCR1485);
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 230);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 233, language);
        sortBy = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 234, language);
        currency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 235, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 236, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 237, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 238, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 239, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 240, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 241, language);
        message = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 242, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 245, language);
        endDate = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 246, language);
        period = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 247, language);
        period1 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 248, language);
        period2 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 249, language);
        period3 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 250, language);
        period4 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 251, language);
        period5 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 252, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 253, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 254, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 255, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 256, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 257, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 258, language);
        type = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 259, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 260, language);
        customAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 261, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 262, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 263, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 264, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 265, language);
        checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 266, language);
        checkRiskMeasurement3YearStandardDeviation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 267, language);
        checkRiskMeasurement3YearStandDevIndices = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 268, language);
        checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 269, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 270, language);
        checkDisplayDetails = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 271, language);
        numbering = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 272, language);
        CheckIncludeNonAnnualizedReturns = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 273, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, performanceCalculations, checkDisplayDetails, numbering, CheckIncludeNonAnnualizedReturns);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 276);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 279, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 280, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, performanceCalculations, checkDisplayDetails, numbering, CheckIncludeNonAnnualizedReturns);
        
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
        
        //Inactivate pref of Bug JIRA CROES-7706
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_NON_ANNUALIZED_RETURN", "NO", vServerReportsCR1485);
    }
    
}