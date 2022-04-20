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

function CR1485_041_Cli_ExclData_DateModf_Per1Y3Y5Y7Y10Y_TWRBrut_NumVis_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 44);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 46);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 49, language);
        sortBy = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 50, language);
        currency = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 51, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 52, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 53, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 54, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 55, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 56, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 57, language);
        message = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 58, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 61, language);
        startDate = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 62, language);
        endDate = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 63, language);
        periodsToBeChecked = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 64, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 65, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 66, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 67, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 68, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 69, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 70, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 71, language);
        numbering = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 72, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, periodsToBeChecked, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 75);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 78, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 79, language);
        
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