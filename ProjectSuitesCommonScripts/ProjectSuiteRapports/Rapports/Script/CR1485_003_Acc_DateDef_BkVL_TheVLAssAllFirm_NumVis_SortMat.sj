//USEUNIT CR1485_003_Acc_DateDef_Grph_Pie_BkVL_AssAllFirm_NumVis_SortMat
//USEUNIT CR1485_003_Common_functions
//USEUNIT CR1485_PreparationBD_CR1012


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\3. Évaluation du portefeuille (simple)\3.2 Comptes
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-14--V9-croesus-co7x-1_8_1_650
*/

function CR1485_003_Acc_DateDef_BkVL_TheVLAssAllFirm_NumVis_SortMat()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\3. Évaluation du portefeuille (simple)\\3.2 Comptes\\", "CR1485_003_Acc_DateDef_AssAllBasic_BookVl_ClassBrk_NumHid_SortDesc_Group()");
    var logAttribute = Log.CreateNewAttributes();
    logAttribute.Bold = true;
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\3. Évaluation du portefeuille (simple)\\3.2 Comptes\\Étapes CR1012\\", "Pré-requis : CR1485_PreparationBD_CR1012()", "", pmNormal, logAttribute);
    Log.Message("CR1012");
    Log.Message("Anomalie JIRA CROES-8365");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 1, language);
        var accountsNumbers = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 419);
        var arrayOfAccountsNumbers = accountsNumbers.split("|");
        var externalAccountsNumbers = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 421, language);
        var externalAccountNumberPosition = StrToInt(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 422, language));
        var arrayOfExternalAccountsNumbers = externalAccountsNumbers.split("|");
        var externalAccountNumber = arrayOfExternalAccountsNumbers[externalAccountNumberPosition - 1]
        arrayOfAccountsNumbers.push(externalAccountNumber);
        var securityForCATEGO = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 423, language);
        
        
        //Activate Prefs
        CR1485_003_Common_functions.ActivatePrefs();
        
        //Activate pref PREF_RPT_DISPLAY_ISSUER_NOTE
        if (null == Execute_SQLQuery_GetField("select SECURITY from B_TRANS where NO_COMPTE = '" + externalAccountNumber + "' and SECURITY in (select SECURITY from B_TITRE where SECUFIRME = '" + securityForCATEGO + "')", vServerReportsCR1485, "SECURITY"))
            Log.Error("Aucune transaction trouvée pour le compte '" + externalAccountNumber + "' sur le titre '" + securityForCATEGO + "'");
        Activate_PREF_RPT_DISPLAY_ISSUER_NOTE_Catego(securityForCATEGO);
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Select accounts
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 425);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 428, language);
        var sortBy = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 429, language);
        var currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 430, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 431, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 432, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 433, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 434, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 435, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 436, language);
        var message = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 437, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var asOfDate = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 440, language);
        var checkIncludeGraph = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 441, language));
        var type = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 442, language);
        var checkComparative = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 443, language));
        var checkGroupByRegion = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 444, language));
        var checkGroupByIndustryCode = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 445, language));
        var groupByIndustryCode = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 446, language));
        var checkGroupByAccountCurrency = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 447, language));
        var costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 449, language): GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 448, language);
        var checkCostDisplayedTheoreticalValue = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 450, language));
        var assetAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 451, language);
        var customAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 452, language);
        var checkUseTheSpecifiedInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 453, language));
        var checkFundBreakdownClassBreakdown = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 454, language));
        var checkFundBreakdownAppendix = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 455, language));
        var numbering = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 456, language);
        var parametersSortBy = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 457, language);
        
        CR1485_003_Acc_DateDef_Grph_Pie_BkVL_AssAllFirm_NumVis_SortMat.SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 461);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 464, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 465, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        CR1485_003_Acc_DateDef_Grph_Pie_BkVL_AssAllFirm_NumVis_SortMat.SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        SetToDefault_PREF_RPT_DISPLAY_ISSUER_NOTE_Catego();
        Terminate_CroesusProcess();
    }
    
}
