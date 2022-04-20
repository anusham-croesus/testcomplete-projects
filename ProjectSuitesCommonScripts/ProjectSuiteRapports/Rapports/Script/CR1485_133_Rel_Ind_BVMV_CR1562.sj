//USEUNIT Common_functions
//USEUNIT CR1485_133_Common_functions
//USEUNIT Global_variables
//USEUNIT CR1485_048_Cli_Ind_BVMV_CR1562
//USEUNIT CR1485_049_Acc_Ind_BVMV_CR1562


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Sana Ayaz
*/

function CR1485_133_Rel_Ind_BVMV_CR1562()
{
   Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\133. Rapport de gestion de portefeuille (trans. + GP + historique)\\1.1 Relations", "CR1485_133_Rel_Ind_BVMV_CR1562()");
   Log.Link("https://jira.croesus.com/browse/TCVE-24", "Lien vers la story");
        
    
    try {
//    Les variables  
        var userNameDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var passwordDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
       
        var CR1562_Relationship_Name             = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 21,language);
        var CR1562_Relationship_IACode           = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 22,language);
        var CR1562_Relationship_Language         = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 23,language);
        var CR1562_Relationship_Currency         = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 24,language);
        var CR1562_Relationship_AccountsNumbers  = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 25,language);
        var packageStartDate=GetData(filePath_ReportsCR1485, "133_trans_GL_history", 26, language);
        var packageEndDate=GetData(filePath_ReportsCR1485, "133_trans_GL_history", 27, language);
        var reportName = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 2, language);
       
        
        
        //Activate Prefs
        ActivatePrefs_CR1485_133_Rel_Ind_BVMV_CR1562();
        
        Log.Message("Mise à jour de la BD");       
        Update_Database();
        
         //Login
        Log.Message("Se connecter avec l'utilisateur DARWIC ");
        Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);
         
        //Dévalidation des rapports
        Log.Message("Dévalider les rapports");
        DevalidateReports_49();
        
        
        Get_ModulesBar_BtnRelationships().Click();
//      Création de la relation:CR1562-1

        Log.Message("Création de la relation:CR1562-1")
        CreateRelationship(CR1562_Relationship_Name, CR1562_Relationship_IACode, CR1562_Relationship_Currency, CR1562_Relationship_Language);
        
        //Associer les comptes à la relation
        var arrayOfRelationshipAccountsNumbers = CR1562_Relationship_AccountsNumbers.split("|");
        for (var i in arrayOfRelationshipAccountsNumbers)
        JoinAccountToRelationship(arrayOfRelationshipAccountsNumbers[i], CR1562_Relationship_Name);
            
       Log.Message("Sélectionner la relation : CR1562-1")
       
        //Select the relationship
        SearchRelationshipByName(CR1562_Relationship_Name);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", CR1562_Relationship_Name, 10, true, 30000).Click();
       
        //************************* Generate English report *********************
        reportFileName = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 29);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        
        Log.Message("Changement de la date de début du groupe de rapports ")
        Get_Reports_GrpReports_GrpCurrentParameters().WaitProperty("IsEnabled", true, 30000)
        SetDateInDateTimePicker(Get_Reports_GrpReports_DtpPackageStartDate(), packageStartDate);   

        Log.Message("Changement de la date de fin du groupe de rapports ")
        SetDateInDateTimePicker(Get_Reports_GrpReports_DtpPackageEndDate(), packageEndDate);   

        
       //Default parameters
        reportLanguage = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 32, language);
        SetReportsOptions(null, null, null, reportLanguage);
        Log.Message("D'aprés Alberto L'erreur est causé par RPT-465 et à partir de *90.17-36* le problème est fixé")
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
            
        
       //************************* Generate French report *********************
        if (CR1485_GENERATE_REPORTS_FOR_ONLY_ONE_LANGUAGE)
            return;
        
            
         reportFileName = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 35);
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectFirmSavedReport(reportName, true);
        
            
        Log.Message("Changement de la date de début du groupe de rapports ")
        Get_Reports_GrpReports_GrpCurrentParameters().WaitProperty("IsEnabled", true, 30000)
        SetDateInDateTimePicker(Get_Reports_GrpReports_DtpPackageStartDate(), packageStartDate);   

        Log.Message("Changement de la date de fin du groupe de rapports ")
        SetDateInDateTimePicker(Get_Reports_GrpReports_DtpPackageEndDate(), packageEndDate);   

        
         //Default parameters
        reportLanguage = GetData(filePath_ReportsCR1485, "133_trans_GL_history", 38, language);
        SetReportsOptions(null, null, null, reportLanguage);
        Log.Message("D'aprés Alberto L'erreur est causé par RPT-465 et à partir de *90.17-36* le problème est fixé")
       
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH);
             
            
        }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
//    Initialisation de la bd  
       DeleteRelationship(CR1562_Relationship_Name);
        Terminate_CroesusProcess();
    }
    
}

function ActivatePrefs_CR1485_133_Rel_Ind_BVMV_CR1562()
{
   
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_BVMV_IND", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_LOT_DEFAULT_PRICE", "NO", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_USE_DEFAULT_VALUES", "NO", vServerReportsCR1485);
       
        
//      Redémarrer les services  
        Log.Message("Redémarrage des services")
        RestartServices(vServerReportsCR1485);
}

