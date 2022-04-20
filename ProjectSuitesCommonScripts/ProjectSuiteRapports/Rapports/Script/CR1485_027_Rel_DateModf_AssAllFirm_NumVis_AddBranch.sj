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

function CR1485_027_Rel_DateModf_AssAllFirm_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 10, language);
        currency = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 17, language);
        message = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 21, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 22, language);
        type = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 23, language);
        checkComparative = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 24, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 25, language);
        customAllocation = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 26, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 27, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 28, language);
        numbering = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 29, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 32);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 35, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 36, language);
        
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