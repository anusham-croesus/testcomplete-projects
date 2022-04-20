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

function CR1485_053_Portf_NoParam()
{
    
    try {
        reportName = (client == "US")? GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 2, language): GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 97);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        //Drag the account to Portfolio module
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 99);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 104, language);
        asOfDate = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 114, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 102, language);
        sortBy = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 103, language);
        //currency = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 104, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 105, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 106, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 107, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 108, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 109, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 110, language);
        message = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 111, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 114, language);
        //positionState = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 115, language);
        //numbering = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 116, language);
        
        //SetReportParameters(asOfDate, positionState, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 119);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 122, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 122, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 123, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        //SetReportParameters(asOfDate, positionState, numbering);
        
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