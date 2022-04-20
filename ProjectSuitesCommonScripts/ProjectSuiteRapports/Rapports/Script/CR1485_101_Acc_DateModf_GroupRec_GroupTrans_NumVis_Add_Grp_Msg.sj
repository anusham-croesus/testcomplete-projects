//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_101_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_101_Acc_DateModf_GroupRec_GroupTrans_NumVis_Add_Grp_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 4);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 10, language);
        currency = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 17, language);
        message = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 22, language);
        checkGroupByRecord = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 23, language);
        checkGroupByTransactionType = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 24, language);
        numbering = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 25, language);
                
        SetReportParameters(startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 28);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 31, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "101_FBNFISC_ACC_INT_TRAN", 32, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, numbering);
        
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