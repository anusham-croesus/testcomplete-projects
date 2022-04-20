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

function CR1485_037_Rel_DateModf_SortDesc_NumVis_AddBranch()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 1, language);
        relationshipsNames = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 4);
        arrayOfRelationshipsNames = relationshipsNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select relationships
        SelectRelationships(arrayOfRelationshipsNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 10, language);
        currency = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 17, language);
        message = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        startDate = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 21, language);
        endDate = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 22, language);
        parametersSortBy = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 23, language);
        checkIncludeAmortizedIncome = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 24, language);
        numbering = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 25, language);
        
        SetReportParameters(startDate, endDate, parametersSortBy, checkIncludeAmortizedIncome, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 28);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 31, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "037_PROJ_PERIODE", 32, language);
        
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