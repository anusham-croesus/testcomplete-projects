//USEUNIT Common_functions
//USEUNIT CR1485_Common_functions
//USEUNIT CR1485_005_Common_functions




/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_005_Acc_DateDef_RepCR1905()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    Log.Message("CR1905");
    Log.Message("Bug JIRA CROES-11541");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 1, language);
        var accountNumber = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 341);
        
                
        //Activate Prefs
        ActivatePrefs(userNameReportsCR1485);
        EnablePerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        
        //Login and goto Accounts module and Select the account
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountNumber);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 343);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 346, language);
        var sortBy = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 347, language);
        var currency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 348, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 349, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 350, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 351, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 352, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 353, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 354, language);
        var message = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 355, language);
        
        //Parameters values
        var nbOfReportOcurrences = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 358, language);
        var separatorChar = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 359, language);
        var CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 360, language).split(separatorChar);
        CompareProperty(CheckExcludeDataPrecedingTheManagementStartDate.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var endDate = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 361, language).split(separatorChar);
        CompareProperty(endDate.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 362, language).split(separatorChar);
        CompareProperty(period.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period1 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 363, language).split(separatorChar);
        CompareProperty(period1.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period2 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 364, language).split(separatorChar);
        CompareProperty(period2.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period3 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 365, language).split(separatorChar);
        CompareProperty(period3.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period4 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 366, language).split(separatorChar);
        CompareProperty(period4.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period5 = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 367, language).split(separatorChar);
        CompareProperty(period5.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 368, language).split(separatorChar);
        CompareProperty(checkDisplayDefaultIndices.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var indicesToBeChecked = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 369, language).split(separatorChar);
        CompareProperty(indicesToBeChecked.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 370, language).split(separatorChar);
        CompareProperty(checkUseIndexBaseCurrency.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 371, language).split(separatorChar);
        CompareProperty(checkGraphsAssetAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 372, language).split(separatorChar);
        CompareProperty(checkGraphsInvestmentObjective.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 373, language).split(separatorChar);
        CompareProperty(checkGraphsPortfolioPerformance.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var type = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 374, language).split(separatorChar);
        CompareProperty(type.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var assetAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 375, language).split(separatorChar);
        CompareProperty(assetAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var customAllocation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 376, language).split(separatorChar);
        CompareProperty(customAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 377, language).split(separatorChar);
        CompareProperty(checkUseTheSpecifiedInvestmentObjective.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 378, language).split(separatorChar);
        CompareProperty(checkTimeWeightedNetOfFees.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 379, language).split(separatorChar);
        CompareProperty(checkTimeWeightedGrossOfFees.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 380, language).split(separatorChar);
        CompareProperty(checkMoneyWeightedNetOfFees.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 381, language).split(separatorChar);
        CompareProperty(checkRiskMeasurementStandardDeviation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkRiskMeasurement3YearStandardDeviation = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 382, language).split(separatorChar);
        CompareProperty(checkRiskMeasurement3YearStandardDeviation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkRiskMeasurement3YearStandDevIndices = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 383, language).split(separatorChar);
        CompareProperty(checkRiskMeasurement3YearStandDevIndices.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 384, language).split(separatorChar);
        CompareProperty(checkRiskMeasurementSharpeIndex.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var performanceCalculations = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 385, language).split(separatorChar);
        CompareProperty(performanceCalculations.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkDisplayDetails = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 386, language).split(separatorChar);
        CompareProperty(checkDisplayDetails.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var numbering = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 387, language).split(separatorChar);
        CompareProperty(numbering.length, cmpEqual, nbOfReportOcurrences, true, lmError);

        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate[i], endDate[i], period[i], period1[i], period2[i], period3[i], period4[i], period5[i], checkDisplayDefaultIndices[i], indicesToBeChecked[i], checkUseIndexBaseCurrency[i], checkGraphsAssetAllocation[i], checkGraphsInvestmentObjective[i], checkGraphsPortfolioPerformance[i], type[i], assetAllocation[i], customAllocation[i], checkUseTheSpecifiedInvestmentObjective[i], checkTimeWeightedNetOfFees[i], checkTimeWeightedGrossOfFees[i], checkMoneyWeightedNetOfFees[i], checkRiskMeasurementStandardDeviation[i], checkRiskMeasurement3YearStandardDeviation[i], checkRiskMeasurement3YearStandDevIndices[i], checkRiskMeasurementSharpeIndex[i], performanceCalculations[i], checkDisplayDetails[i], numbering[i]);
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
        
        var reportFileName = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 390);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        //Parameters values (same as for the English report)
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate[i], endDate[i], period[i], period1[i], period2[i], period3[i], period4[i], period5[i], checkDisplayDefaultIndices[i], indicesToBeChecked[i], checkUseIndexBaseCurrency[i], checkGraphsAssetAllocation[i], checkGraphsInvestmentObjective[i], checkGraphsPortfolioPerformance[i], type[i], assetAllocation[i], customAllocation[i], checkUseTheSpecifiedInvestmentObjective[i], checkTimeWeightedNetOfFees[i], checkTimeWeightedGrossOfFees[i], checkMoneyWeightedNetOfFees[i], checkRiskMeasurementStandardDeviation[i], checkRiskMeasurement3YearStandardDeviation[i], checkRiskMeasurement3YearStandDevIndices[i], checkRiskMeasurementSharpeIndex[i], performanceCalculations[i], checkDisplayDetails[i], numbering[i]);
        }
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 393, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "005_PERFORMANCE", 394, language);
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
