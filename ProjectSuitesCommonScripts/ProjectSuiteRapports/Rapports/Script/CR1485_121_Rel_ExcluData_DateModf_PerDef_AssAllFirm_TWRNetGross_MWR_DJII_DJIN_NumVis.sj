//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_121_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_121_Rel_ExcluData_DateModf_PerDef_AssAllFirm_TWRNetGross_MWR_DJII_DJIN_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 10, language);
        currency = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 17, language);
        message = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 22, language);
        period = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 23, language);
        period1 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 24, language);
        period2 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 25, language);
        period3 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 26, language);
        period4 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 27, language);
        period5 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 28, language);
        period6 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 29, language);
        period7 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 30, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 31, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 32, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 33, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 34, language);
        customAllocation = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 35, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 36, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 37, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 38, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 39, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 40, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 41, language);
        numbering = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 42, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering);

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 45);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 48, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 49, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering);
        
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