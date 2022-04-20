//USEUNIT CR1485_005_Acc_DateDef_PerDef_MWR_Det_NumVis
//USEUNIT CR1485_041_Common_functions





/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\41. Rendement mensuel\3.1 Comptes
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-14--V9-croesus-co7x-1_8_1_650
*/

function CR1485_041_Acc_Excl_DateModf_PerDef_MWR_NumVis()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\41. Rendement mensuel\\3.1 Comptes\\", "CR1485_041_Acc_Excl_DateModf_PerDef_MWR_NumVis()");
    Log.Message("CR1679");
    Log.Message("Anomalie JIRA CROES-9251");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 1, language);
        var accountsNumbers = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 124);
        var accountsFirstTransDate = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 125);
        var arrayOfAccountsNumbers = accountsNumbers.split("|");
        var arrayOf_FIRST_TRANS_DATE = accountsFirstTransDate.split("|");
        
        //Activate Prefs
        Log.Message("Activation des PREFs");
        CR1485_041_Common_functions.ActivatePrefs();
        
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
        var reportFileName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 127);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 130, language);
        var currency = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 132, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 133, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, null, currency, reportLanguage, null, null, null, null, null, null);
        
        //Parameters values
        var CheckExcludeDataPrecedingTheManagementStartDate = GetBooleanValue(GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 141, language));
        var startDate = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 142, language);
        var endDate = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 143, language);
        var periodsToBeChecked = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 144, language);
        var checkDisplayDefaultIndices = GetBooleanValue(GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 145, language));
        var checkTimeWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 148, language));
        var checkTimeWeightedGrossOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 149, language));
        var checkMoneyWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 150, language));
        var numbering = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 152, language);
        
        Log.Message("Sélection des paramètres du rapport");
        SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, periodsToBeChecked, checkDisplayDefaultIndices, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 155);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 158, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 159, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, null, currency, reportLanguage, null, null, null, null, null, null);
        
        //Parameters values (same as for the English report)
        Log.Message("Sélection des paramètres du rapport (les mêmes que le rapport en anglais");
        SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, periodsToBeChecked, checkDisplayDefaultIndices, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //Restor DB CR1679
        CR1485_RestoreBD_CR1679(arrayOfAccountsNumbers);
        Terminate_CroesusProcess();
    }
    
}



function SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, periodsToBeChecked, checkDisplayDefaultIndices, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (CheckExcludeDataPrecedingTheManagementStartDate != Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().Click();
        
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    var allPeriodsCheckboxes = Get_WinParameters_GrpPeriod().FindAllChildren("ClrClassName", "UniCheckBox", 10).toArray();
    if (aqString.ToUpper(periodsToBeChecked) == "TOUTES" || aqString.ToUpper(periodsToBeChecked) == "TOUS" || aqString.ToUpper(periodsToBeChecked) == "ALL"){
        for (var i = 0; i < allPeriodsCheckboxes.length; i++)
            allPeriodsCheckboxes[i].set_IsChecked(true);
    }
    else {
        for (var i = 0; i < allPeriodsCheckboxes.length; i++)
            allPeriodsCheckboxes[i].set_IsChecked(false);
        if (Trim(periodsToBeChecked) != "" && aqString.ToUpper(periodsToBeChecked) != "AUCUNE" && aqString.ToUpper(periodsToBeChecked) != "AUCUN" && aqString.ToUpper(periodsToBeChecked) != "NONE"){
            arrayOfPeriodsToBeChecked = periodsToBeChecked.split("|");
            for (var i = 0; i < arrayOfPeriodsToBeChecked.length; i++)
                Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", Trim(arrayOfPeriodsToBeChecked[i])], 10).set_IsChecked(true);
        }
    }
    
    if (checkDisplayDefaultIndices != Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsChecked.OleValue)
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().Click();
        
    Log.Link("https://jira.croesus.com/browse/TCVE-332");
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
    CompareProperty(Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsChecked.OleValue, cmpEqual, checkDisplayDefaultIndices, true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsChecked.OleValue, cmpEqual, checkTimeWeightedNetOfFees, true, lmWarning);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsChecked.OleValue, cmpEqual, checkTimeWeightedGrossOfFees, true, lmWarning);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue, cmpEqual, checkMoneyWeightedNetOfFees, true, lmError);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}