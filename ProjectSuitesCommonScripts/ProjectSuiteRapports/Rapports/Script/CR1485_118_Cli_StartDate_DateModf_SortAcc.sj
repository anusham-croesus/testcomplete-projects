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

function CR1485_118_Cli_StartDate_DateModf_SortAcc()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 4);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 10, language);
        currency = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 17, language);
        message = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        dateType = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 21, language);
        startDate = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 22, language);
        endDate = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 23, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 24, language);
        
        SetReportParameters(dateType, startDate, endDate, parametersSortBy);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 27);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 30, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "118_SYS_PLANS", 31, language);
        
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