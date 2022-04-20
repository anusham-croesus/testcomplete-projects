﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_024_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_024_Portf_Y2007()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 94);
        
        
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
        reportFileName = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 96);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 101, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 99, language);
        sortBy = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 100, language);
        //currency = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 101, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 102, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 103, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 104, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 105, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 106, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 107, language);
        message = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 108, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        year = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 111, language);
        numbering = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 112, language);
        
        SetReportParameters(year, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 115);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 118, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 118, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 119, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(year, numbering);
        
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