//USEUNIT CR1485_008_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_008_Cli_DateModf_HistgGraph_IndCodeBasic_NumHid_Group()
{
    
    try {
        reportName = (client == "RJ")? GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 2, language): GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 36);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 38);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 41, language);
        sortBy = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 42, language);
        currency = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 43, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 44, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 45, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 46, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 47, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 48, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 49, language);
        message = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 50, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 53, language);
        type = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 54, language);
        industryCode = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 55, language);
        numbering = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 56, language);
        
        SetReportParameters(asOfDate, type, industryCode, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 59);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 62, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 63, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, type, industryCode, numbering);
        
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
        
        //Rétablir la valeur par défaut de la pref PREF_DISABLE_INDUSTRY_CODE
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_DISABLE_INDUSTRY_CODE", null, vServerReportsCR1485);
    }
    
}