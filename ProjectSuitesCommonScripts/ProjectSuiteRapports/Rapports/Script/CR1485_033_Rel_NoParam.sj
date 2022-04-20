//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_033_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_033_Rel_NoParam()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_Billing");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 1, language);
        feeSchedule = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 4);
        relationshipName = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 5);
        accountsNumbers = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 6);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        frequency = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 23, language);
        period = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 24, language);
        billingStartDate = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 25, language);
        billingDate = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 26, language);
        
        //Empty Billing history
        EmptyBillingHistory();
        
        //Login
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);

        BillNowRelationshipAndExportToPDFFormat(relationshipName, frequency, period, feeSchedule, arrayOfAccountsNumbers, billingStartDate, billingDate);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 8);
        
        //Select report
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 11, language);
        sortBy = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 12, language);
        currency = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 13, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 14, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 15, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 16, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 17, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 18, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 19, language);
        message = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 20, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //No Parameters
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        Terminate_CroesusProcess();
        
        reportFileName = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 29);
        
        //Empty Billing history
        EmptyBillingHistory();
        
        //Login
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);

        BillNowRelationshipAndExportToPDFFormat(relationshipName, frequency, period, feeSchedule, arrayOfAccountsNumbers, billingStartDate, billingDate);
        
        //Select report
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 32, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "033_BILLING_FEE_SCHEDULE", 33, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);

        //No Parameters
        
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



