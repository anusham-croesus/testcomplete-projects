//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_052_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_052_Portf_DateDef_GraphHistg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 97);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        //Drag the account to Portfolio module
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 99);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 104, language);
        asOfDate = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 114, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 102, language);
        sortBy = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 103, language);
        //currency = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 104, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 105, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 106, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 107, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 108, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 109, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 110, language);
        message = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 111, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 114, language);
        type = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 115, language);
        numbering = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 116, language);
        
        SetReportParameters(asOfDate, type, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 119);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 122, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 122, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "052_GRAPH_ASSET_REG", 123, language);
        
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