//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_058_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\58. Biens étrangers\1. Relations
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_058_Rel_PrevYear_DateDef_SortCountry()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\58. Biens étrangers\\1. Relations\\", "CR1485_058_Rel_PrevYear_DateDef_SortCountry()");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 10, language);
        currency = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 17, language);
        message = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 21, language);
        startDate = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 22, language);
        endDate = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 23, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 24, language);
        numbering = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 25, language);
        
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, parametersSortBy, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 27);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 30, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 31, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, parametersSortBy, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        RestorePrefs();
        Terminate_CroesusProcess();
    }
    
}