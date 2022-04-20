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

function CR1485_061_Portf_DateModf_Graph_Pie_Compare_Group_Region_IndCode_AssAllBasic_InvstCap_TheoVal_SortMat()
{
    Log.Message("Bug CROES-7004 : impossible de saisir la date du portefeuille.");

    try {
        reportName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 234);
        
        
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
        reportFileName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 236);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 241, language);
        asOfDate = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 251, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 239, language);
        sortBy = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 240, language);
        //currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 241, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 242, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 243, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 244, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 245, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 246, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 247, language);
        message = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 248, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 251, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 252, language);
        type = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 253, language);
        checkComparative = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 254, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 255, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 256, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 257, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 258, language);
        costCalculation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 259, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 260, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 261, language);
        customAllocation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 262, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 263, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 264, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 265, language);
        numbering = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 266, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 267, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 270);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 273, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 273, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 274, language);
        
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