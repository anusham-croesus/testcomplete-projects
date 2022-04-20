//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_048_Common_functions
//USEUNIT CR1485_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables



/**
    Description : "P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\48. Analyse de revenu des titres\2.2 Clients\\"
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Abdel Matmat
*/

function CR1485_048_Cli_DateModf_Group_CR1469()
{
       
    try {
        Log.Message("CR1469");
        Log.Message("JIRA CROES-11602");
    
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                
        var reportName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 263, language);
        var arrayOfReportsNames = reportName.split("|");      
        var clientsNumbers = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 264);
        var arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();

        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 266);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Select the third report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 269, language);
        sortBy = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 270, language);
        currency = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 271, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 272, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 273, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 274, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 275, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 276, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 277, language);
        message = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 278, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate3 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 309, language);
        type3 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 310, language);
        checkComparative3 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 311, language);
        assetAllocation3 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 312, language);
        customAllocation3 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 313, language);
        checkUseTheSpecifiedInvestmentObjective3 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 314, language);
        checkFundBreakdownClassBreakdown3 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 315, language);
        numbering3 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 316, language);
        
        SetReportParameters3(asOfDate3, type3, checkComparative3, assetAllocation3, customAllocation3, checkUseTheSpecifiedInvestmentObjective3, checkFundBreakdownClassBreakdown3, numbering3);
        
        //Select the second report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        
        //Parameters values
        transactionTypesToBeChecked2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 299, language);
        startDate2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 300, language);
        endDate2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 301, language);
        checkGroupByRecord2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 302, language);
        checkGroupByTransactionType2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 303, language);
        checkGroupBySecurity2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 304, language);
        numbering2 = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 305, language);
        
        SetReportParameters2(transactionTypesToBeChecked2, startDate2, endDate2, checkGroupByRecord2, checkGroupByTransactionType2, checkGroupBySecurity2, numbering2);
        
        //Select the first report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 281, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 282, language);
        type = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 283, language);
        checkComparative = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 284, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 285, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 286, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 287, language);
        costCalculation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 288, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 290, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 291, language);
        customAllocation = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 292, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 293, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 294, language);
        numbering = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 295, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
       
       
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report ****************************************************************************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 319);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(arrayOfReportsNames);
        
        //Select the third report (Transactions ACB et Quantité) and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[2]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 322, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "048_EVAL_POS_TOT_RETURN", 323, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters3(asOfDate3, type3, checkComparative3, assetAllocation3, customAllocation3, checkUseTheSpecifiedInvestmentObjective3, checkFundBreakdownClassBreakdown3, numbering3);
        
        //Select the second report (Gains et Pertes Réalisés) and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[1]));
        
        //Parameters values (same as for the English report)
        SetReportParameters2(transactionTypesToBeChecked2, startDate2, endDate2, checkGroupByRecord2, checkGroupByTransactionType2, checkGroupBySecurity2, numbering2);
        
        //Select the first (Transactions) report and move it up
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
        Terminate_CroesusProcess();
    }
    
}

function SetReportParameters3(asOfDate, type, checkComparative, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    if (Get_WinParameters_DtpAsOf().Exists)
        SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
    
    SelectComboBoxItem(Get_WinParameters_GrpType_CmbType(), type);
    
    if (Get_WinParameters_GrpType_ChkComparative().IsEnabled)
        Get_WinParameters_GrpType_ChkComparative().set_IsChecked(aqString.ToUpper(checkComparative) == "VRAI" || aqString.ToUpper(checkComparative) == "TRUE");
        
    Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).set_IsChecked(true);
    
    Delay(200);
    
    if (Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().Exists && Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation().IsEnabled)
        SelectComboBoxItem(Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(), customAllocation);
    
    if (Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().Exists && Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().IsEnabled)
        Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().set_IsChecked(aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "VRAI" || aqString.ToUpper(checkUseTheSpecifiedInvestmentObjective) == "TRUE");    
    
    if (client != "RJ"){
        if (Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().IsEnabled)
            Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().set_IsChecked(aqString.ToUpper(checkFundBreakdownClassBreakdown) == "VRAI" || aqString.ToUpper(checkFundBreakdownClassBreakdown) == "TRUE");
    }
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
        
    Delay(300);
    Get_WinParameters_BtnOK().Click();
}

//Transactions Report Parameters
function SetReportParameters2(transactionTypesToBeChecked, startDate, endDate, checkGroupByRecord, checkGroupByTransactionType, checkGroupBySecurity, numbering, checkIncludeNonregisteredAccountsOnly, checkDisplayCheckDigit)
{
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    var allTransactionTypes = Get_WinParameters_GrpTransactionTypes_ChklstTransactionTypes().FindAllChildren(["ClrClassName"], ["UniCheckBox"], 10).toArray();
    if (aqString.ToUpper(transactionTypesToBeChecked) == "TOUS" || aqString.ToUpper(transactionTypesToBeChecked) == "ALL"){
        Get_WinParameters_GrpTransactionTypes_BtnSelectAll().Click();
        Log.Message("JIRA CROES-10786 : Crash quand on clique sur Get_WinParameters_GrpTransactionTypes_BtnSelectAll().Click();");
        //for (var j in allTransactionTypes) allTransactionTypes[j].set_IsChecked(true);
    }
    else {
        Get_WinParameters_GrpTransactionTypes_BtnRemoveAll().Click();
        Log.Message("JIRA CROES-10786 : Crash quand on clique sur Get_WinParameters_GrpTransactionTypes_BtnRemoveAll().Click();");
        //for (var j in allTransactionTypes) allTransactionTypes[j].set_IsChecked(false);
        if (Trim(transactionTypesToBeChecked) != "" && aqString.ToUpper(transactionTypesToBeChecked) != "AUCUN" && aqString.ToUpper(transactionTypesToBeChecked) != "NONE"){
            arrayOfTransactionTypesToBeChecked = transactionTypesToBeChecked.split("|");
            for (i = 0; i < arrayOfTransactionTypesToBeChecked.length; i++)
                Get_WinParameters_GrpTransactionTypes_ChklstTransactionTypes().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", Trim(arrayOfTransactionTypesToBeChecked[i])], 10).set_IsChecked(true);
        }
    }
    
    SetDateInDateTimePicker(Get_WinParameters_DtpStartDate(), startDate);
    
    SetDateInDateTimePicker(Get_WinParameters_DtpEndDate2(), endDate);
    
    if (GetBooleanValue(checkGroupByRecord) != undefined && GetBooleanValue(checkGroupByRecord) != Get_WinParameters_ChkGroupByRecord().IsChecked.OleValue)
        Get_WinParameters_ChkGroupByRecord().Click();
            
    if (GetBooleanValue(checkGroupByTransactionType) != undefined && GetBooleanValue(checkGroupByTransactionType) != Get_WinParameters_ChkGroupByTransactionType().IsChecked.OleValue)
        Get_WinParameters_ChkGroupByTransactionType().Click();
    
    if (GetBooleanValue(checkGroupBySecurity) != undefined && GetBooleanValue(checkGroupBySecurity) != Get_WinParameters_ChkGroupBySecurity().IsChecked.OleValue)
        Get_WinParameters_ChkGroupBySecurity().Click();
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    if (checkIncludeNonregisteredAccountsOnly != undefined && GetBooleanValue(checkIncludeNonregisteredAccountsOnly) != undefined && GetBooleanValue(checkIncludeNonregisteredAccountsOnly) != Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().IsChecked.OleValue)
        Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().Click();
    
    if (checkDisplayCheckDigit != undefined && GetBooleanValue(checkDisplayCheckDigit) != undefined && GetBooleanValue(checkDisplayCheckDigit) != Get_WinParameters_ChkDisplayCheckDigit().IsChecked.OleValue)
        Get_WinParameters_ChkDisplayCheckDigit().Click();
    
    //Les états de certaines cases à cocher sont inter-dépendants, valider l'état final de cases à cocher
    if (GetBooleanValue(checkGroupByRecord) != undefined)
        CompareProperty(Get_WinParameters_ChkGroupByRecord().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkGroupByRecord), true, lmError);
        
    if (GetBooleanValue(checkGroupByTransactionType) != undefined)
        CompareProperty(Get_WinParameters_ChkGroupByTransactionType().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkGroupByTransactionType), true, lmError);
        
    if (GetBooleanValue(checkGroupBySecurity) != undefined)
        CompareProperty(Get_WinParameters_ChkGroupBySecurity().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkGroupBySecurity), true, lmError);
        
    if (checkIncludeNonregisteredAccountsOnly != undefined && GetBooleanValue(checkIncludeNonregisteredAccountsOnly) != undefined)
        CompareProperty(Get_WinParameters_ChkIncludeNonregisteredAccountsOnly().IsChecked.OleValue, cmpEqual, GetBooleanValue(checkIncludeNonregisteredAccountsOnly), true, lmError);
    
    Delay(1000);
    Get_WinParameters_BtnOK().Click();
}