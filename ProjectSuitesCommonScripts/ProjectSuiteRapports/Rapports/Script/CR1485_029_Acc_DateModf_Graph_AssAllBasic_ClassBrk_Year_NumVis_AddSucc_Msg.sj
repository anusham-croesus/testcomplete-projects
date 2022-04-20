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

function CR1485_029_Acc_DateModf_Graph_AssAllBasic_ClassBrk_Year_NumVis_AddSucc_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 80);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 82);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 85, language);
        sortBy = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 86, language);
        currency = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 87, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 88, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 89, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 90, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 91, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 92, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 93, language);
        message = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 94, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 97, language);
        endDate = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 98, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 99, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 100, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 101, language);
        customAllocation = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 102, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 103, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 104, language);
        data = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 105, language);
        numbering = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 106, language);
        
        SetReportParameters(startDate, endDate, checkAllRecords, checkIncludeGraph, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, data, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 109);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 112, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 113, language);
        
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