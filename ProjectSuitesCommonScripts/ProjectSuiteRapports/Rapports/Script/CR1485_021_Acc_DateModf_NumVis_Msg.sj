//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_021_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_021_Acc_DateModf_NumVis_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 1, language);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 68);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 71, language);
        sortBy = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 72, language);
        currency = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 73, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 74, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 75, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 76, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 77, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 78, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 79, language);
        message = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 80, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 83, language);
        endDate = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 84, language);
        numbering = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 85, language);
        
        SetReportParameters(startDate, endDate, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 88);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 91, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "021_TRANS_MISSING_COST", 92, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, numbering);
        
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