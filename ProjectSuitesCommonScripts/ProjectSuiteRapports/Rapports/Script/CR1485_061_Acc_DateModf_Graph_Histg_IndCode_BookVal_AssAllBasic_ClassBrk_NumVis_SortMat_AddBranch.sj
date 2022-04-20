//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_061_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_061_Acc_DateModf_Graph_Histg_IndCode_BookVal_AssAllBasic_ClassBrk_NumVis_SortMat_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 142);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 144);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 147, language);
        sortBy = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 148, language);
        currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 149, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 150, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 151, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 152, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 153, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 154, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 155, language);
        message = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 156, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 159, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 160, language);
        type = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 161, language);
        checkComparative = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 162, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 163, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 164, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 165, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 166, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 168, language): GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 167, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 169, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 170, language);
        customAllocation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 171, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 172, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 173, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 174, language);
        numbering = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 175, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 176, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 179);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 182, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 183, language);
        
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