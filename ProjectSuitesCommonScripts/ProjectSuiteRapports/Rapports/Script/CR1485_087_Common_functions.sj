//USEUNIT CR1485_Common_functions



function ActivatePrefs(activate_PREF_NON_ANNUALIZED_RETURN)
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_RISK_RETURN", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_GRAPH_RISK_RETURN", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    
    var value_PREF_NON_ANNUALIZED_RETURN = (activate_PREF_NON_ANNUALIZED_RETURN == undefined || activate_PREF_NON_ANNUALIZED_RETURN === false)? "NO": "YES";
    UpdatePrefAtLevelForUser(userNameReportsCR1485, "PREF_NON_ANNUALIZED_RETURN", value_PREF_NON_ANNUALIZED_RETURN, "FIRM", vServerReportsCR1485);
    
    RestartServices(vServerReportsCR1485);
}



function RestorePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_RISK_RETURN", null, vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_GRAPH_RISK_RETURN", null, vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", null, vServerReportsCR1485);
    UpdatePrefAtLevelForUser(userNameReportsCR1485, "PREF_NON_ANNUALIZED_RETURN", null, "FIRM", vServerReportsCR1485);
    RestartServices(vServerReportsCR1485);
}



/**
    Si l'option case à cocher 'Inclure rendement non annualisé'/'Include Non-annualized Returns' ne doit pas être disponible (ref. JIRA CROES-6336),
    omettre ou mettre à null les deux derniers paramètres suivants : expectedIsEnabledForCheckIncludeNonAnnualizedReturns, CheckIncludeNonAnnualizedReturns
*/
function SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, performanceCalculations, numbering, expectedIsEnabledForCheckIncludeNonAnnualizedReturns, CheckIncludeNonAnnualizedReturns)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsEnabled)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().set_IsChecked(aqString.ToUpper(CheckExcludeDataPrecedingTheManagementStartDate) == "VRAI" || aqString.ToUpper(CheckExcludeDataPrecedingTheManagementStartDate) == "TRUE");
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    if (Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsEnabled)
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().set_IsChecked(aqString.ToUpper(checkDisplayDefaultIndices) == "VRAI" || aqString.ToUpper(checkDisplayDefaultIndices) == "TRUE");    
    
    allIndicesCheckboxes = Get_WinParameters_GrpIndices_ChklstIndices().FindAllChildren("ClrClassName", "UniCheckBox", 10).toArray();
    for (var i = 0; i < allIndicesCheckboxes.length; i++)
        allIndicesCheckboxes[i].set_IsChecked(false);
    arrayOfIndicesToBeChecked = new Array();
    if (Trim(indicesToBeChecked) != "")
        arrayOfIndicesToBeChecked = indicesToBeChecked.split("|");
    for (var i = 0; i < arrayOfIndicesToBeChecked.length; i++)
        Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", Trim(arrayOfIndicesToBeChecked[i])], 10).set_IsChecked(true);
    
    if (Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().IsEnabled)
        Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().set_IsChecked(aqString.ToUpper(checkUseIndexBaseCurrency) == "VRAI" || aqString.ToUpper(checkUseIndexBaseCurrency) == "TRUE");
    
    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedNetOfFees) == "TRUE");    
    
    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedGrossOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedGrossOfFees) == "TRUE");    
    
    Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).set_IsChecked(true);
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    Log.Link("https://jira.croesus.com/browse/CROES-6336", "JIRA CROES-6336");
    var isAvalaibleChkIncludeNonAnnualizedReturns = (Get_WinParameters_GrpNonAnnualizedReturns().Exists && Get_WinParameters_GrpNonAnnualizedReturns().IsVisible && Get_WinParameters_GrpNonAnnualizedReturns_ChkIncludeNonAnnualizedReturns().Exists && Get_WinParameters_GrpNonAnnualizedReturns_ChkIncludeNonAnnualizedReturns().IsVisible);
    if (CheckIncludeNonAnnualizedReturns == undefined){
        if (isAvalaibleChkIncludeNonAnnualizedReturns === true)
            Log.Error("L'option case à cocher 'Inclure rendement non annualisé'/'Include Non-annualized Returns' est disponible, ceci est inattendu.");
    }
    else {
        if (isAvalaibleChkIncludeNonAnnualizedReturns === false)
            Log.Error("L'option case à cocher 'Inclure rendement non annualisé'/'Include Non-annualized Returns' n'est pas disponible, ceci est inattendu.");
        else {
            if (GetBooleanValue(expectedIsEnabledForCheckIncludeNonAnnualizedReturns) !== Get_WinParameters_GrpNonAnnualizedReturns_ChkIncludeNonAnnualizedReturns().IsEnabled)
                Log.Error("L'état de l'option case à cocher 'Inclure rendement non annualisé'/'Include Non-annualized Returns' n'est pas celui attendu.");
            
            var isCheckIncludeNonAnnualizedReturns = GetBooleanValue(CheckIncludeNonAnnualizedReturns);
            if (isCheckIncludeNonAnnualizedReturns !== Get_WinParameters_GrpNonAnnualizedReturns_ChkIncludeNonAnnualizedReturns().IsChecked.OleValue){
                Get_WinParameters_GrpNonAnnualizedReturns_ChkIncludeNonAnnualizedReturns().Click();
                Get_WinParameters_GrpNonAnnualizedReturns_ChkIncludeNonAnnualizedReturns().WaitProperty("IsChecked", isCheckIncludeNonAnnualizedReturns, 5000);
            }
            CompareProperty(Get_WinParameters_GrpNonAnnualizedReturns_ChkIncludeNonAnnualizedReturns().IsChecked.OleValue, cmpEqual, isCheckIncludeNonAnnualizedReturns, true, lmError);
        }
    }
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}