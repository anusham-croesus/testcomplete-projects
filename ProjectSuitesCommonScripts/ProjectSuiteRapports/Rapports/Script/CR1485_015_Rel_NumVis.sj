//USEUNIT CR1485_Common_functions
//USEUNIT CR1485_015_Common_functions


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_015_Rel_NumVis()
{
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 1, language);
        arrayOfReportsNames = reportName.split("|");
        relationshipName = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 4);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 6);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the Disclaimer report and move it to the top
        if (client == "CIBC") //PREF_USE_DISCLAIMER_COMPILATION : Permet d'empêcher ou non le déplacement du rapport dans la liste des rapports courants
            CheckIfCurrentReportIsStuckedAtBottom(Trim(arrayOfReportsNames[0]));
        else
            MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 9, language);
        sortBy = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 10, language);
        currency = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 11, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 12, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 13, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 14, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 15, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 16, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 17, language);
        message = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 18, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        numbering = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 21, language);
        
        //Set the report parameters
        SetReportParameters(numbering);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 24);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(arrayOfReportsNames);
        
        //Select the Disclaimer report and move it to the top
        if (client == "CIBC") //PREF_USE_DISCLAIMER_COMPILATION : Permet d'empêcher ou non le déplacement du rapport dans la liste des rapports courants
            CheckIfCurrentReportIsStuckedAtBottom(Trim(arrayOfReportsNames[0]));
        else
            MoveCurrentReportToTop(Trim(arrayOfReportsNames[0]));
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 27, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "015_DISCLAIMER", 28, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(numbering);
        
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