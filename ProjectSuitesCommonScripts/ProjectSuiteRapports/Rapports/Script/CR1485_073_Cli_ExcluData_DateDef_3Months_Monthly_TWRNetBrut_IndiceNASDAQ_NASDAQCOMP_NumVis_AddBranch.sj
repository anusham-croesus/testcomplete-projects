//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_073_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_073_Cli_ExcluData_DateDef_3Months_Monthly_TWRNetBrut_IndiceNASDAQ_NASDAQCOMP_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 44);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 46);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 49, language);
        sortBy = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 50, language);
        currency = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 51, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 52, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 53, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 54, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 55, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 56, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 57, language);
        message = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 58, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 61, language);
        endDate = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 62, language);
        period1 = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 63, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 64, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 65, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 66, language);
        data = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 67, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 68, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 69, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 70, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 71, language);
        numbering = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 72, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period1, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, data, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 75);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 78, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 79, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period1, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, data, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
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