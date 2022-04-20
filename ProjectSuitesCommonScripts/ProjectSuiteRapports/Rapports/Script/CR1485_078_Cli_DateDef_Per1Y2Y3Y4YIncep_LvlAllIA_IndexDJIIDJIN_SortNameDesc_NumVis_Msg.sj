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

function CR1485_078_Cli_DateDef_Per1Y2Y3Y4YIncep_LvlAllIA_IndexDJIIDJIN_SortNameDesc_NumVis_Msg()
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
        Get_ModulesBar_BtnClients().Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 56);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 59, language);
        sortBy = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 60, language);
        currency = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 61, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 62, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 63, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 64, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 65, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 66, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 67, language);
        message = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 68, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 71, language);
        endDate = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 72, language);
        period = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 73, language);
        period1 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 74, language);
        period2 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 75, language);
        period3 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 76, language);
        period4 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 77, language);
        period5 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 78, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 79, language);
        level = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 80, language);
        checkComparativePerformance = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 81, language);
        checkComparativeStandardDeviation = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 82, language);
        checkComparativeSharpeIndex = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 83, language);
        comparativeReferentialIndex = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 84, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 85, language);
        AscendingOrDescending = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 86, language);
        checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 87, language);
        checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 88, language);
        checkRiskMeasurementQuartile = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 89, language);
        checkWeightAccountsNotWeighted = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 90, language);
        checkWeightIACodesNotWeighted = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 91, language);
        numbering = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 92, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, indicesToBeChecked, level, checkComparativePerformance, checkComparativeStandardDeviation, checkComparativeSharpeIndex, comparativeReferentialIndex, parametersSortBy, AscendingOrDescending, checkRiskMeasurementStandardDeviation, checkRiskMeasurementSharpeIndex, checkRiskMeasurementQuartile, checkWeightAccountsNotWeighted, checkWeightIACodesNotWeighted, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 95);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 98, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 99, language);
        
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