//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs(prefActivationUserName)
{
    if (prefActivationUserName == undefined) prefActivationUserName = userNameReportsCR1485;
    Activate_Inactivate_Pref(prefActivationUserName, "PREF_REPORT_PERF_SIMPLE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefActivationUserName, "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefActivationUserName, "PREF_SIMPLE_PERF_REPORT", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefActivationUserName, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkPerfStartEndValues, numbering)
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

    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedNetOfFees) == "TRUE");    

    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedGrossOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedGrossOfFees) == "TRUE");    

    if (Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkMoneyWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkMoneyWeightedNetOfFees) == "TRUE");    
    
    Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).set_IsChecked(true);
    
    if (Get_WinParameters_ChkPerfStartEndValues().IsEnabled)
        Get_WinParameters_ChkPerfStartEndValues().set_IsChecked(aqString.ToUpper(checkPerfStartEndValues) == "VRAI" || aqString.ToUpper(checkPerfStartEndValues) == "TRUE");
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}