//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_011_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_011_Rel_ExclData_DateDef_AssAllFirm_IndexSP60_TSE100_300_35_60_TWRNetBrut_MWRNet_NunVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 10, language);
        currency = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 17, language);
        message = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 21, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 22, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 23, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 24, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 25, language);
        customAllocation = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 26, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 27, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 28, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 29, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 30, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 31, language);
        numbering = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 32, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 35);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 38, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 39, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
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