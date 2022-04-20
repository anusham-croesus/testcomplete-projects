//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_081_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_081_Acc_HardSeve_IAAccess_TrigStatus()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 2, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 38);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 40);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 43, language);
        sortBy = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 44, language);
        currency = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 45, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 46, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 47, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 48, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 49, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 50, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 51, language);
        message = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 52, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkSeverityHard = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 55, language);
        checkSeveritySoft = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 56, language);
        checkAccessFirm = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 57, language);
        checkAccessIA = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 58, language);
        checkStatusTriggered = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 59, language);
        checkStatusNotTriggered = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 60, language);
                
        SetReportParameters(checkSeverityHard, checkSeveritySoft, checkAccessFirm, checkAccessIA, checkStatusTriggered, checkStatusNotTriggered);

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 63);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 66, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 67, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkSeverityHard, checkSeveritySoft, checkAccessFirm, checkAccessIA, checkStatusTriggered, checkStatusNotTriggered);
        
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