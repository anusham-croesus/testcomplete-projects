//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_107_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\107. BIENS ÉTRANGERS (SIMPLIFIÉ)\2. Clients\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_107_Cli_M01_Y2008_BookVl_AddBranch_Msg()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\107. BIENS ÉTRANGERS (SIMPLIFIÉ)\\2. Clients\\", "CR1485_107_Cli_M01_Y2008_BookVl_AddBranch_Msg()");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 36);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        Log.Message("Activation des PREFs");
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        Log.Message("Sélection des clients");
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 38);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 41, language);
        sortBy = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 42, language);
        currency = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 43, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 44, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 45, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 46, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 47, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 48, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 49, language);
        message = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 50, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDateMonth = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 53, language);
        startDateYear = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 54, language);
        foreignPropertyValue = (client == "US")? GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 56, language): GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 55, language);
        checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 59, language);
        checkIncludeSummaryTable = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 57, language);
        PaginationValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 58, language);
        SummaryTableValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 60, language);
        
        Log.Message("Sélection des paramètres du rapport");
        SetReportParameters(startDateMonth, startDateYear, foreignPropertyValue, checkIncludeSummaryTable, checkIncludeNonregisteredAccountsOnly, PaginationValue, SummaryTableValue);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 61);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 63, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 64, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        Log.Message("Sélection des paramètres du rapport (les mêmes que le rapport en anglais");
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