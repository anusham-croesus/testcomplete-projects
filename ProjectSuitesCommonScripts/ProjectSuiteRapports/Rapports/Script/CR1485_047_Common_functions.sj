//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_FDP_TRANSCOVERPAGE", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefBranch("0", "PREF_RECAP_TRADE_REPORT", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    
    //Rendre le rapport visible pour le module Clients
    MakeReportVisibleForClients("FDP_TRANSCOVERPAGE", vServerReportsCR1485);
}
