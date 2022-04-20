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

function CR1485_005_Acc_ExcluData_Period_1Y2Y4Y5Y_PTWNet_PMWNet_IndDJII_StdDev_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 172);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 174);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 177, language);
        sortBy = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 178, language);
        currency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 179, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 180, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 181, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 182, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 183, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 184, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 185, language);
        message = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 186, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 189, language);
        endDate = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 190, language);
        period = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 191, language);
        period1 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 192, language);
        period2 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 193, language);
        period3 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 194, language);
        period4 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 195, language);
        period5 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 196, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 197, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 198, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 199, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 200, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 201, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 202, language);
        type = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 203, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 204, language);
        customAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 205, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 206, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 207, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 208, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 209, language);
        checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 210, language);
        checkRiskMeasurement3YearStandardDeviation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 211, language);
        checkRiskMeasurement3YearStandDevIndices = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 212, language);
        checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 213, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 214, language);
        checkDisplayDetails = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 215, language);
        numbering = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 216, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, performanceCalculations, checkDisplayDetails, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 219);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 222, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 223, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, performanceCalculations, checkDisplayDetails, numbering);
        
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