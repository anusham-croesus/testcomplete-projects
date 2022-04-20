//USEUNIT Common_functions
//USEUNIT CR1485_136_Common_functions
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_136_Acc_ParamDef()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 2, language);
        accountNumber = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 5);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 7);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        
        //Default parameters
        reportLanguage = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 10, language);
        currency = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 11, language);
        SetReportsOptions(null, null, currency, reportLanguage);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 13);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        
        //Default parameters
        reportLanguage = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 16, language);
        currency = GetData(filePath_ReportsCR1485, "136_Year_end_corporate_report", 17, language);
        SetReportsOptions(null, null, currency, reportLanguage);
        
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
