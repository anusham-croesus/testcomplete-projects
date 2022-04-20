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

function CR1485_044_Rel_DateModf_Graph_Histo_Compare_TheoVal_Devise_AssAllBasic_ObjPlac_NumVis_SortMat_App_ClassBrk_Add_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 48);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 50);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 53, language);
        sortBy = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 54, language);
        currency = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 55, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 56, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 57, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 58, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 59, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 60, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 61, language);
        message = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 62, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 65, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 66, language);
        type = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 67, language);
        checkComparative = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 68, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 69, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 70, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 71, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 72, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 73, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 74, language);
        customAllocation = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 75, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 76, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 77, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 78, language);
        numbering = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 79, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 80, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 83);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 86, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 87, language);
        
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