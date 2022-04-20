//USEUNIT CR1485_003_Acc_DateDef_Grph_Pie_BkVL_AssAllFirm_NumVis_SortMat
//USEUNIT CR1485_061_Common_functions
//USEUNIT CR1485_PreparationBD_CR1012


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\61. Évaluation du portefeuille (intermédiaire)\2.1 Clients
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-14--V9-croesus-co7x-1_8_1_650
*/

function CR1485_061_Cli_DateDef_BkVL_TheVLAssAllFirm_NumVis_SortMat()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\61. Évaluation du portefeuille (intermédiaire)\\2.1 Clients\\", "CR1485_061_Cli_DateDef_BkVL_TheVLAssAllFirm_NumVis_SortMat()");
    var logAttribute = Log.CreateNewAttributes();
    logAttribute.Bold = true;
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\3. Évaluation du portefeuille (simple)\\3.2 Comptes\\Étapes CR1012\\", "Pré-requis : CR1485_PreparationBD_CR1012()", "", pmNormal, logAttribute);
    Log.Message("CR1012");
    Log.Message("Anomalie JIRA CROES-8365");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 1, language);
        var clientsNumbers = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 297);
        var arrayOfClientsNumbers = clientsNumbers.split("|");
        var externalClientNumber = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 299, language);
        arrayOfClientsNumbers.push(externalClientNumber);
        var securityForCATEGO = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 300, language);
        
        //Activate Prefs
        CR1485_061_Common_functions.ActivatePrefs();
        
        //Activate pref PREF_RPT_DISPLAY_ISSUER_NOTE
        if (null == Execute_SQLQuery_GetField("select SECURITY from B_TRANS where NO_COMPTE in (select NO_COMPTE from B_COMPTE where NO_CLIENT = '" + externalClientNumber + "') and SECURITY in (select SECURITY from B_TITRE where SECUFIRME = '" + securityForCATEGO + "')", vServerReportsCR1485, "SECURITY"))
            Log.Error("Aucune transaction trouvée pour le client '" + externalClientNumber + "' sur le titre '" + securityForCATEGO + "'");
        Activate_PREF_RPT_DISPLAY_ISSUER_NOTE_Catego(securityForCATEGO);
        
        //Login and goto Accounts module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 302);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 305, language);
        var sortBy = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 306, language);
        var currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 307, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 308, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 309, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 310, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 311, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 312, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 313, language);
        var message = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 314, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var asOfDate = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 317, language);
        var checkIncludeGraph = GetBooleanValue(GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 318, language));
        var type = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 319, language);
        var checkComparative = GetBooleanValue(GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 320, language));
        var checkGroupByRegion = GetBooleanValue(GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 321, language));
        var checkGroupByIndustryCode = GetBooleanValue(GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 322, language));
        var groupByIndustryCode = GetBooleanValue(GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 323, language));
        var checkGroupByAccountCurrency = GetBooleanValue(GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 324, language));
        var costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 326, language): GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 325, language);
        var checkCostDisplayedTheoreticalValue = GetBooleanValue(GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 327, language));
        var assetAllocation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 328, language);
        var customAllocation = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 329, language);
        var checkUseTheSpecifiedInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 330, language));
        var checkFundBreakdownClassBreakdown = GetBooleanValue(GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 331, language));
        var checkFundBreakdownAppendix = GetBooleanValue(GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 332, language));
        var numbering = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 333, language);
        var parametersSortBy = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 334, language);
        
        CR1485_003_Acc_DateDef_Grph_Pie_BkVL_AssAllFirm_NumVis_SortMat.SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 338);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 341, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 342, language);
        
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