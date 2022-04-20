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

function CR1485_061_Portf_Graph_Pie_BookVl_TheoVl_AssAllFirm_SortMat()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 1, language);
        relationshipsNames = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 188);
        arrayOfRelationshipsNames = relationshipsNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select relationships
        SelectRelationships(arrayOfRelationshipsNames);
        
        //Drag the account to Portfolio module
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 190);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 195, language);
        asOfDate = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 205, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 193, language);
        sortBy = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 194, language);
        //currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 195, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 196, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 197, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 198, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 199, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 200, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 201, language);
        message = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 202, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 205, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 206, language);
        type = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 207, language);
        checkComparative = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 208, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 209, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 210, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 211, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 212, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 214, language): GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 213, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 215, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 216, language);
        customAllocation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 217, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 218, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 219, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 220, language);
        numbering = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 221, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 222, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 225);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 228, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 228, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 229, language);
        
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