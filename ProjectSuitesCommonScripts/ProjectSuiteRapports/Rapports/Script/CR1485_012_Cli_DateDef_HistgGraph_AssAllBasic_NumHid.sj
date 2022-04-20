//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_012_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_012_Cli_DateDef_HistgGraph_AssAllBasic_NumHid()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 40);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 42);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 45, language);
        sortBy = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 46, language);
        currency = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 47, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 48, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 49, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 50, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 51, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 52, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 53, language);
        message = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 54, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 57, language);
        type = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 58, language);
        checkComparative = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 59, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 60, language);
        customAllocation = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 61, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 62, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 63, language);
        numbering = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 64, language);
        
        SetReportParameters(asOfDate, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
                
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 67);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 70, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 71, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}