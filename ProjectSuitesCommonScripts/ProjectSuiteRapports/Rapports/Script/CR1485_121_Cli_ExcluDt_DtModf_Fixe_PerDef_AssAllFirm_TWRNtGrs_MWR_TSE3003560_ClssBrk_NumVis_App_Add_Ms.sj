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

function CR1485_121_Cli_ExcluDt_DtModf_Fixe_PerDef_AssAllFirm_TWRNtGrs_MWR_TSE3003560_ClssBrk_NumVis_App_Add_Ms()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 54);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 56);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 59, language);
        sortBy = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 60, language);
        currency = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 61, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 62, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 63, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 64, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 65, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 66, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 67, language);
        message = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 68, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 71, language);
        endDate = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 72, language);
        period = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 73, language);
        period1 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 74, language);
        period2 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 75, language);
        period3 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 76, language);
        period4 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 77, language);
        period5 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 78, language);
        period6 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 79, language);
        period7 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 80, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 81, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 82, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 83, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 84, language);
        customAllocation = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 85, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 86, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 87, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 88, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 89, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 90, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 91, language);
        numbering = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 92, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering);

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 95);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 98, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 99, language);
        
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