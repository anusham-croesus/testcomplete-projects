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

function CR1485_066_Rel_DateDef_Region_AssAllFirm()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 10, language);
        currency = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 17, language);
        message = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 21, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 22, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 23, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 24, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 25, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 26, language);
        customAllocation = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 27, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 28, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 29, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 30, language);
        numbering = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 31, language);
        checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 32, language);
        
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 35);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 38, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 39, language);
        
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