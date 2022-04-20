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

function CR1485_049_Acc_DateModf_Graph_Pie_TheoVal_AssAllBasic_NumVis_ClassBrk_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 127);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 129);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 132, language);
        sortBy = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 133, language);
        currency = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 134, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 135, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 136, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 137, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 138, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 139, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 140, language);
        message = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 141, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 144, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 145, language);
        type = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 146, language);
        checkComparative = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 147, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 148, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 149, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 150, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 151, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 152, language);
        customAllocation = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 153, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 154, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 155, language);
        numbering = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 156, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 159);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 162, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 163, language);
        
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