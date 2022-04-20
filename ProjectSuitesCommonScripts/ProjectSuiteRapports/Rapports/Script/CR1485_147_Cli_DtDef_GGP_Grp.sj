//USEUNIT CR1485_147_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_147_Cli_DtDef_GGP_Grp()
{
    Log.Message("CR2013");
    
    try {
        var reportsNames = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 1, language);
        var arrayOfReportsNames = reportsNames.split("|");
        var clientsNumbers = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 35);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and select Clients
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientsNumbers.split("|"));
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 37);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "Cover Page - PM/FA" report and move it to top
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 40, language);
        sortBy = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 41, language);
        currency = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 42, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 43, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 44, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 45, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 46, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 47, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 48, language);
        message = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 49, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 52, language);
        reportTitle = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 53, language);
        
        SetReportParameters(asOfDate, reportTitle);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 56);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "Cover Page - PM/FA" report and move it to top
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 59, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 60, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, reportTitle);
        
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
