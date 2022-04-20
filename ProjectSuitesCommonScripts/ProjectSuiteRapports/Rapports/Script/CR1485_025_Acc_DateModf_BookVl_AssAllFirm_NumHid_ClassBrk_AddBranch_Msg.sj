//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_025_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_025_Acc_DateModf_BookVl_AssAllFirm_NumHid_ClassBrk_AddBranch_Msg()
{
    Log.Message("Bug JIRA CROES-6464");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 77);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 79);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 82, language);
        sortBy = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 83, language);
        currency = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 84, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 85, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 86, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 87, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 88, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 89, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 90, language);
        message = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 91, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 94, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 95, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 97, language): GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 96, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 98, language);
        customAllocation = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 99, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 100, language);
        numbering = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 101, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 102, language);
                
        SetReportParameters(asOfDate, checkAllRecords, costCalculation, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, numbering, checkFundBreakdownClassBreakdown);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 105);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 108, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 109, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkAllRecords, costCalculation, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, numbering, checkFundBreakdownClassBreakdown);
        
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