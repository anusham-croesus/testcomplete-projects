//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_055_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_055_Acc_DateDef_ChckDigit_SortName_AssAllFirm_NumVis()
{
    Log.Message("Bug JIRA CROES-6464");
    Log.Message("Bug JIRA CROES-7684");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 118);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Activer CHECK DIGIT
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_DISPLAY_CHECK_DIGIT", "YES", vServerReportsCR1485);
        Execute_SQLQuery("update b_compte set check_digit = '3' where no_compte = '" + accountNumber + "'", vServerReportsCR1485)
        
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 120);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 123, language);
        sortBy = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 124, language);
        currency = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 125, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 126, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 127, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 128, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 129, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 130, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 131, language);
        message = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 132, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 135, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 136, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 137, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 138, language);
        nameOrFullName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 139, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 140, language);
        customAllocation = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 141, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 142, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 143, language);
        numbering = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 144, language);
        
        checkDisplayCheckDigit = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 145, language);
        SetReportParameters(asOfDate, checkAllRecords, checkIncludeGraph, parametersSortBy, nameOrFullName, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering, checkDisplayCheckDigit);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 148);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 151, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 152, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkAllRecords, checkIncludeGraph, parametersSortBy, nameOrFullName, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering, checkDisplayCheckDigit);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_DISPLAY_CHECK_DIGIT", "NO", vServerReportsCR1485);
    }
    
}