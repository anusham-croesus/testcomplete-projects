//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_SHOW_REPORT_EVAL_SIMPLE_WEB", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_SIMPLE_WEB", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(asOfDate, checkIncludeGraph, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue)
{
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
        
    if (Get_WinParameters_GrpGroupBy_ChkAccountCurrency().Exists && Get_WinParameters_GrpGroupBy_ChkAccountCurrency().IsEnabled)
        Get_WinParameters_GrpGroupBy_ChkAccountCurrency().set_IsChecked(aqString.ToUpper(checkGroupByAccountCurrency) == "VRAI" || aqString.ToUpper(checkGroupByAccountCurrency) == "TRUE");
        
    Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", costCalculation], 10).set_IsChecked(true);
        
    if (Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue().IsEnabled)
        Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue().set_IsChecked(aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "VRAI" || aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "TRUE");
        
    Get_WinParameters_BtnOK().Click();
}