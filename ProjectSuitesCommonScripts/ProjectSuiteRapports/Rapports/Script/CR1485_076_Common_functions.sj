//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs(userName)
{
    Activate_Inactivate_Pref(userName, "PREF_REPORT_SUMMARY_PERF_OBJINV", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userName, "PREF_REPORT_SHOW_PERFSUMMARY", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userName, "PREF_REPORT_SHOW_PERFSUMMARY_OBJ", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userName, "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userName, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(endDate, period, period1, period2, period3, period4, period5, level, sortBy, AscendingOrDescending, checkRiskMeasurementQuartile, checkRiskMeasurementPerformanceOfIndex, checkWeightAccountsNotWeighted, checkWeightIACodesNotWeighted, numbering)
{
    if (client == "US")
        Log.Message("Bug JIRA CROES-7872");
        
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_GrpPeriod_DtpEndDate(), endDate);
    Get_WinParameters_GrpPeriod_DtpEndDate().Keys("[Tab]");
    if (endDate != Get_WinParameters_GrpPeriod_DtpEndDate().StringValue)
        Log.Error("Bug JIRA CROES-6742 : The End Date has been automatically changed!", "Since a month-end date is required to calculate performances, the End Date has been changed to the last day of the previous month.");

    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod(), period);

    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod1(), period1);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod2(), period2);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod3(), period3);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod4(), period4);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod5(), period5);
        
    Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", level], 10).set_IsChecked(true);
    
    if (projet != "General") SetAutoTimeOut(120000);
    
    if (level == "Succursale" || level == "Branch"){
        Get_WinParameters_GrpLevel_BtnBranch().Click();
        Get_WinBranches_BtnOK().Click();
    }
    else if (level == "Conseiller en placement" || level == "Investment Advisor"){
        Get_WinParameters_GrpLevel_BtnInvestmentAdvisor().Click();
        Get_WinInvestmentAdvisors_BtnOK().Click();
    }
    
    if (projet != "General") RestoreAutoTimeOut();
    
    SelectComboBoxItem(Get_WinParameters_GrpOrder_CmbSortBy(), sortBy);
    
    Get_WinParameters_GrpOrder_GrpAscendingDescending().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", AscendingOrDescending], 10).set_IsChecked(true);
    
    if (Get_WinParameters_GrpRiskMeasurement_ChkQuartile().IsEnabled)
        Get_WinParameters_GrpRiskMeasurement_ChkQuartile().set_IsChecked(aqString.ToUpper(checkRiskMeasurementQuartile) == "VRAI" || aqString.ToUpper(checkRiskMeasurementQuartile) == "TRUE");
    
    if (Get_WinParameters_GrpRiskMeasurement_ChkPerformanceOfIndex().IsEnabled)
        Get_WinParameters_GrpRiskMeasurement_ChkPerformanceOfIndex().set_IsChecked(aqString.ToUpper(checkRiskMeasurementPerformanceOfIndex) == "VRAI" || aqString.ToUpper(checkRiskMeasurementPerformanceOfIndex) == "TRUE");
    
    if (Get_WinParameters_GrpWeight_ChkAccountsNotWeighted().IsEnabled)
        Get_WinParameters_GrpWeight_ChkAccountsNotWeighted().set_IsChecked(aqString.ToUpper(checkWeightAccountsNotWeighted) == "VRAI" || aqString.ToUpper(checkWeightAccountsNotWeighted) == "TRUE");
    
    if (client == "US" && !Get_WinParameters_GrpWeight_ChkIACodesNotWeighted().Exists)
        Log.Error("Bug JIRA USDEV-341");
    
    if (Get_WinParameters_GrpWeight_ChkIACodesNotWeighted().IsEnabled)
        Get_WinParameters_GrpWeight_ChkIACodesNotWeighted().set_IsChecked(aqString.ToUpper(checkWeightIACodesNotWeighted) == "VRAI" || aqString.ToUpper(checkWeightIACodesNotWeighted) == "TRUE");
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    Get_WinParameters_BtnOK().Click();
    
    if (Get_DlgInformation().Exists){
        Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        Delay(1000);
        Get_WinParameters_BtnOK().Click();
    }
}