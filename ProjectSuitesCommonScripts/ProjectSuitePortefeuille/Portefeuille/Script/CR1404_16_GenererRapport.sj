//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


function GenererRapport(excelPageName, reportName, reportFolderPath)
{
  try
  {
    var reportFileName = GetData(filePath_Portefeuille, excelPageName, 6, language);
    PreparationRapport(excelPageName, reportName, reportFolderPath);
    CreationRapport(excelPageName, reportName, reportFolderPath, reportFileName)
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
  }
}

function PreparationRapport(excelPageName, reportName, reportFolderPath)
{
  Create_Folder(reportFolderPath);
        
  Login(vServerPortefeuille, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username"), 
                             ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw"), language);
                               
  Get_ModulesBar_BtnAccounts().Click();
  Get_RelationshipsClientsAccountsGrid().keys("8");
  Get_WinQuickSearch_TxtSearch().keys("00011-NA");
  Get_WinQuickSearch_BtnOK().Click();
}

function CreationRapport(excelPageName, reportName, reportFolderPath, reportFileName)
{
    //Open Reports window and Select report
    Get_Toolbar_BtnReportsAndGraphs().Click();
    WaitReportsWindow();
    SelectReports(reportName);
        
    //Reports options values
    var destination = GetData(filePath_Portefeuille, excelPageName, 9, language);
    var sortBy = GetData(filePath_Portefeuille, excelPageName, 10, language);
    var currency = GetData(filePath_Portefeuille, excelPageName, 11, language);
    var reportLanguage = GetData(filePath_Portefeuille, excelPageName, 12, language);
    var checkAddBranchAddress = GetData(filePath_Portefeuille, excelPageName, 13, language);
    var checkGroupInTheSameReport = GetData(filePath_Portefeuille, excelPageName, 14, language);
    var checkConsolidatePositions = GetData(filePath_Portefeuille, excelPageName, 15, language);
    var checkGroupUnderlyingClients = GetData(filePath_Portefeuille, excelPageName, 16, language);
    var checkIncludeMessage = GetData(filePath_Portefeuille, excelPageName, 17, language);
    var message = GetData(filePath_Portefeuille, excelPageName, 18, language);
        
    SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
    //Parameters values
    var CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_Portefeuille, excelPageName, 21, language);
    var endDate = GetData(filePath_Portefeuille, excelPageName, 22, language);
    var period = GetData(filePath_Portefeuille, excelPageName, 23, language);
    var period1 = GetData(filePath_Portefeuille, excelPageName, 24, language);
    var period2 = GetData(filePath_Portefeuille, excelPageName, 25, language);
    var period3 = GetData(filePath_Portefeuille, excelPageName, 26, language);
    var period4 = GetData(filePath_Portefeuille, excelPageName, 27, language);
    var period5 = GetData(filePath_Portefeuille, excelPageName, 28, language);
    var period6 = GetData(filePath_Portefeuille, excelPageName, 29, language);
    var period7 = GetData(filePath_Portefeuille, excelPageName, 30, language);
    var checkDisplayDefaultIndices = GetData(filePath_Portefeuille, excelPageName, 31, language);
    var indicesToBeChecked = GetData(filePath_Portefeuille, excelPageName, 32, language);
    var checkUseIndexBaseCurrency = GetData(filePath_Portefeuille, excelPageName, 33, language);
    var assetAllocation = GetData(filePath_Portefeuille, excelPageName, 34, language);
    var customAllocation = GetData(filePath_Portefeuille, excelPageName, 35, language);
    var checkUseTheSpecifiedInvestmentObjective = GetData(filePath_Portefeuille, excelPageName, 36, language);
    var checkFundBreakdownClassBreakdown = GetData(filePath_Portefeuille, excelPageName, 37, language);
    var checkFundBreakdownAppendix = GetData(filePath_Portefeuille, excelPageName, 38, language);
    var checkTimeWeightedNetOfFees = GetData(filePath_Portefeuille, excelPageName, 39, language);
    var checkTimeWeightedGrossOfFees = GetData(filePath_Portefeuille, excelPageName, 40, language);
    var checkMoneyWeightedNetOfFees = GetData(filePath_Portefeuille, excelPageName, 41, language);
    var numbering = GetData(filePath_Portefeuille, excelPageName, 42, language);
    
    SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering);

    //Validate and save report
    ValidateAndSaveReportAsPDF(reportFolderPath + reportFileName);
}

function SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsEnabled)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().set_IsChecked(aqString.ToUpper(CheckExcludeDataPrecedingTheManagementStartDate) == "VRAI" || aqString.ToUpper(CheckExcludeDataPrecedingTheManagementStartDate) == "TRUE");    
    
    SetDateInDateTimePicker(Get_WinParameters_GrpPeriod_DtpEndDate(), endDate);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod(), period);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod1(), period1);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod2(), period2);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod3(), period3);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod4(), period4);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod5(), period5);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod6(), period6);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod7(), period7);
    
    if (Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsEnabled)
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().set_IsChecked(aqString.ToUpper(checkDisplayDefaultIndices) == "VRAI" || aqString.ToUpper(checkDisplayDefaultIndices) == "TRUE");    
    
    allIndicesCheckboxes = Get_WinParameters_GrpIndices_ChklstIndices().FindAllChildren("ClrClassName", "UniCheckBox", 10).toArray();
    for (i = 0; i < allIndicesCheckboxes.length; i++)
        allIndicesCheckboxes[i].set_IsChecked(false);
    arrayOfIndicesToBeChecked = new Array();
    if (Trim(indicesToBeChecked) != "")
        arrayOfIndicesToBeChecked = indicesToBeChecked.split("|");
    
    var i = 0; if(client == "VMBL" || client == "BNC" || client == "RJ" || client == "CIBC") i = 1;
    for (; i < arrayOfIndicesToBeChecked.length; i++)
        Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", Trim(arrayOfIndicesToBeChecked[i])], 10).set_IsChecked(true);

    if (Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().IsEnabled)
        Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().set_IsChecked(aqString.ToUpper(checkUseIndexBaseCurrency) == "VRAI" || aqString.ToUpper(checkUseIndexBaseCurrency) == "TRUE");    
        
    Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).set_IsChecked(true);
    
    Delay(200);
    
    if (Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().Exists && Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(), customAllocation);
    
    if (Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().Exists && Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().IsEnabled)
        Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().set_IsChecked(aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "VRAI" || aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "TRUE");    
    
    if (client != "RJ"){
        if (Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().IsEnabled)
            Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().set_IsChecked(aqString.ToUpper(checkFundBreakdownClassBreakdown) == "VRAI" || aqString.ToUpper(checkFundBreakdownClassBreakdown) == "TRUE");

        if (Get_WinParameters_GrpFundBreakdown_ChkAppendix().IsEnabled)
            Get_WinParameters_GrpFundBreakdown_ChkAppendix().set_IsChecked(aqString.ToUpper(checkFundBreakdownAppendix) == "VRAI" || aqString.ToUpper(checkFundBreakdownAppendix) == "TRUE");
    }
    
    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedNetOfFees) == "TRUE");

    if (Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().set_IsChecked(aqString.ToUpper(checkTimeWeightedGrossOfFees) == "VRAI" || aqString.ToUpper(checkTimeWeightedGrossOfFees) == "TRUE");

    if (Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsEnabled)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().set_IsChecked(aqString.ToUpper(checkMoneyWeightedNetOfFees) == "VRAI" || aqString.ToUpper(checkMoneyWeightedNetOfFees) == "TRUE");
    
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    Log.Message("CROES-10673");
    Get_WinParameters_BtnOK().Keys("[Enter]");
}