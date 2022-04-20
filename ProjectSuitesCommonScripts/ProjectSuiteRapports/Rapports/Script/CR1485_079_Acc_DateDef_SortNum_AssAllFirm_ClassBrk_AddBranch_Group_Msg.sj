//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_079_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_079_Acc_DateDef_SortNum_AssAllFirm_ClassBrk_AddBranch_Group_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 74);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 76);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 79, language);
        sortBy = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 80, language);
        currency = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 81, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 82, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 83, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 84, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 85, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 86, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 87, language);
        message = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 88, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 91, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 92, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 93, language);
        customAllocation = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 94, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 95, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 96, language);
        numbering = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 97, language);
        
        SetReportParameters(asOfDate, parametersSortBy, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 100);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 103, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "079_ASSETS_ALLOC_ACCSUMM", 104, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, parametersSortBy, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
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