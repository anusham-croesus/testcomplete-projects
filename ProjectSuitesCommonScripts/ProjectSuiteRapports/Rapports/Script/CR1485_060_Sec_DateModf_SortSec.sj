//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_060_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_060_Sec_DateModf_SortSec()
{
    Log.Message("Bug JIRA CROES-7741 / TCVE-1405");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 1, language);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Securities module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnSecurities().Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 10, language);
        currency = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 17, language);
        message = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 21, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 22, language);
        
        SetReportParameters(startDate, parametersSortBy);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 25);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 28, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "060_UNCAT_SECURITIES", 29, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, parametersSortBy);
        
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