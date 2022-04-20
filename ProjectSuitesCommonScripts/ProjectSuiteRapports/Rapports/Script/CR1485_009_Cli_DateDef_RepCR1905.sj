//USEUNIT CR1485_009_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_009_Cli_DateDef_RepCR1905()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    Log.Message("Bug JIRA CROES-6464");
    Log.Message("CR1905");
    Log.Message("Bug JIRA CROES-11541");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 130);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        EnablePerformanceFeesGroupBoxForUser(userNameKEYNEJ);
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 132);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 135, language);
        sortBy = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 136, language);
        currency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 137, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 138, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 139, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 140, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 141, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 142, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 143, language);
        message = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 144, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        CheckExcludeDataPrecedingTheManagementStartDate = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 147, language);
        endDate = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 148, language);
        period = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 149, language);
        period1 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 150, language);
        period2 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 151, language);
        period3 = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 152, language);
        checkTimeWeightedNetOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 153, language);
        checkTimeWeightedGrossOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 154, language);
        checkMoneyWeightedNetOfFees = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 155, language);
        performanceCalculations = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 156, language);
        checkDisplayDefaultIndices = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 157, language);
        indicesToBeChecked = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 158, language);
        checkUseIndexBaseCurrency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 159, language);
        numbering = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 160, language);
        
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 163);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 166, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "009_SUMMARY_PORTFOLIO", 167, language);

        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(CheckExcludeDataPrecedingTheManagementStartDate, endDate, period, period1, period2, period3, checkTimeWeightedNetOfFees, checkTimeWeightedGrossOfFees, checkMoneyWeightedNetOfFees, performanceCalculations, checkDisplayDefaultIndices, indicesToBeChecked, checkUseIndexBaseCurrency, numbering);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "Before_" + reportFileName + ".log");
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        CheckIfCfchartserverServiceIsRunning(vServerReportsCR1485, REPORTS_FILES_FOLDER_PATH + "After_" + reportFileName + ".log");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        RestoreToDefaultPerformanceFeesGroupBoxForUser(userNameKEYNEJ);
        Terminate_CroesusProcess();
    }
    
}