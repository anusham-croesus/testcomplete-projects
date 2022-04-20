//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_VC_TL", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TAX_LOT", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, sortBy)
{
    Log.Message("JIRA CROES-8424");
    if (client == "CIBC") Log.Message("JIRA CROES-9837");
    
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_DtpAsOf().Exists)
        SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
    
    if (Get_WinParameters_ChkIncludeGraph().IsEnabled)
        Get_WinParameters_ChkIncludeGraph().set_IsChecked(aqString.ToUpper(checkIncludeGraph) == "VRAI" || aqString.ToUpper(checkIncludeGraph) == "TRUE");
    
    Delay(200);
    
    if (Get_WinParameters_GrpType_CmbType().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpType_CmbType(), type);
    
    if (Get_WinParameters_GrpType_ChkComparative().IsEnabled)
        Get_WinParameters_GrpType_ChkComparative().set_IsChecked(aqString.ToUpper(checkComparative) == "VRAI" || aqString.ToUpper(checkComparative) == "TRUE");
    
    if (Get_WinParameters_GrpGroupBy_ChkRegion().IsEnabled)
        Get_WinParameters_GrpGroupBy_ChkRegion().set_IsChecked(aqString.ToUpper(checkGroupByRegion) == "VRAI" || aqString.ToUpper(checkGroupByRegion) == "TRUE");
    
    if (Get_WinParameters_GrpGroupBy_ChkIndustryCode().IsEnabled)
        Get_WinParameters_GrpGroupBy_ChkIndustryCode().set_IsChecked(aqString.ToUpper(checkGroupByIndustryCode) == "VRAI" || aqString.ToUpper(checkGroupByIndustryCode) == "TRUE");
    
    Delay(200);
    
    if (Get_WinParameters_GrpGroupBy_CmbIndustryCode().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpGroupBy_CmbIndustryCode(), groupByIndustryCode);
    
    if (Get_WinParameters_GrpGroupBy_ChkAccountCurrency().Exists && Get_WinParameters_GrpGroupBy_ChkAccountCurrency().IsEnabled)
        Get_WinParameters_GrpGroupBy_ChkAccountCurrency().set_IsChecked(aqString.ToUpper(checkGroupByAccountCurrency) == "VRAI" || aqString.ToUpper(checkGroupByAccountCurrency) == "TRUE");
    
    if (Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue().IsEnabled)
        Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue().set_IsChecked(aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "VRAI" || aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "TRUE");
    
    Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).set_IsChecked(true);
    
    Delay(200);
    
    if (Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().Exists && Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(), customAllocation);
    
    if (Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().Exists && Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().IsEnabled)
        Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().set_IsChecked(aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "VRAI" || aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "TRUE");    
    
    if (client != "RJ"){
        if (Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().IsEnabled)
            Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().set_IsChecked(aqString.ToUpper(checkFundBreakdownClassBreakdown) == "VRAI" || aqString.ToUpper(checkFundBreakdownClassBreakdown) == "TRUE");
    
        if (Get_WinParameters_GrpFundBreakdown_ChkAppendix().IsEnabled)
            Get_WinParameters_GrpFundBreakdown_ChkAppendix().set_IsChecked(aqString.ToUpper(checkFundBreakdownAppendix) == "VRAI" || aqString.ToUpper(checkFundBreakdownAppendix) == "TRUE");
    }
    
    if (Get_WinParameters_CmbSortBy2().Exists){
        if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
            Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
        SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
        SelectComboBoxItem(Get_WinParameters_CmbSortBy2(), sortBy);
    }
    else
        SelectComboBoxItem(Get_WinParameters_CmbSortBy1(), sortBy);
    
    Get_WinParameters_BtnOK().Click();
}