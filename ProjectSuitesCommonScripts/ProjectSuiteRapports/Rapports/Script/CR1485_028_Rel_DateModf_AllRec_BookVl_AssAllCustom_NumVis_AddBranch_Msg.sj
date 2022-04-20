//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_028_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_028_Rel_DateModf_AllRec_BookVl_AssAllCustom_NumVis_AddBranch_Msg()
{
    Log.Message("Bug JIRA CROES-6464");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 1, language);
        relationshipsNames = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 4);
        arrayOfRelationshipsNames = relationshipsNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select relationships
        SelectRelationships(arrayOfRelationshipsNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 10, language);
        currency = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 17, language);
        message = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 21, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 22, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 24, language): GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 23, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 25, language);
        customAllocation = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 26, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 27, language);
        numbering = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 28, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 29, language);
        
        SetReportParameters(asOfDate, checkAllRecords, costCalculation, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, numbering, checkFundBreakdownClassBreakdown);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 32);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 35, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "028_IAVM_ASSET_MIX", 36, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkAllRecords, costCalculation, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, numbering, checkFundBreakdownClassBreakdown);
        
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