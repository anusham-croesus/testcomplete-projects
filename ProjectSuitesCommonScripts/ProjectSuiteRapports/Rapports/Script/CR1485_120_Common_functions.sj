//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FREE_UNITS_HOLDERS", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    
    //Rendre le rapport visible pour les modules Titres
    MakeReportVisibleForSecurities("FREE_UNITS_HOLDERS", vServerReportsCR1485);
}



function SetReportParameters(CheckAllRecords)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    Get_WinParameters_ChkAllRecords().set_IsChecked(aqString.ToUpper(CheckAllRecords) == "VRAI" || aqString.ToUpper(CheckAllRecords) == "TRUE");    
        
    Get_WinParameters_BtnOK().Click();
}