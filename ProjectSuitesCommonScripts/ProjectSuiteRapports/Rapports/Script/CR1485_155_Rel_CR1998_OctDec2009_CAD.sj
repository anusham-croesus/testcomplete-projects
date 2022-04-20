//USEUNIT CR1485_155_Common_function


/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Alhassane
*/

function CR1485_155_Rel_CR1998_OctDec2009_CAD()
{
   
    
    
    try {
            
           /****************************************************Variables******************************************************/                     
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");   
           
           var relSTEADYHAND_NOM1    = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "RELATIONNAME", language+client);
           var reportName            = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "REPORTNAME", language+client);
           var reportFileName_155    = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "REPORTFILNAME", language+client);
           var rel_Num               = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "RELATION_NUM", language+client);
           
           
           
           
           //Se Connecter avec Keynej
           Log.Message("Se Connecter avec Keynej")
           Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language); 
           
           //Acceder au module Relation 
           Log.Message("Acceder au module Relation")
           Get_ModulesBar_BtnRelationships().Click();
	         Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
           
           
           //Selectionner la relation STEADYHAND_NOM1 et cliquer sur l'icone rapport 
           Log.Message("Selectionner la relation STEADYHAND_NOM1 et cliquer sur l'icone rapport ");
           SearchRelationshipByName(relSTEADYHAND_NOM1);  
           Get_RelationshipsClientsAccountsGrid().FindChild("Text", relSTEADYHAND_NOM1, 100).Click();
           Get_Toolbar_BtnReportsAndGraphs().Click();
           WaitReportsWindow();
           
           
           //Dans l'onglet rapport sauvegardeés Selectionner le rapport Steadyhand Statement dans la section rapport courrant + OK
           Log.Message("Dans l'onglet rapport sauvegardeés Selectionner le rapport Steadyhand Statement dans la section rapport courrant + OK")
           SelectFirmSavedReport(reportName);
           //Get_WinReports_BtnOK().Click(); //Mise en commentaire par Christophe (car la fonction ValidateAndSaveReportAsPDF() s'occupe déjà de faire le clic sur le bouton OK de la fenêtre Rapports)
           
           //Valider et Sauvegarder le rapport
           Log.Message("Valider et Sauvegarder le rapport");
           ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName_155, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
           


    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}


