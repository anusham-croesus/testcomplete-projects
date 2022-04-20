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

function CR1485_027_Acc_DateDef_Graph_Histog_AssAllBasic_ClassBrk_NumHid_AddBranch_Group_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 78);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 80);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 83, language);
        sortBy = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 84, language);
        currency = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 85, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 86, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 87, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 88, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 89, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 90, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 91, language);
        message = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 92, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 95, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 96, language);
        type = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 97, language);
        checkComparative = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 98, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 99, language);
        customAllocation = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 100, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 101, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 102, language);
        numbering = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 103, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 106);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 109, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "027_ASSETS_ALLOC_DET", 110, language);
        
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