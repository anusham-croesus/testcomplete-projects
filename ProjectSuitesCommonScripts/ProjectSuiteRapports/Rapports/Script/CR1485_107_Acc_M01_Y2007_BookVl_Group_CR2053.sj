//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_107_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\107. BIENS ÉTRANGERS (SIMPLIFIÉ)\3.1 Comptes\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_107_Acc_M01_Y2007_BookVl_Group_CR2053()
{
    Log.Message("CR2053");
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\107. BIENS ÉTRANGERS (SIMPLIFIÉ)\\3.1 Comptes\\", "CR1485_107_Acc_M01_Y2007_BookVl_Group_CR2053()");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 102);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Désactiver Pref relative au CR2053
        Log.Message("Désactiver Pref relative au CR2053.");
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_INCLUDE_SHORT_IN_FOREIGN_REPORT", "NO", vServerReportsCR1485);

        //Activate Prefs
        Log.Message("Activation des PREFs");
        ActivatePrefs();        
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        Log.Message("Sélection des comptes");
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 104);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 107, language);
        sortBy = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 108, language);
        currency = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 109, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 110, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 111, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 112, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 113, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 114, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 115, language);
        message = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 116, language);
        
        Log.Message("Sélection des options du rapport");
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDateMonth = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 119, language);
        startDateYear = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 120, language);
        foreignPropertyValue = (client == "US")? GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 122, language): GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 121, language);
        checkIncludeSummaryTable = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 123, language);
        checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 125, language);
        PaginationValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 124, language);
        SummaryTableValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 126, language);
        
        Log.Message("Sélection des paramètres du rapport");
        SetReportParameters(startDateMonth, startDateYear, foreignPropertyValue, checkIncludeSummaryTable, checkIncludeNonregisteredAccountsOnly, PaginationValue, SummaryTableValue);
        
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 127);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 129, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 130, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        Log.Message("Sélection des paramètres du rapport (les mêmes que pour le rapport en anglais)");
        SetReportParameters(startDateMonth, startDateYear, foreignPropertyValue, checkIncludeSummaryTable, checkIncludeNonregisteredAccountsOnly, PaginationValue, SummaryTableValue);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.Message("Réactiver Pref relative au CR2053.");
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_INCLUDE_SHORT_IN_FOREIGN_REPORT", "YES", vServerReportsCR1485);
        RestorePrefs();
        Terminate_CroesusProcess();
    }
    
}
