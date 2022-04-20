//USEUNIT CR1485_008_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_008_Acc_DateDef_PieGraph_IndCodeFirm_NumVis()
{
    
    try {
        reportName = (client == "RJ")? GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 2, language): GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 68);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 70);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 73, language);
        sortBy = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 74, language);
        currency = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 75, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 76, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 77, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 78, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 79, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 80, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 81, language);
        message = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 82, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 85, language);
        type = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 86, language);
        industryCode = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 87, language);
        numbering = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 88, language);
        
        SetReportParameters(asOfDate, type, industryCode, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 91);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 94, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "008_GRAPH_ASSET_INDC", 95, language);
        
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
