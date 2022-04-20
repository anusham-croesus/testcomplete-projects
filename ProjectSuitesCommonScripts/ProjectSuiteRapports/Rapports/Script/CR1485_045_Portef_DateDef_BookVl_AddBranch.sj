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

function CR1485_045_Portef_DateDef_BookVl_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "045_DIST_BM", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "045_DIST_BM", 99);
        
        
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
        reportFileName = GetData(filePath_ReportsCR1485, "045_DIST_BM", 101);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "045_DIST_BM", 106, language);
        asOfDate = GetData(filePath_ReportsCR1485, "045_DIST_BM", 116, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "045_DIST_BM", 104, language);
        sortBy = GetData(filePath_ReportsCR1485, "045_DIST_BM", 105, language);
        //currency = GetData(filePath_ReportsCR1485, "045_DIST_BM", 106, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "045_DIST_BM", 107, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "045_DIST_BM", 108, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "045_DIST_BM", 109, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "045_DIST_BM", 110, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "045_DIST_BM", 111, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "045_DIST_BM", 112, language);
        message = GetData(filePath_ReportsCR1485, "045_DIST_BM", 113, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "045_DIST_BM", 116, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "045_DIST_BM", 118, language): GetData(filePath_ReportsCR1485, "045_DIST_BM", 117, language);
        numbering = GetData(filePath_ReportsCR1485, "045_DIST_BM", 119, language);
                
        SetReportParameters(asOfDate, costCalculation, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "045_DIST_BM", 122);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "045_DIST_BM", 125, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "045_DIST_BM", 125, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "045_DIST_BM", 126, language);
        
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