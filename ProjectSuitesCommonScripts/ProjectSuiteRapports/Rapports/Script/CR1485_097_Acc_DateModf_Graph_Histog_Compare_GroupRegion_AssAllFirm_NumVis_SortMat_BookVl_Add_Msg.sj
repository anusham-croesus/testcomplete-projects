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

function CR1485_097_Acc_DateModf_Graph_Histog_Compare_GroupRegion_AssAllFirm_NumVis_SortMat_BookVl_Add_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 142);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 144);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 147, language);
        sortBy = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 148, language);
        currency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 149, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 150, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 151, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 152, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 153, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 154, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 155, language);
        message = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 156, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 159, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 160, language);
        type = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 161, language);
        checkComparative = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 162, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 163, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 164, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 165, language);
        checkGroupByAccountCurrency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 166, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "097_EVAL_VC", 168, language): GetData(filePath_ReportsCR1485, "097_EVAL_VC", 167, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 169, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 170, language);
        customAllocation = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 171, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 172, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 173, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 174, language);
        numbering = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 175, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 176, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 179);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 182, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 183, language);
        
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