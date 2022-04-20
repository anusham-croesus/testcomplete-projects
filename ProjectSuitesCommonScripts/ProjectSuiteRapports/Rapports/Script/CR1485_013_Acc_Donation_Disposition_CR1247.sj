//USEUNIT  CR1485_013_Cli_Donation_Disposition_CR1247
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables



/**
    Description : "P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\13. Transactions\3.1 Comptes\\"
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Abdel Matmat
*/

function CR1485_013_Acc_Donation_Disposition_CR1247()
{
    Log.Message("CR1247");
    Log.Message("JIRA CROES-10102");
    
       
    try {
        
         //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                
        var reportName = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 108, language);
        var arrayOfReportsNames = reportName.split("|");      
        var accountsNumbers = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 169);
        var arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select Accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 171);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Select the third report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 174, language);
        sortBy = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 175, language);
        currency = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 176, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 177, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 178, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 179, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 180, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 181, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 182, language);
        message = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 183, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 211, language);
        positionState = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 212, language);
        numbering2 = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 213, language);
        
        SetReportParameters3(asOfDate, positionState, numbering2);
        
        //Select the second report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 196, language);
        startDate1 = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 197, language);
        endDate1 = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 198, language);
        checkIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 199, language);
        checkIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 200, language);
        //checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 201, language);
        checkGroupBySecurity1 = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 202, language);
        checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 203, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "013_TRANSACTION", 205, language): GetData(filePath_ReportsCR1485, "013_TRANSACTION", 204, language);
        transactionDate = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 206, language);
        numbering1 = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 207, language);
        //checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 208, language);
        
        SetReportParameters2(checkPreviousCalendarYear, startDate1, endDate1, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity1, checkOneReportPerAccount, costCalculation, transactionDate, numbering1/*, checkCostDisplayedTheoreticalValue, checkIncludeNonregisteredAccountsOnly*/);
        
        
        //Select the first report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Parameters values
        transactionTypesToBeChecked = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 187, language);
        startDate = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 188, language);
        endDate = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 189, language);
        checkGroupByRecord = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 190, language);
        checkGroupByTransactionType = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 191, language);
        checkGroupBySecurity = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 192, language);
        numbering = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 193, language);
        
        SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report ****************************************************************************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 217);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Select the third report (Transactions ACB et Quantité) and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 220, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 221, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters3(asOfDate, positionState, numbering2);
        
        //Select the second report (Gains et Pertes Réalisés) and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        
        //Parameters values (same as for the English report)
        SetReportParameters2(checkPreviousCalendarYear, startDate1, endDate1, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity1, checkOneReportPerAccount, costCalculation, transactionDate, numbering1/*, checkCostDisplayedTheoreticalValue, checkIncludeNonregisteredAccountsOnly*/);
        
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

