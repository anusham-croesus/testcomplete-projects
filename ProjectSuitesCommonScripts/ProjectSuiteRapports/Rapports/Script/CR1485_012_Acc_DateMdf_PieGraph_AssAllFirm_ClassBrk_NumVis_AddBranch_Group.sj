//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_012_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_012_Acc_DateMdf_PieGraph_AssAllFirm_ClassBrk_NumVis_AddBranch_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 112);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 114);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 117, language);
        sortBy = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 118, language);
        currency = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 119, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 120, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 121, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 122, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 123, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 124, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 125, language);
        message = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 126, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 129, language);
        type = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 130, language);
        checkComparative = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 131, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 132, language);
        customAllocation = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 133, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 134, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 135, language);
        numbering = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 136, language);
        
        SetReportParameters(asOfDate, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
                
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 139);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 142, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 143, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
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