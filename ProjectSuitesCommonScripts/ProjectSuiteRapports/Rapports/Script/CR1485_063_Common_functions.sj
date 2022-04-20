//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA
//USEUNIT ExcelUtils


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_SHOW_REPORT_TRAILER_FEES", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_TRAILER_FEES", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SelectIACodeforTheUser(){
    userFirstNameLastName = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 4, language);
    userIACode= GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 5, language);
    
    //D'abord, désélectionner "Enregister la sélection"
    Get_MenuBar_Users().set_IsSubmenuOpen(true);
    if (Get_MenuBar_Users_RememberMySelection().Exists && Get_MenuBar_Users_RememberMySelection_CheckboxImage().VisibleOnScreen)
        Get_MenuBar_Users_RememberMySelection().Click();
    
    Get_MenuBar_Users().set_IsSubmenuOpen(true);
    Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", userFirstNameLastName], 10).Click();
    Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", userIACode], 10).Click();
    
    Delay(3000);
}



function SetReportParameters(checkAllRecords, startDate, endDate)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_ChkAllRecords().IsEnabled)
        Get_WinParameters_ChkAllRecords().set_IsChecked(aqString.ToUpper(checkAllRecords) == "VRAI" || aqString.ToUpper(checkAllRecords) == "TRUE");
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    Get_WinParameters_BtnOK().Click();
}