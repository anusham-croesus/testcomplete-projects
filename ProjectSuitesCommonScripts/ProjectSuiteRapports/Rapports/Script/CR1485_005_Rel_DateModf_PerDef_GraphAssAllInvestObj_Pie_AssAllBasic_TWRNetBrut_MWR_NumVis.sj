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

function CR1485_005_Rel_DateModf_PerDef_GraphAssAllInvestObj_Pie_AssAllBasic_TWRNetBrut_MWR_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 60);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 62);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 65, language);
        sortBy = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 66, language);
        currency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 67, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 68, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 69, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 70, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 71, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 72, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 73, language);
        message = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 74, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 77, language);
        endDate = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 78, language);
        period = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 79, language);
        period1 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 80, language);
        period2 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 81, language);
        period3 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 82, language);
        period4 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 83, language);
        period5 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 84, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 85, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 86, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 87, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 88, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 89, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 90, language);
        type = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 91, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 92, language);
        customAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 93, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 94, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 95, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 96, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 97, language);
        checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 98, language);
        checkRiskMeasurement3YearStandardDeviation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 99, language);
        checkRiskMeasurement3YearStandDevIndices = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 100, language);
        checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 101, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 102, language);
        checkDisplayDetails = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 103, language);
        numbering = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 104, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkRiskMeasurementStandardDeviation, checkRiskMeasurement3YearStandardDeviation, checkRiskMeasurement3YearStandDevIndices, checkRiskMeasurementSharpeIndex, performanceCalculations, checkDisplayDetails, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 107);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 110, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 111, language);
        
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