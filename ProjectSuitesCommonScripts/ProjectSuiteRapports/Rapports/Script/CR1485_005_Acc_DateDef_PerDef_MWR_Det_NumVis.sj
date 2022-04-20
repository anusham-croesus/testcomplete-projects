//USEUNIT CR1485_Common_functions
//USEUNIT CR1485_005_Common_functions




/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\5. PERFORMANCE DU PORTEFEUILLE\3.3 Comptes
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-14--V9-croesus-co7x-1_8_1_650
*/

function CR1485_005_Acc_DateDef_PerDef_MWR_Det_NumVis()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\5. PERFORMANCE DU PORTEFEUILLE\\3.3 Comptes\\", "CR1485_005_Acc_DateDef_PerDef_MWR_Det_NumVis()");
    Log.Message("CR1679");
    Log.Message("Anomalie JIRA CROES-9251");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 1, language);
        var accountsNumbers = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 399);
        var accountsFirstTransDate = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 400);
        var arrayOfAccountsNumbers = accountsNumbers.split("|");
        var arrayOf_FIRST_TRANS_DATE = accountsFirstTransDate.split("|");
        
        //Activate Prefs
        CR1485_005_Common_functions.ActivatePrefs();
        
        //Prepare DB for CR1679
        CR1485_PreparationBD_CR1679(arrayOfAccountsNumbers, arrayOf_FIRST_TRANS_DATE);
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        Log.Message("Sélection des comptes");
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 402);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        var destination = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 405, language);
        var currency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 407, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 408, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, null, currency, reportLanguage, null, null, null, null, null, null);
        
        //Parameters values
        var CheckExcludeDataPrecedingTheManagementStartDate = GetBooleanValue(GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 417, language));
        var endDate = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 418, language);
        var period = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 419, language);
        var period1 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 420, language);
        var period2 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 421, language);
        var period3 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 422, language);
        var period4 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 423, language);
        var period5 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 424, language);
        var checkDisplayDefaultIndices = GetBooleanValue(GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 425, language));
        var checkTimeWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 435, language));
        var checkTimeWeightedGrossOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 436, language));
        var checkMoneyWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 437, language));
        var checkDisplayDetails = GetBooleanValue(GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 443, language));
        var numbering = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 444, language);
        
        Log.Message("Sélection des paramètres du rapport");
        SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkDisplayDetails, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 447);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 450, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 451, language);
        SetReportsOptions(destination, null, currency, reportLanguage, null, null, null, null, null, null);
        
        //Parameters values (same as for the English report)
        Log.Message("Sélection des paramètres du rapport (les mêmes que le rapport en anglais)");
        SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkDisplayDetails, numbering);
        
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



function SetReportParametersCR1679(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkDisplayDetails, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (CheckExcludeDataPrecedingTheManagementStartDate != Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue)
        Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().Click();
    
    //Section "Periode"
    SetDateInDateTimePicker(Get_WinParameters_GrpPeriod_DtpEndDate(), endDate);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod(), period);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod1(), period1);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod2(), period2);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod3(), period3);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod4(), period4);
    
    SelectComboBoxItem(Get_WinParameters_GrpPeriod_CmbPeriod5(), period5);
    
    if (checkDisplayDefaultIndices != Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsChecked.OleValue)
        Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().Click();
        
    //Section "Performance - Frais"
    Log.Link("https://jira.croesus.com/browse/TCVE-332");
       
    //Checkbox: Time Weighted Fees (Net)
    if (checkTimeWeightedNetOfFees != Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().Click();
        
    //Checkbox: Time Weighted Fees (Gross)   
    if (checkTimeWeightedGrossOfFees != Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().Click();
        
    //Checkbox: Money Weighted Fees (Net)  
    if (checkMoneyWeightedNetOfFees != Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue)
        Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().Click();
        
    //Checkbox "Afficher le detail"
    if (checkDisplayDetails != Get_WinParameters_ChkDisplayDetails().IsChecked.OleValue)
        Get_WinParameters_ChkDisplayDetails().Click();
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    CompareProperty(Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate().IsChecked.OleValue, cmpEqual, CheckExcludeDataPrecedingTheManagementStartDate, true, lmError);
    CompareProperty(Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices().IsChecked.OleValue, cmpEqual, checkDisplayDefaultIndices, true, lmError);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees().IsChecked.OleValue, cmpEqual, checkTimeWeightedNetOfFees, true, lmWarning);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees().IsChecked.OleValue, cmpEqual, checkTimeWeightedGrossOfFees, true, lmWarning);
    CompareProperty(Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees().IsChecked.OleValue, cmpEqual, checkMoneyWeightedNetOfFees, true, lmError);
    CompareProperty(Get_WinParameters_ChkDisplayDetails().IsChecked.OleValue, cmpEqual, checkDisplayDetails, true, lmError);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}



function CR1485_PreparationBD_CR1679(arrayOfAccountsNumbers, arrayOf_FIRST_TRANS_DATE)
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\5. PERFORMANCE DU PORTEFEUILLE\\3.3 Comptes\\Procédure+Pref.txt", "CR1485_PreparationBD_CR1679()");
    
    //Pref Niveau FIRME: USE_STATIS_HISTO_FOR_INFLOW_OUTFLOW = YES
    UpdatePrefAtLevelForUser(userNameReportsCR1485, "USE_STATIS_HISTO_FOR_INFLOW_OUTFLOW", "YES", "FIRM", vServerReportsCR1485);
    
    //Rouler les commandes SQL
    var SQLQuery = "";
    for (var i = 0; i < arrayOfAccountsNumbers.length; i++)
        SQLQuery += "update b_compte set FIRST_TRANS_DATE = \"" + arrayOf_FIRST_TRANS_DATE[i] + "\" where no_compte in (\"" + arrayOfAccountsNumbers[i] + "\"" + ")\r\n";
    Log.Message("Rouler commandes SQL pour mettre à jour FIRST_TRANS_DATE.", SQLQuery);
    Execute_SQLQuery(SQLQuery, vServerReportsCR1485);
    
    //Repartir les services
    RestartServices(vServerReportsCR1485);
    
    //Validation des calculs
    var periodsCount = 5;
    Log.Message("Validation des calculs comptes : " + arrayOfAccountsNumbers)
    for (var i = 0; i < arrayOfAccountsNumbers.length; i++){
        var accountNumber = arrayOfAccountsNumbers[i];
        Log.Message("Validation des calculs (RENTRÉES/SORTIES des périodes) pour le compte '" + accountNumber + "'")
        for (var j = 1; j <= periodsCount; j++){
            var excelAccountPeriodRowID = "CR1679_CROES_9251_ValidationCalculs_Compte_" + accountNumber + "_Period_" +IntToStr(j);
            var periodLabel = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1679", excelAccountPeriodRowID, language + "_Period_Label");
            var periodStart = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1679", excelAccountPeriodRowID, "DATE_DEBUT");
            var periodEnd = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1679", excelAccountPeriodRowID, "DATE_FIN");
            var expectedInflows = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1679", excelAccountPeriodRowID, "RENTREES");
            var expectedOutflows = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1679", excelAccountPeriodRowID, "SORTIES");
            expectedInflows = (Trim(expectedInflows) == "")? null: expectedInflows;
            expectedOutflows = (Trim(expectedOutflows) == "")? null: expectedOutflows;
            
            var queryInflows = "select sum (MOENCAISSE) as INFLOWS from B_STATIS where NO_COMPTE in ('" + accountNumber + "') and MOENCAISSE > 0 and DATE_MAJ >= '" + periodStart + "' and DATE_MAJ <= '" + periodEnd + "'";
            var queryOutflows = "select sum (MOENCAISSE) as OUTFLOWS from B_STATIS where NO_COMPTE in ('" + accountNumber + "') and MOENCAISSE < 0 and DATE_MAJ >= '" + periodStart + "' and DATE_MAJ <= '" + periodEnd + "'";
            var actualInflows = Execute_SQLQuery_GetField(queryInflows, vServerReportsCR1485, "INFLOWS");
            var actualOutflows = Execute_SQLQuery_GetField(queryOutflows, vServerReportsCR1485, "OUTFLOWS");
            CheckEquals(actualInflows, expectedInflows, "Account " + accountNumber + " '" + periodLabel + "' (" + periodStart + " - " + periodEnd + ") INFLOWS validation");
            CheckEquals(actualOutflows, expectedOutflows, "Account " + accountNumber + " '" + periodLabel + "' (" + periodStart + " - " + periodEnd + ") OUTFLOWS validation");
        }
    }
}



function CR1485_RestoreBD_CR1679(arrayOfAccountsNumbers)
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\5. PERFORMANCE DU PORTEFEUILLE\\3.3 Comptes\\Procédure+Pref.txt", "CR1485_RestoreBD_CR1679()");

    //Pref Niveau FIRME: USE_STATIS_HISTO_FOR_INFLOW_OUTFLOW = YES
    UpdatePrefAtLevelForUser(userNameReportsCR1485, "USE_STATIS_HISTO_FOR_INFLOW_OUTFLOW", "NO", "FIRM", vServerReportsCR1485);
    
    //Rouler les commandes SQL
    if (arrayOfAccountsNumbers != undefined){
        var SQLQuery = "";
        for (var i = 0; i < arrayOfAccountsNumbers.length; i++)
            SQLQuery += "update b_compte set first_trans_date = null where no_compte = \"" + arrayOfAccountsNumbers[i] + "\"\r\n";
        Log.Message("Rouler commandes SQL pour restaurer FIRST_TRANS_DATE.", SQLQuery);
        Execute_SQLQuery(SQLQuery, vServerReportsCR1485);
    }
    
    //Repartir les services
    RestartServices(vServerReportsCR1485);
}
