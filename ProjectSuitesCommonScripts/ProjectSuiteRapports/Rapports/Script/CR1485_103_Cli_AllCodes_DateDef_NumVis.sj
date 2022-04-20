﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_103_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_103_Cli_AllCodes_DateDef_NumVis()
{
    Log.Message("Bug JIRA CROES-6464");
    Log.Message("Bug JIRA CROES-6741.");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 4);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 10, language);
        currency = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 17, language);
        message = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        codes = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 22, language);
        numbering = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 23, language);
        
        SetReportParameters(codes, endDate, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 26);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 29, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "103_ASSET_REP", 30, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(codes, endDate, numbering);
        
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