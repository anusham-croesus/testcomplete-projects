//USEUNIT Common_functions
//USEUNIT CR1485_137_Common_functions
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_137_Acc_ParamDef_IndPROBAL()
{
    Log.Message("JIRA CROES-9342");
    Log.Message("Bug JIRA CROES-10192");
    Log.Message("Bug JIRA CROES-10329");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "137_Summarized_IA", 2, language);
        accountNumber = GetData(filePath_ReportsCR1485, "137_Summarized_IA", 21);
        
        
        //Se connecter avec l'utilisateur GP1859
        userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameGP1859);
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameGP1859, passwordGP1859, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the Account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "137_Summarized_IA", 23);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        
        //Default parameters
        reportLanguage = GetData(filePath_ReportsCR1485, "137_Summarized_IA", 26, language);
        SetReportsOptions(null, null, null, reportLanguage);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "137_Summarized_IA", 29);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        
        //Default parameters
        reportLanguage = GetData(filePath_ReportsCR1485, "137_Summarized_IA", 32, language);
        SetReportsOptions(null, null, null, reportLanguage);
        
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
