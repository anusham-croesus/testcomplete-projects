//USEUNIT CR1485_005_Acc_DateDef_PerDef_MWR_Det_NumVis
//USEUNIT CR1485_113_Common_functions




/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\113. PERFORMANCE DE VOS PLACEMENTS\3.1 Comptes
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_113_Acc_Excl_DateDef_PerDef_MWR_NumVis()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\113. PERFORMANCE DE VOS PLACEMENTS\\3.1 Comptes\\", "CR1485_113_Acc_Excl_DateDef_PerDef_MWR_NumVis()");
    Log.Message("CR1679");
    Log.Message("Anomalie JIRA CROES-9251");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 1, language);
        var accountsNumbers = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 136);
        var accountsFirstTransDate = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 137);
        var arrayOfAccountsNumbers = accountsNumbers.split("|");
        var arrayOf_FIRST_TRANS_DATE = accountsFirstTransDate.split("|");
        
        //Activate Prefs
        CR1485_113_Common_functions.ActivatePrefs();
        
        //Prepare DB for CR1679
        Log.Message("Préparation de la BD");
        CR1485_PreparationBD_CR1679(arrayOfAccountsNumbers, arrayOf_FIRST_TRANS_DATE);
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        Log.Message("Sélection des comptes");
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 139);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 142, language);
        var currency = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 144, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 145, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, null, currency, reportLanguage, null, null, null, null, null, null);
        
        //Parameters values
        var CheckExcludeDataPrecedingTheManagementStartDate = GetBooleanValue(GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 154, language));
        var endDate = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 155, language);
        var period = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 156, language);
        var period1 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 157, language);
        var period2 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 158, language);
        var period3 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 159, language);
        var period4 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 160, language);
        var period5 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 161, language);
        
        var CheckDisplayDefaultIndex = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 162, language);
        
        var checkTimeWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 165, language));
        var checkTimeWeightedGrossOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 166, language));
        var checkMoneyWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 167, language));
        var numbering = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 169, language);
        
        Log.Message("Sélection des paramètres du rapport");
        SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, CheckDisplayDefaultIndex, endDate, period, period1, period2, period3, period4, period5, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 172);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 175, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 176, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, null, currency, reportLanguage, null, null, null, null, null, null);
        
        //Parameters values (same as for the English report)
        Log.Message("Sélection des paramètres du rapport (les mêmes que le rapport en anglais)");
        SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, CheckDisplayDefaultIndex, endDate, period, period1, period2, period3, period4, period5, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering);
        
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




function SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, CheckDisplayDefaultIndex, endDate, period, period1, period2, period3, period4, period5, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (CheckExcludeDataPrecedingTheManagementStartDate != Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().Click();
        
    if (CheckDisplayDefaultIndex != Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsChecked.OleValue)
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().Click();
    
    SetDateInDateTimePicker(Get_WinParameters_GrpPeriod_DtpEndDate(), endDate);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod(), period);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod1(), period1);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod2(), period2);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod3(), period3);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod4(), period4);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod5(), period5);
    
    Log.Link("https://jira.croesus.com/browse/TCVE-332", "Suite à la story TCVE-332, il faut que seulement la case Money Weigthed (Net) soit cochée");
    //Section "Performance - Frais"
    if (checkTimeWeightedNetOfFees != Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().Click();
        
    if (checkTimeWeightedGrossOfFees != Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().Click();
        
    if (checkMoneyWeightedNetOfFees != Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().Click();

    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    CompareProperty(Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue, cmpEqual, CheckExcludeDataPrecedingTheManagementStartDate, true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsChecked.OleValue, cmpEqual, checkTimeWeightedNetOfFees, true, lmWarning);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsChecked.OleValue, cmpEqual, checkTimeWeightedGrossOfFees, true, lmWarning);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue, cmpEqual, checkMoneyWeightedNetOfFees, true, lmError);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}
