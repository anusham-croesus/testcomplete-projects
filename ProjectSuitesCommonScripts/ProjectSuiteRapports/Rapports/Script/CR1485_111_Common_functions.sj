//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_FREEDOM_COVER_PAGE", "YES", vServerReportsCR1485);
    
    //Activer la pref pour le rapport "Revenus" ("Income") : rapport à jumeler avec le rapport "Page couverture Liberté"
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_REVENUES", "YES", vServerReportsCR1485);
}



function SetReportParameters(asOfDate)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
            
    Get_WinParameters_BtnOK().Click();
}