//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_024_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_024_Rel_Ydef_NumVis_AddBranch_Group()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 1, language);
        relationshipsNames = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 4);
        arrayOfRelationshipsNames = relationshipsNames.split("|");
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select relationships
        SelectRelationships(arrayOfRelationshipsNames);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 10, language);
        currency = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 17, language);
        message = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        year = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 21, language);
        numbering = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 22, language);
        
        SetReportParameters(year, numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 25);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 28, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "024_THEORETICAL_INTEREST", 29, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(year, numbering);
        
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