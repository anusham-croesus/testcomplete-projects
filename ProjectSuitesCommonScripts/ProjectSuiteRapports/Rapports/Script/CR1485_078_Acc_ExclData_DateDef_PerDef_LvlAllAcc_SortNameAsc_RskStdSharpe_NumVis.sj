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

function CR1485_078_Acc_ExclData_DateDef_PerDef_LvlAllAcc_SortNameAsc_RskStdSharpe_NumVis()
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
        Get_ModulesBar_BtnAccounts().Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 106);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 109, language);
        sortBy = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 110, language);
        currency = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 111, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 112, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 113, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 114, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 115, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 116, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 117, language);
        message = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 118, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 121, language);
        endDate = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 122, language);
        period = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 123, language);
        period1 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 124, language);
        period2 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 125, language);
        period3 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 126, language);
        period4 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 127, language);
        period5 = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 128, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 129, language);
        level = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 130, language);
        checkComparativePerformance = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 131, language);
        checkComparativeStandardDeviation = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 132, language);
        checkComparativeSharpeIndex = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 133, language);
        comparativeReferentialIndex = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 134, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 135, language);
        AscendingOrDescending = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 136, language);
        checkRiskMeasurementStandardDeviation = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 137, language);
        checkRiskMeasurementSharpeIndex = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 138, language);
        checkRiskMeasurementQuartile = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 139, language);
        checkWeightAccountsNotWeighted = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 140, language);
        checkWeightIACodesNotWeighted = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 141, language);
        numbering = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 142, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, indicesToBeChecked, level, checkComparativePerformance, checkComparativeStandardDeviation, checkComparativeSharpeIndex, comparativeReferentialIndex, parametersSortBy, AscendingOrDescending, checkRiskMeasurementStandardDeviation, checkRiskMeasurementSharpeIndex, checkRiskMeasurementQuartile, checkWeightAccountsNotWeighted, checkWeightIACodesNotWeighted, numbering);
        Log.Message("RPT-1152");
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 145);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 148, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "078_SUMMARY_PERF", 149, language);
        
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