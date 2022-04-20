//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_049_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_049_Portf_DateDef_IndCode_AssAllFim_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 168);
        
        
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
        reportFileName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 170);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 175, language);
        asOfDate = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 185, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 173, language);
        sortBy = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 174, language);
        //currency = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 175, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 176, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 177, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 178, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 179, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 180, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 181, language);
        message = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 182, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 185, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 186, language);
        type = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 187, language);
        checkComparative = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 188, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 189, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 190, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 191, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 192, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 193, language);
        customAllocation = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 194, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 195, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 196, language);
        numbering = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 197, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 200);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 203, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 203, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 204, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
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