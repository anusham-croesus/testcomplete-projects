//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_029_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_029_Acc_DateModf_AssAllFirm_Monthly_NumVis_Add()
{
    Log.Message("Bug JIRA CROES-7674");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 118);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 120);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 123, language);
        sortBy = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 124, language);
        currency = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 125, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 126, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 127, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 128, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 129, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 130, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 131, language);
        message = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 132, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 135, language);
        endDate = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 136, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 137, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 138, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 139, language);
        customAllocation = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 140, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 141, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 142, language);
        data = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 143, language);
        numbering = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 144, language);
        
        SetReportParameters(startDate, endDate, checkAllRecords, checkIncludeGraph, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, data, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 147);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 150, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 151, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, checkAllRecords, checkIncludeGraph, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, data, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}