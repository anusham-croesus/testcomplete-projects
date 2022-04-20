//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_049_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_049_Rel_DateModf_Graph_Histo_Compare_Reg_TheoVal_AssAllBasic_NumVis_Add_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 45);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 47);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 50, language);
        sortBy = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 51, language);
        currency = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 52, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 53, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 54, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 55, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 56, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 57, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 58, language);
        message = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 59, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 62, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 63, language);
        type = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 64, language);
        checkComparative = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 65, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 66, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 67, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 68, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 69, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 70, language);
        customAllocation = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 71, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 72, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 73, language);
        numbering = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 74, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 77);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 80, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 81, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
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