//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_GP_NON_REALISES", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function ActivatePDFFirmPrefs()
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SET_USER_REPORT_TITLE", "SYSADM,FIRMADM,BRMAN", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("Firm_1", "PREF_PATH_PDF", REPORTS_FILES_FOLDER_PATH, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("Firm_1", "PREF_PDF_NAMING_CONVENTION", "RJ", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_USE_PDF_NAMING_CONVENTION", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}



function DesactivatePDFFirmPrefs()
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SET_USER_REPORT_TITLE", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("Firm_1", "PREF_PATH_PDF", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("Firm_1", "PREF_PDF_NAMING_CONVENTION", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_USE_PDF_NAMING_CONVENTION", "NO", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}



function SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount)
{
    Log.Message("JIRA CROES-8424");
    if (client == "CIBC") Log.Message("JIRA CROES-9837");
    
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();

    SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
        
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
    
    if (Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().Exists && Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().IsEnabled)
        Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().set_IsChecked(aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "VRAI" || aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "TRUE");    
    
    if (client != "RJ"){
        if (Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().IsEnabled)
            Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().set_IsChecked(aqString.ToUpper(checkFundBreakdownClassBreakdown) == "VRAI" || aqString.ToUpper(checkFundBreakdownClassBreakdown) == "TRUE");
    
        if (Get_WinParameters_GrpFundBreakdown_ChkAppendix().IsEnabled)
            Get_WinParameters_GrpFundBreakdown_ChkAppendix().set_IsChecked(aqString.ToUpper(checkFundBreakdownAppendix) == "VRAI" || aqString.ToUpper(checkFundBreakdownAppendix) == "TRUE");
    }
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    if (Get_WinParameters_ChkOneReportPerAccount().Exists && Get_WinParameters_ChkOneReportPerAccount().IsEnabled)
        Get_WinParameters_ChkOneReportPerAccount().set_IsChecked(aqString.ToUpper(checkOneReportPerAccount) == "VRAI" || aqString.ToUpper(checkOneReportPerAccount) == "TRUE");
    
    Get_WinParameters_BtnOK().Click();
}