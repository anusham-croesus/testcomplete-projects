//USEUNIT Common_functions
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

function CR1485_044_Portf_DateModf_Graph_Pie_Region_AssAllBasic_Appdx_SortMat_AddBranch()
{
    Log.Message("Bug CROES-7004 : impossible de saisir la date du portefeuille.");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 180);
        
        
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
        reportFileName = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 182);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 187, language);
        asOfDate = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 197, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 185, language);
        sortBy = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 186, language);
        //currency = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 187, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 188, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 189, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 190, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 191, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 192, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 193, language);
        message = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 194, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 197, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 198, language);
        type = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 199, language);
        checkComparative = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 200, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 201, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 202, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 203, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 204, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 205, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 206, language);
        customAllocation = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 207, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 208, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 209, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 210, language);
        numbering = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 211, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 212, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 215);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 218, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 218, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "044_EVAL_SIMPLE_TL", 219, language);
        
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