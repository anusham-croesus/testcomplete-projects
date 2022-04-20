//USEUNIT CR1485_108_Common_functions
//USEUNIT CR1485_108_Acc_CR1642_CR1915_CR2009_CR2014_CR2023



/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\2.2 Clients
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation :Sana Ayaz
    Version de scriptage:	ref90-13-In-3--V9-croesus-co7x-1_8_2_653
    
    Sprint7
*/

function CR1485_108_Cli_CR1642_CR1915_CR2009_CR2014_CR2023()
{

    

    
    try {
        reportName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 363);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
       
        //Activate Prefs
        ActivatePrefCR1642_CR1915_CR2009_CR2014_CR2023();
       
       // Login and goto client module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientsNumbers.split("|"));
                
        
        //************************* Generate English report ********************************************************************************************//
        reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 500);
       //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une deuxiéme fois le rapport
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une troisiéme fois le rapport
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une quatriéme fois le rapport
        
        var reportsWindowTitle = Get_WinReports().Title.OleValue;      
       
        //Reports options values
        reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 504, language);
        currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 503, language);
        SetReportsOptions(null, null, currency, reportLanguage);
        
        //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
              
       //Parameters values Paramètres du rapport(sommaire du portefeuille (détaillé-thème alternatif))1
        firstCheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 382, language);
        firstEndDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 384, language);
        firstPeriod = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 385, language);
        firstPeriod1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 386, language);
        firstPeriod2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 387, language);
        firstPeriod3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 388, language);
        firstPeriod4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 389, language);
        firstPeriod5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 390, language);
        firstPeriod6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 391, language);
        firstPeriod7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 392, language);
        firstcheckDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 393, language);
        firstIndicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 394, language);
        firstCheckUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 395, language);
        firstAssetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 396, language);
        firstCustomAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 397, language);
        firstCheckUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 398, language);
        firstPerformanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 399, language);
        firstCheckTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 400, language);
        firstCheckTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 401, language);
        firstCheckMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 402, language);
        firstNumbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 403, language);
        firstCheckFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 404, language);
        firstCheckGraphsRegionAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 405, language);
        firstStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 383, language);
       
         
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé)1
         SetReportParameters(firstCheckExcludeDataPrecedingTheManagementStartDate, firstEndDate, firstPeriod, firstPeriod1, firstPeriod2, firstPeriod3, firstPeriod4, firstPeriod5, firstPeriod6, firstPeriod7,firstcheckDisplayDefaultIndices, firstIndicesToBeChecked, firstCheckUseIndexBaseCurrency, firstAssetAllocation, firstCustomAllocation, firstCheckUseTheSpecifiedInvestmentObjective, firstPerformanceCalculations, firstCheckTimeWeightedNetOfFees,firstCheckTimeWeightedGrossOfFees, firstCheckMoneyWeightedNetOfFees, firstNumbering, null, firstStartDate, firstCheckGraphsRegionAllocation);
         WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000);
         
         
        /******************************sélectionner le deuxiéme rapport************************************************************************************/
        // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "2",reportName],10).Click();
        
        
        //Parameters values Paramètres du rapport(sommaire du portefeuille (détaillé)2
        secondCheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 412, language);
        secondEndDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 414, language);
        secondPeriod = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 415, language);
        secondPeriod1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 416, language);
        secondPeriod2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 417, language);
        secondPeriod3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 418, language);
        secondPeriod4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 419, language);
        secondPeriod5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 420, language);
        secondPeriod6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 421, language);
        secondPeriod7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 422, language);
        secondcheckDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 423, language);
        secondIndicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 424, language);
        secondCheckUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 425, language);
        secondAssetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 426, language);
        secondCustomAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 427, language);
        secondCheckUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 428, language);
        secondPerformanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 429, language);
        secondCheckTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 430, language);
        secondCheckTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 431, language);
        secondCheckMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 432, language);
        secondNumbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 433, language);
        secondCheckFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 434, language);
        secondCheckGraphsRegionAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 435, language);
        secondStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 413, language);
        secondInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 436, language);
        secondCheckOneReportPerAccount=GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 437, language);
      
          Log.Message("le JIRA :RPT-404")
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé-thème alternatif))1
         SetReportParameters(secondCheckExcludeDataPrecedingTheManagementStartDate, secondEndDate, secondPeriod, secondPeriod1, secondPeriod2, secondPeriod3, secondPeriod4, secondPeriod5, secondPeriod6, secondPeriod7,secondcheckDisplayDefaultIndices, secondIndicesToBeChecked, secondCheckUseIndexBaseCurrency, secondAssetAllocation, secondCustomAllocation, secondCheckUseTheSpecifiedInvestmentObjective, secondPerformanceCalculations, secondCheckTimeWeightedNetOfFees,secondCheckTimeWeightedGrossOfFees, secondCheckMoneyWeightedNetOfFees, secondNumbering, null, secondStartDate, secondCheckGraphsRegionAllocation,secondCheckOneReportPerAccount,secondInvestmentObjective);
         WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000);
        
            /******************************sélectionner le troisième rapport************************************************************************************/
        // sélectionner le troisième rapports  dans la partie de Rapports courants
       Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "3",reportName],10).Click();
        
        
        //Parameters values Paramètres du rapport(sommaire du portefeuille (détaillé)2
        thirdCheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 442, language);
        thirdEndDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 444, language);
        thirdPeriod = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 445, language);
        thirdPeriod1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 446, language);
        thirdPeriod2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 447, language);
        thirdPeriod3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 448, language);
        thirdPeriod4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 449, language);
        thirdPeriod5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 450, language);
        thirdPeriod6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 451, language);
        thirdPeriod7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 452, language);
        thirdcheckDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 453, language);
        thirdIndicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 454, language);
        thirdCheckUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 455, language);
        thirdAssetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 456, language);
        thirdCustomAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 457, language);
        thirdCheckUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 458, language);
        thirdPerformanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 459, language);
        thirdCheckTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 460, language);
        thirdCheckTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 461, language);
        thirdCheckMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 462, language);
        thirdNumbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 463, language);
        thirdCheckFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 464, language);
        thirdCheckGraphsRegionAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 465, language);
        thirdStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 443, language);
        thirdCheckOneReportPerAccount=GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 466, language);
       
         
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé))3
         SetReportParameters(thirdCheckExcludeDataPrecedingTheManagementStartDate, thirdEndDate, thirdPeriod, thirdPeriod1, thirdPeriod2, thirdPeriod3, thirdPeriod4, thirdPeriod5, thirdPeriod6, thirdPeriod7,thirdcheckDisplayDefaultIndices, thirdIndicesToBeChecked, thirdCheckUseIndexBaseCurrency, thirdAssetAllocation, thirdCustomAllocation, thirdCheckUseTheSpecifiedInvestmentObjective, thirdPerformanceCalculations, thirdCheckTimeWeightedNetOfFees,thirdCheckTimeWeightedGrossOfFees, thirdCheckMoneyWeightedNetOfFees, thirdNumbering, null, thirdStartDate, thirdCheckGraphsRegionAllocation,thirdCheckOneReportPerAccount);
         WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000);
        
        
        
              /******************************sélectionner le quatrième rapport************************************************************************************/
        // sélectionner le quatrième rapports  dans la partie de Rapports courants
       Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "4",reportName],10).Click();
        
        
        //Parameters values Paramètres du rapport(sommaire du portefeuille (détaillé)4
        fourthCheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 472, language);
        fourthEndDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 474, language);
        fourthPeriod = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 475, language);
        fourthPeriod1 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 476, language);
        fourthPeriod2 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 477, language);
        fourthPeriod3 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 478, language);
        fourthPeriod4 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 479, language);
        fourthPeriod5 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 480, language);
        fourthPeriod6 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 481, language);
        fourthPeriod7 = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 482, language);
        fourthcheckDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 483, language);
        fourthIndicesToBeChecked = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 484, language);
        fourthCheckUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 485, language);
        fourthAssetAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 486, language);
        fourthCustomAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 487, language);
        fourthCheckUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 488, language);
        fourthPerformanceCalculations = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 489, language);
        fourthCheckTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 490, language);
        fourthCheckTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 491, language);
        fourthCheckMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 492, language);
        fourthNumbering = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 493, language);
        fourthCheckFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 494, language);
        fourthCheckGraphsRegionAllocation = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 495, language);
        fourthStartDate = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 473, language);
        fourthCheckOneReportPerAccount=GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 496, language);
       
         
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé))4
         SetReportParameters(fourthCheckExcludeDataPrecedingTheManagementStartDate, fourthEndDate,fourthPeriod, fourthPeriod1, fourthPeriod2, fourthPeriod3, fourthPeriod4, fourthPeriod5, fourthPeriod6, fourthPeriod7,fourthcheckDisplayDefaultIndices, fourthIndicesToBeChecked, fourthCheckUseIndexBaseCurrency, fourthAssetAllocation, fourthCustomAllocation, fourthCheckUseTheSpecifiedInvestmentObjective, fourthPerformanceCalculations, fourthCheckTimeWeightedNetOfFees,fourthCheckTimeWeightedGrossOfFees, fourthCheckMoneyWeightedNetOfFees, fourthNumbering, null, fourthStartDate, fourthCheckGraphsRegionAllocation,fourthCheckOneReportPerAccount);
         
          CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

         //Validate and save report
       ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
       CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
       
       
       
       
       
        //************************* Generate French report ***************************************************************************************************/
       if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 366);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("Enabled", true, 30000);
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une deuxiéme fois le rapport
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une troisiéme fois le rapport
        Get_Reports_GrpReports_BtnAddAReport().Click();// ajouter une quatriéme fois le rapport
        
        
        //Reports options values (Other options are the same as for the French report)
        
        currency = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 370, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "108_SUMMARY_PORT_DETAIL", 369, language);
        
        
        SetReportsOptions(null, null, currency, reportLanguage);
        
        
        /***************************************************Sélectionner le premier rapport en anglais   **************************************************************************************/
        
        //Sélectionner le premier rapport pour changer ses paramétres
        Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "1",reportName],10).Click();
        //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé))1
         SetReportParameters(firstCheckExcludeDataPrecedingTheManagementStartDate, firstEndDate, firstPeriod, firstPeriod1, firstPeriod2, firstPeriod3, firstPeriod4, firstPeriod5, firstPeriod6, firstPeriod7,firstcheckDisplayDefaultIndices, firstIndicesToBeChecked, firstCheckUseIndexBaseCurrency, firstAssetAllocation, firstCustomAllocation, firstCheckUseTheSpecifiedInvestmentObjective, firstPerformanceCalculations, firstCheckTimeWeightedNetOfFees,firstCheckTimeWeightedGrossOfFees, firstCheckMoneyWeightedNetOfFees, firstNumbering, null, firstStartDate, firstCheckGraphsRegionAllocation);
         
         /******Sélectionner le deuxième rapport**************************************************************************************************************/
         
         // sélectionner le deuxiéme rapports  dans la partie de Rapports courants
         WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000);
         Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "2",reportName],10).Click();
         
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé))2
          SetReportParameters(secondCheckExcludeDataPrecedingTheManagementStartDate, secondEndDate, secondPeriod, secondPeriod1, secondPeriod2, secondPeriod3, secondPeriod4, secondPeriod5, secondPeriod6, secondPeriod7,secondcheckDisplayDefaultIndices, secondIndicesToBeChecked, secondCheckUseIndexBaseCurrency, secondAssetAllocation, secondCustomAllocation, secondCheckUseTheSpecifiedInvestmentObjective, secondPerformanceCalculations, secondCheckTimeWeightedNetOfFees,secondCheckTimeWeightedGrossOfFees, secondCheckMoneyWeightedNetOfFees, secondNumbering, null, secondStartDate, secondCheckGraphsRegionAllocation,secondCheckOneReportPerAccount,secondInvestmentObjective);
          WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000);
          
         /******Sélectionner le troisième rapport**************************************************************************************************************/
         
         // sélectionner le troisième rapport  dans la partie de Rapports courants
         WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000);
         Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "3",reportName],10).Click();
         
          //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé))3
          SetReportParameters(thirdCheckExcludeDataPrecedingTheManagementStartDate, thirdEndDate, thirdPeriod, thirdPeriod1, thirdPeriod2, thirdPeriod3, thirdPeriod4, thirdPeriod5, thirdPeriod6, thirdPeriod7,thirdcheckDisplayDefaultIndices, thirdIndicesToBeChecked, thirdCheckUseIndexBaseCurrency, thirdAssetAllocation, thirdCustomAllocation, thirdCheckUseTheSpecifiedInvestmentObjective, thirdPerformanceCalculations, thirdCheckTimeWeightedNetOfFees,thirdCheckTimeWeightedGrossOfFees, thirdCheckMoneyWeightedNetOfFees, thirdNumbering, null, thirdStartDate, thirdCheckGraphsRegionAllocation,thirdCheckOneReportPerAccount);
          WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000);
        
          
            /******Sélectionner le quatrième rapport**************************************************************************************************************/
         
          // sélectionner le quatrième rapport  dans la partie de Rapports courants
         WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", reportsWindowTitle], 5000);
         Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo","WPFControlText"], ["ListBoxItem", "4",reportName],10).Click();
          
         //Changement de paramétres pour le rapport (sommaire du portefeuille (détaillé))4
         SetReportParameters(fourthCheckExcludeDataPrecedingTheManagementStartDate, fourthEndDate,fourthPeriod, fourthPeriod1, fourthPeriod2, fourthPeriod3, fourthPeriod4, fourthPeriod5, fourthPeriod6, fourthPeriod7,fourthcheckDisplayDefaultIndices, fourthIndicesToBeChecked, fourthCheckUseIndexBaseCurrency, fourthAssetAllocation, fourthCustomAllocation, fourthCheckUseTheSpecifiedInvestmentObjective, fourthPerformanceCalculations, fourthCheckTimeWeightedNetOfFees,fourthCheckTimeWeightedGrossOfFees, fourthCheckMoneyWeightedNetOfFees, fourthNumbering, null, fourthStartDate, fourthCheckGraphsRegionAllocation,fourthCheckOneReportPerAccount);
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
