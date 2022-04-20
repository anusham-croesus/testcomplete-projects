//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_057_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_057_Acc_DateMOdf_BookVl_AssAllFirm_NumVis_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 10, language);
        currency = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 17, language);
        message = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 21, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 22, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 23, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 24, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 25, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 27, language): GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 26, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 28, language);
        customAllocation = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 29, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 30, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 31, language);
        numbering = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 32, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 35);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 38, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "057_FBNFISC_BEG_EVAL", 39, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
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