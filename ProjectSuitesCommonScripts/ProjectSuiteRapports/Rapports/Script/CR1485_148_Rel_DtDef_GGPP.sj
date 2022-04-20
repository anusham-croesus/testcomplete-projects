//USEUNIT CR1485_148_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_148_Rel_DtDef_GGPP()
{
    Log.Message("CR2013");
    
    try {
        var reportsNames = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 1, language);
        var arrayOfReportsNames = reportsNames.split("|");
        var relationshipsNames = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 5);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and select relationships
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        SelectRelationships(relationshipsNames.split("|"));
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 7);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "Cover Page - PM/FA" report and move it to top
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 10, language);
        sortBy = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 11, language);
        currency = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 12, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 13, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 14, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 15, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 16, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 17, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 18, language);
        message = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 19, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 22, language);
        reportTitle = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 23, language);
        
        SetReportParameters(asOfDate, reportTitle);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 26);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "Cover Page - PM/FA" report and move it to top
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 29, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "148_PMFA_COVERPAGE2", 30, language);
        
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
