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

function CR1485_011_Acc_ExclDate_DateDef_IndexDJII_TWRNet_MWRNet_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 84);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 86);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 89, language);
        sortBy = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 90, language);
        currency = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 91, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 92, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 93, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 94, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 95, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 96, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 97, language);
        message = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 98, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 101, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 102, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 103, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 104, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 105, language);
        customAllocation = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 106, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 107, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 108, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 109, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 110, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 111, language);
        numbering = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 112, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 115);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 118, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "011_SUMMARY_PORT_WO_REF", 119, language);
        
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