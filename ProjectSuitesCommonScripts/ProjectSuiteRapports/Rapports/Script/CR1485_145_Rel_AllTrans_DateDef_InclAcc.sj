//USEUNIT CR1485_145_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-11--V9-croesus-co7x-1_5_550
*/

function CR1485_145_Rel_AllTrans_DateDef_InclAcc()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR2008_CR1880");
    Log.Message("CR2008 / CR1880");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 2, language);
        var relationshipName = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 4);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SelectRelationships(relationshipName);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 9, language);
        var sortBy = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 10, language);
        var currency = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 11, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 12, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 13, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 14, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 15, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 16, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 17, language);
        var message = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var checkDisplayCheckDigit = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 21, language);
        var transactionTypesToBeChecked = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 22, language);
        var startDate = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 23, language);
        var endDate = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 24, language);
        var checkGroupByRecord = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 25, language);
        var checkGroupByTransactionType = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 26, language);
        var checkGroupBySecurity = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 27, language);
        var checkIncludeNonregisteredAccountsOnly = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 28, language);
        var numbering = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 29, language);
        
        SetReportParameters(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering, checkIncludeNonregisteredAccountsOnly, checkDisplayCheckDigit);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 32);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 35, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "145_TAX_TRANSACTION", 36, language);
        
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