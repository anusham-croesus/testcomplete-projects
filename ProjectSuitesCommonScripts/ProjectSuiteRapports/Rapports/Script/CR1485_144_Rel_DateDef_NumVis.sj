//USEUNIT CR1485_144_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_144_Rel_DateDef_NumVis()
{
    Log.Message("CR1984");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 1, language);
        var accountNumber = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 4);
        var relationshipsNames = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 5);
        
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Activate Prefs
        ActivatePrefs(userNameKEYNEJ);
        
        //Activer CHECK DIGIT
        Activate_Inactivate_CheckDigit(userNameKEYNEJ, "YES", accountNumber, "8");
        
        //Login and select relationships
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        SelectRelationships(relationshipsNames.split("|"));
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 7);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 10, language);
        sortBy = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 11, language);
        currency = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 12, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 13, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 14, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 15, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 16, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 17, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 18, language);
        message = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 19, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 22, language);
        numbering = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 23, language);
        checkDisplayCheckDigit = GetBooleanValue(GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 24, language));
        
        SetReportParameters(asOfDate, numbering, checkDisplayCheckDigit);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 27);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 30, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 31, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, numbering, checkDisplayCheckDigit);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Activate_Inactivate_CheckDigit(userNameKEYNEJ, null, accountNumber, null);
    }
    
}
