//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_119_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_119_Acc_NoParam_AddBranch_Group_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 32);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 34);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 37, language);
        sortBy = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 38, language);
        currency = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 39, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 40, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 41, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 42, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 43, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 44, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 45, language);
        message = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 46, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Set no Parameters (take the default parameters)
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 51);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 54, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "119_FREE_UNITS", 55, language);
        
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