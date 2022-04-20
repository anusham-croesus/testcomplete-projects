//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_004_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_004_Portef_DateModf_AmortIncome_SortDesc()
{
    Log.Message("Bug CROES-7004 : impossible de saisir la date du portefeuille.");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "004_ANNIC", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "004_ANNIC", 100);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        //Drag the account to Portfolio module
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "004_ANNIC", 102);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "004_ANNIC", 107, language);
        startDate = GetData(filePath_ReportsCR1485, "004_ANNIC", 117, language);
        SetPortfolioCurrencyAndDate(currency, startDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "004_ANNIC", 105, language);
        sortBy = GetData(filePath_ReportsCR1485, "004_ANNIC", 106, language);
        //currency = GetData(filePath_ReportsCR1485, "004_ANNIC", 107, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "004_ANNIC", 108, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "004_ANNIC", 109, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "004_ANNIC", 110, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "004_ANNIC", 111, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "004_ANNIC", 112, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "004_ANNIC", 113, language);
        message = GetData(filePath_ReportsCR1485, "004_ANNIC", 114, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //startDate = GetData(filePath_ReportsCR1485, "004_ANNIC", 117, language);
        checkIncludeAmortizedIncome = GetData(filePath_ReportsCR1485, "004_ANNIC", 118, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "004_ANNIC", 119, language);
        numbering = GetData(filePath_ReportsCR1485, "004_ANNIC", 120, language);
        
        SetReportParameters(startDate, checkIncludeAmortizedIncome, parametersSortBy, numbering);
                
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "004_ANNIC", 123);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "004_ANNIC", 126, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "004_ANNIC", 126, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "004_ANNIC", 127, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, checkIncludeAmortizedIncome, parametersSortBy, numbering);
        
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