//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_066_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_066_Acc_DateModf_Region_TheoVal_AssAllBasic_ClassBrk_NumHid_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 84);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 86);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 89, language);
        sortBy = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 90, language);
        currency = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 91, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 92, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 93, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 94, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 95, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 96, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 97, language);
        message = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 98, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 101, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 102, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 103, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 104, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 105, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 106, language);
        customAllocation = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 107, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 108, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 109, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 110, language);
        numbering = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 111, language);
        checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 112, language);
        
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 115);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 118, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 119, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}