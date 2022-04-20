//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_048_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_048_Acc_DateModf_BookVl_AssAllFirm_NumHid_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 132);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 134);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 137, language);
        sortBy = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 138, language);
        currency = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 139, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 140, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 141, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 142, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 143, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 144, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 145, language);
        message = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 146, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 149, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 150, language);
        type = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 151, language);
        checkComparative = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 152, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 153, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 154, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 155, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 157, language): GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 156, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 158, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 159, language);
        customAllocation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 160, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 161, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 162, language);
        numbering = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 163, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 166);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 169, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 170, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
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