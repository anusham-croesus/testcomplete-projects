//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_POS_TOT_RETURN", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering)
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
    
    Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", costCalculation], 10).set_IsChecked(true);
    
    if (Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue().IsEnabled)
        Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue().set_IsChecked(aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "VRAI" || aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "TRUE");
    
    Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).set_IsChecked(true);
    
    Delay(200);
    
    if (Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().Exists && Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(), customAllocation);
    
    if (client != "RJ"){
        if (Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().IsEnabled)
            Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().set_IsChecked(aqString.ToUpper(checkFundBreakdownClassBreakdown) == "VRAI" || aqString.ToUpper(checkFundBreakdownClassBreakdown) == "TRUE");
    
        if (Get_WinParameters_GrpFundBreakdown_ChkAppendix().IsEnabled)
            Get_WinParameters_GrpFundBreakdown_ChkAppendix().set_IsChecked(aqString.ToUpper(checkFundBreakdownAppendix) == "VRAI" || aqString.ToUpper(checkFundBreakdownAppendix) == "TRUE");
    }
    
    if (Trim(VarToStr(numbering)) != ""){
        if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
            Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
        SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    }
        
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}


function SetReportParameters_ForeignProperty(startDateMonth, startDateYear, foreignPropertyValue, checkIncludeSummaryTable, checkIncludeNonregisteredAccountsOnly, PaginationValue, SummaryTableValue)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SelectComboBoxItem(Get_WinParameters_CmbStartDateMonth(), startDateMonth);
    
    SelectComboBoxItem(Get_WinParameters_CmbStartDateYear(), startDateYear);
    
    Get_WinParameters_GrpDetailedSectionValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", foreignPropertyValue], 10).set_IsChecked(true);
    
    if (Get_WinParameters_ChkIncludeSummaryTable().IsEnabled)
        Get_WinParameters_ChkIncludeSummaryTable().set_IsChecked(aqString.ToUpper(checkIncludeSummaryTable) == "VRAI" || aqString.ToUpper(checkIncludeSummaryTable) == "TRUE");
    
    if (checkIncludeNonregisteredAccountsOnly != undefined)
        Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().set_IsChecked(aqString.ToUpper(checkIncludeNonregisteredAccountsOnly) == "VRAI" || aqString.ToUpper(checkIncludeNonregisteredAccountsOnly) == "TRUE");
    
    SelectComboBoxItem(Get_WinParameters_CmbNumbering3(), PaginationValue);
    
    Get_WinParameters_GrpSummaryTableValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", SummaryTableValue], 10).set_IsChecked(true);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}


function SetReportParameters_ForeignPropertyDetailed(prevCalendarYear, startDate, endDate, sortBy, numbering)  {
    
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    
    //Previous Calendar Year
    if (Get_WinParameters_ChkPreviousCalendarYear().IsEnabled)
        Get_WinParameters_ChkPreviousCalendarYear().set_IsChecked(aqString.ToUpper(prevCalendarYear) == "VRAI" || aqString.ToUpper(prevCalendarYear) == "TRUE");
    
    //Start Date
    if (Get_WinParameters_DtpAsOf().Exists)
        SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
        
    //End Date
    if (Get_WinParameters_DtpAsOf().Exists)
        SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
        
    //Sort By
    SelectComboBoxItem(Get_WinParameters_CmbSortBy1(), sortBy);
    
    //Pagination
    SelectComboBoxItem(Get_WinParameters_CmbNumbering2(), numbering);
      
    //Close the window
    Get_WinParameters_BtnOK().Click();
}


function SetReportParameters_DistributionMaturity(asOfDate, numbering, costCalculation, checkDigit)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    //Au
    SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
    
    //Pagination
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    //Coût de calculation
    Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", costCalculation], 10).set_IsChecked(true);
    
    //Chiffre vérificateur
     if (Get_WinParameters_ChkDisplayCheckDigit().IsEnabled)
        Get_WinParameters_ChkDisplayCheckDigit().set_IsChecked(aqString.ToUpper(checkDigit) == "VRAI" || aqString.ToUpper(checkDigit) == "TRUE");
       
    Get_WinParameters_BtnOK().Click();
}