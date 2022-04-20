//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_029_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1485_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_029_Cli_DateModf_Graph_AssAllFirm_Qrt_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 42);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 44);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 47, language);
        sortBy = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 48, language);
        currency = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 49, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 50, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 51, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 52, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 53, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 54, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 55, language);
        message = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 56, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 59, language);
        endDate = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 60, language);
        checkAllRecords = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 61, language);
        checkIncludeGraph = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 62, language);
        assetAllocation = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 63, language);
        customAllocation = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 64, language);
        checkUseTheSpecifiedInvestmentObjective = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 65, language);
        checkFundBreakdownClassBreakdown = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 66, language);
        data = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 67, language);
        numbering = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 68, language);
        
        SetReportParameters(startDate, endDate, checkAllRecords, checkIncludeGraph, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, data, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");

        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);

        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 71);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 74, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "029_ASSETS_UNDER_MGT_PER", 75, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, checkAllRecords, checkIncludeGraph, assetAllocation, customAllocation, checkUseTheSpecifiedInvestmentObjective, checkFundBreakdownClassBreakdown, data, numbering);
        
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