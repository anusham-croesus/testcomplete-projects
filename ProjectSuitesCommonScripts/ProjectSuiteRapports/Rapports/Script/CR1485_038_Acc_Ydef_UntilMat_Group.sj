//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_038_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_038_Acc_Ydef_UntilMat_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 66);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 68);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 71, language);
        sortBy = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 72, language);
        currency = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 73, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 74, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 75, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 76, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 77, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 78, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 79, language);
        message = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 80, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        year = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 83, language);
        checkUntilMaturity = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 84, language);
        numbering = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 85, language);
        
        SetReportParameters(year, checkUntilMaturity, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 88);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 91, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "038_ACCUM_INTEREST_PROJ", 92, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(year, checkUntilMaturity, numbering);
        
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