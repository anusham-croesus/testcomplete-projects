//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_037_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_037_Cli_DateModf_SortTotal_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 37);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 39);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 42, language);
        sortBy = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 43, language);
        currency = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 44, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 45, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 46, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 47, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 48, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 49, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 50, language);
        message = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 51, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 54, language);
        endDate = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 55, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 56, language);
        checkIncludeAmortizedIncome = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 57, language);
        numbering = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 58, language);
        
        SetReportParameters(startDate, endDate, parametersSortBy, checkIncludeAmortizedIncome, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 61);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 64, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 65, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, parametersSortBy, checkIncludeAmortizedIncome, numbering);
        
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