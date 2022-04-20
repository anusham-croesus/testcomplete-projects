//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_067_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_067_Cli_Source_DateModf_NumVis_AddBranch_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 36);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 38);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 41, language);
        sortBy = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 42, language);
        currency = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 43, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 44, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 45, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 46, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 47, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 48, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 49, language);
        message = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 50, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkIncludeTheSourceColumn = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 53, language);
        startDate = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 54, language);
        endDate = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 55, language);
        numbering = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 56, language);
        
        SetReportParameters(checkIncludeTheSourceColumn, startDate, endDate, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 59);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 62, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "067_CASH_MOVEMENT", 63, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkIncludeTheSourceColumn, startDate, endDate, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}