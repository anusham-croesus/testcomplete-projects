//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_INVESTMENT_OBJ", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_SHOW_INVOBJAUDIT", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(codes, sortBy, numbering, checkAllRecords)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SelectComboBoxItem(Get_WinParameters_CmbCodes(), codes);
    
    SelectComboBoxItem(Get_WinParameters_CmbSortBy2(), sortBy);
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering3(), numbering);
    
    if (Get_WinParameters_ChkAllRecords().IsEnabled)
        Get_WinParameters_ChkAllRecords().set_IsChecked(aqString.ToUpper(checkAllRecords) == "VRAI" || aqString.ToUpper(checkAllRecords) == "TRUE");

    Get_WinParameters_BtnOK().Click();
}