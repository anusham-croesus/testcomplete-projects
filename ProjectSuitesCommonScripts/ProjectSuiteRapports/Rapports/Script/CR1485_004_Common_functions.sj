//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_ANNIC", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}

function ActivatePDFFirmPrefs()
{
    //MAJ ce 2020-04-28 (Christophe)
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SET_USER_REPORT_TITLE", "SYSADM,FIRMADM,BRMAN", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_ANNIC", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DISPLAY_CHECK_DIGIT", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_USE_PDF_NAMING_CONVENTION", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_PDF_NAMING_CONVENTION", "RJ", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("Firm_1", "PREF_PATH_PDF", REPORTS_FILES_FOLDER_PATH, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SHOW_ACCOUNT_NO", "10", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SHOW_CLIENT_NO", "10", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SHOW_REL_NO", "10", vServerReportsCR1485);

    RestartServices(vServerReportsCR1485);
}


function DesactivatePDFFirmPrefs()
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SET_USER_REPORT_TITLE", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_ANNIC", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DISPLAY_CHECK_DIGIT", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_USE_PDF_NAMING_CONVENTION", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_PDF_NAMING_CONVENTION", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("Firm_1", "PREF_PATH_PDF", null, vServerReportsCR1485);
    if (client == "RJ"){
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SHOW_ACCOUNT_NO", "20", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SHOW_CLIENT_NO", "20", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SHOW_REL_NO", "0", vServerReportsCR1485);
    }
    else {
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SHOW_ACCOUNT_NO", null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SHOW_CLIENT_NO", null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SHOW_REL_NO", null, vServerReportsCR1485);
    }
    
    RestartServices(vServerReportsCR1485);
}



function SetReportParameters(startDate, checkIncludeAmortizedIncome, sortBy, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    if (Get_WinParameters_ChkIncludeAmortizedIncome().IsEnabled)
        Get_WinParameters_ChkIncludeAmortizedIncome().set_IsChecked(aqString.ToUpper(checkIncludeAmortizedIncome) == "VRAI" || aqString.ToUpper(checkIncludeAmortizedIncome) == "TRUE");
    
    SelectComboBoxItem(Get_WinParameters_CmbSortBy1(), sortBy);
    
    if (Trim(VarToStr(numbering)) != ""){
        if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
            Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
        SelectComboBoxItem(Get_WinParameters_CmbNumbering2(), numbering);
    }
    
    Get_WinParameters_BtnOK().Click();
}