//USEUNIT CR1485_005_Acc_DateDef_PerDef_MWR_Det_NumVis
//USEUNIT CR1485_074_Common_functions


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\74. PERFORMANCE DU PORTEFEUILLE (HISTORIQUE)\3.2 Comptes\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_074_Acc_Excl_DateDef_PerDef_RepBase_MWR_NumVis()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\74. PERFORMANCE DU PORTEFEUILLE (HISTORIQUE)\\3.2 Comptes\\", "CR1485_074_Acc_Excl_DateDef_PerDef_RepBase_MWR_NumVis()");
    Log.Message("CR1679");
    Log.Message("Anomalie JIRA CROES-9251");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 1, language);
        var accountsNumbers = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 191);
        var accountsFirstTransDate = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 192);
        var arrayOfAccountsNumbers = accountsNumbers.split("|");
        var arrayOf_FIRST_TRANS_DATE = accountsFirstTransDate.split("|");
        
        //Activate Prefs
        CR1485_074_Common_functions.ActivatePrefs();
        
        //Prepare DB for CR1679
        CR1485_PreparationBD_CR1679(arrayOfAccountsNumbers, arrayOf_FIRST_TRANS_DATE);
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 195);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 198, language);
        var currency = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 200, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 201, language);
        SetReportsOptions(destination, null, currency, reportLanguage, null, null, null, null, null, null);
        
        //Parameters values
        var CheckExcludeDataPrecedingTheManagementStartDate = GetBooleanValue(GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 210, language));
        var endDate = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 211, language);
        var period = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 212, language);
        var period1 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 213, language);
        var period2 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 214, language);
        var period3 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 215, language);
        var period4 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 216, language);
        var period5 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 217, language);
        var period6 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 218, language);
        var period7 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 219, language);
        var assetAllocation = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 220, language);
        var checkTimeWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 223, language));
        var checkTimeWeightedGrossOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 224, language));
        var checkMoneyWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 225, language));
        var numbering = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 227, language);
        
        SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, assetAllocation, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 230);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 233, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 234, language);
        SetReportsOptions(destination, null, currency, reportLanguage, null, null, null, null, null, null);
        
        //Parameters values (same as for the English report)
        SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, assetAllocation, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //Restore DB CR1679
        CR1485_RestoreBD_CR1679(arrayOfAccountsNumbers);
        Terminate_CroesusProcess();
    }
    
}



function SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, assetAllocation, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (CheckExcludeDataPrecedingTheManagementStartDate != Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().Click();
    
    SetDateInDateTimePicker(Get_WinParameters_GrpPeriod_DtpEndDate(), endDate);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod(), period);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod1(), period1);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod2(), period2);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod3(), period3);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod4(), period4);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod5(), period5);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod6(), period6);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod7(), period7);
    
    if (true !== Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).IsChecked.OleValue)
        Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).Click();
    
    if (checkMoneyWeightedNetOfFees != Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().Click();
    
    CompareProperty(Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue, cmpEqual, CheckExcludeDataPrecedingTheManagementStartDate, true, lmError);
    CompareProperty(Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).IsChecked.OleValue, cmpEqual, true, true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsChecked.OleValue, cmpEqual, checkTimeWeightedNetOfFees, true, lmWarning);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsChecked.OleValue, cmpEqual, checkTimeWeightedGrossOfFees, true, lmWarning);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue, cmpEqual, checkMoneyWeightedNetOfFees, true, lmError);
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}
