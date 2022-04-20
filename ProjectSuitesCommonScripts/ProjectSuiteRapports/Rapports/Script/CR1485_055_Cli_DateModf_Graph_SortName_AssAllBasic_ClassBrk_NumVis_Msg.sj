//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_055_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_055_Cli_DateModf_Graph_SortName_AssAllBasic_ClassBrk_NumVis_Msg()
{
    Log.Message("Bug JIRA CROES-6464");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 42);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 44);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 47, language);
        sortBy = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 48, language);
        currency = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 49, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 50, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 51, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 52, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 53, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 54, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 55, language);
        message = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 56, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 59, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 60, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 61, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 62, language);
        nameOrFullName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 63, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 64, language);
        customAllocation = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 65, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 66, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 67, language);
        numbering = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 68, language);
        
        SetReportParameters(asOfDate, checkAllRecords, checkIncludeGraph, parametersSortBy, nameOrFullName, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 71);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 74, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 75, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkAllRecords, checkIncludeGraph, parametersSortBy, nameOrFullName, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
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