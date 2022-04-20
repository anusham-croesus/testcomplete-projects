//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_078_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_078_Rel_DateDef_PerDef_LvlAllBranch_SortTotVl_NumVis()
{
    Log.Message("Bug JIRA CROES-6464");
    Log.Message("Bug JIRA CROES-10192");
    Log.Message("Bug JIRA CROES-10329");
    
    try {
        
        reportName = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 1, language);
        
        
        //Se connecter avec l'utilisateur GP1859 afin que le groupbox Niveau (Level) de la fenêtre Paramètres du rapport soit activé
        userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameGP1859);
        
        //Login and goto Relationships module, select no relationship
        Login(vServerReportsCR1485, userNameGP1859, passwordGP1859, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 10, language);
        currency = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 17, language);
        message = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 22, language);
        period = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 23, language);
        period1 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 24, language);
        period2 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 25, language);
        period3 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 26, language);
        period4 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 27, language);
        period5 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 28, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 29, language);
        level = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 30, language);
        checkComparativePerformance = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 31, language);
        checkComparativeStandardDeviation = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 32, language);
        checkComparativeSharpeIndex = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 33, language);
        comparativeReferentialIndex = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 34, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 35, language);
        AscendingOrDescending = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 36, language);
        checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 37, language);
        checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 38, language);
        checkRiskMeasurementQuartile = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 39, language);
        checkWeightAccountsNotWeighted = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 40, language);
        checkWeightIACodesNotWeighted = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 41, language);
        numbering = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 42, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, indicesToBeChecked, level, checkComparativePerformance, checkComparativeStandardDeviation, checkComparativeSharpeIndex, comparativeReferentialIndex, parametersSortBy, AscendingOrDescending, checkRiskMeasurementStandardDeviation, checkRiskMeasurementSharpeIndex, checkRiskMeasurementQuartile, checkWeightAccountsNotWeighted, checkWeightIACodesNotWeighted, numbering);

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 45);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 48, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 49, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, indicesToBeChecked, level, checkComparativePerformance, checkComparativeStandardDeviation, checkComparativeSharpeIndex, comparativeReferentialIndex, parametersSortBy, AscendingOrDescending, checkRiskMeasurementStandardDeviation, checkRiskMeasurementSharpeIndex, checkRiskMeasurementQuartile, checkWeightAccountsNotWeighted, checkWeightIACodesNotWeighted, numbering);
        
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