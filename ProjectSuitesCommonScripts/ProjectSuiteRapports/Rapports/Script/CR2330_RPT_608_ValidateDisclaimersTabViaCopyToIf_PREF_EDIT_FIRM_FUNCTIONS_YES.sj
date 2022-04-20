//USEUNIT Common_Get_functions
//USEUNIT CR2330_Common

/**
    Description : Valider que l'onglet "Avis et notes", ''Disclaimers'' s'affiche VIA 'Copy To' si PREF_EDIT_FIRM_FUNCTIONS=YES
    
    Analyste d'assurance qualité : Carole T.
    Analyste d'automatisation : Amine A.
    version: 90.15.86
    Date: 2/17/2020
*/

function CR2330_RPT_608_ValidateDisclaimersTabViaCopyToIf_PREF_EDIT_FIRM_FUNCTIONS_YES()
{
    Log.Link("https://jira.croesus.com/browse/RPT-608");  
       
    try {
        
            //Se connecter avec l'utilisateur KEYNEJ
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
               
            //Login 
            Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
                
            var nomRapport = GetData(filePath_ReportsCR1485, "Anomalies", 9, language);
            var waitTime = 10000;
            
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
            SelectOneReport(nomRapport, userNameKEYNEJ);
            
            Get_WinCopyReport().WaitProperty("VisibleOnScreen", true, waitTime);
            Get_WinCopyReport_CmbUser().set_IsChecked(true);
            Delay(500);
            Get_WinCopyReport_BtnOK().Click();
           
            //Valider que l'onglet 'Disclaimers' existe et visible
            aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabDisclaimers(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabDisclaimers(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabDisclaimers(), "VisibleOnScreen", cmpEqual, true);
            
            Get_WinReportConfigurationCopy_TabDisclaimers().Click();
            WaitObject(Get_WinReportConfigurationCopy(), "Uid", "TextBox_990e", 30000)
                        
            //Valider que le champ texte 'Avis de non-responsabilité' existe et n'est pas vide
            aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabDisclaimers_TextBoxReportNotes(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabDisclaimers_TextBoxReportNotes(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabDisclaimers_TextBoxReportNotes(), "wText", cmpNotEqual, "");
            
              
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