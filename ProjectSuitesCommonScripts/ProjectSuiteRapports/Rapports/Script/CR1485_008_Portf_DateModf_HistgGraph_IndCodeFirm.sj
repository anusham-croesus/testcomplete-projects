//USEUNIT CR1485_008_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_008_Portf_DateModf_HistgGraph_IndCodeFirm()
{
    Log.Message("Bug CROES-7004 : impossible de saisir la date du portefeuille.");

    try {
        reportName = (client == "RJ")? GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 2, language): GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 100);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        //Drag the account to Portfolio module
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 102);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 107, language);
        asOfDate = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 117, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 105, language);
        sortBy = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 106, language);
        //currency = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 107, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 108, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 109, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 110, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 111, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 112, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 113, language);
        message = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 114, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 117, language);
        type = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 118, language);
        industryCode = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 119, language);
        numbering = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 120, language);
        
        SetReportParameters(asOfDate, type, industryCode, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 123);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 126, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 126, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 127, language);
        
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