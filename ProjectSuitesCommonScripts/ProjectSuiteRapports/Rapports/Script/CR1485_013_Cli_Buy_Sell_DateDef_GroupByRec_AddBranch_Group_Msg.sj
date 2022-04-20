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

function CR1485_013_Cli_Buy_Sell_DateDef_GroupByRec_AddBranch_Group_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 2, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 39);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 41);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 44, language);
        sortBy = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 45, language);
        currency = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 46, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 47, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 48, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 49, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 50, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 51, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 52, language);
        message = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 53, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        transactionTypesToBeChecked = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 56, language);
        startDate = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 57, language);
        endDate = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 58, language);
        checkGroupByRecord = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 59, language);
        checkGroupByTransactionType = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 60, language);
        checkGroupBySecurity = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 61, language);
        numbering = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 62, language);
        
        SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering);
                
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 65);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 68, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "013_TRANSACTION", 69, language);
        
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