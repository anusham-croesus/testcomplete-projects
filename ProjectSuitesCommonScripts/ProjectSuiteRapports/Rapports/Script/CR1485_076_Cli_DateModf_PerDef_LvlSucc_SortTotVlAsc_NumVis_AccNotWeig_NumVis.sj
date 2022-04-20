//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_076_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_076_Cli_DateModf_PerDef_LvlSucc_SortTotVlAsc_NumVis_AccNotWeig_NumVis()
{
    Log.Message("Bug JIRA CROES-6464");
    Log.Message("Bug JIRA CROES-10192");
    Log.Message("Bug JIRA CROES-10329");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 1, language);
        
        
        //Se connecter avec l'utilisateur GP1859 afin que le groupbox Niveau (Level) de la fenêtre Paramètres du rapport soit activé
        userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameGP1859);
        
        //Login and goto Relationships module, select no relationship
        Login(vServerReportsCR1485, userNameGP1859, passwordGP1859, language);
        Get_ModulesBar_BtnClients().Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 49);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 52, language);
        sortBy = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 53, language);
        currency = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 54, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 55, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 56, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 57, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 58, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 59, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 60, language);
        message = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 61, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        endDate = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 64, language);
        period = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 65, language);
        period1 = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 66, language);
        period2 = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 67, language);
        period3 = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 68, language);
        period4 = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 69, language);
        period5 = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 70, language);
        level = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 71, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 72, language);
        AscendingOrDescending = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 73, language);
        checkRiskMeasurementQuartile = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 74, language);
        checkRiskMeasurementPerformanceOfIndex = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 75, language);
        checkWeightAccountsNotWeighted = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 76, language);
        checkWeightIACodesNotWeighted = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 77, language);
        numbering = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 78, language);
        
        SetReportParameters(endDate, period, period1, period2, period3, period4, period5, level, parametersSortBy, AscendingOrDescending, checkRiskMeasurementQuartile, checkRiskMeasurementPerformanceOfIndex, checkWeightAccountsNotWeighted, checkWeightIACodesNotWeighted, numbering);

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 81);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 84, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "076_SUMMARY_PERF_OBJINV", 85, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(endDate, period, period1, period2, period3, period4, period5, level, parametersSortBy, AscendingOrDescending, checkRiskMeasurementQuartile, checkRiskMeasurementPerformanceOfIndex, checkWeightAccountsNotWeighted, checkWeightIACodesNotWeighted, numbering);
        
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