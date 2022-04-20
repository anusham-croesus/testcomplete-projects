//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs(userName)
{
    Activate_Inactivate_Pref(userName, "PREF_REPORT_SHOW_PERFSUMMARY", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userName, "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userName, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, indicesToBeChecked, level, checkComparativePerformance, checkComparativeStandardDeviation, checkComparativeSharpeIndex, comparativeReferentialIndex, sortBy, AscendingOrDescending, checkRiskMeasurementStandardDeviation, checkRiskMeasurementSharpeIndex, checkRiskMeasurementQuartile, checkWeightAccountsNotWeighted, checkWeightIACodesNotWeighted, numbering)
{
    if (client == "US")
        Log.Message("Bug JIRA CROES-7872");
    
    Log.Message("Bug JIRA CROES-7242");
        
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsEnabled)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().set_IsChecked(aqString.ToUpper(CheckExcludeDataPrecedingTheManagementStartDate) == "VRAI" || aqString.ToUpper(CheckExcludeDataPrecedingTheManagementStartDate) == "TRUE");
    
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
    
    allIndicesCheckboxes = Get_WinParameters_GrpIndices_ChklstIndices().FindAllChildren("ClrClassName", "UniCheckBox", 10).toArray();
    for (i = 0; i < allIndicesCheckboxes.length; i++)
        allIndicesCheckboxes[i].set_IsChecked(false);
    arrayOfIndicesToBeChecked = new Array();
    if (Trim(indicesToBeChecked) != "")
        arrayOfIndicesToBeChecked = indicesToBeChecked.split("|");
    for (i = 0; i < arrayOfIndicesToBeChecked.length; i++)
        Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", Trim(arrayOfIndicesToBeChecked[i])], 10).set_IsChecked(true);
    
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
    
    if (Get_WinParameters_GrpComparative_ChkPerformance().IsEnabled)
        Get_WinParameters_GrpComparative_ChkPerformance().set_IsChecked(aqString.ToUpper(checkComparativePerformance) == "VRAI" || aqString.ToUpper(checkComparativePerformance) == "TRUE");

    if (Get_WinParameters_GrpComparative_ChkStandardDeviation().IsEnabled)
        Get_WinParameters_GrpComparative_ChkStandardDeviation().set_IsChecked(aqString.ToUpper(checkComparativeStandardDeviation) == "VRAI" || aqString.ToUpper(checkComparativeStandardDeviation) == "TRUE");

    if (Get_WinParameters_GrpComparative_ChkSharpeIndex().IsEnabled)
        Get_WinParameters_GrpComparative_ChkSharpeIndex().set_IsChecked(aqString.ToUpper(checkComparativeSharpeIndex) == "VRAI" || aqString.ToUpper(checkComparativeSharpeIndex) == "TRUE");
    
    if (Get_WinParameters_GrpComparative_CmbReferentialIndex().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpComparative_CmbReferentialIndex(), comparativeReferentialIndex);
    
    SelectComboBoxItem(Get_WinParameters_GrpOrder_CmbSortBy(), sortBy);
    
    Get_WinParameters_GrpOrder_GrpAscendingDescending().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", AscendingOrDescending], 10).set_IsChecked(true);
    
    if (Get_WinParameters_GrpRiskMeasurement_ChkStandardDeviation().IsEnabled)
        Get_WinParameters_GrpRiskMeasurement_ChkStandardDeviation().set_IsChecked(aqString.ToUpper(checkRiskMeasurementStandardDeviation) == "VRAI" || aqString.ToUpper(checkRiskMeasurementStandardDeviation) == "TRUE");

    if (Get_WinParameters_GrpRiskMeasurement_ChkSharpeIndex().IsEnabled)
        Get_WinParameters_GrpRiskMeasurement_ChkSharpeIndex().set_IsChecked(aqString.ToUpper(checkRiskMeasurementSharpeIndex) == "VRAI" || aqString.ToUpper(checkRiskMeasurementSharpeIndex) == "TRUE");
    
    if (Get_WinParameters_GrpRiskMeasurement_ChkQuartile().IsEnabled)
        Get_WinParameters_GrpRiskMeasurement_ChkQuartile().set_IsChecked(aqString.ToUpper(checkRiskMeasurementQuartile) == "VRAI" || aqString.ToUpper(checkRiskMeasurementQuartile) == "TRUE");
        
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