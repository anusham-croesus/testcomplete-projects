//USEUNIT CR1485_108_Common_functions
//USEUNIT CR1485_108_Acc_CR1642_CR1915_CR2009_CR2014_CR2023



/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\2.2 Clients
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation :Sana Ayaz
    Version de scriptage:	ref90-13-In-3--V9-croesus-co7x-1_8_2_653
    
    Sprint7
*/

function CR1485_108_Rel_CR1642_CR1915_CR2009_CR2014_CR2023()
{

    

    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 1, language);
        var relationshipName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 520);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
       
        //Activate Prefs
        ActivatePrefCR1642_CR1915_CR2009_CR2014_CR2023();
       
       // Login and goto client module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
         //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
                
        
        //************************* Generate English report ********************************************************************************************//
        var reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 589);
       //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une deuxiéme fois le rapport
        
     
        
        var reportsWindowTitle = Get_WinReports().Title.OleValue;      
       
        //Reports options values
        var reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 593, language);
        var currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 592, language);
        SetReportsOptions(null, null, currency, reportLanguage);
        
        //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
              
        //Parameters values Paramètres du rapport(sommaire du portefeuille (détaillé-thème alternatif))1
        var firstCheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 532, language);
        var firstEndDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 534, language);
        var firstPeriod = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 535, language);
        var firstPeriod1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 536, language);
        var firstPeriod2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 537, language);
        var firstPeriod3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 538, language);
        var firstPeriod4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 539, language);
        var firstPeriod5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 540, language);
        var firstPeriod6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 541, language);
        var firstPeriod7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 542, language);
        var firstcheckDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 543, language);
        var firstIndicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 544, language);
        var firstCheckUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 545, language);
        var firstAssetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 546, language);
        var firstCustomAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 547, language);
        var firstCheckUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 547, language);
        var firstPerformanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 548, language);
        var firstCheckTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 549, language);
        var firstCheckTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 550, language);
        var firstCheckMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 551, language);
        var firstNumbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 552, language);
        var firstCheckFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 553, language);
        var firstCheckGraphsRegionAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 554, language);
        var firstStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 533, language);
        var firstInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 555, language);
        var firstCheckOneReportPerAccount=GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 556, language);
        var firstcheckGraphsInvestmentObjective=GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 557, language);
        
          Log.Message("le JIRA :RPT-404")
        
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé)1
         SetReportParameters(firstCheckExcludeDataPrecedingTheManagementStartDate, firstEndDate, firstPeriod, firstPeriod1, firstPeriod2, firstPeriod3, firstPeriod4, firstPeriod5, firstPeriod6, firstPeriod7,firstcheckDisplayDefaultIndices, firstIndicesToBeChecked, firstCheckUseIndexBaseCurrency, firstAssetAllocation, firstCustomAllocation, firstCheckUseTheSpecifiedInvestmentObjective, firstPerformanceCalculations, firstCheckTimeWeightedNetOfFees,firstCheckTimeWeightedGrossOfFees, firstCheckMoneyWeightedNetOfFees, firstNumbering, null, firstStartDate, firstCheckGraphsRegionAllocation,firstCheckOneReportPerAccount,firstInvestmentObjective, firstcheckGraphsInvestmentObjective);
         WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000);
         
         
        /******************************sélectionner le deuxiéme rapport************************************************************************************/
        // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "2",reportName],10).Click();
        
        
        //Parameters values Paramètres du rapport(sommaire du portefeuille (détaillé)2
        var secondCheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 560, language);
        var secondEndDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 562, language);
        var secondPeriod = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 563, language);
        var secondPeriod1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 564, language);
        var secondPeriod2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 565, language);
        var secondPeriod3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 566, language);
        var secondPeriod4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 567, language);
        var secondPeriod5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 568, language);
        var secondPeriod6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 569, language);
        var secondPeriod7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 570, language);
        var secondcheckDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 571, language);
        var secondIndicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 572, language);
        var secondCheckUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 573, language);
        var secondAssetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 574, language);
        var secondCustomAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 575, language);
        var secondCheckUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 576, language);
        var secondPerformanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 577, language);
        var secondCheckTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 578, language);
        var secondCheckTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 579, language);
        var secondCheckMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 580, language);
        var secondNumbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 581, language);
        var secondCheckFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 582, language);
        var secondCheckGraphsRegionAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 583, language);
        var secondStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 561, language);
        var secondInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 584, language);
        var secondCheckOneReportPerAccount=GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 585, language);
       
     
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé-thème alternatif))1
         SetReportParameters(secondCheckExcludeDataPrecedingTheManagementStartDate, secondEndDate, secondPeriod, secondPeriod1, secondPeriod2, secondPeriod3, secondPeriod4, secondPeriod5, secondPeriod6, secondPeriod7,secondcheckDisplayDefaultIndices, secondIndicesToBeChecked, secondCheckUseIndexBaseCurrency, secondAssetAllocation, secondCustomAllocation, secondCheckUseTheSpecifiedInvestmentObjective, secondPerformanceCalculations, secondCheckTimeWeightedNetOfFees,secondCheckTimeWeightedGrossOfFees, secondCheckMoneyWeightedNetOfFees, secondNumbering, null, secondStartDate, secondCheckGraphsRegionAllocation,secondCheckOneReportPerAccount,secondInvestmentObjective);
         CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        
       
         //Validate and save report
         ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
         CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
       
       
       
       
       
        //************************* Generate French report ***************************************************************************************************/
       if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 524);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une deuxiéme fois le rapport
       
        
        
        //Reports options values (Other options are the same as for the French report)
        
        var currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 529, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 528, language);
        
        
        SetReportsOptions(null, null, currency, reportLanguage);
        
        
        /***************************************************Sélectionner le premier rapport en anglais   **************************************************************************************/
        
        //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
        //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé))1
        SetReportParameters(firstCheckExcludeDataPrecedingTheManagementStartDate, firstEndDate, firstPeriod, firstPeriod1, firstPeriod2, firstPeriod3, firstPeriod4, firstPeriod5, firstPeriod6, firstPeriod7,firstcheckDisplayDefaultIndices, firstIndicesToBeChecked, firstCheckUseIndexBaseCurrency, firstAssetAllocation, firstCustomAllocation, firstCheckUseTheSpecifiedInvestmentObjective, firstPerformanceCalculations, firstCheckTimeWeightedNetOfFees,firstCheckTimeWeightedGrossOfFees, firstCheckMoneyWeightedNetOfFees, firstNumbering, null, firstStartDate, firstCheckGraphsRegionAllocation,firstCheckOneReportPerAccount,firstInvestmentObjective, firstcheckGraphsInvestmentObjective);
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000);
         
         /******Sélectionner le deuxième rapport**************************************************************************************************************/
         
         // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
         Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "2",reportName],10).Click();
         
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé))2
         SetReportParameters(secondCheckExcludeDataPrecedingTheManagementStartDate, secondEndDate, secondPeriod, secondPeriod1, secondPeriod2, secondPeriod3, secondPeriod4, secondPeriod5, secondPeriod6, secondPeriod7,secondcheckDisplayDefaultIndices, secondIndicesToBeChecked, secondCheckUseIndexBaseCurrency, secondAssetAllocation, secondCustomAllocation, secondCheckUseTheSpecifiedInvestmentObjective, secondPerformanceCalculations, secondCheckTimeWeightedNetOfFees,secondCheckTimeWeightedGrossOfFees, secondCheckMoneyWeightedNetOfFees, secondNumbering, null, secondStartDate, secondCheckGraphsRegionAllocation,secondCheckOneReportPerAccount,secondInvestmentObjective);
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