//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_034_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_034_Sec_DateModf_AllRec_BookVl_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "034_MATURITY", 1, language);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Securities module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnSecurities().Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "034_MATURITY", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "034_MATURITY", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "034_MATURITY", 10, language);
        currency = GetData(filePath_ReportsCR1485, "034_MATURITY", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "034_MATURITY", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "034_MATURITY", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "034_MATURITY", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "034_MATURITY", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "034_MATURITY", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "034_MATURITY", 17, language);
        message = GetData(filePath_ReportsCR1485, "034_MATURITY", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "034_MATURITY", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "034_MATURITY", 22, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "034_MATURITY", 23, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "034_MATURITY", 25, language): GetData(filePath_ReportsCR1485, "034_MATURITY", 24, language);
        
        SetReportParameters(startDate, endDate, checkAllRecords, costCalculation);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "034_MATURITY", 28);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "034_MATURITY", 31, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "034_MATURITY", 32, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, checkAllRecords, costCalculation);
        
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