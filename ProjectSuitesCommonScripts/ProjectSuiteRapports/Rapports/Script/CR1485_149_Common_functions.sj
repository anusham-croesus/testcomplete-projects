//USEUNIT CR1485_Common_functions



function ActivatePrefs(isRestartServicesToBeExecuted)
{   
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_TAX_COVERPAGE", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);

    if (isRestartServicesToBeExecuted)
        RestartServices(vServerReportsCR1485);
}


function RestorePrefs(isRestartServicesToBeExecuted)
{    
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_TAX_COVERPAGE", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", null, vServerReportsCR1485); 

    if (isRestartServicesToBeExecuted)
        RestartServices(vServerReportsCR1485);
}



function SetReportParameters(checkPreviousCalendarYear, startDate, endDate)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (GetBooleanValue(checkPreviousCalendarYear) != undefined)
        Get_WinParameters_ChkPreviousCalendarYear().set_IsChecked(GetBooleanValue(checkPreviousCalendarYear));
    
    if (startDate != undefined && VarToStr(Trim(startDate)) != "")
        SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    if (endDate != undefined && VarToStr(Trim(endDate)) != "")
        SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
        
    if (GetBooleanValue(checkPreviousCalendarYear) == true){
        CompareProperty(Get_WinParameters_DtpStartDate().IsEnabled, cmpEqual, false, true, lmError);
        CompareProperty(Get_WinParameters_DtpEndDate2().IsEnabled, cmpEqual, false, true, lmError);
    }
    
    ///////////////////////
    Log.Picture(Sys.Desktop.FocusedWindow(), "Fenêtre Paramètres Rapport 149.");
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}