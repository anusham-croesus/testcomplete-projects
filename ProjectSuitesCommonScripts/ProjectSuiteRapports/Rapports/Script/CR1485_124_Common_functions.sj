//USEUNIT CR1485_Common_functions
//USEUNIT DBA


function ActivatePrefs(userName)
{
    Activate_Inactivate_Pref(userName, "PREF_REPORT_PERF_INTERM", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(userName, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "NO", vServerReportsCR1485);
}



function SetReportParameters(checkExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, typeOfGraphs, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (checkExcludeDataPrecedingTheManagementStartDate != undefined)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().set_IsChecked(checkExcludeDataPrecedingTheManagementStartDate);
    
    if (endDate != undefined)
        SetDateInDateTimePicker(Get_WinParameters_GrpPeriod_DtpEndDate(), endDate);
    
    if (period != undefined)
        SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod(), period);
    
    if (period1 != undefined)
        SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod1(), period1);
    
    if (period2 != undefined)
        SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod2(), period2);
    
    if (period3 != undefined)
        SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod3(), period3);
    
    if (period4 != undefined)
        SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod4(), period4);
    
    if (period5 != undefined)
        SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod5(), period5);
    
    if (checkDisplayDefaultIndices != undefined)
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().set_IsChecked(checkDisplayDefaultIndices);
    
    if (indicesToBeChecked != undefined){
        Log.Message("JIRA CROES-10673 : Crash lorsqu’on sélectionne un indice dans les paramètres du rapport Performance par classe d’actifs pour un compte qui a des indices par défaut");
        allIndicesCheckboxes = Get_WinParameters_GrpIndices_ChklstIndices().FindAllChildren("ClrClassName", "UniCheckBox", 10).toArray();
        for (i = 0; i < allIndicesCheckboxes.length; i++)
            allIndicesCheckboxes[i].set_IsChecked(false);
        arrayOfIndicesToBeChecked = new Array();
        if (Trim(indicesToBeChecked) != "")
            arrayOfIndicesToBeChecked = indicesToBeChecked.split("|");
        for (i = 0; i < arrayOfIndicesToBeChecked.length; i++)
            Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", Trim(arrayOfIndicesToBeChecked[i])], 10).set_IsChecked(true);
    }
    
    if (checkUseIndexBaseCurrency != undefined)
        Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().set_IsChecked(checkUseIndexBaseCurrency);
    
    if (checkGraphsAssetAllocation != undefined)
        Get_WinParameters_GrpGraphs_ChkAssetAllocation().set_IsChecked(checkGraphsAssetAllocation);
    
    if (checkGraphsInvestmentObjective != undefined)
        Get_WinParameters_GrpGraphs_ChkInvestmentObjective().set_IsChecked(checkGraphsInvestmentObjective);
    
    if (checkGraphsPortfolioPerformance != undefined)
        Get_WinParameters_GrpGraphs_ChkPortfolioPerformance().set_IsChecked(checkGraphsPortfolioPerformance);
    
    Delay(200);
    
    if (typeOfGraphs != undefined && Trim(typeOfGraphs) != "")
        SelectComboBoxItem(Get_WinParameters_GrpType_CmbType(), typeOfGraphs);        
    
    if (assetAllocation != undefined && Trim(assetAllocation) != "")
        Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).set_IsChecked(true);
    
    Delay(200);
    
    if (customAllocation != undefined && Trim(customAllocation) != "")
        SelectComboBoxItem(Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(), customAllocation);
    
    if (checkUseTheSpecifiedInvestmentObjective != undefined)
        Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().set_IsChecked(checkUseTheSpecifiedInvestmentObjective);
    
    if (checkTimeWeightedNetOfFees != undefined)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().set_IsChecked(checkTimeWeightedNetOfFees);
    
    if (checkTimeWeightedGrossOfFees != undefined)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().set_IsChecked(checkTimeWeightedGrossOfFees);
    
    if (checkMoneyWeightedNetOfFees != undefined)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().set_IsChecked(checkMoneyWeightedNetOfFees);
        
    Delay(300);
        
    if (checkRiskMeasurementStandardDeviation != undefined)
        Get_WinParameters_GrpRiskMeasurement_ChkStandardDeviation().set_IsChecked(checkRiskMeasurementStandardDeviation);
    
    if (checkRiskMeasurement3YearStandardDeviation != undefined)
        Get_WinParameters_GrpRiskMeasurement_Chk3YearStandardDeviation().set_IsChecked(checkRiskMeasurement3YearStandardDeviation);
    
    if (checkRiskMeasurement3YearStandDevIndices != undefined)
        Get_WinParameters_GrpRiskMeasurement_Chk3YearStandDevIndices().set_IsChecked(checkRiskMeasurement3YearStandDevIndices);
    
    if (checkRiskMeasurementSharpeIndex != undefined)
        Get_WinParameters_GrpRiskMeasurement_ChkSharpeIndex().set_IsChecked(checkRiskMeasurementSharpeIndex);
    
    if (performanceCalculations != undefined && Trim(performanceCalculations) != "")
        Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).set_IsChecked(true);
    
    if (Trim(VarToStr(numbering)) != ""){
        if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
            Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
        SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    }
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}
