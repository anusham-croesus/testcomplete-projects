//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_027_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_027_Cli_DateModf_Graph_Pie_AssAllFirm_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 41);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 43);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 46, language);
        sortBy = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 47, language);
        currency = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 48, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 49, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 50, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 51, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 52, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 53, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 54, language);
        message = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 55, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 58, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 59, language);
        type = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 60, language);
        checkComparative = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 61, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 62, language);
        customAllocation = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 63, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 64, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 65, language);
        numbering = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 66, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 69);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 72, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 73, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
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