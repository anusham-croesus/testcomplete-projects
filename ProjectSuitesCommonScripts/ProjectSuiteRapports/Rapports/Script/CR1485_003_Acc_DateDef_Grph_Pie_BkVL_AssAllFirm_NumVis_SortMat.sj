//USEUNIT CR1485_Common_functions
//USEUNIT DBA



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_003_Acc_DateDef_Grph_Pie_BkVL_AssAllFirm_NumVis_SortMat()
{
    var reportName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 1, language);
    var reportFileName_English = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 281);
    var reportFileName_French = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 316);
    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    
    Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_REPORT_EVAL_SIMPLE", "YES", vServerReportsCR1485);
    CR1485_CROES_9126_Acc_Evaluation_du_portefeuille(reportName, reportFileName_English, reportFileName_French);
}





function CR1485_CROES_9126_Acc_Evaluation_du_portefeuille(reportName, reportFileName_English, reportFileName_French)
{
    Log.Message("JIRA CROES-9126");
    if (client == "BNC") Log.Message("JIRA BNC-2128");
    if (client == "TD") Log.Message("JIRA CROES-9990");
    if (client == "CIBC") Log.Message("JIRA CROES-10213");
    
    try {
        var accountsNumbers = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 279);
        var arrayOfAccountsNumbers = accountsNumbers.split("|");
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
        Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ADD_THEORETICAL_VALUE", "NO", vServerReportsCR1485);
        Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_REPORT_DISPLAY_BRANCH_ADDRESS", "YES", vServerReportsCR1485);
        
        //Login and goto Accounts module and select Accounts
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(arrayOfAccountsNumbers);
        
        
        //************************* Generate English report *********************
        //reportFileName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 281);
        reportFileName = reportFileName_English;
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 284, language);
        sortBy = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 285, language);
        currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 286, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 287, language);
        checkAddBranchAddress = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 288, language);
        checkGroupInTheSameReport = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 289, language);
        checkConsolidatePositions = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 290, language);
        checkGroupUnderlyingClients = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 291, language);
        checkIncludeMessage = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 292, language);
        message = null; //GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 293, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 296, language);
        checkIncludeGraph = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 297, language));
        type = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 298, language);
        checkComparative = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 299, language));
        checkGroupByRegion = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 300, language));
        checkGroupByIndustryCode = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 301, language));
        groupByIndustryCode = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 302, language));
        checkGroupByAccountCurrency = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 303, language));
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 305, language): GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 304, language);
        checkCostDisplayedTheoreticalValue = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 306, language));
        assetAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 307, language);
        customAllocation = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 308, language);
        checkUseTheSpecifiedInvestmentObjective = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 309, language));
        checkFundBreakdownClassBreakdown = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 310, language));
        checkFundBreakdownAppendix = GetBooleanValue(GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 311, language));
        numbering = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 312, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 313, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
                
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        //reportFileName = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 316);
        reportFileName = reportFileName_French;
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 319, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "003_EVAL_SIMPLE", 320, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, parametersSortBy);
        
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



/**
    Cette fonction est, de façon spéciale, réutilisée pour l'ensemble des quatre rapports suivants :
        - PREF_REPORT_EVAL_SIMPLE : Évaluation du portefeuille (simple)
        - PREF_REPORT_EVAL_AVAN : Évaluation du portefeuille (avancé)
        - PREF_REPORT_EVAL_INTER : Évaluation du portefeuille (intermédiaire)
        - PREF_REPORT_EVAL_VC : Évaluation du portefeuille (valeur accumulée)
    relativement à l'anomalie CROES-9126 : https://jira.croesus.com/browse/CROES-9126 et à un cas ajouté du CR1458 (JIRA ???)
    
    Dans les autres scripts, chacun de ces rapports a sa propre fonction SetReportParameters,
    quand bien même leurs fenêtres de Paramètres se ressemblent ; cela a été ainsi conformément à l'approche initiale.
    Elle utilise par ailleurs une approche qui pourrait représenter une amélioration par rapport aux autres.
*/
function SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkGroupByAccountCurrency, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, sortBy)
{
    Log.Message("JIRA CROES-8424");
    if (client == "CIBC") Log.Message("JIRA CROES-9837");
    
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (asOfDate != undefined) SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
    
    if (checkIncludeGraph != undefined) Get_WinParameters_ChkIncludeGraph().set_IsChecked(checkIncludeGraph);
    
    Delay(200);
    
    if (type != undefined && Trim(type) != "") SelectComboBoxItem(Get_WinParameters_GrpType_CmbType(), type);
        
    if (checkComparative != undefined) Get_WinParameters_GrpType_ChkComparative().set_IsChecked(checkComparative);
        
    if (checkGroupByRegion != undefined) Get_WinParameters_GrpGroupBy_ChkRegion().set_IsChecked(checkGroupByRegion);
    
    if (checkGroupByIndustryCode != undefined) Get_WinParameters_GrpGroupBy_ChkIndustryCode().set_IsChecked(checkGroupByIndustryCode);
    
    Delay(200);
    
    if (checkGroupByIndustryCode != undefined && Trim(groupByIndustryCode) != "") SelectComboBoxItem(Get_WinParameters_GrpGroupBy_CmbIndustryCode(), groupByIndustryCode);
    
    if (checkGroupByAccountCurrency != undefined) Get_WinParameters_GrpGroupBy_ChkAccountCurrency().set_IsChecked(checkGroupByAccountCurrency);
    
    if (costCalculation != undefined && Trim(costCalculation) != "") Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", costCalculation], 10).set_IsChecked(true);
    
    if (checkCostDisplayedTheoreticalValue != undefined) Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue().set_IsChecked(checkCostDisplayedTheoreticalValue);
    
    if (assetAllocation != undefined && Trim(assetAllocation) != "") Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).set_IsChecked(true);
    
    Delay(200);
    
    if (customAllocation != undefined && Trim(customAllocation) != "")
        SelectComboBoxItem(Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(), customAllocation);
    
    if (checkUseTheSpecifiedInvestmentObjective != undefined)
        Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().set_IsChecked(checkUseTheSpecifiedInvestmentObjective);
    
    if (client != "RJ"){
        if (checkFundBreakdownClassBreakdown != undefined) Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().set_IsChecked(checkFundBreakdownClassBreakdown);
        if (checkFundBreakdownAppendix != undefined) Get_WinParameters_GrpFundBreakdown_ChkAppendix().set_IsChecked(checkFundBreakdownAppendix);
    }
    
    if (Get_WinParameters_CmbSortBy2().Exists){
        if (Trim(VarToStr(numbering)) != ""){
            if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
                Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
            SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
        }
        if (sortBy != undefined)
            SelectComboBoxItem(Get_WinParameters_CmbSortBy2(), sortBy);
    }
    else if (sortBy != undefined)
        SelectComboBoxItem(Get_WinParameters_CmbSortBy1(), sortBy);
    
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}

