//USEUNIT CR1485_Common_functions
//USEUNIT DBA



function ActivatePrefs(userName)
{
    Activate_Inactivate_Pref(userName, "PREF_REPORT_PORTF_OVERVIEW", "YES", vServerReportsCR1485);
    //Activate_Inactivate_Pref(userName, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(asOfDate, numbering, checkDisplayCheckDigit)
{
    
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    Get_WinParameters_ChkDisplayCheckDigit().set_IsChecked(checkDisplayCheckDigit);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}
