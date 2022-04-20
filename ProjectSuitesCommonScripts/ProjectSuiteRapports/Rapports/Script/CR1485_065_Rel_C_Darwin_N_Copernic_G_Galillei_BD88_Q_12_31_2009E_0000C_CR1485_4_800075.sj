//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_065_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\65. GAINS ET PERTES (NON RÉALISÉS)\1.1 Relations
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Amine A.
    version: 90.15-45
*/

function CR1485_065_Rel_C_Darwin_N_Copernic_G_Galillei_BD88_Q_12_31_2009E_0000C_CR1485_4_800075()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\65. GAINS ET PERTES (NON RÉALISÉS)\\1.1 Relations\\", "CR1485_065_Rel_C_Darwin_N_Copernic_G_Galillei_BD88_Q_12_31_2009E_0000C_CR1485_4_800075()");
    
    try {
        var reportName       = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 1, language);
        var relationshipName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 129);
        
             
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ADD_THEORETICAL_VALUE", null, vServerReportsCR1485);
        ActivatePDFFirmPrefs(); 
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 131);
        
        //Ce cas est relatif à Destination = 'Ficher PDF' et checkUsePDFFileNamingConvention = true ; choisir le bon nom de fichier attendu car la fonction SetReportsOptionsNew ne ferait pas l'affaire
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE){
            if (CR1485_REPORTS_LANGUAGE == "french")
                reportFileName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 171);
        }
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination         = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 135, language);
        var checkArchiveRepport = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 136, language);
        var checkPrintDuplex    = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 137, language);
        var sortBy              = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 138, language);
        var currency            = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 139, language);
        var reportLanguage      = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 140, language);
        var source              = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 141, language);
        var accountCriteria     = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 142, language);
        var checkRemoveName     = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 143, language);
        var title               = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 144, language);
        
        var checkAddBranchAddress           = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 145, language);
        var checkGroupInTheSameReport       = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 146, language);
        var checkConsolidatePositions       = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 147, language);
        var checkGroupUnderlyingClients     = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 148, language);
        var checkUsePDFFileNamingConvention = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 149, language);
        var checkIncludeMessage             = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 150, language);
        var message                         = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 151, language);
        
        SetReportsOptionsNew(destination, checkArchiveRepport, checkPrintDuplex, sortBy, currency, reportLanguage, source, accountCriteria, checkRemoveName, title, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkUsePDFFileNamingConvention, checkIncludeMessage, message);
        
        //Parameters values
        var asOfDate                 = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 155, language);
        var checkGroupByRegion       = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 156, language);
        var checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 157, language);
        var groupByIndustryCode      = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 158, language);
        
        var costCalculation          = (client == "US")? GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 160, language): GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 159, language);
        var checkCostDisplayedTheoreticalValue      = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 161, language);
        var assetAllocation                         = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 162, language);
        var customAllocation                        = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 163, language);
        var checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 164, language);
        var checkFundBreakdownClassBreakdown        = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 165, language);
        var checkFundBreakdownAppendix              = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 166, language);
        var numbering                               = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 167, language);
        var checkOneReportPerAccount                = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 168, language);
        
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
        //Validate and save report
        var isDestinationPDFFile = true;
        var findExactFileName = (aqString.ToUpper(checkUsePDFFileNamingConvention) == "VRAI" || aqString.ToUpper(checkUsePDFFileNamingConvention) == "TRUE");
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH, isDestinationPDFFile, findExactFileName);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 171);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency       = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 174, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 175, language);
        
        SetReportsOptionsNew(destination, checkArchiveRepport, checkPrintDuplex, sortBy, currency, reportLanguage, source, accountCriteria, checkRemoveName, title, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkUsePDFFileNamingConvention, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH, isDestinationPDFFile, findExactFileName);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        DesactivatePDFFirmPrefs();
        Terminate_CroesusProcess();
    }   
}