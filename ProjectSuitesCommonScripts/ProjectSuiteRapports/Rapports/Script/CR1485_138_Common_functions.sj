//USEUNIT Global_variables
//USEUNIT Common_functions
//USEUNIT DBA



function ActivatePrefs(userName)
{
    Activate_Inactivate_Pref(userName, "PREF_REPORT_SHOW_PERFSUMMARY", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userName, "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
}
