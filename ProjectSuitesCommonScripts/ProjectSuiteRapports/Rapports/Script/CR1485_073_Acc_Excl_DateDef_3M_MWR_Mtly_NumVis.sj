//USEUNIT CR1485_005_Acc_DateDef_PerDef_MWR_Det_NumVis
//USEUNIT CR1485_073_Common_functions



/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\73. Performance du portefeuille (graphique)\3.1 Comptes
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_073_Acc_Excl_DateDef_3M_MWR_Mtly_NumVis()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\73. Performance du portefeuille (graphique)\\3.1 Comptes\\", "CR1485_073_Acc_Excl_DateDef_3M_MWR_Mtly_NumVis()");
    Log.Message("CR1679");
    Log.Message("Anomalie JIRA CROES-9251");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 1, language);
        var accountsNumbers = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 124);
        var accountsFirstTransDate = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 125);
        var arrayOfAccountsNumbers = accountsNumbers.split("|");
        var arrayOf_FIRST_TRANS_DATE = accountsFirstTransDate.split("|");
        
        //Activate Prefs
        CR1485_073_Common_functions.ActivatePrefs();
        
        //Prepare DB for CR1679
        CR1485_PreparationBD_CR1679(arrayOfAccountsNumbers, arrayOf_FIRST_TRANS_DATE);
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 128);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 131, language);
        var sortBy = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 132, language);
        var currency = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 133, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 134, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 135, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 136, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 137, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 138, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 139, language);
        var message = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 140, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var CheckExcludeDataPrecedingTheManagementStartDate = GetBooleanValue(GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 143, language));
        var endDate = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 144, language);
        var period1 = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 145, language);
        var checkTimeWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 146, language));
        var checkTimeWeightedGrossOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 147, language));
        var checkMoneyWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 148, language));
        var data = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 149, language);
        var numbering = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 154, language);
        
        var performanceCalculations = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 150, language);
        var checkDisplayDefaultIndices = GetBooleanValue(GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 151, language));
        var indicesToBeChecked = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 152, language);
        var checkUseIndexBaseCurrency = GetBooleanValue(GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 153, language));

        
        SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period1, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, data, numbering, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 157);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 160, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 161, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period1, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, data, numbering, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency);
        
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



function SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period1, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, data, numbering, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (CheckExcludeDataPrecedingTheManagementStartDate != Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().Click();
        
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate(), endDate);
    
    SelectComboBoxItem(Get_WinParameters_CmbPeriod1(), period1);
    
    if (checkTimeWeightedNetOfFees != Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().Click();
        
    if (checkTimeWeightedGrossOfFees != Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().Click();
    
    if (checkMoneyWeightedNetOfFees != Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().Click();
    
    if (true !== Get_WinParameters_GrpData().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", data], 10).IsChecked.OleValue)
        Get_WinParameters_GrpData().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", data], 10).Click();
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering2(), numbering);
    
    CompareProperty(Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue, cmpEqual, CheckExcludeDataPrecedingTheManagementStartDate, true, lmError);
    CompareProperty(Get_WinParameters_GrpData().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", data], 10).IsChecked.OleValue, cmpEqual, true, true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsChecked.OleValue, cmpEqual, checkTimeWeightedNetOfFees, true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsChecked.OleValue, cmpEqual, checkTimeWeightedGrossOfFees, true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue, cmpEqual, checkMoneyWeightedNetOfFees, true, lmError);
    
    if (performanceCalculations != undefined && true !== Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).IsChecked.OleValue){
        Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).Click();
        Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).WaitProperty("IsChecked.OleValue", true, 5000);
        CompareProperty(Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", performanceCalculations], 10).IsChecked.OleValue, cmpEqual, true, true, lmError);
    }
    
    if (checkDisplayDefaultIndices != undefined && checkDisplayDefaultIndices != Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsChecked.OleValue){
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().Click();
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().WaitProperty("IsChecked.OleValue", checkDisplayDefaultIndices, 5000);
        CompareProperty(Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsChecked.OleValue, cmpEqual, checkDisplayDefaultIndices, true, lmError);
    }
    
    if (indicesToBeChecked != undefined && Trim(indicesToBeChecked) != "")
        CheckIndices(indicesToBeChecked);
    
    if (checkUseIndexBaseCurrency != undefined && checkUseIndexBaseCurrency != Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().IsChecked.OleValue){
        Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().Click();
        Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().WaitProperty("IsChecked.OleValue", checkUseIndexBaseCurrency, 5000);
        CompareProperty(Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency().IsChecked.OleValue, cmpEqual, checkUseIndexBaseCurrency, true, lmError);
    }
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}
