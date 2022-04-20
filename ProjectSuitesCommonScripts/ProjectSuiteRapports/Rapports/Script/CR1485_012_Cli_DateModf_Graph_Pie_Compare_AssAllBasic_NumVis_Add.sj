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

function CR1485_012_Cli_DateModf_Graph_Pie_Compare_AssAllBasic_NumVis_Add()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 76);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 78);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 81, language);
        sortBy = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 82, language);
        currency = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 83, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 84, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 85, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 86, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 87, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 88, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 89, language);
        message = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 90, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 93, language);
        type = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 94, language);
        checkComparative = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 95, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 96, language);
        customAllocation = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 97, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 98, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 99, language);
        numbering = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 100, language);
        
        SetReportParameters(asOfDate, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
                
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 103);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 106, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 107, language);
        
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