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

function CR1485_121_Acc_ExcluDt_DtModf_1Y2Y3Y4Y5Y10YSince_AssAllBase_TWRNt_AllIndex_NumHid_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 154);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 156);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 159, language);
        sortBy = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 160, language);
        currency = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 161, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 162, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 163, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 164, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 165, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 166, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 167, language);
        message = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 168, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 171, language);
        endDate = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 172, language);
        period = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 173, language);
        period1 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 174, language);
        period2 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 175, language);
        period3 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 176, language);
        period4 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 177, language);
        period5 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 178, language);
        period6 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 179, language);
        period7 = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 180, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 181, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 182, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 183, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 184, language);
        customAllocation = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 185, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 186, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 187, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 188, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 189, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 190, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 191, language);
        numbering = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 192, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering);

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 195);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 198, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "121_PERFORMANCE_ASSET", 199, language);
        
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