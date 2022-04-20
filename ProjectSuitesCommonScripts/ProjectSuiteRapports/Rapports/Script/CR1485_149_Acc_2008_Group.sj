//USEUNIT CR1485_149_Common_functions
//USEUNIT CR1485_107_Common_functions


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\149. Page couverture (Déclaration de revenus)\3. Comptes\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_149_Acc_2008_Group()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR2008_CR1880");
    Log.Message("CR2008 / CR1880");
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\149. Page couverture (Déclaration de revenus)\\3. Comptes\\", "CR1485_149_Acc_2008_Group()");
    
    try {
        var accountsNumbers = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 66);
        
        //Data for Coupled Report
        var coupledReport_Name = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 1, language);
        var coupledReport_StartDateMonth = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 190, language);
        var coupledReport_StartDateYear = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 191, language);
        var coupledReport_ForeignPropertyValue = (client == "US")? GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 193, language): GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 192, language);
        var coupledReport_CheckIncludeSummaryTable = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 194, language);
        var coupledReport_CheckIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 195, language);
        var coupledReport_PaginationValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 196, language);
        var coupledReport_SummaryTableValue = GetData(filePath_ReportsCR1485, "107_FOREIGN_PROP_SIMPLE", 197, language);
        
        //Data for Main Report
        var reportName = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 1, language);
        var checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 83, language);
        var startDate = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 84, language);
        var endDate = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 85, language);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 71, language);
        var sortBy = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 72, language);
        var currency = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 73, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 74, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 75, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 76, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 77, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 78, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 79, language);
        var message = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 80, language);
        
        //Activate Prefs
        CR1485_149_Common_functions.ActivatePrefs();
        CR1485_107_Common_functions.ActivatePrefs();
        
        //Login and goto the module and select elements
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountsNumbers.split("|"));
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 68);
        
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
        
        var reportFileName = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 88);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 91, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "149_TAX_COVERPAGE", 92, language);
        
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
