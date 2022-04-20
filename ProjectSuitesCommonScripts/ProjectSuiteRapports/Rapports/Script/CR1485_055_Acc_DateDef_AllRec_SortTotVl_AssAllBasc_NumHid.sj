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

function CR1485_055_Acc_DateDef_AllRec_SortTotVl_AssAllBasc_NumHid()
{
    Log.Message("Bug JIRA CROES-6464");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 80);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 82);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 85, language);
        sortBy = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 86, language);
        currency = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 87, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 88, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 89, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 90, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 91, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 92, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 93, language);
        message = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 94, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 97, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 98, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 99, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 100, language);
        nameOrFullName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 101, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 102, language);
        customAllocation = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 103, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 104, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 105, language);
        numbering = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 106, language);
        
        SetReportParameters(asOfDate, checkAllRecords, checkIncludeGraph, parametersSortBy, nameOrFullName, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 109);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 112, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 113, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkAllRecords, checkIncludeGraph, parametersSortBy, nameOrFullName, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
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