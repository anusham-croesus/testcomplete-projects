//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_090_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_090_Rel_DateDef()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 4);
        arrayOfReportsNames = reportName.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        //Goto Relationships module
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        //Save the "Cover Page (Quarterly)" report
        SaveDefaultReportForRelationships(Trim(arrayOfReportsNames[0]));
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 6);
        
        //Open Reports window and Select reports
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectMySavedReport(Trim(arrayOfReportsNames[0]), true);
        SelectReports(Trim(arrayOfReportsNames[1]), true);
        
        //Select the Cover Page report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 10, language);
        currency = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 17, language);
        message = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 21, language);
        
        //Set the report parameters
        SetReportParameters(asOfDate);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 24);
        
        //Open Reports window and Select reports
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectMySavedReport(Trim(arrayOfReportsNames[0]), true);
        SelectReports(Trim(arrayOfReportsNames[1]), true);
        
        //Select the Cover Page report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 27, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "090_FBNGP_Q_COVERPAGE", 28, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //Delete the saved report
        DeleteSavedDefaultReportForRelationships(Trim(arrayOfReportsNames[0]));
        
        Terminate_CroesusProcess();
    }
    
}