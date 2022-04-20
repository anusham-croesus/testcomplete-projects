//USEUNIT CR1485_001_Common_functions


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\1. INFORMATION CLIENTS\1.2 Clients\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_001_Cli_Profile_Notes_Event_NumVis()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\1. INFORMATION CLIENTS\\1.2 Clients\\", "CR1485_001_Cli_Profile_Notes_Event_NumVis()");
    Log.Message("Pré-requis : CR1485_123_Common_functions.ActivateDelegator() exécutée dans CR1485_PreparationBD_Misc().");
    Log.Link("https://jira.croesus.com/browse/BDQA-3", "Bug JIRA BDQA-3");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 1, language);
        var clientNumber = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 37);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 39);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 42, language);
        var sortBy = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 43, language);
        var currency = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 44, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 45, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 46, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 47, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 48, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 49, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 50, language);
        var message = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 51, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var checkProfile = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 54, language);
        var checkNotes = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 55, language);
        var checkEventHistory = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 56, language);
        var numbering = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 57, language);
        
        SetReportParameters(checkProfile, checkNotes, checkEventHistory, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 60);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 63, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 64, language);
        
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