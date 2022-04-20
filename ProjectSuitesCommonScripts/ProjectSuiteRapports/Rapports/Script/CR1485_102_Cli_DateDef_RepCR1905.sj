//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_102_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions




/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_102_Cli_DateDef_RepCR1905()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    Log.Message("CR1905");
    Log.Message("Bug JIRA CROES-11541");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 1, language);
        var clientsNumbers = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 208);
        
        
        //Activate Prefs
        ActivatePrefs();
        EnablePerformanceFeesGroupBoxForUser(userNameReportsCR1485);
        
        //Login and goto Clients module and Select Clients
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientsNumbers.split("|"));
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 210);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 213, language);
        var sortBy = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 214, language);
        var currency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 215, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 216, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 217, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 218, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 219, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 220, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 221, language);
        var message = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 222, language);
        
        //Parameters values
        var nbOfReportOcurrences = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 225, language);
        var separatorChar = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 226, language);
        var CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 227, language).split(separatorChar);
        CompareProperty(CheckExcludeDataPrecedingTheManagementStartDate.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var endDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 228, language).split(separatorChar);
        CompareProperty(endDate.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 229, language).split(separatorChar);
        CompareProperty(period.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period1 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 230, language).split(separatorChar);
        CompareProperty(period1.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 231, language).split(separatorChar);
        CompareProperty(period2.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 232, language).split(separatorChar);
        CompareProperty(period3.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period4 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 233, language).split(separatorChar);
        CompareProperty(period4.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var period5 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 234, language).split(separatorChar);
        CompareProperty(period5.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 235, language).split(separatorChar);
        CompareProperty(checkDisplayDefaultIndices.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var indicesToBeChecked = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 236, language).split(separatorChar);
        CompareProperty(indicesToBeChecked.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 237, language).split(separatorChar);
        CompareProperty(checkUseIndexBaseCurrency.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 238, language).split(separatorChar);
        CompareProperty(checkGraphsAssetAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 239, language).split(separatorChar);
        CompareProperty(checkGraphsInvestmentObjective.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 240, language).split(separatorChar);
        CompareProperty(checkGraphsPortfolioPerformance.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var type = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 241, language).split(separatorChar);
        CompareProperty(type.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var assetAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 242, language).split(separatorChar);
        CompareProperty(assetAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var customAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 243, language).split(separatorChar);
        CompareProperty(customAllocation.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 244, language).split(separatorChar);
        CompareProperty(checkUseTheSpecifiedInvestmentObjective.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 245, language).split(separatorChar);
        CompareProperty(checkTimeWeightedNetOfFees.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 246, language).split(separatorChar);
        CompareProperty(checkTimeWeightedGrossOfFees.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 247, language).split(separatorChar);
        CompareProperty(checkMoneyWeightedNetOfFees.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var performanceCalculations = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 248, language).split(separatorChar);
        CompareProperty(performanceCalculations.length, cmpEqual, nbOfReportOcurrences, true, lmError);
        var numbering = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 249, language).split(separatorChar);
        CompareProperty(numbering.length, cmpEqual, nbOfReportOcurrences, true, lmError);

        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate[i], endDate[i], period[i], period1[i], period2[i], period3[i], period4[i], period5[i], checkDisplayDefaultIndices[i], indicesToBeChecked[i], checkUseIndexBaseCurrency[i], checkGraphsAssetAllocation[i], checkGraphsInvestmentObjective[i], checkGraphsPortfolioPerformance[i], type[i], assetAllocation[i], customAllocation[i], checkUseTheSpecifiedInvestmentObjective[i], checkTimeWeightedNetOfFees[i], checkTimeWeightedGrossOfFees[i], checkMoneyWeightedNetOfFees[i], performanceCalculations[i], numbering[i]);
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
        
        var reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 252);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Sélectionner le rapport et Configurer les paramètres autant de fois que spécifié par nbOfReportOcurrences
        if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
            Get_Reports_GrpReports_BtnRemoveAllReports().Click();
        
        //Parameters values (same as for the English report)
        for (var i = 0; i < nbOfReportOcurrences; i++){
            SelectAReport(reportName);
            SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate[i], endDate[i], period[i], period1[i], period2[i], period3[i], period4[i], period5[i], checkDisplayDefaultIndices[i], indicesToBeChecked[i], checkUseIndexBaseCurrency[i], checkGraphsAssetAllocation[i], checkGraphsInvestmentObjective[i], checkGraphsPortfolioPerformance[i], type[i], assetAllocation[i], customAllocation[i], checkUseTheSpecifiedInvestmentObjective[i], checkTimeWeightedNetOfFees[i], checkTimeWeightedGrossOfFees[i], checkMoneyWeightedNetOfFees[i], performanceCalculations[i], numbering[i]);
        }
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 255, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 256, language);
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
