//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2314_TCVE699_Currency_DetailedPortfolioSummaryReport_PrefYesNo
//USEUNIT CR1485_150_Common_functions



/**
    Description : valider que lorsque la PREF_REPORT_HIDE_CURRENCY=YES, la devise ne sera pas indiquée dans le titre du
                  rapport si la devise du rapport est la même que la devise de la firme.  
                  et que lorsque la PREF est à NO, la devise sera toujours indiquée.
    
    Analyste d'assurance qualité : Marina Gassin.
    Analyste d'automatisation : Alhassane Diallo.
    version: 90.15.2020.3-37
    Date: 19/03/2020
*/

function CR2314_TCVE701_PREF_REPORT_HIDE_CURRENCY_AND_PREF_PORT_SUMMARY_CURRENCY_BOTTOM()
{
    Log.Link("https://jira.croesus.com/browse/TCVE-701");  
       
    try {        
            
           //Mettre les pref suivates aux valeurs demandées
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_PORT_SUMMARY_CURRENCY_BOTTOM", "YES", vServerReportsCR1485);
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SUMMARY_DETAIL_BY_ACCOUNT", "YES", vServerReportsCR1485);
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_BOX_ON_PF_SUMMARY_DETAILED", "YES", vServerReportsCR1485);
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_SUMMARY_PORT_DETAIL", "YES", vServerReportsCR1485);
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_ALTT_SUM_PORT_DETAIL", "YES", vServerReportsCR1485);
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_HIDE_CURRENCY", "YES", vServerReportsCR1485);
            
           //Redemarrer les service
           RestartServices(vServerReportsCR1485);
             
           /****************************************************Variables******************************************************/                     
           var passwordCOPERN       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
           var userNameCOPERN       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "COPERN", "username");
             
           var client800228                  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "Client800228", language+client);
           var reportDetailledPortefolio     = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportDetailledPortefolio", language+client);
           var reportDetailledAlternateTheme = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportDetailledAlternateTheme", language+client);
           var reportDistributionbyMaturity  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportDistributionbyMaturity", language+client);
       
           
           
           var reportFileName701_1   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportFileName701_1", language+client);
           var reportFileName701_2   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportFileName701_2", language+client);
           var reportFileName701_3   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportFileName701_3", language+client);
           var reportFileName701_4   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2314", "ReportFileName701_4", language+client);
           
//Étape 1           
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
           ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName701_1, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
           Terminate_CroesusProcess();
           
//Étape2
           
           
            //Mettre la PREF_PORT_SUMMARY_CURRENCY_BOTTOM a NO
            Log.Message("Mettre la PREF_PORT_SUMMARY_CURRENCY_BOTTOM = NO");
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
            generateRapport(client800228, reportDetailledAlternateTheme,false);
            ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName701_2, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
           
//Étape3
           
          
           
            //selectionner le client 800228 et generer le Rapport Sommaire du portefeuilles detaillés
            Log.Message("selectionner le client 800228 et generer le Rapport Sommaire du portefeuilles detaillés");
            generateRapport(client800228, reportDetailledPortefolio,true);
            ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName701_3, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
            Terminate_CroesusProcess();
//Étape4  

           //Mettre la PREF_PORT_SUMMARY_CURRENCY_BOTTOM a NO et la PREF_REPORT_HIDE_CURRENCY a NO
            Log.Message("Mettre la PREF_PORT_SUMMARY_CURRENCY_BOTTOM a NO et la PREF_REPORT_HIDE_CURRENCY a NO");
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_PORT_SUMMARY_CURRENCY_BOTTOM", "YES", vServerReportsCR1485);
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_HIDE_CURRENCY", "NO", vServerReportsCR1485);
            
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
            Log.Message("selectionner le client 800228 et generer le Rapport Distribution par écheance");
            //generateRapport(client800228, reportDistributionbyMaturity,false);
            Search_Client(client800228)
            Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", client800228, 10, true, 30000).Click();
            
            
            //Cliquer sur le bouton Raport et Graphique
            Log.Message("Cliquer sur le bouton Raport et Graphique");
            Get_Toolbar_BtnReportsAndGraphs().Click();
            WaitReportsWindow();
            
            //Selectionner le Rapport Distribution par écheance
            Log.Message("Selectionner le Rapport Distribution par écheance");
            SelectReports(reportDistributionbyMaturity);      
            ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName701_4, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
           
        }
    catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
            Terminate_CroesusProcess();
    }   
}



