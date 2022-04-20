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

function CR1485_053_Acc_DateModf_ClosedPos_NumVis_AddBranch()
{
    
    try {
        reportName = (client == "US")? GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 2, language): GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 66);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 68);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 71, language);
        sortBy = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 72, language);
        currency = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 73, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 74, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 75, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 76, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 77, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 78, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 79, language);
        message = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 80, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 83, language);
        positionState = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 84, language);
        numbering = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 85, language);
        
        SetReportParameters(asOfDate, positionState, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 88);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 91, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 92, language);
        
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