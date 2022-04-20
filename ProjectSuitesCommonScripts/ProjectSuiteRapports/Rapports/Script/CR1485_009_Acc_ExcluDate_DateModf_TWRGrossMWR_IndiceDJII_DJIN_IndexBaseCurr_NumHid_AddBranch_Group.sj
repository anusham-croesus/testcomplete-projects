//USEUNIT CR1485_009_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_009_Acc_ExcluDate_DateModf_TWRGrossMWR_IndiceDJII_DJIN_IndexBaseCurr_NumHid_AddBranch_Group()
{
    Log.Message("Bug JIRA CROES-6464");

    try {
        reportName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 172);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 174);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 177, language);
        sortBy = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 178, language);
        currency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 179, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 180, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 181, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 182, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 183, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 184, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 185, language);
        message = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 186, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 189, language);
        endDate = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 190, language);
        period = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 191, language);
        period1 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 192, language);
        period2 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 193, language);
        period3 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 194, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 195, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 196, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 197, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 198, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 199, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 200, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 201, language);
        numbering = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 202, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 205);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 208, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 209, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);

        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
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