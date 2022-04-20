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

function CR1485_041_Rel_ExclData_DateModf_PerDef_TWRNet_IndexDJII_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 10, language);
        currency = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 17, language);
        message = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 21, language);
        startDate = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 22, language);
        endDate = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 23, language);
        periodsToBeChecked = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 24, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 25, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 26, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 27, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 28, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 29, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 30, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 31, language);
        numbering = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 32, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, startDate, endDate, periodsToBeChecked, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 35);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 38, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "041_PERF_HISTO_FIXCUM", 39, language);
        
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