//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_054_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_054_Acc_DateModf_Summ_NumVis_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 70);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 72);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 75, language);
        sortBy = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 76, language);
        currency = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 77, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 78, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 79, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 80, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 81, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 82, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 83, language);
        message = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 84, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkPreviousCalendarYear = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 87, language);
        startDate = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 88, language);
        endDate = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 89, language);
        transactions = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 90, language);
        numbering = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 91, language);
        
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, transactions, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 94);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 97, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "054_GAIN_PERTE_TL", 98, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkPreviousCalendarYear, startDate, endDate, transactions, numbering);
        
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