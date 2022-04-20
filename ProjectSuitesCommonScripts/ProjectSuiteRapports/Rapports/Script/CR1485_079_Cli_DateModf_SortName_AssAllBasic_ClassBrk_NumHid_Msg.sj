//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_079_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_079_Cli_DateModf_SortName_AssAllBasic_ClassBrk_NumHid_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 39);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 41);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 44, language);
        sortBy = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 45, language);
        currency = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 46, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 47, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 48, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 49, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 50, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 51, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 52, language);
        message = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 53, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 56, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 57, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 58, language);
        customAllocation = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 59, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 60, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 61, language);
        numbering = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 62, language);
        
        SetReportParameters(asOfDate, parametersSortBy, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 65);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 68, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 69, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, parametersSortBy, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
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