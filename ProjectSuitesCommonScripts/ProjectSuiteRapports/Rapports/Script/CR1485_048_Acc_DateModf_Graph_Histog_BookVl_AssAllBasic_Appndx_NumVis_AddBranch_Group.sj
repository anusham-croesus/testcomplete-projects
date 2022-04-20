//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_048_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_048_Acc_DateModf_Graph_Histog_BookVl_AssAllBasic_Appndx_NumVis_AddBranch_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 89);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 91);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 94, language);
        sortBy = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 95, language);
        currency = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 96, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 97, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 98, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 99, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 100, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 101, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 102, language);
        message = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 103, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 106, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 107, language);
        type = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 108, language);
        checkComparative = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 109, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 110, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 111, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 112, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 114, language): GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 113, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 115, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 116, language);
        customAllocation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 117, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 118, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 119, language);
        numbering = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 120, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 123);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 126, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 127, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
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