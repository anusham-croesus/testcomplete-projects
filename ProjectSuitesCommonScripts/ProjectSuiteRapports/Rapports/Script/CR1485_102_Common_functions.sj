//USEUNIT CR1485_Common_functions



function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_SHOW_PERFSUMMARY", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_PERF_ACCOUNTSUMMARY", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering, period6)
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
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod1(), period1);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod2(), period2);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod3(), period3);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod4(), period4);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod5(), period5);
    
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
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
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
