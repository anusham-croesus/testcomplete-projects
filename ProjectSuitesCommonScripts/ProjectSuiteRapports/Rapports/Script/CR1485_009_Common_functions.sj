//USEUNIT CR1485_Common_functions


function ActivatePrefs(prefUserName)
{
    if (prefUserName == undefined) prefUserName = userNameReportsCR1485;
    Activate_Inactivate_Pref(prefUserName, "PREF_REPORT_SUMMARY_PORTFOLIO", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_PERFORMANCE_REPORT_DETAILS", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering)
{
    if (client == "TD") Log.Message("Bug JIRA CROES-9975");
    
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsEnabled)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().set_IsChecked(GetBooleanValue(CheckExcludeDataPrecedingTheManagementStartDate));
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate(), endDate);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod(), period);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod1(), period1);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod2(), period2);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod3(), period3);
    
    if (Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).IsEnabled)
        Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).set_IsChecked(true);
    
    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().set_IsChecked(GetBooleanValue(checkTimeWeightedNetOfFees));
    
    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().set_IsChecked(GetBooleanValue(checkTimeWeightedGrossOfFees));
    
    if (Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().set_IsChecked(GetBooleanValue(checkMoneyWeightedNetOfFees));
    
    if (Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsEnabled)
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().set_IsChecked(GetBooleanValue(checkDisplayDefaultIndices));
    
    if (Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().IsEnabled)
        Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().set_IsChecked(GetBooleanValue(checkUseIndexBaseCurrency));
    
    if (Get_WinParameters_ChkDisplayDetails().Exists && Get_WinParameters_ChkDisplayDetails().IsVisible)
        Log.Error("Bug JIRA CROES-11274 : L'option Case à cocher 'Display Details' / 'Afficher le détail' est disponible, elle ne devrait pas.");
    
    Delay(500);
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    CheckIndices(indicesToBeChecked);
    
    CompareProperty(Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue, cmpEqual, GetBooleanValue(CheckExcludeDataPrecedingTheManagementStartDate), true, lmError);
    CompareProperty(Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkDisplayDefaultIndices), true, lmError);
    CompareProperty(Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkUseIndexBaseCurrency), true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkTimeWeightedNetOfFees), true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkTimeWeightedGrossOfFees), true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkMoneyWeightedNetOfFees), true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).IsChecked.OleValue, cmpEqual, true, true, lmError);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}
