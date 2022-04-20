//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs(prefUserName)
{
    if (prefUserName == undefined)
        prefUserName = userNameReportsCR1485;
    
    Activate_Inactivate_Pref(prefUserName, "PREF_REPORT_ASSETS_UNDER_MGT", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(asOfDate, checkAllRecords, checkIncludeGraph, sortBy, nameOrFullName, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering, checkDisplayCheckDigit)
{
    Log.Message("Bug JIRA CROES-8112");
    
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
    
    if (Get_WinParameters_ChkAllRecords().IsEnabled)
        Get_WinParameters_ChkAllRecords().set_IsChecked(aqString.ToUpper(checkAllRecords) == "VRAI" || aqString.ToUpper(checkAllRecords) == "TRUE");
    
    if (Get_WinParameters_ChkIncludeGraph().IsEnabled)
        Get_WinParameters_ChkIncludeGraph().set_IsChecked(aqString.ToUpper(checkIncludeGraph) == "VRAI" || aqString.ToUpper(checkIncludeGraph) == "TRUE");
    
    SelectComboBoxItem(Get_WinParameters_GrpOrder_CmbSortBy(), sortBy);
    
    Get_WinParameters_Grp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", nameOrFullName], 10).set_IsChecked(true);
        
    Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).set_IsChecked(true);
    
    Delay(200);
    
    if (Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().Exists && Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(), customAllocation);
    
    if (Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().Exists && Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().IsEnabled)
        Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().set_IsChecked(aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "VRAI" || aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "TRUE");    
    
    if (client != "RJ"){
        if (Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().IsEnabled)
            Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().set_IsChecked(aqString.ToUpper(checkFundBreakdownClassBreakdown) == "VRAI" || aqString.ToUpper(checkFundBreakdownClassBreakdown) == "TRUE");
    }
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    if (checkDisplayCheckDigit != undefined)
        Get_WinParameters_ChkDisplayCheckDigit().set_IsChecked(aqString.ToUpper(checkDisplayCheckDigit) == "VRAI" || aqString.ToUpper(checkDisplayCheckDigit) == "TRUE");
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}