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

function CR1485_121_Cli_ExcluDt_DtModf_PerDef_AssAllFirm_TWRNt_MWR_TSE60_ClssBrk_App_NumVis_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 104);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 106);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 109, language);
        sortBy = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 110, language);
        currency = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 111, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 112, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 113, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 114, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 115, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 116, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 117, language);
        message = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 118, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 121, language);
        endDate = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 122, language);
        period = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 123, language);
        period1 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 124, language);
        period2 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 125, language);
        period3 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 126, language);
        period4 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 127, language);
        period5 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 128, language);
        period6 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 129, language);
        period7 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 130, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 131, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 132, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 133, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 134, language);
        customAllocation = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 135, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 136, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 137, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 138, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 139, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 140, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 141, language);
        numbering = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 142, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering);

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 145);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 148, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 149, language);
        
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