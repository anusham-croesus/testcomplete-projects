//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_003_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_003_Acc_DateModf_Graph_Pie_Compare_Region_InvstCap_AssAllFirm_NumHid_SortDesc_App_Add_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 188);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 190);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 193, language);
        sortBy = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 194, language);
        currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 195, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 196, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 197, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 198, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 199, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 200, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 201, language);
        message = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 202, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 205, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 206, language);
        type = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 207, language);
        checkComparative = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 208, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 209, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 210, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 211, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 212, language);
        costCalculation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 213, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 214, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 215, language);
        customAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 216, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 217, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 218, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 219, language);
        numbering = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 220, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 221, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 224);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 227, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 228, language);
        
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