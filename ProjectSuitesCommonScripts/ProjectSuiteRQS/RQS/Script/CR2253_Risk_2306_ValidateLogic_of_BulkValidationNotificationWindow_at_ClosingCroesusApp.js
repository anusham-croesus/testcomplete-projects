//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions

/*
     Description : 
     
     Valider la logique de la fenêtre Bulk validation notification &a la fermeture de l'application Croesus
      
      https://jira.croesus.com/browse/RISK-2306
      
      Analyste d'assurance qualité: Taous A.
      Analyste d'automatisation: Alhassane D. 
      
      Version de scriptage : ref90.17-53 */ 

function CR2253_Risk_2306_ValidateLogic_of_BulkValidationNotificationWindow_at_ClosingCroesusApp(){

            var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
            var userDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
            var waitTime   = 5000;
            var logEtape1, logEtape2, logEtape3,logEtape4, logEtape5, logEtape6, logRetourEtatInitial;
            
      try {
              
               Activate_Inactivate_PrefFirm("FIRM_1", "PREF_BULK_VALIDATION_REMINDER", 0, vServerRQS); 
               RestartServices(vServerRQS)
                          
             
               var brancheBDLaval      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_BrancheBDLaval", language + client);
               var brancheACToronto    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_BrancheACToronto", language + client);
               var brancheNameToronto  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_BrancheNameToronto", language + client);
               
               var transactionValidationStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_TransactionValidationStatus", language + client);
               var excludingOperator           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_ExcludingOperator", language + client);
               
               var spotCheckValue      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2306_SpotCheckValue", language + client);
               var bulkValidationValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_BulkValidationValue", language + client);
               var manualAlertValue    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_ManualAlertValue", language + client);
               var noteText            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "NOTETEXT", language + client);
               
               
               var confirmationMessage = "Some trades from the following branch(es) have not been bulk validated:\r\n• BD (Laval)\r\n\r\nDo you want to continue with the validation?"
               if (language == "french")
                        confirmationMessage = "Certaines transactions des succursales suivantes n’ont pas été validées en lot :\r\n• BD (Laval)\r\n\r\nVoulez-vous continuer la validation ?"
 
                        
                        
               Log.PopLogFolder();
               logEtape1 = Log.AppendFolder("Étape 1 : Se connecter avec KEYNEJ, Séléctionner la branche Toronto ");      
                   
                //Se connecter avec KEYNEJ
                Log.Message("Se connecter avec KEYNEJ");
                Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
                
                
                //Séléctionner dans le menu Utilisateurs---->> Séléction ---> Séléctionner Toronto 
                Log.Message("Séléctionner dans le menu Utilisateurs---->> Séléction ---> Séléctionner Toronto");             
                Get_MenuBar_Users().OpenMenu();
                WaitObject(Get_CroesusApp(), "ClrClassName", "MenuItem",waitTime);
                Get_MenuBar_Users_Selection().Click();
                WaitObject(Get_CroesusApp(), "Uid", "UserMultiSelectionWindow_e5eb",waitTime);
                Get_WinUserMultiSelection_TabBranches().Click();               
                Get_WinUserMultiSelection_TabBranches_DgvBranches().Find("Value",brancheNameToronto,10).Click();
                Get_WinUserMultiSelection_BtnApply().Click();
                
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Étape 2 : Ouvrir la fênetre RQS, selectionner les transactions-->> «Review slected» --> Ajouter une Note: TORONTO puis faire une validation spotcheck"); 
                //Ouvrir la fênetre RQS, selectionner les transactions-->> «Review slected» --> Ajouter une Note: TORONTO
                Log.Message("Ouvrir la fênetre RQS, selectionner les transactions-->> «Review slected» --> Ajouter une Note: TORONTO");  

                Get_Toolbar_BtnRQS().WaitProperty("IsEnabled", true, 30000);
                 var nbTries = 0; //Par Christophe : Réessayer  au cas où le clic n'aurait pas réussi à faire afficher la fenêtre
                 do {
                     Get_Toolbar_BtnRQS().Click();
                 } while((++nbTries) < 3 && !Get_WinRQS().Exists)
                    
                WaitObject(Get_CroesusApp(), "Uid", "AlertsManagementWindow_0621", waitTime);
                Get_WinRQS().Parent.Maximize();
            
                //Attendre le boutton RQS présent et actif
                WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
                Get_WinRQS_BottomSection().set_IsExpanded(false);  
                Get_WinRQS_TabTransactionBlotter_DgvTransactions().Keys("^a");
                Get_WinRQS_TabTransactionBlotter_BtnReviewSelected().Click();
                Get_WinTransactionReview_GrpNoteTextBox().Click();
                Get_WinTransactionReview_GrpNoteTextBox().SetText(noteText);
                Get_WinTransactionReview_BtnValidate().Click();
                Get_WinTransactionReview_BtnValidate().Click();
                
                
                
                 //Validation spotcheck
                 Log.Message("Cliquer sur L'oeil  pour ouvrir la fênetre RQS"); 
                 var grid  = Aliases.CroesusApp.winRQS.WPFObject("TabControl", "", 1).WPFObject("_blotterControl").WPFObject("_transactionList").WPFObject("RecordListControl", "", 1)
                 var count = grid.Items.Count;
                    for (i=0; i<count; i++){
                       aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ValidationStatus",cmpEqual,spotCheckValue)
                  }              
               
                  
                Log.PopLogFolder();
                logEtape3 = Log.AppendFolder("Étape 3 : Réduire la fenêtre RQS puis Cliquer sur File---->> Quit pour fermer l'application et validert le message dans la fenêtre Bulk validation notification ");      
                   
                 //Réduire la fenêtre RQS puis Cliquer sur File---->> Quit pour fermer l'application et validert le message dans la fenêtre Bulk validation notification
                 Log.Message("Réduire la fenêtre RQS puis Cliquer sur File-->> Quit pour fermer l'application et validert le message dans la fenêtre Bulk validation notification");     
                 DlgConfirmationWinValidation("X", confirmationMessage);   


                 
                 Log.PopLogFolder();
                 logEtape5 = Log.AppendFolder("Étape 5 : Valider que la fenêtre Bulk validation notification& Menu Current Context de RQS ");
                
                 //Fermer la fenetre RQS
                 Log.Message("Fermer la fenetre RQS");
                 Get_WinRQS().Parent.Close();
                 Get_DlgConfirmation_BtnClose().Click();
                 
                 
                
                 
                //Séléctionner dans le menu Utilisateurs---->> Firm
                Log.Message("Séléctionner dans le menu Utilisateurs---->> Firm");             
                Get_MenuBar_Users().OpenMenu();
                WaitObject(Get_CroesusApp(), "ClrClassName", "MenuItem",waitTime);
                Get_MenuBar_Users_Firm().Click();
                
                //Ouvrir la fênetre RQS en cliquant sur l'oeil
                Log.Message("Ouvrir la fênetre RQS en cliquant sur l'oeil");
                var nbTries = 0; //Par Christophe : Réessayer  au cas où le clic n'aurait pas réussi à faire afficher la fenêtre
                do {
                    Get_Toolbar_BtnRQS().Click();
                } while((++nbTries) < 3 && !Get_WinRQS().Exists)
                WaitObject(Get_CroesusApp(), "Uid", "AlertsManagementWindow_0621", waitTime);
                Get_WinRQS().Parent.Maximize();
                
                //Choisir Toronto dans le champ Current context
                Log.Message(" Choisir Toronto dans le champ Current context");
                Get_WinRQS_BtnTreeView().Click();
                WaitObject(Get_WinRQS(), "ClrClassName", "PopupRoot",waitTime);
              
                if(Get_SubMenus().Exists){
                        Get_SubMenus().Find("Value",brancheNameToronto,10).Click();
                }
                WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTime);
               
                 
               // fermer l'application avec ALT + F4 puis valider le message dans la fenêtre Bulk validation notification
               Log.Message("fermer l'application avec ALT + F4 puis valider le message dans la fenêtre Bulk validation notification"); 
               DlgConfirmationWinValidation("Alt_F4", confirmationMessage);

               //-----------------------Ajouté par A.A-----------------------------------
               //Supprimer tous les spot-check de Toronto
               
                Get_WinRQS_BottomSection_TabNotesAndAlerts().Click(); 
                Get_WinRQS_BottomSection_TabNotesAndAlerts().WaitProperty("IsSelected", true, 5000)
                Get_WinRQS_BottomSection_TabNotesAndAlerts_BtnDelete().Click();
                WaitObject(Get_CroesusApp(), "Uid", "DeletionWindow_5967", 5000);
                if(Get_WinDeletion_BtnDeleteForManyTransactions().Exists)           
                    Get_WinDeletion_BtnDeleteForManyTransactions().Click();                
                //------------------------------------------------------------------------          
               
                Log.PopLogFolder();
                logEtape6 = Log.AppendFolder("Étape 6 :  Fermer la fenêtre RQS Cliquer sur File---->> Qit la fenetre de notification S'affiche Cliquer sur le bouton Quitter");      
                //Fermer la fenetre RQS
                Log.Message(" Fermer la fenetre RQS");
                Get_WinRQS().Parent.Close();
                if (Get_DlgConfirmation().Exists){                   
                    Get_DlgConfirmation_BtnOk().Click();
                
                 }
       
               Get_MenuBar_File().Click();
               Get_MenuBar_File_Close().Click()
               Get_DlgConfirmation_BtnYes().Click();

            }
            catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {
                
              //Remettre la pref a sa valeur initiale null
              Activate_Inactivate_PrefFirm("FIRM_1", "PREF_BULK_VALIDATION_REMINDER", "", vServerRQS); 
              RestartServices(vServerRQS);
              //Fermer Croesus
              Terminate_CroesusProcess();
            }
}
function DlgConfirmationWinValidation(choix, message){
    
            switch(choix){
                case "X":
                {                 
                    Log.Message("Fermeture de la fenêtre RQS par X");  
                    Get_WinRQS().Parent.Minimize();
                    Get_MenuBar_File().Click();
                    Get_MenuBar_File_Close().Click()                
                    break;
                }
                case "Alt_F4":
                {  
                    Log.Message("Fermeture de la fenêtre RQS par Alt_F4");  
                    Get_WinRQS().Parent.Keys("~[F4]");               
                    break;
                }
               
            } 
            if (Get_DlgConfirmation().Exists){                   
                aqObject.CheckProperty(Get_DlgConfirmation().CommentTag, "OleValue", cmpEqual, message);
                
            }               
            Get_DlgConfirmation_BtnContinue().Click();          
}