//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_045_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_045_Rel_DateModf_InvestCap_NumHiddn_AddBranch_Msg()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "045_DIST_BM", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "045_DIST_BM", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "045_DIST_BM", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "045_DIST_BM", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "045_DIST_BM", 10, language);
        currency = GetData(filePath_ReportsCR1485, "045_DIST_BM", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "045_DIST_BM", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "045_DIST_BM", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "045_DIST_BM", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "045_DIST_BM", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "045_DIST_BM", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "045_DIST_BM", 17, language);
        message = GetData(filePath_ReportsCR1485, "045_DIST_BM", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        asOfDate = GetData(filePath_ReportsCR1485, "045_DIST_BM", 21, language);
        costCalculation = GetData(filePath_ReportsCR1485, "045_DIST_BM", 22, language);
        numbering = GetData(filePath_ReportsCR1485, "045_DIST_BM", 23, language);
                
        SetReportParameters(asOfDate, costCalculation, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "045_DIST_BM", 26);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "045_DIST_BM", 29, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "045_DIST_BM", 30, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(asOfDate, costCalculation, numbering);
        
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