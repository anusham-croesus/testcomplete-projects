//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_080_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_080_Cli_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 1, language);
        clientsNumbers = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 4);
        arrayOfClientsNumbers = clientsNumbers.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select clients
        SelectClients(arrayOfClientsNumbers);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 10, language);
        currency = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 17, language);
        message = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        numbering = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 21, language);
        
        SetReportParameters(numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 24);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 27, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "080_FDP_TRANSACTION", 28, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(numbering);
        
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