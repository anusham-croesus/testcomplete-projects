//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_107_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\107. BIENS ÉTRANGERS (SIMPLIFIÉ)\3. Comptes\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_107_Acc_M02_Y2007_BookVl_Group()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\107. BIENS ÉTRANGERS (SIMPLIFIÉ)\\3. Comptes\\", "CR1485_107_Acc_M02_Y2007_BookVl_Group()");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 69);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        Log.Message("Activation des PREFs");
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        Log.Message("Sélection des comptes");
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 71);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 74, language);
        sortBy = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 75, language);
        currency = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 76, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 77, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 78, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 79, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 80, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 81, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 82, language);
        message = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 83, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDateMonth = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 86, language);
        startDateYear = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 87, language);
        foreignPropertyValue = (client == "US")? GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 89, language): GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 88, language);
        checkIncludeSummaryTable = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 90, language);
        checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 92, language);
        PaginationValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 91, language);
        SummaryTableValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 93, language);
        
        Log.Message("Sélection des paramètres du rapport");
        SetReportParameters(startDateMonth, startDateYear, foreignPropertyValue, checkIncludeSummaryTable, checkIncludeNonregisteredAccountsOnly, PaginationValue, SummaryTableValue);
        
        //Validate and save report
        Log.Message("Validation et sauvegarde du rapport");
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 94);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 96, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 97, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        Log.Message("Sélection des paramètres du rapport (les mêmes que le rapport en anglais)");
        SetReportParameters(startDateMonth, startDateYear, foreignPropertyValue, checkIncludeSummaryTable, checkIncludeNonregisteredAccountsOnly, PaginationValue, SummaryTableValue);
        
        //Validate and save report
        Log.Message("Validation et sauvegarde du rapport");
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