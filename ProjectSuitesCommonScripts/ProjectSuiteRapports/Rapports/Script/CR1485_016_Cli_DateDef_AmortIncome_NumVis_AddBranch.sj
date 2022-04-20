//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_016_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_016_Cli_DateDef_AmortIncome_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "016_REVENUES", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "016_REVENUES", 36);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "016_REVENUES", 38);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "016_REVENUES", 41, language);
        sortBy = GetData(filePath_ReportsCR1485, "016_REVENUES", 42, language);
        currency = GetData(filePath_ReportsCR1485, "016_REVENUES", 43, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "016_REVENUES", 44, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "016_REVENUES", 45, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "016_REVENUES", 46, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "016_REVENUES", 47, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "016_REVENUES", 48, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "016_REVENUES", 49, language);
        message = GetData(filePath_ReportsCR1485, "016_REVENUES", 50, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "016_REVENUES", 53, language);
        endDate = GetData(filePath_ReportsCR1485, "016_REVENUES", 54, language);
        checkIncludeAmortizedIncome = GetData(filePath_ReportsCR1485, "016_REVENUES", 55, language);
        numbering = GetData(filePath_ReportsCR1485, "016_REVENUES", 56, language);
        
        SetReportParameters(startDate, endDate, checkIncludeAmortizedIncome, numbering);
                
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "016_REVENUES", 59);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "016_REVENUES", 62, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "016_REVENUES", 63, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, checkIncludeAmortizedIncome, numbering);
        
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