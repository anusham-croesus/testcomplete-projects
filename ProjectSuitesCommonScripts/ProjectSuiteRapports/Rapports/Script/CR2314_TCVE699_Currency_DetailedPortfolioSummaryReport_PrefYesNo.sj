//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1485_150_Common_functions


/**
    Description : Valider que la Devise s'affiche  dans le bas du rapport Sommaire du portefeuille détaillé quand pref = YE
                  Valider que la Devise ne s'affiche  dans le bas du rapport Sommaire du portefeuille détaillé quand pref = NO
    
    Analyste d'assurance qualité : Marina Gassin.
    Analyste d'automatisation : Alhassane Diallo.
    version: 90.15.2020.3-37
    Date: 19/03/2020
*/

function CR2314_TCVE699_Currency_DetailedPortfolioSummaryReport_PrefYesNo()
{
    Log.Link("https://jira.croesus.com/browse/TCVE-699");  
       
    try {        
            
           //Mettre les pref suivates aux valeurs demandées
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_PORT_SUMMARY_CURRENCY_BOTTOM", "YES", vServerReportsCR1485);
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SUMMARY_DETAIL_BY_ACCOUNT", "YES", vServerReportsCR1485);
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_BOX_ON_PF_SUMMARY_DETAILED", "YES", vServerReportsCR1485);
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_PORT_DETAIL", "YES", vServerReportsCR1485);
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_ALTT_SUM_PORT_DETAIL", "YES", vServerReportsCR1485);
            
           //Redemarrer les service
           RestartServices(vServerReportsCR1485);
             
           /****************************************************Variables******************************************************/                     
           var passwordCOPERN       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
           var userNameCOPERN       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "COPERN", "username");
             
           var client800228                  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "Client800228", language+client);
           var reportDetailledPortefolio     = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportDetailledPortefolio", language+client);
           var reportDetailledAlternateTheme = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportDetailledAlternateTheme", language+client);
            
           
           var reportFileName    = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportFileName", language+client);
           var reportFileName2   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportFileName2", language+client);
           var reportFileName3   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportFileName3", language+client);
           var reportFileName4   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportFileName4", language+client);

       
//Étape 1           
           //Se Connecter avec Copern
           Log.Message("Se Connecter avec Copern")
           Login(vServerReportsCR1485, userNameCOPERN, passwordCOPERN, language); 
           

//Étape2
           
           //Acceder aumodule client
           Log.Message("Acceder aumodule client")
           Get_ModulesBar_BtnClients().Click();
	         Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
           
           
           //selectionner le client 800228 et generer le Rapport Sommaire du portefeuilles detaillés
           Log.Message("selectionner le client 800228 et generer le Rapport Sommaire du portefeuilles detaillés");
           generateRapport(client800228, reportDetailledPortefolio,false);
           ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
        
           
//Étape3

           
           //selectionner le client 800228 et generer le Rapport Sommaire du portefeuilles detaillés
           Log.Message("selectionner le client 800228 et generer le Rapport Sommaire du portefeuille (détaillé - thème alternatif");
           generateRapport(client800228, reportDetailledAlternateTheme,true);
           ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName2, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
           Terminate_CroesusProcess();
           
           
//Étape4

             
            //Mettre la PREF_PORT_SUMMARY_CURRENCY_BOTTOM a NO
            Log.Message("Mettre la PREF_PORT_SUMMARY_CURRENCY_BOTTOM=NO");
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_PORT_SUMMARY_CURRENCY_BOTTOM", "NO", vServerReportsCR1485);

           
            //Redemarrer les service
            RestartServices(vServerReportsCR1485);
            
            //Se Connecter avec Copern
            Log.Message("Se Connecter avec Copern")
            Login(vServerReportsCR1485, userNameCOPERN, passwordCOPERN, language);
            
            
           //Acceder aumodule client
           Log.Message("Acceder aumodule client")
           Get_ModulesBar_BtnClients().Click();
	         Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
           
           //selectionner le client 800228 et generer le Rapport Sommaire du portefeuilles detaillés
           Log.Message("selectionner le client 800228 et generer le Rapport Sommaire du portefeuilles detaillés");
           generateRapport(client800228, reportDetailledPortefolio,false);
           ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName3, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
//Étape5  
   
             
            //selectionner le client 800228 et generer le Rapport Sommaire du portefeuilles detaillés
           Log.Message("selectionner le client 800228 et generer le Rapport Sommaire du portefeuille (détaillé - thème alternatif");
           generateRapport(client800228, reportDetailledAlternateTheme,true);      
           ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName4, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
           
        }
    catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
            Terminate_CroesusProcess();
    }   
}



function generateRapport(clientNumber, rapportName,value ){
  


           // selectionner le client 800228 et cliquer sur Rapport
           Log.Message("selectionner le client 800228 et cliquer sur l'icônne Rapport")
           Search_Client(clientNumber)
           Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNumber, 10, true, 30000).Click();
           
           //Cliquer sur le bouton Raport et Graphique
           Log.Message("Cliquer sur le bouton Raport et Graphique");
           Get_Toolbar_BtnReportsAndGraphs().Click();
           WaitReportsWindow();
           
           
           //Selectionner le rapport portefeuilles detaillés selon le théme defini
           SelectReports(rapportName);
           
           
           //Ouvrir la fenêtre Paramêtre
           Log.Message("Ouvrir la fenêtre Paramêtre");
           //Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
           Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true, 30000);
            while (! Get_WinParameters().Exists){
           Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
           WaitReportParametersWindow();
           }
            //Cocher ou decocher la case à cocher Un rapprt par compte selon ce qui est demandé dans le cas
           Log.Message("Cocher ou decocher la case à cocher Un rapprt par compte selon ce qui est demandé dans le cas ");
           Get_WinParameters_ChkOneReportPerAccount().set_IsChecked(value);
           Get_WinParameters_BtnOK().Click();
//           Get_WinReports_BtnOK().Click();
}
