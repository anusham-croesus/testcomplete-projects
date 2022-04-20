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

function CR1485_046_Acc_DateModf_Group()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_Billing");
    
    try {
        //First, bill the relationship that contains the accounts
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
        
        //Generate report for the Accounts module
        
        reportName = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 68);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        //Goto Accounts module and select the accounts
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 70);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 73, language);
        sortBy = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 74, language);
        currency = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 75, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 76, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 77, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 78, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 79, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 80, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 81, language);
        message = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 82, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 85, language);
        endDate = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 86, language);
        
        //Set the report parameters
        SetReportParameters(startDate, endDate);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 89);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 92, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "046_BILLING_SUMMARY", 93, language);
        
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