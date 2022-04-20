//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    
    //Activer les prefs du rapport 6
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_CROFT_COVERPAGE", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_CROFT_COVER_PAGE", "YES", vServerReportsCR1485);
    
    //Désactiver la pref du rapport 109 (car même nom)
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_ROGERS_COVER_PAGE", "NO", vServerReportsCR1485);
    
    //Désactiver les prefs du rapport RPFL_COVERPAGE_ALONE (car même nom)
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_RPFL_COVERPAGE_ALONE", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_RPFL_COVER_PAGE", "NO", vServerReportsCR1485);
    
    //Désactiver la pref du rapport PORTFMAN_COVERPAGE (car même nom)
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_PORTFMAN_COVERPAGE", "NO", vServerReportsCR1485);
    
    //Pour le rapport "Évaluation du portefeuille (simple)" (rapport à jumeler avec le rapport "Page de couverture")
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_SIMPLE", "YES", vServerReportsCR1485);
}



function SetReportParameters(startDate, endDate)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    Get_WinParameters_BtnOK().Click();
}