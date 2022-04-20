//USEUNIT CR1485_108_Common_functions




/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\3.1 Comptes
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation :Sana Ayaz
    Version de scriptage:	ref90-13-In-3--V9-croesus-co7x-1_8_2_653
    
    Sprint7
*/

function CR1485_108_Acc_CR1642_CR1915_CR2009_CR2014_CR2023()
{

    
    try {
        reportName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 1, language);
        accountNumbers = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 311);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
       Execute_SQLQuery("update b_compte set DATE_INCEP='Nov 1 2006 12:00AM' where NO_COMPTE='800228-FS'", vServerReportsCR1485);
       //Activate Prefs
        ActivatePrefCR1642_CR1915_CR2009_CR2014_CR2023();
        
        
        //Login and goto client module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountNumbers)
        
                
        
        //************************* Generate English report ********************************************************************************************//
        reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 348);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
               
        //Reports options values
        reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 352, language);
        currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 351, language);
        SetReportsOptions(null, null, currency, reportLanguage);
        
        
        //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
        
       //Parameters values Paramètres du rapport(sommaire du portefeuille (détaillé-thème alternatif))1
        checkExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 321, language);
        endDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 323, language);
        period = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 324, language);
        period1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 325, language);
        period2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 326, language);
        period3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 327, language);
        period4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 328, language);
        period5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 329, language);
        period6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 330, language);
        period7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 331, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 332, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 333, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 334, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 335, language);
        customAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 336, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 337, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 338, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 339, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL",340, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 341, language);
        numbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 342, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 343, language);
        checkGraphsRegionAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 344, language);
        startDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 322, language);
       
         
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé-thème alternatif))1
         SetReportParameters(checkExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7,checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, performanceCalculations, checkTimeWeightedNetOfFees,checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering, null, startDate, checkGraphsRegionAllocation);
         CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
       
       
        //************************* Generate French report ***************************************************************************************************/
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 314);
        
       //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        
        //Reports options values 
        
        currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 317, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 316, language);
        SetReportsOptions(null, null, currency, reportLanguage);
        
        //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé-thème alternatif))1
         SetReportParameters(checkExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, period4, period5, period6, period7,checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, performanceCalculations, checkTimeWeightedNetOfFees,checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, numbering, null, startDate, checkGraphsRegionAllocation);
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        RestorePrefCR1642_CR1915_CR2009_CR2014_CR2023();
        Terminate_CroesusProcess();
    }
    
}

function ActivatePrefCR1642_CR1915_CR2009_CR2014_CR2023()
{
  //*** Niveau Firme ***
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_REPORT_PORTFOLIO_SUMMARY_DETAILED", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_PORTFOLIO_SUMMARY_DETAILED_COLUMNS", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SUMMARY_DETAIL_BY_ACCOUNT", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_BOX_ON_PF_SUMMARY_DETAILED", "YES", vServerReportsCR1485); //(CR1492)
    
    //Après CR2009/CR2023:
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_PORT_DETAIL", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INCLUDE_YTD_ONLY", "YES", vServerReportsCR1485);
    
    
  
        
RestartServices(vServerReportsCR1485);

}


function RestorePrefCR1642_CR1915_CR2009_CR2014_CR2023()
{
  //*** Niveau Firme ***
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_REPORT_PORTFOLIO_SUMMARY_DETAILED", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ACCESS_PERFORMANCE_FIGURES", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_PORTFOLIO_SUMMARY_DETAILED_COLUMNS", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SUMMARY_DETAIL_BY_ACCOUNT", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_BOX_ON_PF_SUMMARY_DETAILED", null, vServerReportsCR1485); //(CR1492)
    
    //Après CR2009/CR2023:
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_PORT_DETAIL", null, vServerReportsCR1485);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INCLUDE_YTD_ONLY", null, vServerReportsCR1485);
    
    
  
        
RestartServices(vServerReportsCR1485);

}
