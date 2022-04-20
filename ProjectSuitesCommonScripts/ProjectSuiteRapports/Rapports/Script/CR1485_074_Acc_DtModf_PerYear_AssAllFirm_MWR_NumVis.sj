//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_074_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\74. PERFORMANCE DU PORTEFEUILLE (HISTORIQUE)\3.1 Comptes
    
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Sana Ayaz
    
     sprint 7
    version sur laquelle on a scripté: 	ref90-12-Hf-12--V9-croesus-co7x-1_8_2_653
    
    
*/

function CR1485_074_Acc_DtModf_PerYear_AssAllFirm_MWR_NumVis()
{
  
    Log.Message("Bug JIRA CROES-8071");
    
    try {
      
        reportName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 1, language);
        accountsNumbers = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 246);
        
        
        
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(accountsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 248);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        
        currency = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 252, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 253, language);
        SetReportsOptions(null, null, currency, reportLanguage);
        
      
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 258, language);
        endDate = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 259, language);
        period = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 260, language);
        period1 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 261, language);
        period2 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 262, language);
        period3 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 263, language);
        period4 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 264, language);
        period5 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 265, language);
        period6 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 266, language);
        period7 = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 267, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 268, language);
        customAllocation = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 269, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 270, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 271, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 272, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 273, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 274, language);
        numbering = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 275, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 278);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 281, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "074_VMD_PERF_HISTO", 282, language);
        
        SetReportsOptions(null, null, currency, reportLanguage);
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, numbering);
        
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