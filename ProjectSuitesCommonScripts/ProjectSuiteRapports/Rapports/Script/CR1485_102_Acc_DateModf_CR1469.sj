//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_102_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : "P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\102. PERFORMANCE DU PORTEFEUILLE (SOMMAIRE DES COMPTES)\3.3 Comptes"
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Abdel Matmat
*/

function CR1485_102_Acc_DateModf_CR1469()
{
    
    try {
      
        Log.Message("CR1469");
        Log.Message("JIRA CROES-11602");
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                
        var reportName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 413, language);
        var arrayOfReportsNames = reportName.split("|");      
        var accountsNumbers = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 415);
        var arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        Activate_Inactivate_PrefFirm("Firm_1", "PREF_REPORT_PERF_ACCOUNTSUMMARY", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("Firm_1", "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
        RestartServices(vServerReportsCR1485)
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select Accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 417);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Select the third report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 420, language);
        sortBy = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 421, language);
        currency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 422, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 423, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 424, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 425, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 426, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 427, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 428, language);
        message = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 429, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values Report 3
        CheckExcludeDataPrecedingTheManagementStartDate3 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 475, language);
        endDate3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 476, language);
        period_3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 477, language);
        /*period1_3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 478, language);
        period2_3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 479, language);
        period3_3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 480, language);
        period4_3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 481, language);
        period5_3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 482, language);*/
        checkDisplayDefaultIndices3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 483, language);
        indicesToBeChecked3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 484, language);
        checkUseIndexBaseCurrency3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 485, language);
        checkTimeWeightedNetOfFees3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 486, language);
        checkTimeWeightedGrossOfFees3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 487, language);
        checkMoneyWeightedNetOfFees3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 488, language);
        performanceCalculations3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 489, language);
        numbering3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 490, language);
        
        SetReportParameters3(CheckExcludeDataPrecedingTheManagementStartDate3, endDate3, period_3, /*period1_3, period2_3, period3_3, period4_3, period5_3,*/ checkDisplayDefaultIndices3, indicesToBeChecked3, checkUseIndexBaseCurrency3, checkTimeWeightedNetOfFees3, checkTimeWeightedGrossOfFees3, checkMoneyWeightedNetOfFees3, performanceCalculations3, numbering3);
        
        //Select the second report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        
        checkPreviousCalendarYear2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 459, language);
        startDate2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 460, language);
        endDate2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 461, language);
        checkIncludeInterestAndDividends2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 462, language);
        checkIncludeTotalGainAndLossBreakdown2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 463, language);
        checkIncludeNonregisteredAccountsOnly2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 464, language);
        checkGroupBySecurity2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 465, language);
        checkOneReportPerAccount2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 466, language);
        costCalculation2 = (client == "US")? GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 468, language): GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 467, language);
        transactionDate2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 469, language);
        numbering2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 470, language);
        checkCostDisplayedTheoreticalValue2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 471, language);
        
        SetReportParameters2(checkPreviousCalendarYear2, startDate2, endDate2, checkIncludeInterestAndDividends2, checkIncludeTotalGainAndLossBreakdown2, checkGroupBySecurity2, checkOneReportPerAccount2, costCalculation2, transactionDate2, numbering2, /*checkCostDisplayedTheoreticalValue2,*/ checkIncludeNonregisteredAccountsOnly2);
        
        
        //Select the first report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Parameters values Report 1
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 433, language);
        endDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 434, language);
        period = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 435, language);
        /*period1 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 436, language);
        period2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 437, language);
        period3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 438, language);
        period4 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 439, language);
        period5 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 440, language);*/
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 441, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 442, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 443, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 444, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 445, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 446, language);
        type = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 447, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 448, language);
        customAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 449, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 450, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 451, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 452, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 453, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 454, language);
        numbering = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 455, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, /*period1, period2, period3, period4, period5,*/ checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report ****************************************************************************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 493);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Select the third report (Transactions ACB et Quantité) and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 496, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 497, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters3(CheckExcludeDataPrecedingTheManagementStartDate3, endDate3, period_3, /*period1_3, period2_3, period3_3, period4_3, period5_3,*/ checkDisplayDefaultIndices3, indicesToBeChecked3, checkUseIndexBaseCurrency3, checkTimeWeightedNetOfFees3, checkTimeWeightedGrossOfFees3, checkMoneyWeightedNetOfFees3, performanceCalculations3, numbering3);
        
        //Select the second report (Gains et Pertes Réalisés) and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        
        //Parameters values (same as for the English report)
        SetReportParameters2(checkPreviousCalendarYear2, startDate2, endDate2, checkIncludeInterestAndDividends2, checkIncludeTotalGainAndLossBreakdown2, checkGroupBySecurity2, checkOneReportPerAccount2, costCalculation2, transactionDate2, numbering2, /*checkCostDisplayedTheoreticalValue2,*/ checkIncludeNonregisteredAccountsOnly2);
        
        //Select the first (Transactions) report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
         //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period,/* period1, period2, period3, period4, period5,*/ checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
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

function SetReportParameters3(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, /*period1, period2, period3, period4, period5,*/ checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering)
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
    //Mettre en commentaire totes les périodes pour couvrir l'anomalie d'affichage des périodes fixe automatiquement
    
   /* SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod1(), period1);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod2(), period2);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod3(), period3);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod4(), period4);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod5(), period5);*/
    
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
    
    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedNetOfFees) == "TRUE");    
    
    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedGrossOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedGrossOfFees) == "TRUE");    
    
    if (Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkMoneyWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkMoneyWeightedNetOfFees) == "TRUE");    
    
    Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).set_IsChecked(true);
    
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    Get_WinParameters_BtnOK().Click();
}

function SetReportParameters2(checkPreviousCalendarYear, startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity, checkOneReportPerAccount, costCalculation, transactionDate, numbering, checkCostDisplayedTheoreticalValue, checkIncludeNonregisteredAccountsOnly)
{
   if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();

    if (Get_WinParameters_ChkPreviousCalendarYear().IsEnabled)
        Get_WinParameters_ChkPreviousCalendarYear().set_IsChecked(aqString.ToUpper(checkPreviousCalendarYear) == "VRAI" || aqString.ToUpper(checkPreviousCalendarYear) == "TRUE");
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    if (Get_WinParameters_ChkIncludeInterestAndDividends().IsEnabled)
        Get_WinParameters_ChkIncludeInterestAndDividends().set_IsChecked(aqString.ToUpper(checkIncludeInterestAndDividends) == "VRAI" || aqString.ToUpper(checkIncludeInterestAndDividends) == "TRUE");
    
    if (Get_WinParameters_ChkIncludeTotalGainAndLossBreakdown().IsEnabled)
        Get_WinParameters_ChkIncludeTotalGainAndLossBreakdown().set_IsChecked(aqString.ToUpper(checkIncludeTotalGainAndLossBreakdown) == "VRAI" || aqString.ToUpper(checkIncludeTotalGainAndLossBreakdown) == "TRUE");
    
    if (checkIncludeNonregisteredAccountsOnly != undefined)
        Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().set_IsChecked(aqString.ToUpper(checkIncludeNonregisteredAccountsOnly) == "VRAI" || aqString.ToUpper(checkIncludeNonregisteredAccountsOnly) == "TRUE");
        
    if (Get_WinParameters_ChkGroupBySecurity().IsEnabled)
        Get_WinParameters_ChkGroupBySecurity().set_IsChecked(aqString.ToUpper(checkGroupBySecurity) == "VRAI" || aqString.ToUpper(checkGroupBySecurity) == "TRUE");
        
    if (Get_WinParameters_ChkOneReportPerAccount().Exists && Get_WinParameters_ChkOneReportPerAccount().IsEnabled)
        Get_WinParameters_ChkOneReportPerAccount().set_IsChecked(aqString.ToUpper(checkOneReportPerAccount) == "VRAI" || aqString.ToUpper(checkOneReportPerAccount) == "TRUE");
    
   // if (!Get_ModulesBar_BtnAccounts().IsChecked.OleValue)
     //   CompareProperty(Get_WinParameters_ChkOneReportPerAccount().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkOneReportPerAccount), true, lmError);
        
    Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", costCalculation], 10).set_IsChecked(true);
    
    Get_WinParameters_GrpTransactionDate().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", transactionDate], 10).set_IsChecked(true);
    
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    if (checkCostDisplayedTheoreticalValue != undefined)
        Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue().set_IsChecked(aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "VRAI" || aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "TRUE");
        
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}

function SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period,/* period1, period2, period3, period4, period5,*/ checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering, period6)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsEnabled)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().set_IsChecked(GetBooleanValue(CheckExcludeDataPrecedingTheManagementStartDate));
    
    SetDateInDateTimePicker(Get_WinParameters_GrpPeriod_DtpEndDate(), endDate);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod(), period);
    
   /* SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod1(), period1);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod2(), period2);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod3(), period3);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod4(), period4);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod5(), period5);*/
    
    if (period6 != undefined)
        SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod6(), period6);
    
    if (Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsEnabled)
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().set_IsChecked(GetBooleanValue(checkDisplayDefaultIndices));
    
    if (Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().IsEnabled)
        Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().set_IsChecked(GetBooleanValue(checkUseIndexBaseCurrency));
    
    if (Get_WinParameters_GrpGraphs_ChkAssetAllocation().IsEnabled)
        Get_WinParameters_GrpGraphs_ChkAssetAllocation().set_IsChecked(GetBooleanValue(checkGraphsAssetAllocation));
    
    if (Get_WinParameters_GrpGraphs_ChkInvestmentObjective().IsEnabled)
        Get_WinParameters_GrpGraphs_ChkInvestmentObjective().set_IsChecked(GetBooleanValue(checkGraphsInvestmentObjective));
    
    if (Get_WinParameters_GrpGraphs_ChkPortfolioPerformance().IsEnabled)
        Get_WinParameters_GrpGraphs_ChkPortfolioPerformance().set_IsChecked(GetBooleanValue(checkGraphsPortfolioPerformance));
    
    Delay(200);    
    
    if (Get_WinParameters_GrpType_CmbType().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpType_CmbType(), type);
    
    if (Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).IsEnabled)
        Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).set_IsChecked(true);
    
    Delay(200);
    
    if (Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().Exists && Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(), customAllocation);
    
    if (Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().Exists && Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().IsEnabled)
        Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().set_IsChecked(GetBooleanValue(checkUseTheSpecifiedInvestmentObjective));
    
    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().set_IsChecked(GetBooleanValue(checkTimeWeightedNetOfFees));
    
    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().set_IsChecked(GetBooleanValue(checkTimeWeightedGrossOfFees));
    
    if (Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().set_IsChecked(GetBooleanValue(checkMoneyWeightedNetOfFees));
    
    if (Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).IsEnabled)
        Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).set_IsChecked(true);
    
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    CompareProperty(Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue, cmpEqual, GetBooleanValue(CheckExcludeDataPrecedingTheManagementStartDate), true, lmError);
    CompareProperty(Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkDisplayDefaultIndices), true, lmError);
    CompareProperty(Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkUseIndexBaseCurrency), true, lmError);
    CompareProperty(Get_WinParameters_GrpGraphs_ChkAssetAllocation().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkGraphsAssetAllocation), true, lmError);
    CompareProperty(Get_WinParameters_GrpGraphs_ChkInvestmentObjective().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkGraphsInvestmentObjective), true, lmError);
    CompareProperty(Get_WinParameters_GrpGraphs_ChkPortfolioPerformance().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkGraphsPortfolioPerformance), true, lmError);
    CompareProperty(Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).IsChecked.OleValue, cmpEqual, true, true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkTimeWeightedNetOfFees), true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkTimeWeightedGrossOfFees), true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkMoneyWeightedNetOfFees), true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).IsChecked.OleValue, cmpEqual, true, true, lmError);
    
    CheckIndices(indicesToBeChecked);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
    
    //Vérifier s'il y a eu affichage d'une ou plusieurs boîtes de dialogue inattendues
    SetAutoTimeOut(1000);
    CheckUnexpectedDialogBoxes(Get_WinParameters());
    SetAutoTimeOut(1000);
    if (Get_WinParameters().Exists && Get_WinParameters_BtnOK().Exists)
        Get_WinParameters_BtnOK().Click();
    RestoreAutoTimeOut();
}
