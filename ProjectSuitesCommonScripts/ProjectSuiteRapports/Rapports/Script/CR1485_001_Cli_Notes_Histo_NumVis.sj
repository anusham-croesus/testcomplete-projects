//USEUNIT CR1485_001_Common_functions


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\1. INFORMATION CLIENTS\1.3 Clients\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_001_Cli_Notes_Histo_NumVis()
{
    Log.Link("P:\\aq\\Projets\\GEN\CR1485\\Rapports de référence\\BNC\\1. INFORMATION CLIENTS\\1.3 Clients\\", "CR1485_001_Cli_Notes_Histo_NumVis()");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 1, language);
        var clientNumber = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 70);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module and Select the client
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientNumber);
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 72);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 75, language);
        var sortBy = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 76, language);
        var currency = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 77, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 78, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 79, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 80, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 81, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 82, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 83, language);
        var message = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 84, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var checkProfile = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 87, language);
        var checkNotes = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 88, language);
        var checkEventHistory = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 89, language);
        var numbering = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 90, language);
        
        SetReportParameters(checkProfile, checkNotes, checkEventHistory, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 93);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 96, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 97, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkProfile, checkNotes, checkEventHistory, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        RestorePrefs();
        Terminate_CroesusProcess();
    }
    
}