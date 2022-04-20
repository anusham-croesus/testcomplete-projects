//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function ActivatePrefs()
{
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_SUMMARY_PORT_WO_REF", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_FBN_GP", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
}



function SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsEnabled)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().set_IsChecked(aqString.ToUpper(CheckExcludeDataPrecedingTheManagementStartDate) == "VRAI" || aqString.ToUpper(CheckExcludeDataPrecedingTheManagementStartDate) == "TRUE");    
        
    if (Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsEnabled)
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().set_IsChecked(aqString.ToUpper(checkDisplayDefaultIndices) == "VRAI" || aqString.ToUpper(checkDisplayDefaultIndices) == "TRUE");    
    
    allIndicesCheckboxes = Get_WinParameters_GrpIndices_ChklstIndices().FindAllChildren("ClrClassName", "UniCheckBox", 10).toArray();
    for (i = 0; i < allIndicesCheckboxes.length; i++)
        allIndicesCheckboxes[i].set_IsChecked(false);
    arrayOfIndicesToBeChecked = new Array();
    if (Trim(indicesToBeChecked) != "")
        arrayOfIndicesToBeChecked = indicesToBeChecked.split("|");
    for (i = 0; i < arrayOfIndicesToBeChecked.length; i++)
        Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", Trim(arrayOfIndicesToBeChecked[i])], 10).set_IsChecked(true);

    if (Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().IsEnabled)
        Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().set_IsChecked(aqString.ToUpper(checkUseIndexBaseCurrency) == "VRAI" || aqString.ToUpper(checkUseIndexBaseCurrency) == "TRUE");    
        
    Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).set_IsChecked(true);
    
    Delay(200);
    
    if (Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().Exists && Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(), customAllocation);
    
    if (Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().Exists && Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().IsEnabled)
        Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().set_IsChecked(aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "VRAI" || aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "TRUE");    
    
    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedNetOfFees) == "TRUE");    

    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedGrossOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedGrossOfFees) == "TRUE");    

    if (Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkMoneyWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkMoneyWeightedNetOfFees) == "TRUE");
    
    Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).set_IsChecked(true);
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    Get_WinParameters_BtnOK().Click();
}