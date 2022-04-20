//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1827_RPT_3438
//USEUNIT CR1485_048_Common_functions
//USEUNIT CR1485_Common_functions


/**
    
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Sana Ayaz
*/

function CR1827_RPT_3448()
{
       
    try {
       Log.Link("https://jira.croesus.com/browse/TCVE-2509", "Lien vers la story");
       Log.Link("https://jira.croesus.com/browse/RPT-3448", "Lien vers le cas de test");
       
       //Les préconditions
//       UpdateDatabase()

        //Se connecter avec l'utilisateur GP1859
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
       
        var reportNameRPT3448     =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportNameRPT3448", language+client);
        var dateOfDetentionStep2  =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "dateOfDetentionStep2", language+client);  
        var reportLanguageStep2   =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportLanguageStep2", language+client); 
        var reportFileNameStep2RPT3448=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportFileNameStep2RPT3448", language+client);
        var reportLanguageStep3   =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportLanguageStep3", language+client); 
        var reportFileNameStep3RPT3448   =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportFileNameStep3RPT3448", language+client);
        var dateOfDetentionStep4  =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "dateOfDetentionStep4", language+client);
        var reportFileNameStep4RPT3448   =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportFileNameStep4RPT3448", language+client);
        var reportFileNameStep5RPT3448   =ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1827", "reportFileNameStep5RPT3448", language+client);
  
  
      
        
/************************************Étape 1************************************************************************/     
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: - - Se loguer avec l'user GP1859- Clients / Rapports / Déplacer vers la droite le rapport *NCD – Particulier – Valeurs élevées*");
         
        //Login and goto Clients module
        Login(vServerReportsCR1485, userNameGP1859, passwordGP1859, language);
        Get_ModulesBar_BtnClients().Click();
	      Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(reportNameRPT3448);
/************************************Étape 2************************************************************************/     
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2:- Paramètres:- *Date de détention*: 31 décembre 2009- *Langue*: Français-  Cliquer sur OK pour produire le rapport *Note:* La devise est toujours USD ");
 
        //Changer la date sur la fenêtre des paramétres
        SetReportParametersDateOfDetention(dateOfDetentionStep2);
        SetReportsOptions(null, null, null, reportLanguageStep2, null, null, null, null, null, null, true);
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileNameStep2RPT3448, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
        
 /************************************Étape 3************************************************************************/     
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3:-Refaire l'étape 2, pour produire le rapport en *English*");
          //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(reportNameRPT3448);
        //Changer la date sur la fenêtre des paramétres
        SetReportParametersDateOfDetention(dateOfDetentionStep2);
        SetReportsOptions(null, null, null, reportLanguageStep3, null, null, null, null, null, null, true);
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileNameStep3RPT3448, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
        
/************************************Étape 4************************************************************************/     
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4:- Avec le même user- Clients / Rapports / Déplacer vers la droite le rapport *NCD – Particulier – Valeurs élevées*- Paramètres:- *Date de détention*: 31 décembre 2005*Langue*: Français-Cliquer sur OK pour produire le rapport");
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(reportNameRPT3448);
        //Changer la date sur la fenêtre des paramétres
        SetReportParametersDateOfDetention(dateOfDetentionStep4);
        SetReportsOptions(null, null, null, reportLanguageStep2, null, null, null, null, null, null, true);
          //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileNameStep4RPT3448, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
       
        
/************************************Étape 5************************************************************************/     
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5:- Refaire l'étape 4, pour produire le rapport en *English*");
         //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //Select reports
        SelectReports(reportNameRPT3448);
        //Changer la date sur la fenêtre des paramétres
        SetReportParametersDateOfDetention(dateOfDetentionStep4);
        SetReportsOptions(null, null, null, reportLanguageStep3, null, null, null, null, null, null, true);
          //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileNameStep5RPT3448, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
       
        
        
                
         }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}