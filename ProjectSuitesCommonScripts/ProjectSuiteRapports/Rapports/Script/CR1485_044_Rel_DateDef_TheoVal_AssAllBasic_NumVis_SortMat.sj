﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_044_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_044_Rel_DateDef_TheoVal_AssAllBasic_NumVis_SortMat()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 10, language);
        currency = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 17, language);
        message = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 21, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 22, language);
        type = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 23, language);
        checkComparative = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 24, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 25, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 26, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 27, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 28, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 29, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 30, language);
        customAllocation = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 31, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 32, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 33, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 34, language);
        numbering = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 35, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 36, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 39);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 42, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 43, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
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