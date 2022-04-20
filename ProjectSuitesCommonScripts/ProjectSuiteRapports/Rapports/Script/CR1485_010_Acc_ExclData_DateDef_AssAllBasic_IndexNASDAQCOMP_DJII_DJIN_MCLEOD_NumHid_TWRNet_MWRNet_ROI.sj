//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_010_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_010_Acc_ExclData_DateDef_AssAllBasic_IndexNASDAQCOMP_DJII_DJIN_MCLEOD_NumHid_TWRNet_MWRNet_ROI()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 44);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select the account
        Search_Account(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", accountNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 46);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 49, language);
        sortBy = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 50, language);
        currency = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 51, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 52, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 53, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 54, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 55, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 56, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 57, language);
        message = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 58, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 61, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 62, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 63, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 64, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 65, language);
        customAllocation = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 66, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 67, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 68, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 69, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 70, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 71, language);
        numbering = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 72, language);
    
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 75);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 78, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "010_SUMMARY_PORT", 79, language);
        
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