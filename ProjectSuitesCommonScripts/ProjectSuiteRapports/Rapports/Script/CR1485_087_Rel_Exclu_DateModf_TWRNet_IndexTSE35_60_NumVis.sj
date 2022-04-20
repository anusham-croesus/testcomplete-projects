//USEUNIT CR1485_087_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_087_Rel_Exclu_DateModf_TWRNet_IndexTSE35_60_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 10, language);
        currency = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 17, language);
        message = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 21, language);
        startDate = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 22, language);
        endDate = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 23, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 24, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 25, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 26, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 27, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 28, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 29, language);
        numbering = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 30, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 33);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 36, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "087_GRAPH_RISK_RETURN", 37, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        RestorePrefs();
        Terminate_CroesusProcess();
    }
    
}