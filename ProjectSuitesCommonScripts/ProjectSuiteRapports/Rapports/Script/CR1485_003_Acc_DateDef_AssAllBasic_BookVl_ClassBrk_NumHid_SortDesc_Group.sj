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

function CR1485_003_Acc_DateDef_AssAllBasic_BookVl_ClassBrk_NumHid_SortDesc_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 142);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 144);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 147, language);
        sortBy = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 148, language);
        currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 149, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 150, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 151, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 152, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 153, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 154, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 155, language);
        message = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 156, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 159, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 160, language);
        type = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 161, language);
        checkComparative = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 162, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 163, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 164, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 165, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 166, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 168, language): GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 167, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 169, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 170, language);
        customAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 171, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 172, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 173, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 174, language);
        numbering = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 175, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 176, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 179);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 182, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 183, language);
        
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