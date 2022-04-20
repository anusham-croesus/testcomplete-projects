//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_088_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_088_Cli_DateModf_NumHidden_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 36);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 38);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 41, language);
        sortBy = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 42, language);
        currency = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 43, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 44, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 45, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 46, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 47, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 48, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 49, language);
        message = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 50, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 53, language);
        endDate = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 54, language);
        numbering = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 55, language);
        checkIncludeAmortizedIncome = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 56, language);
        
        SetReportParameters(startDate, endDate, numbering, checkIncludeAmortizedIncome);
                
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 59);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 62, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "088_FBNFISC_CASH_INT", 63, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, numbering, checkIncludeAmortizedIncome);
        
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