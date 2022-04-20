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

function CR1485_020_Acc_DateModf_Region_InvstCap_TheoVal_AssAllBasic_ClassBrk_NumVis_SortDesc_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 142);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 144);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 147, language);
        sortBy = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 148, language);
        currency = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 149, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 150, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 151, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 152, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 153, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 154, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 155, language);
        message = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 156, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 159, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 160, language);
        type = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 161, language);
        checkComparative = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 162, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 163, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 164, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 165, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 166, language);
        costCalculation = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 167, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 168, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 169, language);
        customAllocation = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 170, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 171, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 172, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 173, language);
        numbering = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 174, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 175, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 178);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 181, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 182, language);
        
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