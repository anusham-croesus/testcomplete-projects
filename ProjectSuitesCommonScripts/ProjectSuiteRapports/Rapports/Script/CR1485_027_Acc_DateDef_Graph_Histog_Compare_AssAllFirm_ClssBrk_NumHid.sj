//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_027_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_027_Acc_DateDef_Graph_Histog_Compare_AssAllFirm_ClssBrk_NumHid()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 115);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 117);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 120, language);
        sortBy = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 121, language);
        currency = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 122, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 123, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 124, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 125, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 126, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 127, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 128, language);
        message = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 129, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 132, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 133, language);
        type = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 134, language);
        checkComparative = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 135, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 136, language);
        customAllocation = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 137, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 138, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 139, language);
        numbering = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 140, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 143);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 146, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 147, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
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