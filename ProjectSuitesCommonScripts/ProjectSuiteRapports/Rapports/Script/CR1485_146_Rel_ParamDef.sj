//USEUNIT CR1485_Common_functions
//USEUNIT DBA



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_146_Rel_ParamDef()
{
    Log.Message("JIRA CROES-10317");
    Log.Message("Bug JIRA QAV-727 : GP1859 / Ajouter un fichier : Erreur de connexion (Impact aussi sur Autres rapports qui contiennent un document externe)");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "146_base_evol_act", 2, language);
        relationshipName = GetData(filePath_ReportsCR1485, "146_base_evol_act", 5);
        
        
        //Rouler le script : ScriptFlottantFBN_CR828.sql
        ExecuteSQLFile_ThroughISQL(folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\ScriptFlottantFBN_CR828.sql", vServerReportsCR1485);
        
        //Login, goto Relationships module and select Relationship
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        SelectRelationships(relationshipName);
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "146_base_evol_act", 7);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        
        //Default parameters
        reportLanguage = GetData(filePath_ReportsCR1485, "146_base_evol_act", 10, language);
        SetReportsOptions(null, null, null, reportLanguage);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "146_base_evol_act", 13);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        
        //Default parameters
        reportLanguage = GetData(filePath_ReportsCR1485, "146_base_evol_act", 16, language);
        SetReportsOptions(null, null, null, reportLanguage);
        
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
