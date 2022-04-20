//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT PDFUtils


/**
   Copier, Imprimer, Exporter la grille CRM clients pref définie avec limitation [0]

    Auteur :               Ayaz Sana
    Cas de test :          TCVE823
    Version de scriptage:	90.15.2020.3-47
*/


function CR2345_TCVE_869_CopyPrintExporClientGridPrefDefinedwithLimitationZero() {
         
          var userNameKEYNEJ    = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ    = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          var msgWarningTCVE869  =ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2243", "msgWarningTCVE869", language+client);
       
          
          Log.Link("https://jira.croesus.com/browse/TCVE-869");
          
          try {
                Log.Message("*************************** L'étape 1 *********************************************")
                 /*Dans la table B_DEF mettre la pref PREF_MAX_ROW_EXPORTATION à 0*/
                 Log.Message("Dans la table B_DEF mettre la pref PREF_MAX_ROW_EXPORTATION à 0")
                 Activate_Inactivate_Pref(userNameKEYNEJ,"PREF_MAX_ROW_EXPORTATION","0",vServerClients); 
                
                 Log.Message("*************************** L'étape 2 *********************************************")
                 Log.Message("Redémarrer les services du vserver")
                 RestartServices(vServerClients);
                 Log.Message("*************************** L'étape 3 *********************************************")
                 Log.Message("Ouvrir Croesus Client avec KEYNEJ")
                 Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
                 Log.Message("Aller dans le pad Client")
                 Get_ModulesBar_BtnClients().Click();
                 Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
                 Log.Message("Maximiser l'application") 
                 Get_MainWindow().Maximize();
                 Log.Message("Sélectionner une ligne")
                 Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsSelected(true)
                 Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsActive(true)
                 Log.Message("*************************** L'étape 4 *********************************************")
                 Log.Message("Sélectionner le menu: Edition, Copier")
                 Get_MenuBar_Edit().OpenMenu();
                 //Les points de vérifications
                 Log.Message("Le bouton :Copier devrait être DISABLED")
                 aqObject.CheckProperty(Get_MenuBar_Edit_Copy(), "Enabled", cmpEqual, false);
                 Log.Message("*************************** L'étape 5 *********************************************")
                 Log.Message("Aller dans PAD Clients, ne rien sélectionner dans la grille")
                 Get_ModulesBar_BtnClients().Click();
                 Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
                 Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                 Log.Message("*************************** L'étape 6 *********************************************")
                 //Sélectionner le menu: Edition > Exporter vers MS Excel...
                 Log.Message("Sélectionner le menu: Edition > Exporter vers MS Excel...")
                 Get_MenuBar_Edit().OpenMenu();
                
                 //Les points de vérifications:Exporter vers MS Excel devrait être DISABLED
                 Log.Message("Exporter vers MS Excel devrait être DISABLED")
                 aqObject.CheckProperty(Get_MenuBar_Edit_ExportToFile(), "Enabled", cmpEqual, false);
                 //Dans PAD Clients, sélectionner une ligne puis Fichier, Imprimer
                 Log.Message("*************************** L'étape 7 *********************************************")
                 Log.Message("Dans PAD Clients")
                 Get_ModulesBar_BtnClients().Click();
                 Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
                 Log.Message("Sélectionner une ligne")
                 Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsSelected(true)
                 Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsActive(true)
                 Log.Message("Cliquer sur fichier")
                 Get_MenuBar_File().OpenMenu();
                 Log.Message("Le bouton imprimer est DISABLED")
                 aqObject.CheckProperty(Get_MenuBar_File_Print(), "Enabled", cmpEqual, false); 
                 Log.Message("*************************** L'étape 8 *********************************************")  
                 Log.Message("Cliquer sur Ctrl+C pour Imprimer")
                 Sys.Keys("^c");
                 Log.Message("Une boite de dialogue doit ouvrir avec un Warning qui explique que la configuration actuel ne permet pas l'exportation de donnée")
                 aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, msgWarningTCVE869);
              
                 
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                   
          }
          finally {
                   
                  
                    //Close croesus
                    Terminate_CroesusProcess();
                  
                    
          }
}
