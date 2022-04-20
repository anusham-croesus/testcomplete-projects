//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_058_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\58. Biens étrangers\4. Portefeuille\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_058_Portf_DateModf_SortCountry()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\58. Biens étrangers\\4. Portefeuille\\", "CR1485_058_Portf_DateModf_SortCountry()");
    Log.Message("Bug CROES-7004 : impossible de saisir la date du portefeuille.");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 100);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        //Drag the account to Portfolio module
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 102);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 107, language);
        endDate = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 119, language);
        SetPortfolioCurrencyAndDate(currency, endDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 105, language);
        sortBy = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 106, language);
        //currency = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 107, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 108, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 109, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 110, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 111, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 112, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 113, language);
        message = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 114, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 117, language);
        startDate = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 118, language);
        //endDate = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 119, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 120, language);
        //numbering = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 121, language);
        
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, parametersSortBy);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 123);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 126, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 126, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 127, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, parametersSortBy);
        
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