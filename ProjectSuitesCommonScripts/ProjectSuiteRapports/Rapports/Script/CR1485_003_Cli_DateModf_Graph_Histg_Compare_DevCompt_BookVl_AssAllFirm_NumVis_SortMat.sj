//USEUNIT CR1485_003_Acc_DateDef_Grph_Pie_BkVL_AssAllFirm_NumVis_SortMat



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_003_Cli_DateModf_Graph_Histg_Compare_DevCompt_BookVl_AssAllFirm_NumVis_SortMat()
{
    var reportName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 1, language);
    var reportFileName_English = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 327);
    var reportFileName_French = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 362);
    
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_SIMPLE", "YES", vServerReportsCR1485);
    CR1485_CR1458_Evaluation_du_portefeuille_Cli_DateModf_Graph_Histg_Compare_DevCompt_BookVl_AssAllFirm_NumVis_SortMat(reportName, reportFileName_English, reportFileName_French);
}





function CR1485_CR1458_Evaluation_du_portefeuille_Cli_DateModf_Graph_Histg_Compare_DevCompt_BookVl_AssAllFirm_NumVis_SortMat(reportName, reportFileName_English, reportFileName_French)
{
    Log.Message("CR1458");
    
    try {
        var clientsNumbers = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 325);
        var arrayOfCliensNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_ADD_THEORETICAL_VALUE", "NO", vServerReportsCR1485);
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "NO", vServerReportsCR1485);
        
        //Login and goto Accounts module and select Accounts
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(arrayOfCliensNumbers);
        
        
        //************************* Generate English report *********************
        //reportFileName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 281);
        reportFileName = reportFileName_English;
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 330, language);
        sortBy = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 331, language);
        currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 332, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 333, language);
        checkAddBranchAddress = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 334, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 335, language);
        checkConsolidatePositions = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 336, language);
        checkGroupUnderlyingClients = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 337, language);
        checkIncludeMessage = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 338, language);
        message = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 339, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 342, language);
        checkIncludeGraph = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 343, language));
        type = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 344, language);
        checkComparative = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 345, language));
        checkGroupByRegion = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 346, language));
        checkGroupByIndustryCode = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 347, language));
        groupByIndustryCode = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 348, language));
        checkGroupByAccountCurrency = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 349, language));
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 351, language): GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 350, language);
        checkCostDisplayedTheoreticalValue = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 352, language));
        assetAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 353, language);
        customAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 354, language);
        checkUseTheSpecifiedInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 355, language));
        checkFundBreakdownClassBreakdown = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 356, language));
        checkFundBreakdownAppendix = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 357, language));
        numbering = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 358, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 359, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        //reportFileName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 316);
        reportFileName = reportFileName_French;
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 365, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 366, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
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
