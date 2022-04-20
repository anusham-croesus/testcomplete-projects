//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_058_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\58. Biens étrangers\2. Clients\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_058_Cli_DateModf_SortFinInst_AddBranch_Msg_Group()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\58. Biens étrangers\\2. Clients\\", "CR1485_058_Cli_DateModf_SortFinInst_AddBranch_Msg_Group()");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 36);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 38);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 41, language);
        sortBy = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 42, language);
        currency = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 43, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 44, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 45, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 46, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 47, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 48, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 49, language);
        message = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 50, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 53, language);
        startDate = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 54, language);
        endDate = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 55, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 56, language);
        numbering = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 57, language);
        
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, parametersSortBy, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 59);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 62, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 63, language);
        
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