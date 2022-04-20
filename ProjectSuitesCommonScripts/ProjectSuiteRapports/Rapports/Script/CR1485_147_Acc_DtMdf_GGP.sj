//USEUNIT CR1485_147_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_147_Acc_DtMdf_GGP()
{
    Log.Message("CR2013");
    
    try {
        var reportsNames = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 1, language);
        var arrayOfReportsNames = reportsNames.split("|");
        var accountsNumbers = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 65);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Login and select Accounts
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountsNumbers.split("|"));
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 67);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "Cover Page - PM/FA" report and move it to top
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 70, language);
        sortBy = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 71, language);
        currency = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 72, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 73, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 74, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 75, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 76, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 77, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 78, language);
        message = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 79, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 82, language);
        reportTitle = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 83, language);
        
        SetReportParameters(asOfDate, reportTitle);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 86);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "Cover Page - PM/FA" report and move it to top
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 89, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "147_PMFA_COVERPAGE1", 90, language);
        
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
