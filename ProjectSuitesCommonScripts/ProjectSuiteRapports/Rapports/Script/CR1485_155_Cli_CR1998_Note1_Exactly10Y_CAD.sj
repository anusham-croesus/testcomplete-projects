//USEUNIT CR1485_155_Common_function


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Alhassane
*/

function CR1485_155_Cli_CR1998_Note1_Exactly10Y_CAD()
{
   
    
    
    try {
            
           /****************************************************Variables******************************************************/                     
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");   
           
           var clientNUM800040             = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "CLIENT800040", language+client);
           var reportName                  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "REPORTNAME", language+client);
           var rptFileName_Note1_ExT10Y    = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "REPORTFILLENAME_NOTE1_EXACTLY10Y", language+client);
           var startDate                   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "START_DATE", language+client);
           var endDate                     = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "END_DATE", language+client);
           
           
           //Se Connecter avec Keynej
           Log.Message("Se Connecter avec Keynej")
           Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language); 
           
           //Acceder au module Client
           Log.Message("Acceder au module Client")
           Get_ModulesBar_BtnClients().Click();
	         Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
           
           
           //Selectionner le client 800040 et cliquer sur l'icone rapport 
           Log.Message("Selectionner le client 800040 et cliquer sur l'icone rapport ");
           Search_Client(clientNUM800040)
           Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", clientNUM800040, 10, true, 30000).Click();
           Get_Toolbar_BtnReportsAndGraphs().Click();
           WaitReportsWindow();
           
           
           //Dans l'onglet rapport sauvegardeés Selectionner le rapport Steadyhand Statement dans la section rapport courrant + OK
           Log.Message("Dans l'onglet rapport sauvegardeés Selectionner le rapport Steadyhand Statement dans la section rapport courrant + OK")
           SelectFirmSavedReport(reportName);
           selectDates(startDate, endDate);
           Sys.Keys("[Tab]"); //Ajouté par Christophe (pour s'assurer de la validation de la saisie de date)
           //Get_WinReports_BtnOK().Click(); //Mise en commentaire par Christophe (car la fonction ValidateAndSaveReportAsPDF() s'occupe déjà de faire le clic sur le bouton OK de la fenêtre Rapports)
           //Get_WinReports_BtnOK().Click(); //Mise en commentaire par Christophe (car la fonction ValidateAndSaveReportAsPDF() s'occupe déjà de faire le clic sur le bouton OK de la fenêtre Rapports)
           
           //Valider et Sauvegarder le rapport
           Log.Message("Valider et Sauvegarder le rapport");
           ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + rptFileName_Note1_ExT10Y, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
           


    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}



