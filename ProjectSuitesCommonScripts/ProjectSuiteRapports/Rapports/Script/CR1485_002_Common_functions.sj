//USEUNIT CR1485_Common_functions


function ActivatePrefs(prefUserName)
{
    if (prefUserName == undefined) prefUserName = userNameReportsCR1485;
    Activate_Inactivate_Pref(prefUserName, "PREF_SUMMARY_DETAIL_BY_ACCOUNT", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_REPORT_GAIN_PERTE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
}



function SetReportParameters(checkPreviousCalendarYear, startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity, checkOneReportPerAccount, costCalculation, transactionDate, numbering, checkCostDisplayedTheoreticalValue, checkIncludeNonregisteredAccountsOnly)
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
    
    if (!Get_ModulesBar_BtnAccounts().IsChecked.OleValue)
        CompareProperty(Get_WinParameters_ChkOneReportPerAccount().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkOneReportPerAccount), true, lmError);
        
    Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", costCalculation], 10).set_IsChecked(true);
    
    Get_WinParameters_GrpTransactionDate().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", transactionDate], 10).set_IsChecked(true);
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    if (checkCostDisplayedTheoreticalValue != undefined)
        Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue().set_IsChecked(aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "VRAI" || aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "TRUE");
        
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}
