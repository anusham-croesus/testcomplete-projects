//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_064_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_064_Rel_ParamDef()
{
    Log.Message("Jira BNC-1494");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 43);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 45);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 48, language);
        sortBy = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 49, language);
        currency = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 50, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 51, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 52, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 53, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 54, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 55, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 56, language);
        message = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 57, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 60, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 61, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 62, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 63, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 64, language);
        costCalculation = (client == "US")? GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 66, language): GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 65, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 67, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 68, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 69, language);
        numbering = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 70, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 73);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 76, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "064_FBNGP_Q_EVAL", 77, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, costCalculation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
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