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

function CR1485_075_Cli_ExcluData_DateModf_IndiceTSE300_35_60_Qrt_TWRNetBrut_MWRNet_NumVis_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 45);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 47);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 50, language);
        sortBy = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 51, language);
        currency = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 52, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 53, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 54, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 55, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 56, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 57, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 58, language);
        message = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 59, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 62, language);
        startDate = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 63, language);
        endDate = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 64, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 65, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 66, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 67, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 68, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 69, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 70, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 71, language);
        data = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 72, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 73, language);
        numbering = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 74, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkIncludeGraph, data, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 77);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 80, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 81, language);
        
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