//USEUNIT CR1485_155_Common_function

/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Alhassane
*/

function CR1485_155_CRSTEADYHANDNOM1__STEADYHANDP3_STEADYHAND_PCLIE()
{
   
    
    
    try {
            
            
           /****************************************************Variables******************************************************/                     
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");   
           
           var relSTEADYHAND_NOM1     = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "RELATIONNAME", language+client);
           var relSTEADYHAND_PCLIENT  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "REL_NAME_PRIMARYCLIEN", language+client);
           var relSTEADYHAND_P3       = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "STEADYHAND_P3", language+client);
           

           var startDate             = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "START_DATE_3", language+client);
           var endDate               = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "END_DATE_3", language+client);
           var destination           = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "DESTINATION", language+client);
           var reportName            = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "REPORTNAME", language+client);
           var reportFileName_155    = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "REPORTFILNAME", language+client);
           var rel_Num               = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "RELATION_NUM", language+client);
           
           
           
           var reportFile_NOM_1to5   = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "reportFile_NOM_1to5", language+client);
           var reportFile_0012       = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "reportFile_0012", language+client);
           var reportFile_0011       = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1485_155_Rel_CR1998", "reportFile_0011", language+client);
           
//           var  reportFile_NOM_1to5  = "Statement for RELATION STEADYHAND NOM1 NOM2 NOM3 NOM4 NOM5(00010) for October 31, 2009_EN"
//           var  reportFile_0012  = "Statement for STEADYHAND_PCLIENT(00012) for October 31, 2009_EN"
//           var  reportFile_0011  = "Statement for Relation Steadyhand Account Statement (Part 3)(00011) for October 31, 2009_EN"
//           
           //Se Connecter avec Keynej
           Log.Message("Se Connecter avec Keynej")
           Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language); 
           
           //Acceder au module Relation 
           Log.Message("Acceder au module Relation")
           Get_ModulesBar_BtnRelationships().Click();
	         Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
           WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071",1000);
           
           //Selectionner les relation STEADYHAND_NOM1, STEADYHAND P3 et STEADYHAND_PCLIENT puis cliquer sur l'icone rapport 
           Log.Message("Selectionner les relation STEADYHAND_NOM1, STEADYHAND P3 et STEADYHAND_PCLIENT puis cliquer sur l'icone rapport ");
              
           SearchRelationshipByName(relSTEADYHAND_P3)                
           Get_RelationshipsClientsAccountsGrid().FindChild("Text", relSTEADYHAND_P3, 10).Click(-1, -1, skCtrl);
           Delay(1000)
           Get_RelationshipsClientsAccountsGrid().FindChild("Text", relSTEADYHAND_PCLIENT, 10).Click(-1, -1, skCtrl);
           Delay(1000)
           Get_RelationshipsClientsAccountsGrid().FindChild("Text", relSTEADYHAND_NOM1, 100).Click(-1, -1, skCtrl);

           Get_Toolbar_BtnReportsAndGraphs().Click();
           WaitReportsWindow();
           
           
           //Dans l'onglet rapport sauvegardeés Selectionner le rapport Steadyhand Statement dans la section rapport courrant 
           Log.Message("Dans l'onglet rapport sauvegardeés Selectionner le rapport Steadyhand Statement dans la section rapport courrant ")
           SelectFirmSavedReport(reportName);
           
          
           //Selectionner la date de debut et de fin
           Log.Message("Selectionner la date de debut et de fin");
           selectDates(startDate, endDate);
           
           //Selectionner les differentes  options du rapport puis cliquer sur OK
           Log.Message("//Selectionner les differentes  options du rapport puis cliquer sur OK");
           SelectComboBoxItem(Get_WinReports_GrpOptions_CmbDestination(), destination);
           Get_WinReports_GrpOptions_ChkArchiveReports().Click();
           Get_WinReports_GrpOptions_ChkUsePDFFileNamingConvention().Click();
           Get_WinReports_BtnOK().Click();

           
           //Attendre l'apparution la fenetre statut d'impression  puis cliquer sur le bouton OK 
           Log.Message("Attendre l'apparution la fenetre statut d'impression  puis cliquer sur le bouton OK")
           while (!Get_DlgPrintingStatusMessageLogs().Exists){
              WaitGet_DlgPrintingStatusMessageLogs();
           }
           RestoreAutoTimeOut();
           Get_DlgPrintingStatusMessageLogs_BtnOK().Click();
           
           
           //Sélectionner la relation "STEADYHAND NOM1", cliquer sur  info puis  documents 
           Log.Message("Sélectionner la relation STEADYHAND NOM1, cliquer sur  info puis  documents ")
           SelectRelationship_And_Dowload_Rapport(relSTEADYHAND_NOM1)
           
            // Sauvegarder le rapport
           Log.Message(" Sauvegarder le rapport");
          //SaveAs_AcrobatReader_155(REPORTS_FILES_FOLDER_PATH)
           SaveAs_AcrobatReader_155(REPORTS_FILES_FOLDER_PATH + reportFile_NOM_1to5, REPORTS_FILES_BACKUP_FOLDER_PATH)
           Get_WinDetailedInfo_BtnOK().Click(); 
           
           
           
           //Sélectionner la relation "relSTEADYHAND_PCLIENT", cliquer sur  info puis  documents 
           Log.Message("Sélectionner la relation relSTEADYHAND_PCLIENT, cliquer sur  info puis  documents ")
           SelectRelationship_And_Dowload_Rapport(relSTEADYHAND_PCLIENT)
           
            // Sauvegarder le rapport
           Log.Message(" Sauvegarder le rapport");
          //SaveAs_AcrobatReader_155(REPORTS_FILES_FOLDER_PATH)
           SaveAs_AcrobatReader_155(REPORTS_FILES_FOLDER_PATH + reportFile_0012, REPORTS_FILES_BACKUP_FOLDER_PATH)
           Get_WinDetailedInfo_BtnOK().Click(); 
           
           
           //Sélectionner la relation "relSTEADYHAND_P3", cliquer sur  info puis  documents 
           Log.Message("Sélectionner la relation relSTEADYHAND_P3 cliquer sur  info puis  documents ")
           SelectRelationship_And_Dowload_Rapport(relSTEADYHAND_P3)
           
            // Sauvegarder le rapport
           Log.Message(" Sauvegarder le rapport");
           //SaveAs_AcrobatReader_155(REPORTS_FILES_FOLDER_PATH)
           SaveAs_AcrobatReader_155(REPORTS_FILES_FOLDER_PATH + reportFile_0011, REPORTS_FILES_BACKUP_FOLDER_PATH)
           Get_WinDetailedInfo_BtnOK().Click();
           


          

    }            
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}

