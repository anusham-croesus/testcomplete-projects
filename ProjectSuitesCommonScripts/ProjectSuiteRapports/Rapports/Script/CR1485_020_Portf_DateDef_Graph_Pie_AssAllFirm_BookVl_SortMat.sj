//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_020_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_020_Portf_DateDef_Graph_Pie_AssAllFirm_BookVl_SortMat()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 187);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        //Drag the account to Portfolio module
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 189);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 194, language);
        asOfDate = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 204, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 192, language);
        sortBy = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 193, language);
        //currency = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 194, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 195, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 196, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 197, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 198, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 199, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 200, language);
        message = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 201, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 204, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 205, language);
        type = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 206, language);
        checkComparative = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 207, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 208, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 209, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 210, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 211, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 213, language): GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 212, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 214, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 215, language);
        customAllocation = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 216, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 217, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 218, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 219, language);
        numbering = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 220, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 221, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 224);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 227, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 227, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 228, language);
        
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