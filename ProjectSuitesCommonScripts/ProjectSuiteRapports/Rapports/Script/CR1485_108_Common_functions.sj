//USEUNIT CR1485_Common_functions


function ActivatePrefs(prefUserName)
{
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    
    //*** Niveau Firme ***
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_REPORT_PORTFOLIO_SUMMARY_DETAILED", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_PORTFOLIO_SUMMARY_DETAILED_COLUMNS", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SUMMARY_DETAIL_BY_ACCOUNT", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_BOX_ON_PF_SUMMARY_DETAILED", "YES", vServerReportsCR1485); //(CR1492)
    
    //Après CR2009/CR2023:
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_PORT_DETAIL", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INCLUDE_YTD_ONLY", "YES", vServerReportsCR1485);
    
    
    /**
    //old
    if (prefUserName == undefined) prefUserName = userNameReportsCR1485;
    Activate_Inactivate_Pref(prefUserName, "PREF_ENABLE_REPORT_PORTFOLIO_SUMMARY_DETAILED", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_REPORT_SUMMARY_PORT_DETAIL", "YES", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_REPORT_INCLUDE_YTD_ONLY", "NO", vServerReportsCR1485);
    Activate_Inactivate_Pref(prefUserName, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
    */
    
    RestartServices(vServerReportsCR1485);
}



function SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, performanceCalculations, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering, checkFundBreakdownClassBreakdown, startDate, checkGraphsRegionAllocation,CheckOneReportPerAccount,checkGraphsInvestmentObjective)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (GetBooleanValue(CheckExcludeDataPrecedingTheManagementStartDate) != Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().Click();
        
    if (startDate == undefined)
        SetDateInDateTimePicker(Get_WinParameters_DtpEndDate(), endDate);
    else {
        SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
        SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    }
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod(), period);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod1(), period1);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod2(), period2);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod3(), period3);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod4(), period4);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod5(), period5);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod6(), period6);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod7(), period7);
    
    if (GetBooleanValue(checkDisplayDefaultIndices) != Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsChecked.OleValue)
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().Click();
        
    CheckIndices(indicesToBeChecked);
    
    if (Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().IsEnabled)
        Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().set_IsChecked(aqString.ToUpper(checkUseIndexBaseCurrency) == "VRAI" || aqString.ToUpper(checkUseIndexBaseCurrency) == "TRUE");    
        
    Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).set_IsChecked(true);
    
    Delay(200);
    
    if (Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().Exists && Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(), customAllocation);
    
    if (Trim(VarToStr(checkUseTheSpecifiedInvestmentObjective)) != ""){
        if (GetBooleanValue(checkUseTheSpecifiedInvestmentObjective) != Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().IsChecked.OleValue)
            Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().Click();
    }
    
    Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).set_IsChecked(true);
    
    //Checkbox: Time Weighted Fees (Net)
    if (GetBooleanValue(checkTimeWeightedNetOfFees) != Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().Click();
    
    //Checkbox: Time Weighted Fees (Gross)   
    if (GetBooleanValue(checkTimeWeightedGrossOfFees) != Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().Click();
        
    //Checkbox: Money Weighted Fees (Net)  
    if (GetBooleanValue(checkMoneyWeightedNetOfFees) != Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().Click();       
    
    if (client != "RJ"&& checkFundBreakdownClassBreakdown != undefined ){
        if (Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().IsEnabled)
            Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().set_IsChecked(aqString.ToUpper(checkFundBreakdownClassBreakdown) == "VRAI" || aqString.ToUpper(checkFundBreakdownClassBreakdown) == "TRUE");
    }
    
    if (CheckOneReportPerAccount != undefined){
        if (GetBooleanValue(CheckOneReportPerAccount) != Get_WinParameters_ChkOneReportPerAccount().IsChecked.OleValue)
            Get_WinParameters_ChkOneReportPerAccount().Click();
        Get_WinParameters_ChkOneReportPerAccount().WaitProperty("IsChecked.OleValue", GetBooleanValue(CheckOneReportPerAccount), 5000);
        CompareProperty(Get_WinParameters_ChkOneReportPerAccount().IsChecked.OleValue, cmpEqual, GetBooleanValue(CheckOneReportPerAccount), true, lmError);
    }
    
    //ChkGraphsRegionAllocation
    if (checkGraphsRegionAllocation != undefined){
        var isGraphsRegionAllocationToBeChecked = GetBooleanValue(checkGraphsRegionAllocation);
        if (isGraphsRegionAllocationToBeChecked != Get_WinParameters_GrpGraphs_ChkRegionAllocation().IsChecked.OleValue){
            if (!Get_WinParameters_GrpGraphs_ChkRegionAllocation().IsEnabled){
                var allEnabledGraphsCheckboxes = Get_WinParameters_GrpGraphs().FindAllChildren(["ClrClassName", "IsEnabled"], ["UniCheckBox", true], 10).toArray();
                for (var j in allEnabledGraphsCheckboxes)
                    allEnabledGraphsCheckboxes[j].Click();
            }
            Get_WinParameters_GrpGraphs_ChkRegionAllocation().set_IsChecked(isGraphsRegionAllocationToBeChecked);
        }
    }
    
    //check box Objectif d'investissement - ChkInvestmentObjective
    if (checkGraphsInvestmentObjective != undefined){
        var isGraphsInvestmentObjectiveToBeChecked = GetBooleanValue(checkGraphsInvestmentObjective);
        
        //Vérifier si le bug Jira RPT-818 est présent
        var ChkInvestmentObjectiveBugRPT818 = Utils.CreateStubObject();
        if (language == "french")
            ChkInvestmentObjectiveBugRPT818 = Get_WinParameters_GrpGraphs().FindChildEx(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Objectif d'investissement"], 10, true, 15000);
        if (ChkInvestmentObjectiveBugRPT818.Exists){
            SetAutoTimeOut();
            Log.Link("https://jira.croesus.com/browse/RPT-818", "Bug Jira RPT-818");
            aqObject.CheckProperty(ChkInvestmentObjectiveBugRPT818, "WPFControlText", cmpEqual, "Objectif de placement");
            RestoreAutoTimeOut();
            
            if (isGraphsInvestmentObjectiveToBeChecked != ChkInvestmentObjectiveBugRPT818.IsChecked.OleValue){
                if (!ChkInvestmentObjectiveBugRPT818.IsEnabled){
                    var allEnabledGraphsCheckboxes = Get_WinParameters_GrpGraphs().FindAllChildren(["ClrClassName", "IsEnabled"], ["UniCheckBox", true], 10).toArray();
                    for (var j in allEnabledGraphsCheckboxes)
                        allEnabledGraphsCheckboxes[j].set_IsChecked(false);
                }
                ChkInvestmentObjectiveBugRPT818.Click();
            }
            Delay(1000);
            CompareProperty(ChkInvestmentObjectiveBugRPT818.IsChecked.OleValue, cmpEqual, isGraphsInvestmentObjectiveToBeChecked, true, lmError);
        }
        else {
            if (isGraphsInvestmentObjectiveToBeChecked != Get_WinParameters_GrpGraphs_ChkInvestmentObjective().IsChecked.OleValue){
                if (!Get_WinParameters_GrpGraphs_ChkInvestmentObjective().IsEnabled){
                    var allEnabledGraphsCheckboxes = Get_WinParameters_GrpGraphs().FindAllChildren(["ClrClassName", "IsEnabled"], ["UniCheckBox", true], 10).toArray();
                    for (var j in allEnabledGraphsCheckboxes)
                        allEnabledGraphsCheckboxes[j].set_IsChecked(false);
                }
                Get_WinParameters_GrpGraphs_ChkInvestmentObjective().Click();
            }
            Delay(1000);
            CompareProperty(Get_WinParameters_GrpGraphs_ChkInvestmentObjective().IsChecked.OleValue, cmpEqual, isGraphsInvestmentObjectiveToBeChecked, true, lmError);
        }
    }
    
    //Pagination
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    //valider l'état final
    if (checkGraphsRegionAllocation != undefined)
        CompareProperty(Get_WinParameters_GrpGraphs_ChkRegionAllocation().IsChecked.OleValue, cmpEqual, isGraphsRegionAllocationToBeChecked, true, lmError);
        
    CompareProperty(Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue, cmpEqual, GetBooleanValue(CheckExcludeDataPrecedingTheManagementStartDate), true, lmError);
    CompareProperty(Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkDisplayDefaultIndices), true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkTimeWeightedNetOfFees), true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkTimeWeightedGrossOfFees), true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkMoneyWeightedNetOfFees), true, lmError);
    if (Trim(VarToStr(checkUseTheSpecifiedInvestmentObjective)) != "")
        CompareProperty(Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkUseTheSpecifiedInvestmentObjective), true, lmError);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}
