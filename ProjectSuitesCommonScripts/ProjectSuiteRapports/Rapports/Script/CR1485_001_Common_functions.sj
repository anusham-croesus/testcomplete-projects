//USEUNIT CR1485_Common_functions


function ActivatePrefs()
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INFO_CLIENT", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_INFO_CLIENT_REPORT", "SYSADM,FIRMADM,BRMAN", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}



function RestorePrefs()
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INFO_CLIENT", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_INFO_CLIENT_REPORT", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", null, vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}



function SetReportParameters(checkProfile, checkNotes, checkEventHistory, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    //Checkbox : Profile
    var boolCheckProfile = GetBooleanValue(checkProfile);
    if (boolCheckProfile !== Get_WinParameters_GrpInclude_ChkProfile().IsChecked.OleValue){
        Get_WinParameters_GrpInclude_ChkProfile().Click();
        Get_WinParameters_GrpInclude_ChkProfile().WaitProperty("IsChecked.OleValue", boolCheckProfile, 5000);
        CompareProperty(Get_WinParameters_GrpInclude_ChkProfile().IsChecked.OleValue, cmpEqual, boolCheckProfile, true, lmError);
    }
        
    //Checkbox : Notes
    var boolCheckNotes = GetBooleanValue(checkNotes);
    if (boolCheckNotes !== Get_WinParameters_GrpInclude_ChkNotes().IsChecked.OleValue){
        Get_WinParameters_GrpInclude_ChkNotes().Click();
        Get_WinParameters_GrpInclude_ChkNotes().WaitProperty("IsChecked.OleValue", boolCheckNotes, 5000);
        CompareProperty(Get_WinParameters_GrpInclude_ChkNotes().IsChecked.OleValue, cmpEqual, boolCheckNotes, true, lmError);
    }
    
    //Checkbox : Event History
    var boolCheckEventHistory = GetBooleanValue(checkEventHistory);
    if (boolCheckEventHistory !== Get_WinParameters_GrpInclude_ChkEventHistory().IsChecked.OleValue){
        Get_WinParameters_GrpInclude_ChkEventHistory().Click();
        Get_WinParameters_GrpInclude_ChkEventHistory().WaitProperty("IsChecked.OleValue", boolCheckEventHistory, 5000);
        CompareProperty(Get_WinParameters_GrpInclude_ChkEventHistory().IsChecked.OleValue, cmpEqual, boolCheckEventHistory, true, lmError);
    }
        
    //Combobox : Numbering
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    Get_WinParameters_BtnOK().Click();
}
