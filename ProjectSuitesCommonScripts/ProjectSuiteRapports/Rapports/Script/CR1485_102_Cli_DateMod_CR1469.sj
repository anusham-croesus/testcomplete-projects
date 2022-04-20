//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_102_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : "P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\102. PERFORMANCE DU PORTEFEUILLE (SOMMAIRE DES COMPTES)\2.2 Clients"
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Abdel Matmat
*/

function CR1485_102_Cli_DateModf_CR1469()
{
    
    try {
      
        Log.Message("CR1469");
        Log.Message("JIRA CROES-11602");
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                
        var reportName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 314, language);
        var arrayOfReportsNames = reportName.split("|");      
        var clientsNumbers = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 316);
        var arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 318);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Select the third report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 321, language);
        sortBy = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 322, language);
        currency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 323, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 324, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 325, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 326, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 327, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 328, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 329, language);
        message = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 330, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values Report 3
        CheckExcludeDataPrecedingTheManagementStartDate3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 374, language);
        endDate3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 375, language);
        period_3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 376, language);
        period1_3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 377, language);
        period2_3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 378, language);
        period3_3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 379, language);
        period4_3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 380, language);
        period5_3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 381, language);
        checkDisplayDefaultIndices3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 382, language);
        indicesToBeChecked3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 383, language);
        checkUseIndexBaseCurrency3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 384, language);
        checkGraphsAssetAllocation3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 385, language);
        checkGraphsInvestmentObjective3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 386, language);
        checkGraphsPortfolioPerformance3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 387, language);
        type3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 388, language);
        assetAllocation3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 389, language);
        customAllocation3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 390, language);
        checkUseTheSpecifiedInvestmentObjective3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 391, language);
        checkTimeWeightedNetOfFees3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 392, language);
        checkTimeWeightedGrossOfFees3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 393, language);
        checkMoneyWeightedNetOfFees3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 394, language);
        checkRiskMeasurementStandardDeviation3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 395, language);
        checkRiskMeasurement3YearStandardDeviation3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 396, language);
        checkRiskMeasurement3YearStandDevIndices3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 397, language);
        checkRiskMeasurementSharpeIndex3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 398, language);
        performanceCalculations3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 399, language);
        checkDisplayDetails3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 400, language);
        numbering3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 401, language);
        
        SetReportParameters3(CheckExcludeDataPrecedingTheManagementStartDate3, endDate3, period_3, period1_3, period2_3, period3_3, period4_3, period5_3, checkDisplayDefaultIndices3, indicesToBeChecked3, checkUseIndexBaseCurrency3, checkGraphsAssetAllocation3, checkGraphsInvestmentObjective3, checkGraphsPortfolioPerformance3, type3, assetAllocation3, customAllocation3, checkUseTheSpecifiedInvestmentObjective3, checkTimeWeightedNetOfFees3, checkTimeWeightedGrossOfFees3, checkMoneyWeightedNetOfFees3, checkRiskMeasurementStandardDeviation3, checkRiskMeasurement3YearStandardDeviation3, checkRiskMeasurement3YearStandDevIndices3, checkRiskMeasurementSharpeIndex3, performanceCalculations3, checkDisplayDetails3, numbering3/*, CheckIncludeNonAnnualizedReturns*/);
        
        //Select the second report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 359, language);
        endDate2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 360, language);
        period1_2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 361, language);
        checkTimeWeightedNetOfFees2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 362, language);
        checkTimeWeightedGrossOfFees2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 363, language);
        checkMoneyWeightedNetOfFees2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 364, language);
        data2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 365, language);
        performanceCalculations2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 366, language);
        checkDisplayDefaultIndices2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 367, language);
        indicesToBeChecked2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 368, language);
        checkUseIndexBaseCurrency2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 369, language);
        numbering2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 370, language);
        
        SetReportParameters2(CheckExcludeDataPrecedingTheManagementStartDate2, endDate2, period1_2, checkTimeWeightedNetOfFees2, checkTimeWeightedGrossOfFees2, checkMoneyWeightedNetOfFees2, data2, performanceCalculations2, checkDisplayDefaultIndices2, indicesToBeChecked2, checkUseIndexBaseCurrency2, numbering2);
        
        
        //Select the first report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 333, language);
        endDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 334, language);
        period = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 335, language);
        period1 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 336, language);
        period2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 337, language);
        period3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 338, language);
        period4 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 339, language);
        period5 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 340, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 341, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 342, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 343, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 344, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 345, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 346, language);
        type = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 347, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 348, language);
        customAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 349, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 350, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 351, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 352, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 353, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 354, language);
        numbering = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 355, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report ****************************************************************************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 404);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Select the third report (Transactions ACB et Quantité) and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 407, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 408, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters3(CheckExcludeDataPrecedingTheManagementStartDate3, endDate3, period_3, period1_3, period2_3, period3_3, period4_3, period5_3, checkDisplayDefaultIndices3, indicesToBeChecked3, checkUseIndexBaseCurrency3, checkGraphsAssetAllocation3, checkGraphsInvestmentObjective3, checkGraphsPortfolioPerformance3, type3, assetAllocation3, customAllocation3, checkUseTheSpecifiedInvestmentObjective3, checkTimeWeightedNetOfFees3, checkTimeWeightedGrossOfFees3, checkMoneyWeightedNetOfFees3, checkRiskMeasurementStandardDeviation3, checkRiskMeasurement3YearStandardDeviation3, checkRiskMeasurement3YearStandDevIndices3, checkRiskMeasurementSharpeIndex3, performanceCalculations3, checkDisplayDetails3, numbering3/*, CheckIncludeNonAnnualizedReturns*/);
        
        //Select the second report (Gains et Pertes Réalisés) and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        
        //Parameters values (same as for the English report)
        SetReportParameters2(CheckExcludeDataPrecedingTheManagementStartDate2, endDate2, period1_2, checkTimeWeightedNetOfFees2, checkTimeWeightedGrossOfFees2, checkMoneyWeightedNetOfFees2, data2, performanceCalculations2, checkDisplayDefaultIndices2, indicesToBeChecked2, checkUseIndexBaseCurrency2, numbering2);
        
        //Select the first (Transactions) report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
         //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}

function SetReportParameters3(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, performanceCalculations, checkDisplayDetails, numbering, CheckIncludeNonAnnualizedReturns)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsEnabled)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().set_IsChecked(aqString.ToUpper(CheckExcludeDataPrecedingTheManagementStartDate) == "VRAI" || aqString.ToUpper(CheckExcludeDataPrecedingTheManagementStartDate) == "TRUE");
    
    SetDateInDateTimePicker(Get_WinParameters_GrpPeriod_DtpEndDate(), endDate);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod(), period);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod1(), period1);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod2(), period2);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod3(), period3);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod4(), period4);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod5(), period5);
    
    if (Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsEnabled)
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().set_IsChecked(aqString.ToUpper(checkDisplayDefaultIndices) == "VRAI" || aqString.ToUpper(checkDisplayDefaultIndices) == "TRUE");    
    
    Log.Message("JIRA CROES-10670 : Crash de l'application dans les paramètres de performance du portefeuille");
    CheckIndices(indicesToBeChecked);
    
    if (Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().IsEnabled)
        Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().set_IsChecked(aqString.ToUpper(checkUseIndexBaseCurrency) == "VRAI" || aqString.ToUpper(checkUseIndexBaseCurrency) == "TRUE");    
        
    if (Get_WinParameters_GrpGraphs_ChkAssetAllocation().IsEnabled)
        Get_WinParameters_GrpGraphs_ChkAssetAllocation().set_IsChecked(aqString.ToUpper(checkGraphsAssetAllocation) == "VRAI" || aqString.ToUpper(checkGraphsAssetAllocation) == "TRUE");    

    if (Get_WinParameters_GrpGraphs_ChkInvestmentObjective().IsEnabled)
        Get_WinParameters_GrpGraphs_ChkInvestmentObjective().set_IsChecked(aqString.ToUpper(checkGraphsInvestmentObjective) == "VRAI" || aqString.ToUpper(checkGraphsInvestmentObjective) == "TRUE");    
    
    if (Get_WinParameters_GrpGraphs_ChkPortfolioPerformance().IsEnabled)
        Get_WinParameters_GrpGraphs_ChkPortfolioPerformance().set_IsChecked(aqString.ToUpper(checkGraphsPortfolioPerformance) == "VRAI" || aqString.ToUpper(checkGraphsPortfolioPerformance) == "TRUE");    
    
    Delay(200);
    
    if (Get_WinParameters_GrpType_CmbType().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpType_CmbType(), type);
    
    Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).set_IsChecked(true);
    
    Delay(200);
    
    if (Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().Exists && Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(), customAllocation);
    
    if (Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().Exists && Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().IsEnabled)
        Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().set_IsChecked(aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "VRAI" || aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "TRUE");    
    
    if (Get_WinParameters_GrpRiskMeasurement_ChkStandardDeviation().IsEnabled)
        Get_WinParameters_GrpRiskMeasurement_ChkStandardDeviation().set_IsChecked(aqString.ToUpper(checkRiskMeasurementStandardDeviation) == "VRAI" || aqString.ToUpper(checkRiskMeasurementStandardDeviation) == "TRUE");    
    
    if (Get_WinParameters_GrpRiskMeasurement_Chk3YearStandardDeviation().IsEnabled)
        Get_WinParameters_GrpRiskMeasurement_Chk3YearStandardDeviation().set_IsChecked(aqString.ToUpper(checkRiskMeasurement3YearStandardDeviation) == "VRAI" || aqString.ToUpper(checkRiskMeasurement3YearStandardDeviation) == "TRUE");    

    if (Get_WinParameters_GrpRiskMeasurement_Chk3YearStandDevIndices().IsEnabled)
        Get_WinParameters_GrpRiskMeasurement_Chk3YearStandDevIndices().set_IsChecked(aqString.ToUpper(checkRiskMeasurement3YearStandDevIndices) == "VRAI" || aqString.ToUpper(checkRiskMeasurement3YearStandDevIndices) == "TRUE");    

    if (Get_WinParameters_GrpRiskMeasurement_ChkSharpeIndex().IsEnabled)
        Get_WinParameters_GrpRiskMeasurement_ChkSharpeIndex().set_IsChecked(aqString.ToUpper(checkRiskMeasurementSharpeIndex) == "VRAI" || aqString.ToUpper(checkRiskMeasurementSharpeIndex) == "TRUE");    
    
    Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).set_IsChecked(true);
    
    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedNetOfFees) == "TRUE");    

    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedGrossOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedGrossOfFees) == "TRUE");    

    if (Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkMoneyWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkMoneyWeightedNetOfFees) == "TRUE");
    
    if (Get_WinParameters_ChkDisplayDetails().IsEnabled)
        Get_WinParameters_ChkDisplayDetails().set_IsChecked(aqString.ToUpper(checkDisplayDetails) == "VRAI" || aqString.ToUpper(checkDisplayDetails) == "TRUE");
    
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    if (CheckIncludeNonAnnualizedReturns != undefined)
        Get_WinParameters_GrpNonAnnualizedReturns_ChkIncludeNonAnnualizedReturns().set_IsChecked(aqString.ToUpper(CheckIncludeNonAnnualizedReturns) == "VRAI" || aqString.ToUpper(CheckIncludeNonAnnualizedReturns) == "TRUE");
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}

function SetReportParameters2(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period1, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, data, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsEnabled)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().set_IsChecked(aqString.ToUpper(CheckExcludeDataPrecedingTheManagementStartDate) == "VRAI" || aqString.ToUpper(CheckExcludeDataPrecedingTheManagementStartDate) == "TRUE");
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate(), endDate);
    
    SelectComboBoxItem(Get_WinParameters_CmbPeriod1(), period1);
    
    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedNetOfFees) == "TRUE");    

    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedGrossOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedGrossOfFees) == "TRUE");    

    if (Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkMoneyWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkMoneyWeightedNetOfFees) == "TRUE");    

    Get_WinParameters_GrpData().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", data], 10).set_IsChecked(true);
        
    Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).set_IsChecked(true);
        
    if (Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsEnabled)
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().set_IsChecked(aqString.ToUpper(checkDisplayDefaultIndices) == "VRAI" || aqString.ToUpper(checkDisplayDefaultIndices) == "TRUE");    
    
    allIndicesCheckboxes = Get_WinParameters_GrpIndices_ChklstIndices().FindAllChildren("ClrClassName", "UniCheckBox", 10).toArray();
    for (i = 0; i < allIndicesCheckboxes.length; i++)
        allIndicesCheckboxes[i].set_IsChecked(false);
    arrayOfIndicesToBeChecked = new Array();
    if (Trim(indicesToBeChecked) != "")
        arrayOfIndicesToBeChecked = indicesToBeChecked.split("|");
    for (i = 0; i < arrayOfIndicesToBeChecked.length; i++)
        Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", Trim(arrayOfIndicesToBeChecked[i])], 10).set_IsChecked(true);
    
    if (Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().IsEnabled)
        Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().set_IsChecked(aqString.ToUpper(checkUseIndexBaseCurrency) == "VRAI" || aqString.ToUpper(checkUseIndexBaseCurrency) == "TRUE");
    
    SelectComboBoxItem(Get_WinParameters_CmbNumbering2(), numbering);
    
    Get_WinParameters_BtnOK().Click();
}