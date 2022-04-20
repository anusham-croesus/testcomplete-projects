//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_075_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_075_Acc_ExcluData_DateModf_IndiceTSE300_35_60_MWRNet_Year_TotPerf_NumVis_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 86);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 88);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 91, language);
        sortBy = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 92, language);
        currency = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 93, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 94, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 95, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 96, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 97, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 98, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 99, language);
        message = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 100, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 103, language);
        startDate = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 104, language);
        endDate = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 105, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 106, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 107, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 108, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 109, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 110, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 111, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 112, language);
        data = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 113, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 114, language);
        numbering = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 115, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkIncludeGraph, data, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 118);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 121, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 122, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkIncludeGraph, data, performanceCalculations, numbering);
        
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