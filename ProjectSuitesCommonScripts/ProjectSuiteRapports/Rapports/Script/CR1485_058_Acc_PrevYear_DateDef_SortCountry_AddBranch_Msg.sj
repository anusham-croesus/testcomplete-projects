//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_058_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\58. Biens étrangers\3. Comptes\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_058_Acc_PrevYear_DateDef_SortCountry_AddBranch_Msg()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\58. Biens étrangers\\3. Comptes\\", "CR1485_058_Acc_PrevYear_DateDef_SortCountry_AddBranch_Msg()");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 68);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 70);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 73, language);
        sortBy = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 74, language);
        currency = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 75, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 76, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 77, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 78, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 79, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 80, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 81, language);
        message = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 82, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 85, language);
        startDate = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 86, language);
        endDate = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 87, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 88, language);
        numbering = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 89, language);
        
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, parametersSortBy, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 91);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 94, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 95, language);
        
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