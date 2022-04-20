//USEUNIT CR1485_148_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_148_Cli_DtMdf_GGP()
{
    Log.Message("CR2013");
    
    try {
        var reportsNames = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 1, language);
        var arrayOfReportsNames = reportsNames.split("|");
        var clientsNumbers = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 35);
        
        
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
        reportFileName = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 37);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "Cover Page - PM/FA" report and move it to top
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 40, language);
        sortBy = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 41, language);
        currency = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 42, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 43, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 44, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 45, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 46, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 47, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 48, language);
        message = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 49, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 52, language);
        reportTitle = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 53, language);
        
        SetReportParameters(asOfDate, reportTitle);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 56);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "Cover Page - PM/FA" report and move it to top
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 59, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 60, language);
        
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
