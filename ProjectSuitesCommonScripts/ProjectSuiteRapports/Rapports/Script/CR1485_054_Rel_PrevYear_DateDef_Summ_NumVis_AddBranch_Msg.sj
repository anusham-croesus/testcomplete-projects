﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_054_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_054_Rel_PrevYear_DateDef_Summ_NumVis_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 10, language);
        currency = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 17, language);
        message = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 21, language);
        startDate = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 22, language);
        endDate = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 23, language);
        transactions = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 24, language);
        numbering = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 25, language);
        
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, transactions, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 28);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 31, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 32, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, transactions, numbering);
        
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