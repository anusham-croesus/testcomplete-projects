//USEUNIT Common_functions
//USEUNIT DBA


function ActivatePrefs(prefUserName)
{
    if (prefUserName == undefined) prefUserName = userNameReportsCR1485;
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_EXPECT_TAX_SLIPS_NRA", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(year, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SelectComboBoxItem(Get_WinParameters_CmbYear(), year);
    
    if (!Get_ModulesBar_BtnPortfolio().IsChecked.OleValue){
        if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
            Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
        SelectComboBoxItem(Get_WinParameters_CmbNumbering2(), numbering);
    }
    else
        CompareProperty((Get_WinParameters_CmbNumbering2().Exists && Get_WinParameters_CmbNumbering2().IsVisible), cmpEqual, false, true, lmError);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}