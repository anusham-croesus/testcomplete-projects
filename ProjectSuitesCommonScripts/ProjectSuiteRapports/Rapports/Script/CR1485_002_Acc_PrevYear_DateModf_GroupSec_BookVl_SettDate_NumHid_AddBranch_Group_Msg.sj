//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_002_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_002_Acc_PrevYear_DateModf_GroupSec_BookVl_SettDate_NumHid_AddBranch_Group_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 120);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 122);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 125, language);
        sortBy = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 126, language);
        currency = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 127, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 128, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 129, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 130, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 131, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 132, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 133, language);
        message = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 134, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 137, language);
        startDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 138, language);
        endDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 139, language);
        checkIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 140, language);
        checkIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 141, language);
        checkGroupBySecurity = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 142, language);
        checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 143, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 145, language): GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 144, language);
        transactionDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 146, language);
        numbering = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 147, language);
        
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity, checkOneReportPerAccount, costCalculation, transactionDate, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 150);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 153, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 154, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity, checkOneReportPerAccount, costCalculation, transactionDate, numbering);
        
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