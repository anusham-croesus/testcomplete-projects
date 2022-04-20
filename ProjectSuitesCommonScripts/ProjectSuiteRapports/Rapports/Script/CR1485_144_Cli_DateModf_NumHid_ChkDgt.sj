//USEUNIT CR1485_144_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_144_Cli_DateModf_NumHid_ChkDgt()
{
    Log.Message("CR1984");
    
    try {
        var reportName = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 1, language);
        var accountNumber = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 36);
        var clientNumber = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 37);
        
        
        //Activate Prefs
        ActivatePrefs(userNameReportsCR1485);
        
        //Activer CHECK DIGIT
        Activate_Inactivate_CheckDigit(userNameReportsCR1485, "YES", accountNumber, "8");
        
        //Login and goto Clients module and select Client
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        SelectClients(clientNumber);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 39);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 42, language);
        sortBy = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 43, language);
        currency = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 44, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 45, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 46, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 47, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 48, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 49, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 50, language);
        message = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 51, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 54, language);
        numbering = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 55, language);
        checkDisplayCheckDigit = GetBooleanValue(GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 56, language));
        
        SetReportParameters(asOfDate, numbering, checkDisplayCheckDigit);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 59);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 62, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 63, language);
        
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
        Activate_Inactivate_CheckDigit(userNameReportsCR1485, null, accountNumber, null);
    }
    
}
