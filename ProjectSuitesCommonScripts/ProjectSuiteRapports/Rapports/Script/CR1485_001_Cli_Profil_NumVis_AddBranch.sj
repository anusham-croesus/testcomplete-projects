//USEUNIT CR1485_001_Common_functions


/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\1. INFORMATION CLIENTS\1.1 Clients\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_001_Cli_Profil_NumVis_AddBranch()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\1. INFORMATION CLIENTS\\1.1 Clients\\", "CR1485_001_Cli_Profil_NumVis_AddBranch()");
    Log.Message("Pré-requis : CR1485_123_Common_functions.ActivateDelegator() exécutée dans CR1485_PreparationBD_Misc().");
    Log.Link("https://jira.croesus.com/browse/BDQA-3", "Bug JIRA BDQA-3");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 1, language);
        var clientNumber = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        var reportFileName = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        var destination = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 9, language);
        var sortBy = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 10, language);
        var currency = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 11, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 12, language);
        var checkAddBranchAddress = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 13, language);
        var checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 14, language);
        var checkConsolidatePositions = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 15, language);
        var checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 16, language);
        var checkIncludeMessage = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 17, language);
        var message = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        var checkProfile = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 21, language);
        var checkNotes = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 22, language);
        var checkEventHistory = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 23, language);
        var numbering = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 24, language);
        
        SetReportParameters(checkProfile, checkNotes, checkEventHistory, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        var reportFileName = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 27);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        var currency = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 30, language);
        var reportLanguage = GetData(filePath_ReportsCR1485, "001_INFO_CLIENT", 31, language);
        
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