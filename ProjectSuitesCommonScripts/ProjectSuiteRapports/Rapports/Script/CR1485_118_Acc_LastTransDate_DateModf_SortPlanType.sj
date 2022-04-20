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

function CR1485_118_Acc_LastTransDate_DateModf_SortPlanType()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 36);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 38);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 41, language);
        sortBy = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 42, language);
        currency = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 43, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 44, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 45, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 46, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 47, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 48, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 49, language);
        message = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 50, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        dateType = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 53, language);
        startDate = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 54, language);
        endDate = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 55, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 56, language);
        
        SetReportParameters(dateType, startDate, endDate, parametersSortBy);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 59);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 62, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 63, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
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