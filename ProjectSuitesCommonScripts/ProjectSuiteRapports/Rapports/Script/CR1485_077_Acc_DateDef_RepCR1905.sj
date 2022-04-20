//USEUNIT Common_functions
//USEUNIT CR1485_Common_functions
//USEUNIT CR1485_077_Common_functions




/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_077_Acc_DateDef_RepCR1905()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    Log.Message("CR1905");
    Log.Message("Bug JIRA CROES-11541");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 1, language);
        var accountNumber = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 284);
        
                
        //Activate Prefs
        ActivatePrefs(userNameReportsCR1485);
        EnablePerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        
        //Login and goto Accounts module and Select the account
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountNumber);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 286);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 289, language);
        var sortBy = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 290, language);
        var currency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 291, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 292, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 293, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 294, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 295, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 296, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 297, language);
        var message = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 298, language);
        
        //Parameters values
        var nbOfReportOcurrences = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 301, language);
        var separatorChar = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 302, language);
        var CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 303, language).split(separatorChar);
        CompareProperty(CheckExcludeDataPrecedingTheManagementStartDate.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var endDate = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 304, language).split(separatorChar);
        CompareProperty(endDate.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 305, language).split(separatorChar);
        CompareProperty(period.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period1 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 306, language).split(separatorChar);
        CompareProperty(period1.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period2 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 307, language).split(separatorChar);
        CompareProperty(period2.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period3 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 308, language).split(separatorChar);
        CompareProperty(period3.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period4 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 309, language).split(separatorChar);
        CompareProperty(period4.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period5 = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 310, language).split(separatorChar);
        CompareProperty(period5.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 311, language).split(separatorChar);
        CompareProperty(checkDisplayDefaultIndices.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var indicesToBeChecked = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 312, language).split(separatorChar);
        CompareProperty(indicesToBeChecked.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 313, language).split(separatorChar);
        CompareProperty(checkUseIndexBaseCurrency.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 314, language).split(separatorChar);
        CompareProperty(checkGraphsAssetAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 315, language).split(separatorChar);
        CompareProperty(checkGraphsInvestmentObjective.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 316, language).split(separatorChar);
        CompareProperty(checkGraphsPortfolioPerformance.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var type = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 317, language).split(separatorChar);
        CompareProperty(type.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var assetAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 318, language).split(separatorChar);
        CompareProperty(assetAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var customAllocation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 319, language).split(separatorChar);
        CompareProperty(customAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 320, language).split(separatorChar);
        CompareProperty(checkUseTheSpecifiedInvestmentObjective.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 321, language).split(separatorChar);
        CompareProperty(checkRiskMeasurementStandardDeviation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkRiskMeasurement3YearStandardDeviation = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 322, language).split(separatorChar);
        CompareProperty(checkRiskMeasurement3YearStandardDeviation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkRiskMeasurement3YearStandDevIndices = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 323, language).split(separatorChar);
        CompareProperty(checkRiskMeasurement3YearStandDevIndices.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 324, language).split(separatorChar);
        CompareProperty(checkRiskMeasurementSharpeIndex.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 325, language).split(separatorChar);
        CompareProperty(checkTimeWeightedNetOfFees.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 326, language).split(separatorChar);
        CompareProperty(checkTimeWeightedGrossOfFees.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 327, language).split(separatorChar);
        CompareProperty(checkMoneyWeightedNetOfFees.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var performanceCalculations = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 328, language).split(separatorChar);
        CompareProperty(performanceCalculations.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkPerfStartEndValues = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 329, language).split(separatorChar);
        CompareProperty(checkPerfStartEndValues.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var numbering = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 330, language).split(separatorChar);
        CompareProperty(numbering.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        
        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate[i], endDate[i], period[i], period1[i], period2[i], period3[i], period4[i], period5[i], checkDisplayDefaultIndices[i], indicesToBeChecked[i], checkUseIndexBaseCurrency[i], checkGraphsAssetAllocation[i], checkGraphsInvestmentObjective[i], checkGraphsPortfolioPerformance[i], type[i], assetAllocation[i], customAllocation[i], checkUseTheSpecifiedInvestmentObjective[i], checkRiskMeasurementStandardDeviation[i], checkRiskMeasurement3YearStandardDeviation[i], checkRiskMeasurement3YearStandDevIndices[i], checkRiskMeasurementSharpeIndex[i], checkTimeWeightedNetOfFees[i], checkTimeWeightedGrossOfFees[i], checkMoneyWeightedNetOfFees[i], performanceCalculations[i], checkPerfStartEndValues[i], numbering[i]);
        }
        
        //Configurer les options du rapport
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);

        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 333);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        //Parameters values (same as for the English report)
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate[i], endDate[i], period[i], period1[i], period2[i], period3[i], period4[i], period5[i], checkDisplayDefaultIndices[i], indicesToBeChecked[i], checkUseIndexBaseCurrency[i], checkGraphsAssetAllocation[i], checkGraphsInvestmentObjective[i], checkGraphsPortfolioPerformance[i], type[i], assetAllocation[i], customAllocation[i], checkUseTheSpecifiedInvestmentObjective[i], checkRiskMeasurementStandardDeviation[i], checkRiskMeasurement3YearStandardDeviation[i], checkRiskMeasurement3YearStandDevIndices[i], checkRiskMeasurementSharpeIndex[i], checkTimeWeightedNetOfFees[i], checkTimeWeightedGrossOfFees[i], checkMoneyWeightedNetOfFees[i], performanceCalculations[i], checkPerfStartEndValues[i], numbering[i]);
        }
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 336, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "077_PERF_SIMPLE", 337, language);
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
               
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        RestoreToDefaultPerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        Terminate_CroesusProcess();
    }
    
}
