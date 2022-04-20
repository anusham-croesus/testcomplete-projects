//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_107_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\107. BIENS ÉTRANGERS (SIMPLIFIÉ)\1. Relations\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_107_Rel_M01_Y2009_MrktVl_Som_AddBranch_Msg()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\107. BIENS ÉTRANGERS (SIMPLIFIÉ)\\1. Relations\\", "CR1485_107_Rel_M01_Y2009_MrktVl_Som_AddBranch_Msg()");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 1, language);
        relationshipsNames = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 4);
        arrayOfRelationshipsNames = relationshipsNames.split("|");
        
        
        //Activate Prefs
        Log.Message("Activation des PREFs");
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select relationships
        Log.Message("Sélection des relations");
        SelectRelationships(arrayOfRelationshipsNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 10, language);
        currency = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 17, language);
        message = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 18, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDateMonth = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 21, language);
        startDateYear = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 22, language);
        foreignPropertyValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 23, language);
        checkIncludeSummaryTable = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 24, language);
        checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 27, language);
        PaginationValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 25, language);
        SummaryTableValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 26, language);
        
        Log.Message("Sélection des paramètres du rapport");
        SetReportParameters(startDateMonth, startDateYear, foreignPropertyValue, checkIncludeSummaryTable, checkIncludeNonregisteredAccountsOnly, PaginationValue, SummaryTableValue);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 28);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 30, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 31, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        Log.Message("Sélection des paramètres du rapport (les mêmes que le rapport en anglais)");
        SetReportParameters(startDateMonth, startDateYear, foreignPropertyValue, checkIncludeSummaryTable, checkIncludeNonregisteredAccountsOnly, PaginationValue, SummaryTableValue);
        
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