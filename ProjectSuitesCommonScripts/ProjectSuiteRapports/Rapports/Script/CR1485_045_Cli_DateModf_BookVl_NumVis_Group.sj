//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_045_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_045_Cli_DateModf_BookVl_NumVis_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "045_DIST_BM", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "045_DIST_BM", 35);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "045_DIST_BM", 37);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "045_DIST_BM", 40, language);
        sortBy = GetData(filePath_ReportsCR1485, "045_DIST_BM", 41, language);
        currency = GetData(filePath_ReportsCR1485, "045_DIST_BM", 42, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "045_DIST_BM", 43, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "045_DIST_BM", 44, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "045_DIST_BM", 45, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "045_DIST_BM", 46, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "045_DIST_BM", 47, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "045_DIST_BM", 48, language);
        message = GetData(filePath_ReportsCR1485, "045_DIST_BM", 49, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "045_DIST_BM", 52, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "045_DIST_BM", 54, language): GetData(filePath_ReportsCR1485, "045_DIST_BM", 53, language);
        numbering = GetData(filePath_ReportsCR1485, "045_DIST_BM", 55, language);
                
        SetReportParameters(asOfDate, costCalculation, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "045_DIST_BM", 58);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "045_DIST_BM", 61, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "045_DIST_BM", 62, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, costCalculation, numbering);
        
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