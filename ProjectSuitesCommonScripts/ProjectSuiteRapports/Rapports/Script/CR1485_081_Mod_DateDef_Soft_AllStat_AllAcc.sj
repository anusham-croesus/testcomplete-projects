//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_081_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_081_Mod_DateDef_Soft_AllStat_AllAcc()
{
    Log.Message("Jira BNC-1427 / CROES-8013 / CROES-8755");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 2, language);
        modelName = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 106);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
        
        //Select the relationship
        SearchModelByName(modelName);
        Get_ModelsGrid().FindChild("Value", modelName, 10).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 108);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 111, language);
        sortBy = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 112, language);
        currency = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 113, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 114, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 115, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 116, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 117, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 118, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 119, language);
        message = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 120, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkSeverityHard = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 123, language);
        checkSeveritySoft = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 124, language);
        checkAccessFirm = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 125, language);
        checkAccessIA = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 126, language);
        checkStatusTriggered = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 127, language);
        checkStatusNotTriggered = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 128, language);
                
        SetReportParameters(checkSeverityHard, checkSeveritySoft, checkAccessFirm, checkAccessIA, checkStatusTriggered, checkStatusNotTriggered);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 131);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 134, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 135, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values (same as for the English report)
        SetReportParameters(checkSeverityHard, checkSeveritySoft, checkAccessFirm, checkAccessIA, checkStatusTriggered, checkStatusNotTriggered);
        
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