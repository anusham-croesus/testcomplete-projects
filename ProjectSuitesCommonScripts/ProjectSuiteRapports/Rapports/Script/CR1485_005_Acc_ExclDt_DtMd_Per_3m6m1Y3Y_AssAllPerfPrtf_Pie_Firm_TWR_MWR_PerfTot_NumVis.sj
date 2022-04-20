//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_005_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_005_Acc_ExclDt_DtMd_Per_3m6m1Y3Y_AssAllPerfPrtf_Pie_Firm_TWR_MWR_PerfTot_NumVis()
{
    Log.Message("Bug JIRA CROES-8071");
    
    try {
        //Se connecter avec l'utilisateur GP1859 (Le JIRA CROES-8071 requiert de se connecter avec UNI00, dans les tests auto, on utilise GP1859 en lieu et place d'UNI00)
        //Par suite d'une discussion avec Alberto, utiliser le user DARWIC
        //var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        //var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
    
        reportName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 285);
        
        
        //Activate Prefs for GP1859 
        //Activate_Inactivate_Pref(userNameGP1859, "PREF_REPORT_PERFORMANCE", "YES", vServerReportsCR1485);
        //Activate_Inactivate_Pref(userNameGP1859, "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
        //Activate_Inactivate_Pref(userNameGP1859, "PREF_PERFORMANCE_REPORT_DETAILS", "YES", vServerReportsCR1485);
        //Activate_Inactivate_Pref(userNameGP1859, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 287);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 290, language);
        sortBy = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 291, language);
        currency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 292, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 293, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 294, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 295, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 296, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 297, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 298, language);
        message = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 299, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 302, language);
        endDate = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 303, language);
        period = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 304, language);
        period1 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 305, language);
        period2 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 306, language);
        period3 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 307, language);
        period4 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 308, language);
        period5 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 309, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 310, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 311, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 312, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 313, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 314, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 315, language);
        type = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 316, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 317, language);
        customAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 318, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 319, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 320, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 321, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 322, language);
        checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 323, language);
        checkRiskMeasurement3YearStandardDeviation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 324, language);
        checkRiskMeasurement3YearStandDevIndices = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 325, language);
        checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 326, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 327, language);
        checkDisplayDetails = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 328, language);
        numbering = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 329, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, performanceCalculations, checkDisplayDetails, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 332);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 335, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 336, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, performanceCalculations, checkDisplayDetails, numbering);
        
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