﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_120_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_120_Sec_AllRecords()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 1, language);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Securities module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 10, language);
        currency = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 17, language);
        message = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckAllRecords = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 21, language);
        
        SetReportParameters(CheckAllRecords);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 24);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 27, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "120_FREE_UNITS_HOLDERS", 28, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckAllRecords);
        
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