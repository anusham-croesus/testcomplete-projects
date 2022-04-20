//USEUNIT Common_functions
//USEUNIT DBA



function ActivatePrefs()
{
    //1. Rouler le script : ScriptFlottantFDP_CR1092.sql
    ExecuteSQLFile_ThroughISQL(folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\CR1092_CR1252\\ScriptFlottantFDP_CR1092.sql", vServerReportsCR1485);
    
    //2. Activer la pref : PREF_RECAP_TRADE_REPORT=YES
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_RECAP_TRADE_REPORT", "YES", vServerReportsCR1485);
}



function VerifyIfReportsAreDisplayedInCurrentReports()
{
    var arrayOfExpectedReports = [];
    arrayOfExpectedReports.push(GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 2, language).split("|")[0]);
    arrayOfExpectedReports.push(GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 1, language));
    for (var i in arrayOfExpectedReports)
        if (!Get_Reports_GrpReports_LvwCurrentReports().FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["ListBoxItem", true, arrayOfExpectedReports[i]], 10).Exists)
            Log.Error("Le rapport '" + arrayOfExpectedReports[i] + "' n'est pas affiché dans les Rapports courants.");
}
