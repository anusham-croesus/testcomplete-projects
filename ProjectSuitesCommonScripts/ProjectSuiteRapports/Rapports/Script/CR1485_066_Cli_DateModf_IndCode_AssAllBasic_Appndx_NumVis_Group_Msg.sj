//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_066_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_066_Cli_DateModf_IndCode_AssAllBasic_Appndx_NumVis_Group_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 44);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 46);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 49, language);
        sortBy = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 50, language);
        currency = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 51, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 52, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 53, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 54, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 55, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 56, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 57, language);
        message = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 58, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 61, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 62, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 63, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 64, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 65, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 66, language);
        customAllocation = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 67, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 68, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 69, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 70, language);
        numbering = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 71, language);
        checkOneReportPerAccount = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 72, language);
        
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 75);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 78, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "066_GP_NON_REALISES_TL", 79, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering, checkOneReportPerAccount);
        
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