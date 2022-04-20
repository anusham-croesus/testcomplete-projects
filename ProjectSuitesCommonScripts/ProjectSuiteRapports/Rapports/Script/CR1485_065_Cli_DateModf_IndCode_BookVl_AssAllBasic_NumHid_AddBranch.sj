//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_065_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_065_Cli_DateModf_IndCode_BookVl_AssAllBasic_NumHid_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 46);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 48);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 51, language);
        sortBy = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 52, language);
        currency = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 53, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 54, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 55, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 56, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 57, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 58, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 59, language);
        message = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 60, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 63, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 64, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 65, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 66, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 68, language): GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 67, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 69, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 70, language);
        customAllocation = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 71, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 72, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 73, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 74, language);
        numbering = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 75, language);
        checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 76, language);
        
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 79);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 82, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "065_GP_NON_REALISES", 83, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
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