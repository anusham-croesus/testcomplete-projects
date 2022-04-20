//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_065_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_065_Rel_DateDef_BookVl_TheoVl_AssAllFirm_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 10, language);
        currency = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 17, language);
        message = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 21, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 22, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 23, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 24, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 26, language): GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 25, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 27, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 28, language);
        customAllocation = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 29, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 30, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 31, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 32, language);
        numbering = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 33, language);
        checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 34, language);
        
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 37);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 40, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 41, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
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