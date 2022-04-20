//USEUNIT CR1485_125_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_125_Cli_DateDef()
{
    Log.Message("CR1092");
    Log.Message("JIRA CROES-1707");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "125_Monthly_transactions_report", 2, language);
        clientNumber = GetData(filePath_ReportsCR1485, "125_Monthly_transactions_report", 5);
        
                
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module and Select Client
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientNumber.split("|"));
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "125_Monthly_transactions_report", 7);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        VerifyIfReportsAreDisplayedInCurrentReports();
        
        //Default parameters
        reportLanguage = GetData(filePath_ReportsCR1485, "125_Monthly_transactions_report", 10, language);
        SetReportsOptions(null, null, null, reportLanguage);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "125_Monthly_transactions_report", 13);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        VerifyIfReportsAreDisplayedInCurrentReports();
        
        //Default parameters
        reportLanguage = GetData(filePath_ReportsCR1485, "125_Monthly_transactions_report", 16, language);
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
