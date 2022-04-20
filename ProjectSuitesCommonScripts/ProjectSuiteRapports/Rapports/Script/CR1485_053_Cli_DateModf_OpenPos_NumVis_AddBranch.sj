//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_053_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_053_Cli_DateModf_OpenPos_NumVis_AddBranch()
{
    
    try {
        reportName = (client == "US")? GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 2, language): GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 35);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 37);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 40, language);
        sortBy = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 41, language);
        currency = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 42, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 43, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 44, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 45, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 46, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 47, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 48, language);
        message = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 49, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 52, language);
        positionState = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 53, language);
        numbering = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 54, language);
        
        SetReportParameters(asOfDate, positionState, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 57);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 60, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 61, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, positionState, numbering);
        
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