//USEUNIT CR1485_Common_functions
//USEUNIT DBA


function ActivatePrefs(userName)
{
    //Activer la pref du rapport 148
    Activate_Inactivate_Pref(userName, "PREF_REPORT_PMFA_COVERPAGE2", "YES", vServerReportsCR1485);
    
    //Désactiver la pref du rapport 147 (Car même nom)
    Activate_Inactivate_Pref(userName, "PREF_REPORT_PMFA_COVERPAGE1", "NO", vServerReportsCR1485);
    
    //Pour le rapport "Revenus" (rapport à jumeler avec le rapport "Page couverture - PM/FA")
    Activate_Inactivate_Pref(userName, "PREF_REPORT_REVENUES", "YES", vServerReportsCR1485);
}



function SetReportParameters(asOfDate, reportTitle)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
    
    SelectComboBoxItem(Get_WinParameters_CmbTitle(), reportTitle);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}