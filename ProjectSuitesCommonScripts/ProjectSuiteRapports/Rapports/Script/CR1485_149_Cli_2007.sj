//USEUNIT CR1485_149_Common_functions
//USEUNIT CR1485_107_Common_functions


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\149. Page couverture (Déclaration de revenus)\2. Clients\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_149_Cli_2007()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR2008_CR1880");
    Log.Message("CR2008 / CR1880");
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\149. Page couverture (Déclaration de revenus)\\2. Clients\\", "CR1485_149_Cli_2007()");
    
    try {
        var clientsNumbers = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 35);
        
        //Data for Coupled Report
        var coupledReport_Name = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 1, language);
        var coupledReport_StartDateMonth = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 180, language);
        var coupledReport_StartDateYear = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 181, language);
        var coupledReport_ForeignPropertyValue = (client == "US")? GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 183, language): GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 182, language);
        var coupledReport_CheckIncludeSummaryTable = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 184, language);
        var coupledReport_CheckIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 185, language);
        var coupledReport_PaginationValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 186, language);
        var coupledReport_SummaryTableValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 187, language);
        
        //Data for Main Report
        var reportName = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 1, language);
        var checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 52, language);
        var startDate = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 53, language);
        var endDate = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 54, language);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 40, language);
        var sortBy = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 41, language);
        var currency = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 42, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 43, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 44, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 45, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 46, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 47, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 48, language);
        var message = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 49, language);
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        CR1485_149_Common_functions.ActivatePrefs();
        CR1485_107_Common_functions.ActivatePrefs();
        
        //Login and goto the module and select elements
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientsNumbers.split("|"));
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 37);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select Main report and set its parameters
        SelectReports(reportName);
        CR1485_149_Common_functions.SetReportParameters(checkPreviousCalendarYear, startDate, endDate);
        
        //Select Coupled report and set its parameters 
        SelectAReport(coupledReport_Name);
        CR1485_107_Common_functions.SetReportParameters(coupledReport_StartDateMonth, coupledReport_StartDateYear, coupledReport_ForeignPropertyValue, coupledReport_CheckIncludeSummaryTable, coupledReport_CheckIncludeNonregisteredAccountsOnly, coupledReport_PaginationValue, coupledReport_SummaryTableValue);
        
        //Set Reports options
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 57);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 60, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 61, language);
        
        //Open Reports window
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select Main report and set its parameters (same parameters as for the English report)
        SelectReports(reportName);
        CR1485_149_Common_functions.SetReportParameters(checkPreviousCalendarYear, startDate, endDate);
        
        //Select Coupled report and set its parameters (same parameters as for the English report)
        SelectAReport(coupledReport_Name);
        CR1485_107_Common_functions.SetReportParameters(coupledReport_StartDateMonth, coupledReport_StartDateYear, coupledReport_ForeignPropertyValue, coupledReport_CheckIncludeSummaryTable, coupledReport_CheckIncludeNonregisteredAccountsOnly, coupledReport_PaginationValue, coupledReport_SummaryTableValue);
        
        //Set Reports options
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        CR1485_149_Common_functions.RestorePrefs();
        CR1485_107_Common_functions.RestorePrefs();
        Terminate_CroesusProcess();
    }
    
}
