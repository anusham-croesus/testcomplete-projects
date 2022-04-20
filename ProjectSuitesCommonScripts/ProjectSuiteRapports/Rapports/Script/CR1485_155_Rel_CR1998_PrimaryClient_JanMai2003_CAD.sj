//USEUNIT CR1485_155_Common_function



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Alhassane
*/

function CR1485_155_Rel_CR1998_PrimaryClient_JanMai2003_CAD()
{
   
    
    
    try {
            
           /****************************************************Variables******************************************************/                     
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");   
           
           var relSTEADYHAND_PCLIENT              = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "REL_NAME_PRIMARYCLIEN", language+client);
           var reportName_PrimaryClien            = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "REPORTNAME", language+client);
           var reportFileName_155_PrimaryClien    = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "REPORT_FILNAME_PRIMARYCLIEN", language+client);
           var rel_Num_PrimaryClien               = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "REL_NUM_PRIMARYCLIENT", language+client);
           
           
           var startDate1                         = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "START_DATE_1", language+client);
           var endDate1                           = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "END_DATE_1", language+client);
        
           
           //Se Connecter avec Keynej
           Log.Message("Se Connecter avec Keynej")
           Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language); 
           
           //Acceder au module Relation 
           Log.Message("Acceder au module Relation")
           Get_ModulesBar_BtnRelationships().Click();
	         Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
           
           
           //Selectionner la relation STEADYHAND_PCLIENT et cliquer sur l'icone rapport 
           Log.Message("Selectionner la relation STEADYHAND_PCLIENT et cliquer sur l'icone rapport ");
           SearchRelationshipByName(relSTEADYHAND_PCLIENT);  
           Get_RelationshipsClientsAccountsGrid().FindChild("Text", relSTEADYHAND_PCLIENT, 100).Click();
           Get_Toolbar_BtnReportsAndGraphs().Click();
           WaitReportsWindow();
           

           
           
           //Dans l'onglet rapport sauvegardeés Selectionner le rapport Steadyhand Statement dans la section rapport courrant + OK
           Log.Message("Dans l'onglet rapport sauvegardeés Selectionner le rapport Steadyhand Statement dans la section rapport courrant + OK")
           SelectFirmSavedReport(reportName_PrimaryClien);
           selectDates(startDate1, endDate1);
           Sys.Keys("[Tab]"); //Ajouté par Christophe (pour s'assurer de la validation de la saisie de date)
           //Get_WinReports_BtnOK().Click(); //Mise en commentaire par Christophe (car la fonction ValidateAndSaveReportAsPDF() s'occupe déjà de faire le clic sur le bouton OK de la fenêtre Rapports)
           //Get_WinReports_BtnOK().Click(); //Mise en commentaire par Christophe (car la fonction ValidateAndSaveReportAsPDF() s'occupe déjà de faire le clic sur le bouton OK de la fenêtre Rapports)
           
           //Valider et Sauvegarder le rapport
           Log.Message("Valider et Sauvegarder le rapport");
           ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName_155_PrimaryClien, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
           


    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}


