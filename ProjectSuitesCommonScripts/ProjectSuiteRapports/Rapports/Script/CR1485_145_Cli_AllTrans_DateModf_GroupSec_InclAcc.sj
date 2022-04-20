//USEUNIT CR1485_145_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-11--V9-croesus-co7x-1_5_550
*/

function CR1485_145_Cli_AllTrans_DateModf_GroupSec_InclAcc()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR2008_CR1880");
    Log.Message("CR2008 / CR1880");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 2, language);
        var clientsNumbers = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 41);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the relationship
        SelectClients(clientsNumbers.split("|"));
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 43);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 46, language);
        var sortBy = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 47, language);
        var currency = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 48, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 49, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 50, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 51, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 52, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 53, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 54, language);
        var message = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 55, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var checkDisplayCheckDigit = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 58, language);
        var transactionTypesToBeChecked = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 59, language);
        var startDate = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 60, language);
        var endDate = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 61, language);
        var checkGroupByRecord = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 62, language);
        var checkGroupByTransactionType = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 63, language);
        var checkGroupBySecurity = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 64, language);
        var checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 65, language);
        var numbering = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 66, language);
        
        SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering, checkIncludeNonregisteredAccountsOnly, checkDisplayCheckDigit);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 70);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 73, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 74, language);
        
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