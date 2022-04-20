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

function CR1485_081_Mod_DateDef_AllSev_AllStat_AllAcc()
{
    Log.Message("Jira BNC-1427 / CROES-8013 / CROES-8755");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 2, language);
        modelName = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 140);
        
        
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
        reportFileName = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 142);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values
        destination = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 145, language);
        sortBy = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 146, language);
        currency = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 147, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 148, language);
        checkAddBranchAddress = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 149, language);
        checkGroupInTheSameReport = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 150, language);
        checkConsolidatePositions = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 151, language);
        checkGroupUnderlyingClients = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 152, language);
        checkIncludeMessage = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 153, language);
        message = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 154, language);
        
        SetReportsOptions(destination, sortBy, currency, reportLanguage, checkAddBranchAddress, checkGroupInTheSameReport, checkConsolidatePositions, checkGroupUnderlyingClients, checkIncludeMessage, message);
        
        //Parameters values
        checkSeverityHard = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 157, language);
        checkSeveritySoft = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 158, language);
        checkAccessFirm = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 159, language);
        checkAccessIA = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 160, language);
        checkStatusTriggered = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 161, language);
        checkStatusNotTriggered = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 162, language);
                
        SetReportParameters(checkSeverityHard, checkSeveritySoft, checkAccessFirm, checkAccessIA, checkStatusTriggered, checkStatusNotTriggered);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 165);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Reports options values (Other options are the same as for the English report)
        currency = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 168, language);
        reportLanguage = GetData(filePath_ReportsCR1485, "081_RESTRICTION_CRITERIA", 169, language);
        
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