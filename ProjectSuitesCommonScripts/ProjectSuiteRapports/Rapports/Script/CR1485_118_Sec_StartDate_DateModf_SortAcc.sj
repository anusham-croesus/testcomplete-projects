//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_118_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_118_Sec_StartDate_DateModf_SortAcc()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 1, language);
        securitiesNames = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 68, language);
        arrayOfSecuritiesNames = securitiesNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Securities module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnSecurities().Click();
        
        //Check securities
        CheckSecurities(arrayOfSecuritiesNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 70);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 73, language);
        sortBy = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 74, language);
        currency = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 75, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 76, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 77, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 78, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 79, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 80, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 81, language);
        message = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 82, language);
        source = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 83, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbSource(), source);
        
        //Parameters values
        dateType = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 86, language);
        startDate = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 87, language);
        endDate = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 88, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 89, language);
        
        SetReportParameters(dateType, startDate, endDate, parametersSortBy);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 92);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 95, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 96, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        SelectComboBoxItem(Get_WinReports_GrpOptions_CmbSource(), source);
        
        //Parameters values (same as for the English report)
        SetReportParameters(dateType, startDate, endDate, parametersSortBy);
        
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