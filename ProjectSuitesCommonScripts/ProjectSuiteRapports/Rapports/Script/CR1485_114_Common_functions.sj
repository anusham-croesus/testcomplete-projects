//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    //Activate_Inactivate_PrefBranch("0", "PREF_REPORT_MSTAR_XRAY", "YES", vServerReportsCR1485);
    //Activate_Inactivate_PrefBranch("0", "PREF_REPORT_SHOW_MSTAR_XRAY", "1", vServerReportsCR1485);
    
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_MSTAR_XRAY", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_SHOW_MSTAR_XRAY", "1", vServerReportsCR1485);
}



function SetReportParameters(asOfDate, checkReportUnidentifiedSecurities, checkMorningstarDisclaimer, checkDisplayDefaultIndices, indicesToBeChecked)
{
    Log.Message("JIRA CROES-9754");
    Log.Message("JIRA CROES-10072");
    
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_DtpAsOf().Exists)
        SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
    
    if (!Get_WinParameters_ChkReportUnidentifiedSecurities().Exists)
        Log.Message("La case à cocher 'Report Unidentified Securities' n'existe pas : correction du bug JIRA CROES-7140");
    else if (Get_WinParameters_ChkReportUnidentifiedSecurities().IsEnabled)
        Get_WinParameters_ChkReportUnidentifiedSecurities().set_IsChecked(aqString.ToUpper(checkReportUnidentifiedSecurities) == "VRAI" || aqString.ToUpper(checkReportUnidentifiedSecurities) == "TRUE");    
    
    if (Get_WinParameters_ChkMorningstarDisclaimer().IsEnabled)
        Get_WinParameters_ChkMorningstarDisclaimer().set_IsChecked(aqString.ToUpper(checkMorningstarDisclaimer) == "VRAI" || aqString.ToUpper(checkMorningstarDisclaimer) == "TRUE");    
    
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
    
    Get_WinParameters_BtnOK().Click();
}