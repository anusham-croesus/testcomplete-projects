//USEUNIT CR1485_055_Common_functions
//USEUNIT CR1485_Common_functions


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\55. ACTIFS SOUS GESTION\2.2 Clients\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-51--V9-croesus-co7x-1_8_2_653
*/

function CR1485_055_Cli_DateModf_GraphNegatif()
{
    Log.Message("Bug JIRA CROES-9916");
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\55. ACTIFS SOUS GESTION\\2.2 Clients\\", "CR1485_055_Cli_DateModf_GraphNegatif()");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 196);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 198);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 201, language);
        sortBy = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 202, language);
        currency = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 203, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 204, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 205, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 206, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 207, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 208, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 209, language);
        message = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 210, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 213, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 214, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 215, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 216, language);
        nameOrFullName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 217, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 218, language);
        customAllocation = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 219, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 220, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 221, language);
        numbering = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 222, language);
        
        SetReportParameters(asOfDate, checkAllRecords, checkIncludeGraph, parametersSortBy, nameOrFullName, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 225);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 228, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "055_ASSETS_UNDER_MGT_PER", 229, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkAllRecords, checkIncludeGraph, parametersSortBy, nameOrFullName, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering);
        
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



function SetReportParameters(asOfDate, checkAllRecords, checkIncludeGraph, sortBy, nameOrFullName, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, numbering, checkDisplayCheckDigit)
{
    Log.Message("Bug JIRA CROES-8112");
    
    if (!Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("The Parameters button is disabled!");
        return;
    }
    
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
    
    SetDateInDateTimePicker(Get_WinParameters_DtpAsOf(), asOfDate);
    
    var isAllRecordsCheckboxToBeChecked = GetBooleanValue(checkAllRecords);
    if (isAllRecordsCheckboxToBeChecked != Get_WinParameters_ChkAllRecords().IsChecked.OleValue)
        Get_WinParameters_ChkAllRecords().Click();
    
    var isIncludeGraphCheckboxToBeChecked = GetBooleanValue(checkIncludeGraph);
    if (isIncludeGraphCheckboxToBeChecked != Get_WinParameters_ChkIncludeGraph().IsChecked.OleValue)
        Get_WinParameters_ChkIncludeGraph().Click();
    
    SelectComboBoxItem(Get_WinParameters_GrpOrder_CmbSortBy(), sortBy);
    
    if (true !== Get_WinParameters_Grp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", nameOrFullName], 10).IsChecked.OleValue)
        Get_WinParameters_Grp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", nameOrFullName], 10).Click();
    
    if (true !== Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).IsChecked.OleValue)
        Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).Click();
    
    if (Trim(VarToStr(customAllocation)) != "")
        SelectComboBoxItem(Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(), customAllocation);
    
    var isUseTheSpecifiedInvestmentObjectiveCheckboxToBeChecked = GetBooleanValue(checkUseTheSpecifiedInvestmentObjective);
    if (isUseTheSpecifiedInvestmentObjectiveCheckboxToBeChecked != undefined && isUseTheSpecifiedInvestmentObjectiveCheckboxToBeChecked != Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().IsChecked.OleValue)
        Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().Click();
    
    if (client != "RJ"){
        var isFundBreakdownClassBreakdownCheckboxToBeChecked = GetBooleanValue(checkFundBreakdownClassBreakdown);
        if (isFundBreakdownClassBreakdownCheckboxToBeChecked != Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().IsChecked.OleValue)
            Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().Click();
    }
    
    if (!Get_WinParameters_LblNumbering().Exists || !Get_WinParameters_LblNumbering().IsVisible)
        Log.Error((language == "french")? "Libellé de 'Pagination:' non trouvé.": "'Numbering:' label not found.");
    SelectComboBoxItem(Get_WinParameters_CmbNumbering1(), numbering);
    
    if (checkDisplayCheckDigit != undefined){
        var isDisplayCheckDigitCheckboxToBeChecked = GetBooleanValue(checkDisplayCheckDigit);
        if (isDisplayCheckDigitCheckboxToBeChecked != Get_WinParameters_ChkDisplayCheckDigit().IsChecked.OleValue)
            Get_WinParameters_ChkDisplayCheckDigit().Click();
    }
    
    CompareProperty(Get_WinParameters_ChkAllRecords().IsChecked.OleValue, cmpEqual, isAllRecordsCheckboxToBeChecked, true, lmError);    
    CompareProperty(Get_WinParameters_ChkIncludeGraph().IsChecked.OleValue, cmpEqual, isIncludeGraphCheckboxToBeChecked, true, lmError);
    CompareProperty(Get_WinParameters_Grp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", nameOrFullName], 10).IsChecked.OleValue, cmpEqual, true, true, lmError);
    CompareProperty(Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", assetAllocation], 10).IsChecked.OleValue, cmpEqual, true, true, lmError);
    if (isUseTheSpecifiedInvestmentObjectiveCheckboxToBeChecked != undefined)
        CompareProperty(Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective().IsChecked.OleValue, cmpEqual, isUseTheSpecifiedInvestmentObjectiveCheckboxToBeChecked, true, lmError);    
    if (client != "RJ")
        CompareProperty(Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown().IsChecked.OleValue, cmpEqual, isFundBreakdownClassBreakdownCheckboxToBeChecked, true, lmError);    
    if (checkDisplayCheckDigit != undefined)
        CompareProperty(Get_WinParameters_ChkDisplayCheckDigit().IsChecked.OleValue, cmpEqual, isDisplayCheckDigitCheckboxToBeChecked, true, lmError);    
    
    Get_WinParameters_BtnOK().Click();
}