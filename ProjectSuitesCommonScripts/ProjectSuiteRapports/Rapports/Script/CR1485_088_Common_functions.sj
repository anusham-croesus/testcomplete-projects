﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_FBN_FISCAL_REPORT", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_CASH_INT", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(startDate, endDate, numbering, checkIncludeAmortizedIncome)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    if (Get_WinParameters_ChkIncludeAmortizedIncome().IsEnabled)
        Get_WinParameters_ChkIncludeAmortizedIncome().set_IsChecked(aqString.ToUpper(checkIncludeAmortizedIncome) == "VRAI" || aqString.ToUpper(checkIncludeAmortizedIncome) == "TRUE");    
    
    Get_WinParameters_BtnOK().Click();
}