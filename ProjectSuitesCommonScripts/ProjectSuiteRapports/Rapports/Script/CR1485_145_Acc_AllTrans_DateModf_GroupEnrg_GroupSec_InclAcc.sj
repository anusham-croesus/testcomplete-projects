//USEUNIT CR1485_145_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-11--V9-croesus-co7x-1_5_550
*/

function CR1485_145_Acc_AllTrans_DateModf_GroupEnrg_GroupSec_InclAcc()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR2008_CR1880");
    Log.Message("CR2008 / CR1880");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 2, language);
        var accountNumber = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 79);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the Account
        SelectAccounts(accountNumber);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 81);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 84, language);
        var sortBy = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 85, language);
        var currency = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 86, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 87, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 88, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 89, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 90, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 91, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 92, language);
        var message = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 93, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var checkDisplayCheckDigit = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 96, language);
        var transactionTypesToBeChecked = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 97, language);
        var startDate = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 98, language);
        var endDate = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 99, language);
        var checkGroupByRecord = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 100, language);
        var checkGroupByTransactionType = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 101, language);
        var checkGroupBySecurity = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 102, language);
        var checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 103, language);
        var numbering = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 104, language);
        
        SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering, checkIncludeNonregisteredAccountsOnly, checkDisplayCheckDigit);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 108);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 111, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 112, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering, checkIncludeNonregisteredAccountsOnly, checkDisplayCheckDigit);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_DISPLAY_CHECK_DIGIT", null, vServerReportsCR1485);
        Terminate_CroesusProcess();
    }
    
}