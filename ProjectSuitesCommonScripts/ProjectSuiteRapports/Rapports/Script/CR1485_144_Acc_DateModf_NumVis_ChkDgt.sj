//USEUNIT CR1485_144_Common_functions



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_144_Acc_DateModf_NumVis_ChkDgt()
{
    Log.Message("CR1984");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 1, language);
        accountNumber = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 68);
        
        
        //Activate Prefs
        ActivatePrefs(userNameReportsCR1485);
        
        //Activer CHECK DIGIT
        Activate_Inactivate_CheckDigit(userNameReportsCR1485, "YES", accountNumber, "8");
        
        //Login and goto Clients module and select Account
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountNumber);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 70);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 73, language);
        sortBy = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 74, language);
        currency = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 75, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 76, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 77, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 78, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 79, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 80, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 81, language);
        message = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 82, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 85, language);
        numbering = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 86, language);
        checkDisplayCheckDigit = GetBooleanValue(GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 87, language));
        
        SetReportParameters(asOfDate, numbering, checkDisplayCheckDigit);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 90);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 93, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "144_PORTF_OVERVIEW", 94, language);
        
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
