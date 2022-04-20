//USEUNIT CR1485_108_Common_functions




/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\156. Sommaire du portefeuille (détaillé - thème alternatif)\2. Clients
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation :Sana Ayaz
    Version de scriptage:	ref90-12-Hf-5--V9-croesus-co7x-1_8_2_653
*/

function CR1485_108_Cli_CR1642_CR1915_CR2009_CR2014_CR2023_Alternate()
{

    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 210, language);
        var clientsNumbers = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 211);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
       
        //Activate Prefs
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_ALTT_SUM_PORT_DETAIL", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_REPORT_PORTFOLIO_SUMMARY_DETAILED", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ACCESS_PERFORMANCE_FIGURES", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_PORTFOLIO_SUMMARY_DETAILED_COLUMNS", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INCLUDE_YTD_ONLY", "YES", vServerReportsCR1485);// doublons
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SUMMARY_DETAIL_BY_ACCOUNT", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_BOX_ON_PF_SUMMARY_DETAILED", "YES", vServerReportsCR1485);// 
        RestartServices(vServerReportsCR1485);
        
        //Login and goto client module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientsNumbers.split("|"));
                
        
        //************************* Generate English report ********************************************************************************************//
        var reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 288);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une deuxiéme fois le rapport
        var reportsWindowTitle = Get_WinReports().Title.OleValue;       
    
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 217, language);
        var sortBy = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 218, language);
        var currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 291, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 292, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 222, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 223, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 224, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 225, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 226, language);
        var message = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 227, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
        
       //Parameters values Paramètres du rapport(sommaire du portefeuille (détaillé-thème alternatif))1
        var firstCheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 230, language);
        var firstEndDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 232, language);
        var firstPeriod = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 233, language);
        var firstPeriod1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 234, language);
        var firstPeriod2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 235, language);
        var firstPeriod3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 236, language);
        var firstPeriod4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 237, language);
        var firstPeriod5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 238, language);
        var firstPeriod6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 239, language);
        var firstPeriod7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 240, language);
        var firstcheckDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 241, language);
        var firstIndicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 242, language);
        var firstCheckUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 243, language);
        var firstAssetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 244, language);
        var firstCustomAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 245, language);
        var firstCheckUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 246, language);
        var firstPerformanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 247, language);
        var firstCheckTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 248, language);
        var firstCheckTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 249, language);
        var firstCheckMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 250, language);
        var firstNumbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 251, language);
        var firstCheckFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 252, language);
        var firstCheckGraphsRegionAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 253, language);
        var firstStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 231, language);
        var firstCheckOneReportPerAccount=GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 254, language);
        var firstCheckGraphsInvestmentObjective=GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 255, language);
         
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé-thème alternatif))1
        SetReportParameters(firstCheckExcludeDataPrecedingTheManagementStartDate, firstEndDate, firstPeriod, firstPeriod1, firstPeriod2, firstPeriod3, firstPeriod4, firstPeriod5, firstPeriod6, firstPeriod7,firstcheckDisplayDefaultIndices, firstIndicesToBeChecked, firstCheckUseIndexBaseCurrency, firstAssetAllocation, firstCustomAllocation, firstCheckUseTheSpecifiedInvestmentObjective, firstPerformanceCalculations, firstCheckTimeWeightedNetOfFees,firstCheckTimeWeightedGrossOfFees, firstCheckMoneyWeightedNetOfFees, firstNumbering, null, firstStartDate, firstCheckGraphsRegionAllocation, firstCheckOneReportPerAccount, firstCheckGraphsInvestmentObjective);

        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000);
         // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "2",reportName],10).Click();
         
         
        //Parameters values Paramètres du rapport(sommaire du portefeuille (détaillé-thème alternatif))2
        var secondCheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 260, language);
        var secondEndDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 262, language);
        var secondPeriod = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 263, language);
        var secondPeriod1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 264, language);
        var secondPeriod2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 265, language);
        var secondPeriod3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 266, language);
        var secondPeriod4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 267, language);
        var secondPeriod5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 268, language);
        var secondPeriod6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 269, language);
        var secondPeriod7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 270, language);
        var secondCheckDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 271, language);
        var secondIndicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 272, language);
        var secondCheckUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 273, language);
        var secondAssetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 274, language);
        var secondCustomAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 275, language);
        var secondCheckUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 276, language);
        var secondPerformanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 277, language);
        var secondCheckTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 278, language);
        var secondCheckTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 279, language);
        var secondCheckMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 280, language);
        var secondNumbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 281, language);
        var secondCheckFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 282, language);
        var secondCheckGraphsRegionAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 283, language);
        var secondStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 261, language);
        var secondCheckOneReportPerAccount=GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 284, language);
        var secondCheckGraphsInvestmentObjective=GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 285, language);
        
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé-thème alternatif))2
        SetReportParameters(secondCheckExcludeDataPrecedingTheManagementStartDate, secondEndDate, secondPeriod, secondPeriod1, secondPeriod2, secondPeriod3, secondPeriod4, secondPeriod5, secondPeriod6, secondPeriod7,secondCheckDisplayDefaultIndices, secondIndicesToBeChecked, secondCheckUseIndexBaseCurrency, secondAssetAllocation, secondCustomAllocation, secondCheckUseTheSpecifiedInvestmentObjective, secondPerformanceCalculations, secondCheckTimeWeightedNetOfFees, secondCheckTimeWeightedGrossOfFees, secondCheckMoneyWeightedNetOfFees, secondNumbering, null, secondStartDate, secondCheckGraphsRegionAllocation, secondCheckOneReportPerAccount, secondCheckGraphsInvestmentObjective);
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
       
       
       
       
       
       
        //************************* Generate French report ***************************************************************************************************/
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 214);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une deuxiéme fois le rapport
        
        //Reports options values (Other options are the same as for the French report)
        
        var currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 219, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 220, language);
        
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
        //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé-thème alternatif))1
        SetReportParameters(firstCheckExcludeDataPrecedingTheManagementStartDate, firstEndDate, firstPeriod, firstPeriod1, firstPeriod2, firstPeriod3, firstPeriod4, firstPeriod5, firstPeriod6, firstPeriod7,firstcheckDisplayDefaultIndices, firstIndicesToBeChecked, firstCheckUseIndexBaseCurrency, firstAssetAllocation, firstCustomAllocation, firstCheckUseTheSpecifiedInvestmentObjective, firstPerformanceCalculations, firstCheckTimeWeightedNetOfFees,firstCheckTimeWeightedGrossOfFees, firstCheckMoneyWeightedNetOfFees, firstNumbering, null, firstStartDate, firstCheckGraphsRegionAllocation, firstCheckOneReportPerAccount, firstCheckGraphsInvestmentObjective);
         
         // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
         WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000);
         Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "2",reportName],10).Click();
         
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé-thème alternatif))2
         SetReportParameters(secondCheckExcludeDataPrecedingTheManagementStartDate, secondEndDate, secondPeriod, secondPeriod1, secondPeriod2, secondPeriod3, secondPeriod4, secondPeriod5, secondPeriod6, secondPeriod7,secondCheckDisplayDefaultIndices, secondIndicesToBeChecked, secondCheckUseIndexBaseCurrency, secondAssetAllocation, secondCustomAllocation, secondCheckUseTheSpecifiedInvestmentObjective, secondPerformanceCalculations, secondCheckTimeWeightedNetOfFees, secondCheckTimeWeightedGrossOfFees, secondCheckMoneyWeightedNetOfFees, secondNumbering, null, secondStartDate, secondCheckGraphsRegionAllocation, secondCheckOneReportPerAccount, secondCheckGraphsInvestmentObjective);
          
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //Restore Prefs
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_ALTT_SUM_PORT_DETAIL", null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_REPORT_PORTFOLIO_SUMMARY_DETAILED", null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ACCESS_PERFORMANCE_FIGURES", null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_PORTFOLIO_SUMMARY_DETAILED_COLUMNS", null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_INCLUDE_YTD_ONLY", null, vServerReportsCR1485);// doublons
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SUMMARY_DETAIL_BY_ACCOUNT", null, vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_BOX_ON_PF_SUMMARY_DETAILED", null, vServerReportsCR1485);// 
        RestartServices(vServerReportsCR1485);
        
        Terminate_CroesusProcess();
    }
    
}
