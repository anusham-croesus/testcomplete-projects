//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_110_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_110_Rel_DateDef()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 1, language);
        arrayOfReportsNames = reportName.split("|");
        relationshipName = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "PIMG Cover Page" report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 10, language);
        currency = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 17, language);
        message = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 21, language);
        
        //Set the report parameters
        SetReportParameters(asOfDate);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 24);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the "PIMG Cover Page" report and move it up
        MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 27, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "110_RJ_PIMG_COVERPAGE", 28, language);
        
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
        Terminate_CroesusProcess();
    }
    
}