//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_058_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\58. Biens étrangers\2.1 Clients\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_058_Cli_DateDef_SortFinInst_Group()
{
    Log.Message("CR1275");
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\58. Biens étrangers\\2.1 Clients\\", "CR1485_058_Cli_DateDef_SortFinInst_Group()");
    
    try {
        //D'abord mettre à jour les titres à exclure du rapport
        var arrayOfSecuritiesToBeUpdated = new Array();
        var securitiesToBeExcludedFromTheReport = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 132);
        var SQLQuery = "select SECURITY, DESC_L1 from B_TITRE where SECURITY in (" + securitiesToBeExcludedFromTheReport + ") and not (EXCLUDE_FOREIGN_REPORT = 'Y')";
        arrayOfSecuritiesToBeUpdated = Execute_SQLQuery_GetFieldAllValues(SQLQuery, vServerReportsCR1485, "SECURITY");
        UpdateSecuritiesExcludeFromForeignProperty(arrayOfSecuritiesToBeUpdated, true);
        
        reportName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 133);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 135);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 138, language);
        sortBy = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 139, language);
        currency = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 140, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 141, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 142, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 143, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 144, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 145, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 146, language);
        message = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 147, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 150, language);
        startDate = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 151, language);
        endDate = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 152, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 153, language);
        numbering = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 154, language);
        
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, parametersSortBy, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 156);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);

        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 159, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "058_FOREIGN_PROPERTY", 160, language);
        
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
        UpdateSecuritiesExcludeFromForeignProperty(arrayOfSecuritiesToBeUpdated, false);
        RestorePrefs();
        Terminate_CroesusProcess();
    }
    
}



function UpdateSecuritiesExcludeFromForeignProperty(arrayOfSecuritiesToBeUpdated, isExcludeForeignReportToBeChecked)
{
    if (arrayOfSecuritiesToBeUpdated.length == 0) return;
    
    var updateValue = (isExcludeForeignReportToBeChecked)? "Y": "N";
    var SQLQuery = "update B_TITRE set EXCLUDE_FOREIGN_REPORT = '" + updateValue + "' where SECURITY in (" + arrayOfSecuritiesToBeUpdated + ")";
    Log.Message(SQLQuery);
    Execute_SQLQuery(SQLQuery, vServerReportsCR1485);
}
