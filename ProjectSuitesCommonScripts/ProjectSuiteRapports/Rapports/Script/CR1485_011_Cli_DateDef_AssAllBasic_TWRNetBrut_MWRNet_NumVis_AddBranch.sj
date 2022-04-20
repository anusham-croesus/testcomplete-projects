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

function CR1485_011_Cli_DateDef_AssAllBasic_TWRNetBrut_MWRNet_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 44);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 46);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 49, language);
        sortBy = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 50, language);
        currency = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 51, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 52, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 53, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 54, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 55, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 56, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 57, language);
        message = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 58, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 61, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 62, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 63, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 64, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 65, language);
        customAllocation = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 66, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 67, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 68, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 69, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 70, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 71, language);
        numbering = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 72, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 75);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 78, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 79, language);
        
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