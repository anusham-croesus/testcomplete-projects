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

function CR1485_073_Rel_ExcluDate_DateModf_3Months_Monthly_TWRNetBrut_MWRNet_IndiceNASDAQCOMP_DJI_DJIN_NunVis_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 1, language);
        relationshipsNames = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 4);
        arrayOfRelationshipsNames = relationshipsNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select relationships
        SelectRelationships(arrayOfRelationshipsNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 10, language);
        currency = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 17, language);
        message = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 22, language);
        period1 = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 23, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 24, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 25, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 26, language);
        data = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 27, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 28, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 29, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 30, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 31, language);
        numbering = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 32, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period1, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, data, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 35);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 38, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "073_GRAPH_PERF", 39, language);
        
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