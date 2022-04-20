//USEUNIT Global_variables
//USEUNIT Common_functions
//USEUNIT DBA



function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_QUARTERLY_REPORT_GP1859", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNGP_Q_COVERPAGE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNGP_Q_ASSETMIX", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNGP_Q_EVAL", "YES", vServerReportsCR1485);
}
