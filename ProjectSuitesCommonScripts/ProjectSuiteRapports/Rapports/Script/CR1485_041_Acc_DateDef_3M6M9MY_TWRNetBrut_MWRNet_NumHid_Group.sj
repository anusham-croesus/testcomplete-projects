//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_041_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_041_Acc_DateDef_3M6M9MY_TWRNetBrut_MWRNet_NumHid_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 84);
        arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 86);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 89, language);
        sortBy = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 90, language);
        currency = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 91, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 92, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 93, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 94, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 95, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 96, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 97, language);
        message = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 98, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 101, language);
        startDate = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 102, language);
        endDate = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 103, language);
        periodsToBeChecked = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 104, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 105, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 106, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 107, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 108, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 109, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 110, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 111, language);
        numbering = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 112, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, periodsToBeChecked, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 115);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 118, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 119, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, periodsToBeChecked, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
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