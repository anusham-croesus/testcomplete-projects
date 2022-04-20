//USEUNIT Common_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_THEORETICAL_INTEREST", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(year, numbering)
{
    Log.Message("Bug JIRA CROES-8688");

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
    
    Get_WinParameters_BtnOK().Click();
}