//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_004_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_004_Cli_DateModf_AmortIncome_SortDesc_NumVis_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "004_ANNIC", 1, language);
        clientNumber = GetData(filePath_ReportsCR1485, "004_ANNIC", 36);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnClients().Click();
        
        //Select the client
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "004_ANNIC", 38);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "004_ANNIC", 41, language);
        sortBy = GetData(filePath_ReportsCR1485, "004_ANNIC", 42, language);
        currency = GetData(filePath_ReportsCR1485, "004_ANNIC", 43, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "004_ANNIC", 44, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "004_ANNIC", 45, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "004_ANNIC", 46, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "004_ANNIC", 47, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "004_ANNIC", 48, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "004_ANNIC", 49, language);
        message = GetData(filePath_ReportsCR1485, "004_ANNIC", 50, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "004_ANNIC", 53, language);
        checkIncludeAmortizedIncome = GetData(filePath_ReportsCR1485, "004_ANNIC", 54, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "004_ANNIC", 55, language);
        numbering = GetData(filePath_ReportsCR1485, "004_ANNIC", 56, language);
        
        SetReportParameters(startDate, checkIncludeAmortizedIncome, parametersSortBy, numbering);
                
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "004_ANNIC", 59);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "004_ANNIC", 62, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "004_ANNIC", 63, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, checkIncludeAmortizedIncome, parametersSortBy, numbering);
        
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