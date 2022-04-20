﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_024_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_024_Cli_Y2007_NumVis_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 34);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 36);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 39, language);
        sortBy = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 40, language);
        currency = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 41, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 42, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 43, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 44, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 45, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 46, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 47, language);
        message = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 48, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        year = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 51, language);
        numbering = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 52, language);
        
        SetReportParameters(year, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 55);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 58, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 59, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(year, numbering);
        
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