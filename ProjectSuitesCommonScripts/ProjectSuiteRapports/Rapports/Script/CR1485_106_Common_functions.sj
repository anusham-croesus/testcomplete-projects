﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_FBN_FISCAL_REPORT", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNFISC_GAIN_PERTE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    
    //Rendre le rapport visible pour le module Comptes
    MakeReportVisibleForAccounts("FBNFISC_GAIN_PERTE", vServerReportsCR1485);
}



function SetReportParameters(startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, costCalculation, transactionDate, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    if (Get_WinParameters_ChkIncludeInterestAndDividends().IsEnabled)
        Get_WinParameters_ChkIncludeInterestAndDividends().set_IsChecked(aqString.ToUpper(checkIncludeInterestAndDividends) == "VRAI" || aqString.ToUpper(checkIncludeInterestAndDividends) == "TRUE");
    
    if (Get_WinParameters_ChkIncludeTotalGainAndLossBreakdown().IsEnabled)
        Get_WinParameters_ChkIncludeTotalGainAndLossBreakdown().set_IsChecked(aqString.ToUpper(checkIncludeTotalGainAndLossBreakdown) == "VRAI" || aqString.ToUpper(checkIncludeTotalGainAndLossBreakdown) == "TRUE");
    
    Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", costCalculation], 10).set_IsChecked(true);
    
    Get_WinParameters_GrpTransactionDate().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", transactionDate], 10).set_IsChecked(true);
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    Get_WinParameters_BtnOK().Click();
}
