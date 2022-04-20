//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_013_Acc_AllTrans_DateModf_GroupTrans_NumVis_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 2, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 74);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 76);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 79, language);
        sortBy = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 80, language);
        currency = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 81, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 82, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 83, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 84, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 85, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 86, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 87, language);
        message = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 88, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        transactionTypesToBeChecked = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 91, language);
        startDate = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 92, language);
        endDate = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 93, language);
        checkGroupByRecord = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 94, language);
        checkGroupByTransactionType = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 95, language);
        checkGroupBySecurity = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 96, language);
        numbering = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 97, language);
        
        SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering);
                
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 100);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 103, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 104, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering);
        
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