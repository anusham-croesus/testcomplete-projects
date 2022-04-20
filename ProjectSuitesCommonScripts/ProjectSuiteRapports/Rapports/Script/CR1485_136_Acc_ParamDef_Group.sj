//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_136_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_136_Acc_ParamDef_Group()
{
    Log.Message("Bugs JIRA BNC-1680 / CROES-5490");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 2, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 21);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 23);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 26, language);
        sortBy = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 27, language);
        currency = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 28, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 29, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 30, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 31, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 32, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 33, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 34, language);
        message = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 35, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Set no Parameters (take the default parameters)
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 41);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 44, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 45, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Set no Parameters (take the default parameters)
        
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
