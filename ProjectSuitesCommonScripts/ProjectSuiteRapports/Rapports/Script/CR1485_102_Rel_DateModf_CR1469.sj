//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_102_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : "P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\102. PERFORMANCE DU PORTEFEUILLE (SOMMAIRE DES COMPTES)\1.1 Relations"
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Abdel Matmat
*/

function CR1485_102_Rel_DateModf_CR1469()
{
    
    try {
      
        Log.Message("CR1469");
        Log.Message("JIRA CROES-11602");
    
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        reportName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 261, language);
        relationshipName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 263);
        
        
        //Activate Prefs
        ActivatePrefs();
        EnablePerformanceFeesGroupBoxForUser(userNameKEYNEJ);
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 265);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 268, language);
        sortBy = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 269, language);
        currency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 270, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 271, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 272, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 273, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 274, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 275, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 276, language);
        message = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 277, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 280, language);
        endDate = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 281, language);
        period = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 282, language);
        period1 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 283, language);
        period2 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 284, language);
        period3 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 285, language);
        period4 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 286, language);
        period5 = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 287, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 288, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 289, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 290, language);
        checkGraphsAssetAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 291, language);
        checkGraphsInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 292, language);
        checkGraphsPortfolioPerformance = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 293, language);
        type = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 294, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 295, language);
        customAllocation = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 296, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 297, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 298, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 299, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 300, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 301, language);
        numbering = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 302, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 305);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 308, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "102_PERF_ACC_SUMM", 309, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkGraphsAssetAllocation, checkGraphsInvestmentObjective, checkGraphsPortfolioPerformance, type, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        RestoreToDefaultPerformanceFeesGroupBoxForUser(userNameKEYNEJ);
        Terminate_CroesusProcess();
    }
    
}