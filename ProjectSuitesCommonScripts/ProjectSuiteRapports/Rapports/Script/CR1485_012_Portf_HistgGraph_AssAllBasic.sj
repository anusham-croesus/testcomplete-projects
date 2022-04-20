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

function CR1485_012_Portf_HistgGraph_AssAllBasic()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 148);
        
        
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
        reportFileName = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 150);
        
        //Set Portfolio Currency and Date
        currency = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 155, language);
        asOfDate = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 165, language);
        SetPortfolioCurrencyAndDate(currency, asOfDate);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 153, language);
        sortBy = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 154, language);
        //currency = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 155, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 156, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 157, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 158, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 159, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 160, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 161, language);
        message = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 162, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        //asOfDate = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 165, language);
        type = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 166, language);
        checkComparative = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 167, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 168, language);
        customAllocation = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 169, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 170, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 171, language);
        numbering = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 172, language);
        
        SetReportParameters(asOfDate, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
                
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 175);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 178, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 178, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "012_GRAPH_ASSET_MAINC", 179, language);
        
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