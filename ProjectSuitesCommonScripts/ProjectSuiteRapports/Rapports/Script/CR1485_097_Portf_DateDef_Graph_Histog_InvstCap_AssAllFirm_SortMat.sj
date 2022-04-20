//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_097_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_097_Portf_DateDef_Graph_Histog_InvstCap_AssAllFirm_SortMat()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 188);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        //Drag the client to Portfolio module
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 190);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 195, language);
        asOfDate = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 205, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 193, language);
        sortBy = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 194, language);
        //currency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 195, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 196, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 197, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 198, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 199, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 200, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 201, language);
        message = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 202, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 205, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 206, language);
        type = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 207, language);
        checkComparative = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 208, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 209, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 210, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 211, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 212, language);
        costCalculation = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 213, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 214, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 215, language);
        customAllocation = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 216, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 217, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 218, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 219, language);
        numbering = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 220, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 221, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 224);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 227, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 227, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 228, language);
        
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