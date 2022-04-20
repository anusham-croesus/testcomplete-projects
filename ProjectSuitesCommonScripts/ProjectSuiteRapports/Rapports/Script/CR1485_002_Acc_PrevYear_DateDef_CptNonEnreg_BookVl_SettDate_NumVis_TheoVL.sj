//USEUNIT CR1485_002_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_002_Acc_PrevYear_DateDef_CptNonEnreg_BookVl_SettDate_NumVis_TheoVL()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR2008_CR1880");
    Log.Message("CR2008 / CR1880");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 199);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and goto the module and Select elements
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountsNumbers.split("|"));
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 201);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 204, language);
        sortBy = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 205, language);
        currency = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 206, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 207, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 208, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 209, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 210, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 211, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 212, language);
        message = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 213, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 216, language);
        startDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 217, language);
        endDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 218, language);
        checkIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 219, language);
        checkIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 220, language);
        checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 221, language);
        checkGroupBySecurity = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 222, language);
        checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 223, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 225, language): GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 224, language);
        transactionDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 226, language);
        numbering = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 227, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 228, language);
        
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity, checkOneReportPerAccount, costCalculation, transactionDate, numbering, checkCostDisplayedTheoreticalValue, checkIncludeNonregisteredAccountsOnly);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 231);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 234, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 235, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity, checkOneReportPerAccount, costCalculation, transactionDate, numbering, checkCostDisplayedTheoreticalValue, checkIncludeNonregisteredAccountsOnly);
        
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
