//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_014_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_014_Cli_DateModf_HistgGraph_NumVis_AddBranch_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 35);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 37);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 40, language);
        sortBy = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 41, language);
        currency = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 42, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 43, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 44, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 45, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 46, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 47, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 48, language);
        message = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 49, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 52, language);
        type = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 53, language);
        numbering = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 54, language);
        
        SetReportParameters(asOfDate, type, numbering);
                
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 57);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 60, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "014_GRAPH_ASSET_CAT", 61, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, type, numbering);
        
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