﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_079_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_079_Rel_DateDef_SortName_AssAllFirm_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 10, language);
        currency = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 17, language);
        message = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 21, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 22, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 23, language);
        customAllocation = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 24, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 25, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 26, language);
        numbering = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 27, language);
        
        SetReportParameters(asOfDate, parametersSortBy, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 30);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 33, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 34, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, parametersSortBy, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}