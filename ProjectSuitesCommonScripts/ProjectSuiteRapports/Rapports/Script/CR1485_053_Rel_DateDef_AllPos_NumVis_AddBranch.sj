//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_053_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_053_Rel_DateDef_AllPos_NumVis_AddBranch()
{
    
    try {
        reportName = (client == "US")? GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 2, language): GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 1, language);
        relationshipsNames = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 4);
        arrayOfRelationshipsNames = relationshipsNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select relationships
        SelectRelationships(arrayOfRelationshipsNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 10, language);
        currency = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 17, language);
        message = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 21, language);
        positionState = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 22, language);
        numbering = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 23, language);
        
        SetReportParameters(asOfDate, positionState, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 26);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 29, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "053_BOOK_PAGE", 30, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, positionState, numbering);
        
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