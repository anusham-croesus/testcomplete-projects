//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_FBN_FISCAL_REPORT", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_ACC_INT_TRAN", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_QUARTERLY_REPORT_GP1859", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    
    //Rendre le rapport visible pour le module Comptes
    MakeReportVisibleForAccounts("FBNFISC_ACC_INT_TRAN", vServerReportsCR1485);
}



function SetReportParameters(startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    if (Get_WinParameters_ChkGroupByRecord().IsEnabled)
        Get_WinParameters_ChkGroupByRecord().set_IsChecked(aqString.ToUpper(checkGroupByRecord) == "VRAI" || aqString.ToUpper(checkGroupByRecord) == "TRUE");
        
    if (Get_WinParameters_ChkGroupByTransactionType().IsEnabled)
        Get_WinParameters_ChkGroupByTransactionType().set_IsChecked(aqString.ToUpper(checkGroupByTransactionType) == "VRAI" || aqString.ToUpper(checkGroupByTransactionType) == "TRUE");
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    Get_WinParameters_BtnOK().Click();
}