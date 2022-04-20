//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_047_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_047_Cli_NoParam()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 2, language);
        arrayOfReportsNames = reportName.split("|");
        clientNumber = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 10, language);
        currency = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 17, language);
        message = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Select the "Cover Page (Monthly Trades)" report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 23);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 26, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "047_FDP_TRANSCOVERPAGE", 27, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Select the "Cover Page (Monthly Trades)" report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
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