﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_037_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_037_Acc_DateModf_SortTotal_NumVis_IncluAmort_AddBranch_Group_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 70);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 72);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 75, language);
        sortBy = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 76, language);
        currency = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 77, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 78, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 79, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 80, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 81, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 82, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 83, language);
        message = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 84, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 87, language);
        endDate = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 88, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 89, language);
        checkIncludeAmortizedIncome = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 90, language);
        numbering = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 91, language);
        
        SetReportParameters(startDate, endDate, parametersSortBy, checkIncludeAmortizedIncome, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 94);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 97, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 98, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, parametersSortBy, checkIncludeAmortizedIncome, numbering);
        
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