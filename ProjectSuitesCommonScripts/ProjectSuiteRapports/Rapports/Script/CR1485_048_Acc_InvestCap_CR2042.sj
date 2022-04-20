//USEUNIT CR1485_048_Cli_InvestCap_CR2042
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_048_Common_functions
//USEUNIT CR1485_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables




/**
    Description : "P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\48. Analyse de revenu des titres\2.4 Clients\\"
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Abdel Matmat
    Date: 20/03/2020
    Version de scriptage: 90.15.2020.3-31
*/

function CR1485_048_Acc_InvestCap_CR2042()
{
       
    try {
            
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var itemGlobal = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "itemGlobal", language+client);        
        var copyTo = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "CopyTo", language+client);        
        var itemFirm = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemFirme", language+client);
        
        var reportSecurityIncomeAnalysis = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 1, language);
        var columnPortInt = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 332, language);
        var columnTauxChang = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 333, language);
        var columnRendGl = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 334, language);
        var columnRendGlPercent = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 335, language);
        
        var reportPortfolioEvaluationInter = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 1, language);
        var columnIntDivAnn = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 336, language);
        var columnRendAchCurent = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 337, language);
        var columnGPNoRealised = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 338, language);
        
        var reportPortfolioEvaluationSimple = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 1, language);
        var columnTotPercent = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 339, language);
        var columnGPPercent = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 340, language);
                
        
        var accountNumber = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 433);
        var reportName1 = copyTo+" "+reportSecurityIncomeAnalysis;
        var reportName2 = copyTo+" "+reportPortfolioEvaluationInter;
        var reportName3 = copyTo+" "+reportPortfolioEvaluationSimple;
        var reportName  = reportName1+"|"+reportName2+"|"+reportName3;
        var arrayOfReportsNames = reportName.split("|"); 
        
        
        //Activer la pref
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ADD_THEORETICAL_VALUE", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_REPORT_GROUPING", "1", vServerReportsCR1485);
        RestartServices(vServerReportsCR1485);
        
        
        //Login and goto Clients module
        Log.Message("----------------- L O G I N -----------------");
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
              
        //Aller dans Outils / configurations / Configuration des rapports
        Log.Message("//Aller dans Outils / Configurations / rapports / configuration des rapports / ");    
        Get_MenuBar_Tools().Click();
        SetAutoTimeOut();
        while (! Get_SubMenus().Exists)
          Get_MenuBar_Tools().Click();
        RestoreAutoTimeOut();
        
        Get_MenuBar_Tools_Configurations().Click();
        WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");    
        
        Log.Message(" - Rapports / Double clique sur Configuration des rapports");
        Get_WinConfigurations_TvwTreeview_LlbReports().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock",GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language)]);
        Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
        WaitObject(Get_CroesusApp(),"WndCaption", GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language));
        
        // Au niveau Global Sélectionner le rapport "Analyse de revenu des titres" et Cliquer sur "Copier vers…"
        Log.Message("---------------- 1er rapport -------------------------");
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemGlobal,10).Click();
        Log.Message("Sélectionner le rapport '"+reportSecurityIncomeAnalysis+"'");
        SelectReportToCopy(reportSecurityIncomeAnalysis);
        Get_WinReportConfiguration_BtnCopyTo().Click();
        
        
        //parametrer le rapport copie
        SetReportCopyConfiguration();
        //Déplacer les colonnes à gauche et à droite
        SelectAndMoveItemToLeft(columnPortInt);
        SelectAndMoveItemToLeft(columnTauxChang);
        SelectAndMoveItemToRight(columnRendGl);
        SelectAndMoveItemToRight(columnRendGlPercent);
        Get_WinReportConfigurationCopy_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
                
        
        //-----------------------2eme rapport ------------------------------------
        // Au niveau Global Sélectionner le rapport "Évaluation portefeuille intermediaire" et Cliquer sur "Copier vers…"
        Log.Message("---------------- 2eme rapport -------------------------");
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemGlobal,10).Click();
        Log.Message("Sélectionner le rapport '"+reportPortfolioEvaluationInter+"'");
        SelectReportToCopy(reportPortfolioEvaluationInter);
        Get_WinReportConfiguration_BtnCopyTo().Click();var copyTo=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "CopyTo", language+client);

    
        //parametrer le rapport copie
        SetReportCopyConfiguration();
        //Déplacer les colonnes à gauche et à droite
        SelectAndMoveItemToLeft(columnIntDivAnn);
        SelectAndMoveItemToLeft(columnRendAchCurent);
        SelectAndMoveItemToRight(columnGPNoRealised);
        SelectAndMoveItemToRight(columnRendGlPercent);
        Get_WinReportConfigurationCopy_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
        
        
        //-----------------------3eme rapport ------------------------------------
        // Au niveau Global Sélectionner le rapport "Évaluation portefeuille simple" et Cliquer sur "Copier vers…"
        Log.Message("---------------- 2eme rapport -------------------------");
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemGlobal,10).Click();
        Log.Message("Sélectionner le rapport '"+reportPortfolioEvaluationSimple+"'");
        SelectReportToCopy(reportPortfolioEvaluationSimple);
        Get_WinReportConfiguration_BtnCopyTo().Click();
        
        //parametrer le rapport copie
        SetReportCopyConfiguration();
        //Déplacer les colonnes à gauche et à droite
        SelectAndMoveItemToLeft(columnTotPercent);
        SelectAndMoveItemToRight(columnGPNoRealised);
        SelectAndMoveItemToRight(columnGPPercent);
        Get_WinReportConfigurationCopy_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
        
        Log.Message("Fermer la fenêtre Configuration des rapports");
        Get_WinReportConfiguration_BtnClose().Click();
        
        Log.Message("Fermer la fenêtre Configuration");
        Get_WinConfigurations().Close();
        
        //Aller au module comptes et selctionner le compte
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountNumber);
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 434);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Select the third report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 350, language);
        sortBy = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 351, language);
        currency = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 352, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 353, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 354, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 355, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 356, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 357, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 358, language);
        message = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 359, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 401, language);
        checkIncludeGraph2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 402, language);
        type2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 403, language);
        checkComparative2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 404, language);
        checkGroupByRegion2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 405, language);
        checkGroupByIndustryCode2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 406, language);
        groupByIndustryCode2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 407, language);
        checkGroupByAccountCurrency2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 408, language);
        costCalculation2 = (client == "US")? GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 410, language): GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 409, language);
        checkCostDisplayedTheoreticalValue2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 411, language);
        assetAllocation2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 412, language);
        customAllocation2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 413, language);
        checkUseTheSpecifiedInvestmentObjective2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 414, language);
        checkFundBreakdownClassBreakdown2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 415, language);
        checkFundBreakdownAppendix2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 416, language);
        numbering2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 417, language);
        parametersSortBy2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 418, language);
        
        SetReportParameters2(asOfDate2, checkIncludeGraph2, type2, checkComparative2, checkGroupByRegion2, checkGroupByIndustryCode2, groupByIndustryCode2, checkGroupByAccountCurrency2, costCalculation2, checkCostDisplayedTheoreticalValue2, assetAllocation2, customAllocation2, checkUseTheSpecifiedInvestmentObjective2, checkFundBreakdownClassBreakdown2, checkFundBreakdownAppendix2, numbering2, parametersSortBy2);
        
        //Select the second report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        
        //Parameters values
        asOfDate1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 380, language);
        checkIncludeGraph1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 381, language);
        type1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 382, language);
        checkComparative1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 383, language);
        checkGroupByRegion1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 384, language);
        checkGroupByIndustryCode1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 385, language);
        groupByIndustryCode1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 386, language);
        checkGroupByAccountCurrency1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 387, language);
        costCalculation1 = (client == "US")? GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 389, language): GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 388, language);
        checkCostDisplayedTheoreticalValue1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 390, language);
        assetAllocation1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 391, language);
        customAllocation1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 392, language);
        checkUseTheSpecifiedInvestmentObjective1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 393, language);
        checkFundBreakdownClassBreakdown1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 394, language);
        checkFundBreakdownAppendix1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 395, language);
        numbering1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 396, language);
        parametersSortBy1 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 397, language);
        
        SetReportParameters1(asOfDate1, checkIncludeGraph1, type1, checkComparative1, checkGroupByRegion1, checkGroupByIndustryCode1, groupByIndustryCode1, checkGroupByAccountCurrency1, costCalculation1, checkCostDisplayedTheoreticalValue1, assetAllocation1, customAllocation1, checkUseTheSpecifiedInvestmentObjective1, checkFundBreakdownClassBreakdown1, checkFundBreakdownAppendix1, numbering1, parametersSortBy1);
        
        //Select the first report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 362, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 363, language);
        type = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 364, language);
        checkComparative = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 365, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 366, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 367, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 368, language);
        costCalculation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 369, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 371, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 372, language);
        customAllocation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 373, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 374, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 375, language);
        numbering = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 376, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
                     
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 435);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Select the third report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 425, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 426, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters2(asOfDate2, checkIncludeGraph2, type2, checkComparative2, checkGroupByRegion2, checkGroupByIndustryCode2, groupByIndustryCode2, checkGroupByAccountCurrency2, costCalculation2, checkCostDisplayedTheoreticalValue2, assetAllocation2, customAllocation2, checkUseTheSpecifiedInvestmentObjective2, checkFundBreakdownClassBreakdown2, checkFundBreakdownAppendix2, numbering2, parametersSortBy2);
        
        //Select the second report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        
        //Parameters values (same as for the English report)
        SetReportParameters1(asOfDate1, checkIncludeGraph1, type1, checkComparative1, checkGroupByRegion1, checkGroupByIndustryCode1, groupByIndustryCode1, checkGroupByAccountCurrency1, costCalculation1, checkCostDisplayedTheoreticalValue1, assetAllocation1, customAllocation1, checkUseTheSpecifiedInvestmentObjective1, checkFundBreakdownClassBreakdown1, checkFundBreakdownAppendix1, numbering1, parametersSortBy1);
        
        //Select the first report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
       
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering); 
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
       }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        
        //-------------------C L E A N U P -----------------------
        Log.Message("-------------------C L E A N U P -----------------------");
        //Aller dans Outils / configurations / Configuration des rapports
        Log.Message("//Aller dans Outils / Configurations / rapports / configuration des rapports / ");    
        Get_MenuBar_Tools().Click();
        SetAutoTimeOut();
        while (! Get_SubMenus().Exists)
          Get_MenuBar_Tools().Click();
        RestoreAutoTimeOut();
        
        Get_MenuBar_Tools_Configurations().Click();
        WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");    
        
        Log.Message(" - Rapports / Double clique sur Configuration des rapports");
        Get_WinConfigurations_TvwTreeview_LlbReports().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock",GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language)]);
        Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
        WaitObject(Get_CroesusApp(),"WndCaption", GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language));
        
        //choisir Firm pour afficher  les copies de rapports créés
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemFirm,10).Click();
        //Supprimer les copies de rapports
        DeleteCopyReports(reportName1);
        DeleteCopyReports(reportName2);
        DeleteCopyReports(reportName3);
        Log.Message("Fermer la fenêtre Configuration des rapports");
        Get_WinReportConfiguration_BtnClose().Click();
        
        Log.Message("Fermer la fenêtre Configuration");
        Get_WinConfigurations().Close();
        
        //Fermer Croesus
        Terminate_CroesusProcess();
    }
    
}

