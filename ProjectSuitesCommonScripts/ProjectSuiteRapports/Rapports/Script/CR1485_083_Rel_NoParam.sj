//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_083_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_083_Rel_NoParam()
{
    Log.Message("Jira BNC-1487");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 1, language);
        relationshipName = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 10, language);
        currency = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 17, language);
        message = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Set no Parameters (take the default parameters)
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 23);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 26, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "083_FBNGP_Q_MKTVALUEEVOL", 27, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Set no Parameters (take the default parameters)
        
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