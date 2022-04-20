//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_037_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_037_Portf_DateModf_SortDesc()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 1, language);
        relationshipsNames = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 103);
        arrayOfRelationshipsNames = relationshipsNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select relationships
        SelectRelationships(arrayOfRelationshipsNames);
        
        //Drag the relationships to Portfolio module
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 105);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 110, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 108, language);
        sortBy = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 109, language);
        //currency = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 110, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 111, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 112, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 113, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 114, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 115, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 116, language);
        message = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 117, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 120, language);
        endDate = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 121, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 122, language);
        checkIncludeAmortizedIncome = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 123, language);
        numbering = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 124, language);
        
        SetReportParameters(startDate, endDate, parametersSortBy, checkIncludeAmortizedIncome, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 127);
        
        //Set Portfolio Currency
        currency = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 130, language);
        SetPortfolioCurrencyAndDate(currency, null);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        //currency = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 130, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 131, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(startDate, endDate, parametersSortBy, checkIncludeAmortizedIncome, numbering);
        
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