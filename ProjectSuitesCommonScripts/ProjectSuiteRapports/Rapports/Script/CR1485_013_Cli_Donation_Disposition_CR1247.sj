//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables



/**
    Description : "P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\13. Transactions\2.1 Clients\\"
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Abdel Matmat
*/

function CR1485_013_Cli_Donation_Disposition_CR1247()
{
       
    try {
        Log.Message("CR1247");
        Log.Message("JIRA CROES-10102");
    
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                
        var reportName = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 108, language);
        var arrayOfReportsNames = reportName.split("|");      
        var clientsNumbers = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 109);
        var arrayOfClientsNumbers = clientsNumbers.split("|");
        
        

        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 111);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Select the third report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 114, language);
        sortBy = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 115, language);
        currency = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 116, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 117, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 118, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 119, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 120, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 121, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 122, language);
        message = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 123, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 150, language);
        positionState = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 151, language);
        numbering2 = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 152, language);
        
        SetReportParameters3(asOfDate, positionState, numbering2);
        
        //Select the second report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 135, language);
        startDate1 = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 136, language);
        endDate1 = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 137, language);
        checkIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 138, language);
        checkIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 139, language);
        //checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 140, language);
        checkGroupBySecurity1 = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 141, language);
        checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 142, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "013_TRANSACTION", 144, language): GetData(filePath_ReportsCR1485, "013_TRANSACTION", 143, language);
        transactionDate = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 145, language);
        numbering1 = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 146, language);
        //checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 147, language);
        
        SetReportParameters2(checkPreviousCalendarYear, startDate1, endDate1, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity1, checkOneReportPerAccount, costCalculation, transactionDate, numbering1/*, checkCostDisplayedTheoreticalValue/*, checkIncludeNonregisteredAccountsOnly*/);
        
        
        //Select the first report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Parameters values
        transactionTypesToBeChecked = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 126, language);
        startDate = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 127, language);
        endDate = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 128, language);
        checkGroupByRecord = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 129, language);
        checkGroupByTransactionType = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 130, language);
        checkGroupBySecurity = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 131, language);
        numbering = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 132, language);
        
        SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report ****************************************************************************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 157);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Select the third report (Transactions ACB et Quantité) and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 160, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 161, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters3(asOfDate, positionState, numbering2);
        
        //Select the second report (Gains et Pertes Réalisés) and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        
        //Parameters values (same as for the English report)
        SetReportParameters2(checkPreviousCalendarYear, startDate1, endDate1, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity1, checkOneReportPerAccount, costCalculation, transactionDate, numbering1/*, checkCostDisplayedTheoreticalValue/*, checkIncludeNonregisteredAccountsOnly*/);
        
        //Select the first (Transactions) report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
         //Parameters values (same as for the English report)
        SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}

function SetReportParameters2(checkPreviousCalendarYear, startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity, checkOneReportPerAccount, costCalculation, transactionDate, numbering, checkCostDisplayedTheoreticalValue, checkIncludeNonregisteredAccountsOnly)
{
   if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();

    if (Get_WinParameters_ChkPreviousCalendarYear().IsEnabled)
        Get_WinParameters_ChkPreviousCalendarYear().set_IsChecked(aqString.ToUpper(checkPreviousCalendarYear) == "VRAI" || aqString.ToUpper(checkPreviousCalendarYear) == "TRUE");
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    if (Get_WinParameters_ChkIncludeInterestAndDividends().IsEnabled)
        Get_WinParameters_ChkIncludeInterestAndDividends().set_IsChecked(aqString.ToUpper(checkIncludeInterestAndDividends) == "VRAI" || aqString.ToUpper(checkIncludeInterestAndDividends) == "TRUE");
    
    if (Get_WinParameters_ChkIncludeTotalGainAndLossBreakdown().IsEnabled)
        Get_WinParameters_ChkIncludeTotalGainAndLossBreakdown().set_IsChecked(aqString.ToUpper(checkIncludeTotalGainAndLossBreakdown) == "VRAI" || aqString.ToUpper(checkIncludeTotalGainAndLossBreakdown) == "TRUE");
    
    if (checkIncludeNonregisteredAccountsOnly != undefined)
        Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().set_IsChecked(aqString.ToUpper(checkIncludeNonregisteredAccountsOnly) == "VRAI" || aqString.ToUpper(checkIncludeNonregisteredAccountsOnly) == "TRUE");
        
    if (Get_WinParameters_ChkGroupBySecurity().IsEnabled)
        Get_WinParameters_ChkGroupBySecurity().set_IsChecked(aqString.ToUpper(checkGroupBySecurity) == "VRAI" || aqString.ToUpper(checkGroupBySecurity) == "TRUE");
        
    if (Get_WinParameters_ChkOneReportPerAccount().Exists && Get_WinParameters_ChkOneReportPerAccount().IsEnabled)
        Get_WinParameters_ChkOneReportPerAccount().set_IsChecked(aqString.ToUpper(checkOneReportPerAccount) == "VRAI" || aqString.ToUpper(checkOneReportPerAccount) == "TRUE");
    
   // if (!Get_ModulesBar_BtnAccounts().IsChecked.OleValue)
     //   CompareProperty(Get_WinParameters_ChkOneReportPerAccount().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkOneReportPerAccount), true, lmError);
        
    Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", costCalculation], 10).set_IsChecked(true);
    
    Get_WinParameters_GrpTransactionDate().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", transactionDate], 10).set_IsChecked(true);
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    if (checkCostDisplayedTheoreticalValue != undefined)
        Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue().set_IsChecked(aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "VRAI" || aqString.ToUpper(checkCostDisplayedTheoreticalValue) == "TRUE");
        
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}

function SetReportParameters3(asOfDate, positionState, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
    
    SelectComboBoxItem(Get_WinParameters_CmbPositionState(), positionState);
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering2(), numbering);
    
    Get_WinParameters_BtnOK().Click();
}


