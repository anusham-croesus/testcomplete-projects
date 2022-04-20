//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_063_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_063_Sec_All_DateModf()
{
    
    Log.Message("Bug JIRA CROES-7711", "Bug CROES-7711 : le bouton 'Remember my selection' n'est pas présent dans la liste des Users. C'est possible que ce bug soit apparu lors du merge de RQS vers Mainline. Réactiver quand le bug aura été résolu et adapter éventuellement le script.");
    Log.Message("Le bug JIRA CROES-7711 est supposé avoir été résolu dans la version 90.04-79.");
    //return;
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 1, language);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Securities module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnSecurities().Click();
        
        //Select IA Code for the connected user
        SelectIACodeforTheUser();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 7);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 10, language);
        sortBy = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 11, language);
        currency = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 12, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 13, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 14, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 15, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 16, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 17, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 18, language);
        message = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 19, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkAllRecords = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 22, language);
        startDate = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 23, language);
        endDate = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 24, language);
        
        SetReportParameters(checkAllRecords, startDate, endDate);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 27);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 30, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "063_TRAILER_FEES", 31, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkAllRecords, startDate, endDate);
        
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