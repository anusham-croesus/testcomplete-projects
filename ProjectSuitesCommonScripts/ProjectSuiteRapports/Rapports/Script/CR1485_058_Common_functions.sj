//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{   
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SHOW_REPORT_FOREIGN_PROPERTY", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}


function RestorePrefs()
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SHOW_REPORT_FOREIGN_PROPERTY", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", null, vServerReportsCR1485); 
    RestartServices(vServerReportsCR1485);
}



function SetReportParameters(checkPreviousCalendarYear, startDate, endDate, sortBy, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    //Case à cocher : Année civile précédente
    var boolCheckPreviousCalendarYear = (aqString.ToUpper(checkPreviousCalendarYear) == "VRAI" || aqString.ToUpper(checkPreviousCalendarYear) == "TRUE");
    if (boolCheckPreviousCalendarYear != Get_WinParameters_ChkPreviousCalendarYear().IsChecked.OleValue){
        Get_WinParameters_ChkPreviousCalendarYear().Click();
        Get_WinParameters_ChkPreviousCalendarYear().WaitProperty("IsChecked.OleValue", boolCheckPreviousCalendarYear, 5000);
        CompareProperty(Get_WinParameters_ChkPreviousCalendarYear().IsChecked.OleValue, cmpEqual, boolCheckPreviousCalendarYear, true, lmError);
    }
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    SelectComboBoxItem(Get_WinParameters_CmbSortBy1(), sortBy);
    
    //Combobox : Pagination
    if (numbering != undefined){
        if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
            Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
        Log.Link("https://jira.croesus.com/browse/TCVE-1201", "Bug JIRA TCVE-1201");
        
        SelectComboBoxItem(Get_WinParameters_CmbNumbering2(), numbering);
    }
    
    ///////////////////////
    Log.Picture(Sys.Desktop.FocusedWindow(), "Fenêtre Paramètres Rapport 058.");
    
    Get_WinParameters_BtnOK().Click();
}