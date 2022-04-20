//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FBNGP_Q_GAIN_PERTE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_QUARTERLY_REPORT_GP1859", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    
    //Rendre le rapport visible pour le module Relations
    MakeReportVisibleForRelationships("FBNGP_Q_GAIN_PERTE", vServerReportsCR1485);
}
