//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_049_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_049_Cli_DateDef_Region_AssAllBasic_NumHid_Appdx_Group_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 86);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 88);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 91, language);
        sortBy = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 92, language);
        currency = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 93, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 94, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 95, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 96, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 97, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 98, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 99, language);
        message = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 100, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 103, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 104, language);
        type = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 105, language);
        checkComparative = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 106, language);
        checkGroupByRegion = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 107, language);
        checkGroupByIndustryCode = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 108, language);
        groupByIndustryCode = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 109, language);
        checkCostDisplayedTheoreticalValue = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 110, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 111, language);
        customAllocation = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 112, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 113, language);
        checkFundBreakdownAppendix = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 114, language);
        numbering = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 115, language);
        
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 118);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 121, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "049_EVAL_POS_TOT_RET_TL", 122, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, checkIncludeGraph, type, checkComparative, checkGroupByRegion, checkGroupByIndustryCode, groupByIndustryCode, checkCostDisplayedTheoreticalValue, assetAllocation, customAllocation, checkFundBreakdownClassBreakdown, checkFundBreakdownAppendix, numbering);
        
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