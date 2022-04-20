//USEUNIT CR1485_113_Common_functions
//USEUNIT CR1485_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\113. PERFORMANCE DE VOS PLACEMENTS\3.2 Comptes
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Philippe Maurice
*/

function CR1485_113_Acc_Excl_DateDef_AllPerF_2Ind_NoGraph_NumVis()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\113. PERFORMANCE DE VOS PLACEMENTS\\3.2 Comptes\\", "CR1485_113_Acc_Excl_DateDef_AllPerF_2Ind_NoGraph_NumVis()");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 1, language);
        var accountNumber = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 181);
        
        //Activate Prefs
        CR1485_113_Common_functions.ActivatePrefs();
            
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select account
        SelectAccounts(accountNumber);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 184);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 187, language);
        var currency = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 189, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 190, language);
        
        SetReportsOptions(destination, null, currency, reportLanguage, null, null, null, null, null, null);
        
        //Parameters values
        var CheckExcludeDataPrecedingTheManagementStartDate = GetBooleanValue(GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 199, language));
        var endDate = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 200, language);
        var period = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 201, language);
        var period1 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 202, language);
        var period2 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 203, language);
        var period3 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 204, language);
        var period4 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 205, language);
        var period5 = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 206, language);
        var checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM",207, language);
        
        var indicesToBeChecked = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM",208, language);
        var checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM",209, language);
        var performanceCalculations = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM",213, language);
    
        var checkTimeWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 210, language));
        var checkTimeWeightedGrossOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 211, language));
        var checkMoneyWeightedNetOfFees = GetBooleanValue(GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 212, language));
        var numbering = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM",214, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
       
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 217);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 220, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "113_INVESTMENT_PERFORM", 221, language);
        SetReportsOptions(destination, null, currency, reportLanguage, null, null, null, null, null, null);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
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