//USEUNIT Common_functions
//USEUNIT CR1485_133_Common_functions
//USEUNIT Global_variables


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_133_Rel_ParamDef()
{
    Log.Message("Pré-requis, dossier C:\\CroesusWeb : CR1485_PreparationBD_Misc");
    Log.Message("JIRA CROES-9337");
    Log.Message("Bug JIRA QAV-727 : GP1859 / Ajouter un fichier : Erreur de connexion (Impact aussi sur Autres rapports qui contiennent un document externe)");
    
    try {
        reportName = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 2, language);
        relationshipName = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 5);
        
        
        //Activate Prefs
        ActivatePrefs();
        
        //Login and goto Relationships module
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Select the relationship
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 7);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        
        //Default parameters
        reportLanguage = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 10, language);
        SetReportsOptions(null, null, null, reportLanguage);
        
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
        
        
        //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
        reportFileName = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 13);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        
        //Default parameters
        reportLanguage = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 16, language);
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
