//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_025_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_025_Cli_DateModf_AllRec_InvstCap_AssAllBasic_NumVis()
{
    Log.Message("Bug JIRA CROES-6464");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 41);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 43);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 46, language);
        sortBy = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 47, language);
        currency = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 48, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 49, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 50, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 51, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 52, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 53, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 54, language);
        message = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 55, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 58, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 59, language);
        costCalculation = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 60, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 61, language);
        customAllocation = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 62, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 63, language);
        numbering = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 64, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 65, language);
                
        SetReportParameters(asOfDate, checkAllRecords, costCalculation, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, numbering, checkFundBreakdownClassBreakdown);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 68);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 71, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "025_ASSET_MIX", 72, language);
        
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