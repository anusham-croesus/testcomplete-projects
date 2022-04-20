//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_033_Common_functions
//USEUNIT CR1485_046_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_046_Cli_DateModf_AddBranch()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_Billing");
    
    try {
        //First, bill the relationship that contains the client
        feeSchedule = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 4);
        relationshipName = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 5);
        accountsNumbers = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 6);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        frequency = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 23, language);
        period = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 24, language);
        billingStartDate = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 25, language);
        billingDate = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 26, language);
        
        EmptyBillingHistory();
        
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        BillNowRelationshipAndExportToPDFFormat(relationshipName, frequency, period, feeSchedule, arrayOfAccountsNumbers, billingStartDate, billingDate);
        
        WaitReportsWindow();
        Get_WinReports_BtnClose().Keys("[Enter]");
        Get_WinDetailedInfo_BtnCancel().Click();
        
        //Generate report for the Clients module
        
        reportName = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 38);
        
        //Goto Clients module and select the client
        Get_ModulesBar_BtnClients().Click();
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 40);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 43, language);
        sortBy = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 44, language);
        currency = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 45, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 46, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 47, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 48, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 49, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 50, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 51, language);
        message = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 52, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 55, language);
        endDate = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 56, language);
        
        //Set the report parameters
        SetReportParameters(startDate, endDate);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 59);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 62, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 63, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        //Empty Billing history
        EmptyBillingHistory();
    }
    
}