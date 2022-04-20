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

function CR1485_002_Cli_DateModf_GLBrk_GroupSec_ByAcc_InvstCap_TradeDate_NumVis_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 43);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 45);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 48, language);
        sortBy = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 49, language);
        currency = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 50, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 51, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 52, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 53, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 54, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 55, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 56, language);
        message = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 57, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 60, language);
        startDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 61, language);
        endDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 62, language);
        checkIncludeInterestAndDividends = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 63, language);
        checkIncludeTotalGainAndLossBreakdown = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 64, language);
        checkGroupBySecurity = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 65, language);
        checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 66, language);
        costCalculation = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 67, language);
        transactionDate = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 68, language);
        numbering = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 69, language);
        
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, checkIncludeInterestAndDividends, checkIncludeTotalGainAndLossBreakdown, checkGroupBySecurity, checkOneReportPerAccount, costCalculation, transactionDate, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 72);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 75, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "002_GAIN_PERTE", 76, language);
        
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