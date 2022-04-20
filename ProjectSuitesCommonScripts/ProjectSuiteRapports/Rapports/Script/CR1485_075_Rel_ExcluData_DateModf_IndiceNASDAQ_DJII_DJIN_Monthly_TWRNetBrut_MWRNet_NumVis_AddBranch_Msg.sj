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

function CR1485_075_Rel_ExcluData_DateModf_IndiceNASDAQ_DJII_DJIN_Monthly_TWRNetBrut_MWRNet_NumVis_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 1, language);
        relationshipsNames = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 4);
        arrayOfRelationshipsNames = relationshipsNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select relationships
        SelectRelationships(arrayOfRelationshipsNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 10, language);
        currency = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 17, language);
        message = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 21, language);
        startDate = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 22, language);
        endDate = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 23, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 24, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 25, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 26, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 27, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 28, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 29, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 30, language);
        data = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 31, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 32, language);
        numbering = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 33, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, checkIncludeGraph, data, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 36);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 39, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "075_PERFORMANCE_HISTO", 40, language);
        
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