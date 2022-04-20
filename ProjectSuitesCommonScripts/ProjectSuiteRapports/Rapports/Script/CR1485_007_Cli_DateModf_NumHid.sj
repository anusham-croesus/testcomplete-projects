//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_007_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_007_Cli_DateModf_NumHid()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 2, language);
        arrayOfReportsNames = reportName.split("|");
        clientNumber = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 34);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 36);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the Document Summary report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 39, language);
        sortBy = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 40, language);
        currency = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 41, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 42, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 43, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 44, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 45, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 46, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 47, language);
        message = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 48, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 51, language);
        numbering = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 52, language);
        
        //Set the report parameters
        SetReportParameters(asOfDate, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 55);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the Document Summary report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 58, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 59, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, numbering);
        
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