//USEUNIT Common_functions
//USEUNIT DBA
//USEUNIT PDFUtils


/**
    Description : CR1679, CAS DE TEST 1
    https://jira.croesus.com/browse/DAS-4418
    P:\aq\Conseillers QA\Carole\TEST AUTO\CR1679\Procédure pour régresser le CR1679.docx
    Analyste d'assurance qualité : Carole Turcotte
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/
function CR1679_001_Acc_all_trans()
{
    Log.Link("https://jira.croesus.com/browse/DAS-4418", "CR1679_001_Acc_all_trans()");
    
    var accountNo = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_001_Acc_all_trans_Account_Number", language + client);
    var FIRST_TRANS_DATE = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_001_Acc_all_trans_Account_FIRST_TRANS_DATE", language + client);
    var Portfolio_Performance_DisplayDetails = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_001_Acc_all_trans_Portfolio_Performance_DisplayDetails", language + client);
    var Performance_Monthly_StartDate = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_001_Acc_all_trans_Performance_Monthly_StartDate", language + client);
    var reportFileName = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_001_Acc_all_trans_ReportFileName", language + client);
    
    var Portfolio_Performance_Period_ToValidate = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_001_Acc_all_trans_Report_Portfolio_Performance_Period_ToValidate", language + client);
    var NetInvestmentAsOfReportDate_ExpectedValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_001_Acc_all_trans_NetInvestmentAsOfReportDate_Value", language + client);
    var InitialValue_ExpectedValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_001_Acc_all_trans_InitialValue_Value", language + client);
    var NetInvestment_ExpectedValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_001_Acc_all_trans_NetInvestment_Value", language + client);
    var Inflows_ExpectedValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_001_Acc_all_trans_Inflows_Value", language + client);
    var Outflows_ExpectedValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_001_Acc_all_trans_Outflows_Value", language + client);
    
    CR1679(accountNo, FIRST_TRANS_DATE, Portfolio_Performance_DisplayDetails, Performance_Monthly_StartDate, reportFileName, Portfolio_Performance_Period_ToValidate, NetInvestmentAsOfReportDate_ExpectedValue, InitialValue_ExpectedValue, NetInvestment_ExpectedValue, Inflows_ExpectedValue, Outflows_ExpectedValue);
}




/**
    Description : 
    P:\aq\Conseillers QA\Carole\TEST AUTO\CR1679\Procédure pour régresser le CR1679.docx
    Analyste d'assurance qualité : Carole Turcotte
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/
function CR1679(accountNo, FIRST_TRANS_DATE, Portfolio_Performance_DisplayDetails, Performance_Monthly_StartDate, reportFileName, Portfolio_Performance_Period_ToValidate, NetInvestmentAsOfReportDate_ExpectedValue, InitialValue_ExpectedValue, NetInvestment_ExpectedValue, Inflows_ExpectedValue, Outflows_ExpectedValue)
{
    Log.Link("P:\\aq\\Conseillers QA\\Carole\\TEST AUTO\\CR1679\\Procédure pour régresser le CR1679.docx", "Pour ouvrir le Document de la Procédure pour régresser le CR1679, cliquer sur le lien dans la colonne 'Link'.");
    
    try {
        var PDFReferenceFilePath = folderPath_Data + client + "\\CR1679\\ExpectedFolder\\" + reportFileName + ".pdf";
        var reportFilesFolder = folderPath_Data + client + "\\CR1679\\ResultFolder\\";
        aqFileSystem.CreateFolder(reportFilesFolder);
        var reportFilePath = reportFilesFolder + reportFileName;
        var PDFFilePath = reportFilePath + ".pdf";
        if (aqFileSystem.Exists(PDFFilePath))
            aqFileSystem.DeleteFile(PDFFilePath);
        
        var ReportName_Portfolio_Performance            = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "ReportName_Portfolio_Performance", language + client);
        var ReportName_Portfolio_Performance_Regulatory = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "ReportName_Portfolio_Performance_Regulatory", language + client);
        var ReportName_Portfolio_Performance_Graph      = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "ReportName_Portfolio_Performance_Graph", language + client);
        var ReportName_Portfolio_Performance_Simple     = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "ReportName_Portfolio_Performance_Simple", language + client);
        var ReportName_Portfolio_Performance_Monthly    = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "ReportName_Portfolio_Performance_Monthly", language + client);
        var ReportName_Portfolio_Performance_History    = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "ReportName_Portfolio_Performance_History", language + client);
        
        var testUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        var testUserPswd = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        //Préalable
        UpdatePrefAtLevelForUser(testUserName, "USE_STATIS_HISTO_FOR_INFLOW_OUTFLOW", "YES", "FIRM", vServerAccounts);
        UpdatePrefAtLevelForUser(testUserName, "PREF_REPORT_PERF_SIMPLE", "YES", "FIRM", vServerAccounts);
        UpdatePrefAtLevelForUser(testUserName, "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", "FIRM", vServerAccounts);
        UpdatePrefAtLevelForUser(testUserName, "PREF_SIMPLE_PERF_REPORT", "YES", "FIRM", vServerAccounts);
        Execute_SQLQuery("update B_COMPTE set FIRST_TRANS_DATE = '" + FIRST_TRANS_DATE + "' where NO_COMPTE = '" + accountNo + "'", vServerAccounts);
        
        //Pref PREF_TIME_MONEY_WEIGHTED = 3 pour avoir le préalable tel que présenté
        var no_succ = Execute_SQLQuery_GetField("select NO_SUCC from B_USER where STATION_ID = '" + testUserName + "'", vServerAccounts, "NO_SUCC");
        var firm_id = Execute_SQLQuery_GetField("select FIRM_ID from B_SUCC where NO_SUCC = '" + no_succ + "'", vServerAccounts, "FIRM_ID");
        var firm_code = Execute_SQLQuery_GetField("select FIRM_CODE from B_FIRM where FIRM_ID = " + firm_id, vServerAccounts, "FIRM_CODE");
        var userValuePref_PREF_TIME_MONEY_WEIGHTED = GetUserPrefValue(vServerAccounts, "PREF_TIME_MONEY_WEIGHTED", testUserName);
        var succValuePref_PREF_TIME_MONEY_WEIGHTED = GetSuccPrefValue(vServerAccounts, "PREF_TIME_MONEY_WEIGHTED", no_succ);
        var firmValuePref_PREF_TIME_MONEY_WEIGHTED = GetFirmPrefValue(vServerAccounts, "PREF_TIME_MONEY_WEIGHTED", firm_code);

        UpdatePrefAtLevelForUser(testUserName, "PREF_TIME_MONEY_WEIGHTED", "3", "FIRM", vServerAccounts);
        
        RestartServices(vServerAccounts);
        
        //Login et selection du compte
        Login(vServerAccounts, testUserName, testUserPswd, language);
        SelectAccounts(accountNo);
        
        //Selection et configuration des rapports
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        Get_Reports_GrpReports_TabReports().Click();
        Get_Reports_GrpReports_TabReports().WaitProperty("IsSelected", true, 60000);
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        //Rapport Performance du portefeuille
        SelectAReport(ReportName_Portfolio_Performance);
        if (!OpenReportParametersWindow())
            return Log.Error("Fenêtre Paramètres des rapports non ouvert.");
        var DisplayDetailsCheckboxValue = (aqString.ToUpper(Portfolio_Performance_DisplayDetails) == "VRAI" || aqString.ToUpper(Portfolio_Performance_DisplayDetails) == "TRUE");
        Get_WinParameters_ChkDisplayDetails().WaitProperty("IsEnabled", true, 10000);
        if (DisplayDetailsCheckboxValue != Get_WinParameters_ChkDisplayDetails().IsChecked.OleValue)
            Get_WinParameters_ChkDisplayDetails().Click();
        CompareProperty(Get_WinParameters_ChkDisplayDetails().IsChecked.OleValue, cmpEqual, DisplayDetailsCheckboxValue, true, lmError);
        Get_WinParameters_BtnOK().Click();
        

        //Rapport Performance du portefeuille (réglementaire)
        SelectAReport(ReportName_Portfolio_Performance_Regulatory);
        
        //Rapport Performance du portefeuille (graphique)
        SelectAReport(ReportName_Portfolio_Performance_Graph);
        
        //Rapport Performance du portefeuille (simple)
        SelectAReport(ReportName_Portfolio_Performance_Simple);
        
        //Rapport Performance du portefeuille (mensuelle)
        SelectAReport(ReportName_Portfolio_Performance_Monthly);
        if (!OpenReportParametersWindow())
            return Log.Error("Fenêtre Paramètres des rapports non ouvert.");
        Get_WinParameters_DtpStartDate().WaitProperty("IsEnabled", true, 10000);
        SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), Performance_Monthly_StartDate);
        CompareProperty(Get_WinParameters_DtpStartDate().StringValue.OleValue, cmpEqual, Performance_Monthly_StartDate, true, lmError);
        Get_WinParameters_BtnOK().Click();
        
        //Rapport Performance du portefeuille (historique)
        SelectAReport(ReportName_Portfolio_Performance_History);
        
        //Validate and save report
        ValidateReport(false, true, reportFileName);
        SaveAs_AcrobatReader(reportFilePath);
        
        if (!aqFileSystem.Exists(PDFFilePath))
            Log.Error("Le fichier PDF '" + PDFFilePath + "' n'a pas été obtenu, ceci est inattendu.");
        else {
            CR1679_Validations(PDFFilePath, Portfolio_Performance_Period_ToValidate, NetInvestmentAsOfReportDate_ExpectedValue, InitialValue_ExpectedValue, NetInvestment_ExpectedValue, Inflows_ExpectedValue, Outflows_ExpectedValue);
        }
        
        //Fermer Croesus
        Close_Croesus_MenuBar();
        SetAutoTimeOut();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation_BtnYes().Click();
        RestoreAutoTimeOut();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //Remise à leur état par défaut des préalables
        Execute_SQLQuery("update B_COMPTE set FIRST_TRANS_DATE = null where NO_COMPTE = '" + accountNo + "'", vServerAccounts);
        UpdatePrefAtLevelForUser(testUserName, "USE_STATIS_HISTO_FOR_INFLOW_OUTFLOW", null, "FIRM", vServerAccounts);
        UpdatePrefAtLevelForUser(testUserName, "PREF_REPORT_PERF_SIMPLE", null, "FIRM", vServerAccounts);
        UpdatePrefAtLevelForUser(testUserName, "PREF_ACCESS_PERFORMANCE_FIGURES", null, "FIRM", vServerAccounts);
        UpdatePrefAtLevelForUser(testUserName, "PREF_SIMPLE_PERF_REPORT", null, "FIRM", vServerAccounts);
        
        //Restauration de la Pref PREF_TIME_MONEY_WEIGHTED à sa valeur antérieure
        Activate_Inactivate_Pref(testUserName, "PREF_TIME_MONEY_WEIGHTED", userValuePref_PREF_TIME_MONEY_WEIGHTED, vServerAccounts);
        Activate_Inactivate_PrefBranch(no_succ, "PREF_TIME_MONEY_WEIGHTED", succValuePref_PREF_TIME_MONEY_WEIGHTED, vServerAccounts);
        Activate_Inactivate_PrefFirm(firm_code, "PREF_TIME_MONEY_WEIGHTED", firmValuePref_PREF_TIME_MONEY_WEIGHTED, vServerAccounts);
        
        RestartServices(vServerAccounts);
        Terminate_CroesusProcess();
    }
}



function OpenReportParametersWindow()
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return false;
    }
    else {
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
        var isReportParametersWindowOpened = WaitReportParametersWindow();
        if (!isReportParametersWindowOpened)
            Log.Error("The Report Parameters window was not opened!");
        
        return isReportParametersWindowOpened;
    }
}



function GetEachReportPartsFromPDF(PDFFilePath, arrayOfReportTitles)
{
    Log.Message("Extract text from PDF file '" + PDFFilePath + "' and group lines into array by reports titles : " + arrayOfReportTitles);
    
    //Initialize result Array
    var arrayOfEachReportParts = [];
    arrayOfEachReportParts["DEFAULT"] = [];
    for (var i = 0; i < arrayOfReportTitles.length; i++)
        arrayOfEachReportParts[arrayOfReportTitles[i]] = [];
    
    //Get Pdf Text
    var PDFFileText = GetPdfTextThroughCommandLine(PDFFilePath);
    if (PDFFileText === null){
        Log.Error("PDF file text extraction was not successfull : " + PDFFilePath);
        return [];
    }
    
    //Put retrieved PDFFileText into Array
    Log.Message("Retrieved text from PDF file : " + PDFFilePath, PDFFileText);
    var lineSeparator = (aqString.Find(PDFFileText, "\r\n") == -1)? "\n": "\r\n";
    var arrayOfPDFFileTextLines = PDFFileText.split(lineSeparator);
    var reportTitle = "DEFAULT";
    var arrayOfReportLines = [];
    for (var i = 0; i < arrayOfPDFFileTextLines.length; i++){
        var currentReportLine = Trim(arrayOfPDFFileTextLines[i]);
        if (GetIndexOfItemInArray(arrayOfReportTitles, currentReportLine) != -1)
            reportTitle = currentReportLine;
        arrayOfEachReportParts[reportTitle].push(currentReportLine);
    }
    
    return arrayOfEachReportParts;
}



function CR1679_Validations(PDFFilePath, Portfolio_Performance_Period_ToValidate, NetInvestmentAsOfReportDate_ExpectedValue, InitialValue_ExpectedValue, NetInvestment_ExpectedValue, Inflows_ExpectedValue, Outflows_ExpectedValue)
{
        var NetInvestmentAsOfReportDate_Label = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "Report_Portfolio_Performance_History_Label_NetInvestmentAsOfReportDate", language + client);
        var InitialValue_Label = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "Report_Portfolio_Performance_Monthly_Label_InitialValue", language + client);
        var NetInvestment_Label = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "Report_Portfolio_Performance_Monthly_Label_NetInvestment", language + client);
        var Inflows_Label = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "Report_Portfolio_Performance_Label_Inflows", language + client);
        var Outflows_Label = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "Report_Portfolio_Performance_Label_Outflows", language + client);
        var CurrencySymbol_AppendString = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "Report_ValuesCurrency_SymbolAppendString", language + client);
        
        var ReportTitle_Portfolio_Performance            = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "ReportTitle_Portfolio_Performance", language + client);
        var ReportTitle_Portfolio_Performance_Regulatory = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "ReportTitle_Portfolio_Performance_Regulatory", language + client);
        var ReportTitle_Portfolio_Performance_Graph      = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "ReportTitle_Portfolio_Performance_Graph", language + client);
        var ReportTitle_Portfolio_Performance_Simple     = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "ReportTitle_Portfolio_Performance_Simple", language + client);
        var ReportTitle_Portfolio_Performance_Monthly    = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "ReportTitle_Portfolio_Performance_Monthly", language + client);
        var ReportTitle_Portfolio_Performance_History    = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "ReportTitle_Portfolio_Performance_History", language + client);
        
        //Retrieve PDF file text and split it, group by reports titles
        var arrayOfReportTitles = [];
        arrayOfReportTitles.push(ReportTitle_Portfolio_Performance);
        arrayOfReportTitles.push(ReportTitle_Portfolio_Performance_Regulatory);
        arrayOfReportTitles.push(ReportTitle_Portfolio_Performance_Graph);
        arrayOfReportTitles.push(ReportTitle_Portfolio_Performance_Simple);
        arrayOfReportTitles.push(ReportTitle_Portfolio_Performance_Monthly);
        arrayOfReportTitles.push(ReportTitle_Portfolio_Performance_History);
        var arrayOfEachReportParts = GetEachReportPartsFromPDF(PDFFilePath, arrayOfReportTitles);
        
        //NetInvestmentAsOfReportDate validation in Portfolio_Performance_History
        Log.Message("Check in Report '" + ReportTitle_Portfolio_Performance_History + "' if " + NetInvestmentAsOfReportDate_Label + " = " + NetInvestmentAsOfReportDate_ExpectedValue);
        var arrayOfPerformanceHistoryText = arrayOfEachReportParts[ReportTitle_Portfolio_Performance_History];
        var NetInvestmentAsOfReportDate_Label_NbOccurrences = 0;
        for (var i = 0; i < arrayOfPerformanceHistoryText.length; i++){
            var currentLine = Trim(arrayOfPerformanceHistoryText[i]);
            if (aqString.Find(currentLine, NetInvestmentAsOfReportDate_Label) == 0){
                NetInvestmentAsOfReportDate_Label_NbOccurrences ++;
                var NetInvestmentAsOfReportDate_ActualValue = Trim(currentLine.split(NetInvestmentAsOfReportDate_Label)[1]);
                CheckEquals(NetInvestmentAsOfReportDate_ActualValue, NetInvestmentAsOfReportDate_ExpectedValue, "'" + NetInvestmentAsOfReportDate_Label + "' value in report " + ReportTitle_Portfolio_Performance_History);
            }
        }
        if (NetInvestmentAsOfReportDate_Label_NbOccurrences == 0)
            Log.Error("'" + NetInvestmentAsOfReportDate_Label + "' label not found in report " + ReportTitle_Portfolio_Performance_History);
        if (NetInvestmentAsOfReportDate_Label_NbOccurrences > 1)
            Log.Error("'" + NetInvestmentAsOfReportDate_Label + "' label found " + NetInvestmentAsOfReportDate_Label_NbOccurrences + " times instead of 1 time in report " + ReportTitle_Portfolio_Performance_History);

        
        //InitialValue and NetInvestment validation in Portfolio_Performance_Monthly
        Log.Message("Check in Report '" + ReportTitle_Portfolio_Performance_Monthly + "' if " + InitialValue_Label + " = " + InitialValue_ExpectedValue + " and " + NetInvestment_Label + " = " + NetInvestment_ExpectedValue);
        var arrayOfPerformanceMonthlyText = arrayOfEachReportParts[ReportTitle_Portfolio_Performance_Monthly];
        var InitialValueAndNetInvestment_Labels = InitialValue_Label + " " + NetInvestment_Label;
        var InitialValueAndNetInvestment_Labels_NbOccurrences = 0;
        for (var i = 0; i < arrayOfPerformanceMonthlyText.length; i++){
            var currentLabelsLine = Trim(arrayOfPerformanceMonthlyText[i]);
            if (aqString.Find(currentLabelsLine, InitialValueAndNetInvestment_Labels) == 0){
            //if (aqString.StrMatches("^" + InitialValue_Label + "(\\b)+" + NetInvestment_Label, currentLabelsLine)){
                InitialValueAndNetInvestment_Labels_NbOccurrences ++;
                if ((i+1) >= arrayOfPerformanceMonthlyText.length)
                    break;
                var currentValuesLine = Trim(arrayOfPerformanceMonthlyText[i+1]);
                var isCurrencySymbolAtBeginningOfcurrentValuesLine = (aqString.Find(currentValuesLine, CurrencySymbol_AppendString) == 0)? true: false;
                var InitialValueIndex = (isCurrencySymbolAtBeginningOfcurrentValuesLine === true)? 1: 0;
                var NetInvestmentIndex = (isCurrencySymbolAtBeginningOfcurrentValuesLine === true)? 2: 1;
                
                var currentValuesLineParts = currentValuesLine.split(CurrencySymbol_AppendString);
                if (currentValuesLineParts.length < (NetInvestmentIndex + 1)){
                    Log.Error("Not enough currency values found in the supposed Initial Value And Net Investment line.");
                    continue;
                }
                
                var InitialValue_ActualValue = (isCurrencySymbolAtBeginningOfcurrentValuesLine === true)? CurrencySymbol_AppendString + Trim(currentValuesLineParts[InitialValueIndex]): Trim(currentValuesLineParts[InitialValueIndex]) + CurrencySymbol_AppendString;
                var NetInvestment_ActualValue = (isCurrencySymbolAtBeginningOfcurrentValuesLine === true)? CurrencySymbol_AppendString + Trim(currentValuesLineParts[NetInvestmentIndex]): Trim(currentValuesLineParts[NetInvestmentIndex]) + CurrencySymbol_AppendString;
                CheckEquals(InitialValue_ActualValue, InitialValue_ExpectedValue, "'" + InitialValue_Label + "' value in report " + ReportTitle_Portfolio_Performance_Monthly);
                CheckEquals(NetInvestment_ActualValue, NetInvestment_ExpectedValue, "'" + NetInvestment_Label + "' value in report " + ReportTitle_Portfolio_Performance_Monthly);
            }
        }
        if (InitialValueAndNetInvestment_Labels_NbOccurrences == 0)
            Log.Error("'" + InitialValueAndNetInvestment_Labels + "' labels line not found in report " + ReportTitle_Portfolio_Performance_Monthly);
        if (InitialValueAndNetInvestment_Labels_NbOccurrences > 1)
            Log.Error("'" + InitialValueAndNetInvestment_Labels + "' labels line found " + InitialValueAndNetInvestment_Labels_NbOccurrences + " times instead of 1 time in report " + ReportTitle_Portfolio_Performance_Monthly);

            
        //Inflows and Outflows validation in Portfolio_Performance
        Log.Message("Check in Report '" + ReportTitle_Portfolio_Performance + "' if " + Inflows_Label + " = " + Inflows_ExpectedValue + " and " + Outflows_Label + " = " + Outflows_ExpectedValue + " for period " + Portfolio_Performance_Period_ToValidate);
        var arrayOfPerformanceText = arrayOfEachReportParts[ReportTitle_Portfolio_Performance];
        var PeriodIndex = GetIndexOfItemInArray(arrayOfPerformanceText, Portfolio_Performance_Period_ToValidate);
        if (PeriodIndex == -1)
            Log.Error("Period '" + Portfolio_Performance_Period_ToValidate + "' not found in report " + ReportTitle_Portfolio_Performance);
        else {
            //Inflows
            var InflowsIndex = GetIndexOfItemInArray(arrayOfPerformanceText, Inflows_Label);
            if (InflowsIndex == -1)
                Log.Error("Label '" + Inflows_Label + "' not found in report " + ReportTitle_Portfolio_Performance);
            else {
                var InflowsIndexOffset = GetPrecedentFirstNumberItemOffset(arrayOfPerformanceText, InflowsIndex);
                if (InflowsIndexOffset === null)
                    Log.Error("Unable to get '" + Inflows_Label + "' value offset in report " + ReportTitle_Portfolio_Performance);
                else {
                    var Inflows_ActualValue = arrayOfPerformanceText[PeriodIndex + InflowsIndexOffset];
                    CheckEquals(Inflows_ActualValue, Inflows_ExpectedValue, "'" + Inflows_Label + "' value in report " + ReportTitle_Portfolio_Performance + " for period " + Portfolio_Performance_Period_ToValidate);
                }
            }
            
            //Outflows
            var OutflowsIndex = GetIndexOfItemInArray(arrayOfPerformanceText, Outflows_Label);
            if (OutflowsIndex == -1)
                Log.Error("Label '" + Outflows_Label + "' not found in report " + ReportTitle_Portfolio_Performance);
            else {
                var OutflowsIndexOffset = GetPrecedentFirstNumberItemOffset(arrayOfPerformanceText, OutflowsIndex);
                if (OutflowsIndexOffset === null)
                    Log.Error("Unable to get '" + Outflows_Label + "' value offset in report " + ReportTitle_Portfolio_Performance);
                else {
                    var Outflows_ActualValue = arrayOfPerformanceText[PeriodIndex + OutflowsIndexOffset];
                    CheckEquals(Outflows_ActualValue, Outflows_ExpectedValue, "'" + Outflows_Label + "' value in report " + ReportTitle_Portfolio_Performance + " for period " + Portfolio_Performance_Period_ToValidate);
                }
            }
            
        }
        
        
        function GetPrecedentFirstNumberItemOffset(arr, fromIndex)
        {
            var arrayMaxIndex = arr.length - 1;
            if (fromIndex > arrayMaxIndex){
                Log.Error("fromIndex " + fromIndex + " is higher than the array maximum index " + arrayMaxIndex);
                return null;
            }
            
            for (var k = fromIndex; k >= 0; k--)
                if (aqString.StrMatches("(\\d)+", arr[k]))
                    return (fromIndex - k);
                    
            Log.Error("No precedent number item found from fromIndex = " + fromIndex);
            return null;
        }
}
