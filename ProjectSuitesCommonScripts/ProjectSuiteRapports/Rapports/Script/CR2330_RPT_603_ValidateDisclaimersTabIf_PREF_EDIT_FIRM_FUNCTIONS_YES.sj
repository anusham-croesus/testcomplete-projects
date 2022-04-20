//USEUNIT Common_Get_functions
//USEUNIT CR2330_Common

/**
    Description : Valider que l'onglet "Avis et notes", ''Disclaimers'' s'affiche VIA 'Edit' si PREF_EDIT_FIRM_FUNCTIONS=YES
    
    Analyste d'assurance qualité : Carole T.
    Analyste d'automatisation : Amine A.
    version: 90.15.86
    Date: 2/17/2020
*/

function CR2330_RPT_603_ValidateDisclaimersTabIf_PREF_EDIT_FIRM_FUNCTIONS_YES()
{
    Log.Link("https://jira.croesus.com/browse/RPT-603");  
       
    try {        
            var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
            var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
                
            var nomRapport = GetData(filePath_ReportsCR1485, "Anomalies", 9, language);
            var waitTime = 10000;
            
            //Se connecter avec l'utilisateur GP1859 
            Login(vServerReportsCR1485, userNameGP1859, passwordGP1859, language);
            
            //Ouvrir la fenêtre de configuration 
            Get_MenuBar_Tools().OpenMenu();
            Delay(500);
            Get_MenuBar_Tools_Configurations().Click();
            Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, waitTime);
            
            Get_WinConfigurations_TvwTreeview_LlbReports().Click();
            WaitObject(Get_WinConfigurations(), "Uid", "ListView_bc90");
            Get_WinConfigurations_LvwListView_ReportConfiguration().Click();
            Get_WinConfigurations_ToolBar_BtnEdit().Click();
            Get_WinReportConfiguration().WaitProperty("VisibleOnScreen", true, waitTime);
            
            //Selectionner le rapport 'Évaluation portefeuille (simple)'
            SelectOneReport(nomRapport, userNameGP1859);           
            WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
            
            //Valider que l'onglet 'Disclaimers' existe et visible
            aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabDisclaimers(), "Exists", cmpEqual,true);
            aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabDisclaimers(), "IsVisible", cmpEqual,true);
            aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabDisclaimers(), "VisibleOnScreen", cmpEqual,true);
            
            //Fermer les fenêtres
            Get_WinReportConfigurationCopy_BtnCancel().Click();
            Get_WinReportConfiguration_BtnClose().Click();
        }
    catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
            Terminate_CroesusProcess();
    }   
}