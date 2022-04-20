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

function CR1485_002_Cli_PrevYear_DateModf_GLBrk_GroupSec_BookVl_TradeDate_NumVis_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 81);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 83);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 86, language);
        sortBy = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 87, language);
        currency = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 88, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 89, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 90, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 91, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 92, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 93, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 94, language);
        message = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 95, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 98, language);
        startDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 99, language);
        endDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 100, language);
        checkIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 101, language);
        checkIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 102, language);
        checkGroupBySecurity = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 103, language);
        checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 104, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 106, language): GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 105, language);
        transactionDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 107, language);
        numbering = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 108, language);
        
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity, checkOneReportPerAccount, costCalculation, transactionDate, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 111);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 114, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 115, language);
        
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