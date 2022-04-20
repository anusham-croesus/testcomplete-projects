//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_029_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_029_Rel_DateDef_AssAllFirm_Month_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 10, language);
        currency = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 17, language);
        message = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 22, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 23, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 24, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 25, language);
        customAllocation = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 26, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 27, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 28, language);
        data = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 29, language);
        numbering = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 30, language);
        
        SetReportParameters(startDate, endDate, checkAllRecords, checkIncludeGraph, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, data, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 33);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 36, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 37, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, checkAllRecords, checkIncludeGraph, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, data, numbering);
        
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