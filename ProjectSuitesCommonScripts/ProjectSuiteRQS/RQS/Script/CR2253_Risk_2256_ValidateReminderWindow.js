//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions

/*
      Scenario Régression de la story: RISK-1493:F2.17 The application must generate a reminder when RQS window is closed manually if the daily 
      Transactions Blotter has not been bulk validated.
      
      https://jira.croesus.com/browse/RISK-2256
      
      Analyste d'assurance qualité: Taous A.
      Analyste d'automatisation: Amine A. 
      
      Version de scriptage : ref90.17-42 */ 

function CR2253_Risk_2256_ValidateReminderWindow (){

            var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
            var userDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
            var pswdDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
            var waitTime   = 5000;
            
      try {
              
               Activate_Inactivate_PrefFirm("FIRM_1", "PREF_BULK_VALIDATION_REMINDER", 0, vServerRQS); 
               RestartServices(vServerRQS)
                          
             
               var brancheBDLaval      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_BrancheBDLaval", language + client);
               var brancheACToronto    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_BrancheACToronto", language + client);
               var brancheNameToronto  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_BrancheNameToronto", language + client);
               
               var transactionValidationStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_TransactionValidationStatus", language + client);
               var excludingOperator           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_ExcludingOperator", language + client);
               
               var spotCheckValue      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_SpotCheckValue", language + client);
               var bulkValidationValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_BulkValidationValue", language + client);
               var manualAlertValue    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR2253", "Risk_2256_ManualAlertValue", language + client);
 
               var confirmationMessage = "Some trades from the following branch(es) have not been bulk validated:\r\n• BD (Laval)\r\n• AC (Toronto)\r\n\r\nDo you want to continue with the validation?"
               if (language == "french")
                    confirmationMessage = "Certaines transactions des succursales suivantes n’ont pas été validées en lot :\r\n• BD (Laval)\r\n• AC (Toronto)\r\n\r\nVoulez-vous continuer la validation ?"

               var attr = Log.CreateNewAttributes();
               attr.Bold = true;
         
                //Se connecter avec KEYNEJ
                Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);

                Get_MenuBar_Users().OpenMenu();
                WaitObject(Get_CroesusApp(), "ClrClassName", "MenuItem",waitTime);
                Get_MenuBar_Users_Firm().Click();
            
                // Attendre le boutton RQS présent et actif
                WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
                Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
                Get_Toolbar_BtnRQS().Click();
                WaitObject(Get_CroesusApp(), "Uid", "AlertsManagementWindow_0621", waitTime);
                Get_WinRQS().Parent.Maximize();
          
                // Attendre l'onglet 'Transactions' présent et actif dans la fenêtre RQS
                WaitObject(Get_CroesusApp(), "Uid", "TabItem_c461", waitTime);
                Get_WinRQS_TabTransactionBlotter().Click();  
                Get_WinRQS_TabTransactionBlotter().WaitProperty("IsChecked", true, waitTime);
                
                //Étape 2: Valider qu'il y'a des transactions non validées dans le blotter
                
                //Appliquer le filtre:  Transaction Validation Status = Excluding : Spot check/Bulk validation/Manual alert
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Étape 2: Valider qu'il y'a des transactions non validées dans le blotter", "", pmNormal, attr);
                
                Get_WinRQS_QuickFilterClick();
                Get_WinRQS_QuickFilter_FilterField(transactionValidationStatus).Click();
                WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
                SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), excludingOperator);

                Get_WinCreateFilter_DgvValue().Find("Value", spotCheckValue, 10).Click(-1,-1, skCtrl);
                Get_WinCreateFilter_DgvValue().Find("Value", bulkValidationValue, 10).Click(-1,-1, skCtrl);
                Get_WinCreateFilter_DgvValue().Find("Value", manualAlertValue, 10).Click(-1,-1, skCtrl);
          
                Get_WinCreateFilter_BtnApply().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);
                
                var nbrTransactions = Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Count   
               
                if (nbrTransactions > 0)
                    Log.Message("Le botter contient des transactions non validées")
                else 
                    Log.Error("Le botter ne contient aucune transaction non validée");
                 
                //Étapes 3 et 4:  fermer la fenêtre RQS de différentes façons et valider le message
                Log.Message("fermer la fenêtre RQS de différentes façons et valider le message", "", pmNormal, attr);
                DlgConfirmationWinValidation("X", confirmationMessage);
                DlgConfirmationWinValidation("Alt_F4", confirmationMessage);
                DlgConfirmationWinValidation("Close", confirmationMessage);
                DlgConfirmationWinValidation("Esc", confirmationMessage);
                Log.PopLogFolder();

                //Étape 5: Tester les deux boutons de la fenêtre d'information pour bulk validation
                Log.PopLogFolder();
                Log.Message("Étape 5: Tester les deux boutons de la fenêtre d'information pour bulk validation", "", pmNormal, attr);
                Get_WinRQS().Parent.Close();
                Get_DlgConfirmation_BtnContinue().Click(); 
                //validation: la fenetre RQS reste ouverte
                aqObject.CheckProperty(Get_WinRQS(), "Exists",          cmpEqual, true);
                aqObject.CheckProperty(Get_WinRQS(), "Isvisible",       cmpEqual, true);
                aqObject.CheckProperty(Get_WinRQS(), "VisibleOnScreen", cmpEqual, true);
                
                Get_WinRQS().Parent.Keys("~[F4]");
                Get_DlgConfirmation_BtnClose().Click();
                //validation: la fenetre RQS est fermée
                aqObject.CheckProperty(Get_WinRQS(), "Exists",          cmpEqual, false);
                
                //Étape 6 : Valider la logique du message de bulk validate avec le menu Utilisateurs
                Log.Message("Étape 6: Valider la logique du message de bulk validate avec le menu Utilisateurs", "", pmNormal, attr);              
                Get_MenuBar_Users().OpenMenu();
                WaitObject(Get_CroesusApp(), "ClrClassName", "MenuItem",waitTime);
                Get_MenuBar_Users_Selection().Click();
                WaitObject(Get_CroesusApp(), "Uid", "UserMultiSelectionWindow_e5eb",waitTime);
                Get_WinUserMultiSelection_TabBranches().Click();               
                Get_WinUserMultiSelection_TabBranches_DgvBranches().Find("Value",brancheNameToronto,10).Click();
                Get_WinUserMultiSelection_BtnApply().Click();
                
                Get_Toolbar_BtnRQS().Click();
                WaitObject(Get_CroesusApp(), "Uid", "AlertsManagementWindow_0621", waitTime);
                Get_WinRQS().Parent.Close();
                aqObject.CheckProperty(Get_DlgConfirmation().CommentTag, "OleValue", cmpContains, brancheBDLaval); 
                aqObject.CheckProperty(Get_DlgConfirmation().CommentTag, "OleValue", cmpContains, brancheACToronto); 
                Get_DlgConfirmation_BtnClose().Click();
               
                //Étape 7
                Get_MenuBar_Users().OpenMenu();
                WaitObject(Get_CroesusApp(), "ClrClassName", "MenuItem",waitTime);
                Get_MenuBar_Users_Firm().Click();
                Get_Toolbar_BtnRQS().Click();
                WaitObject(Get_CroesusApp(), "Uid", "AlertsManagementWindow_0621", waitTime);
                Log.PopLogFolder();
                
                //Étape 8: Valider le message Bulkvalidate & Current context
                Log.PopLogFolder();
                logEtape8 = Log.AppendFolder("Étape 8: Valider le message Bulkvalidate & Current context", "", pmNormal, attr);
            
                //Choisir Toronto dans le champ Current context
                Get_WinRQS_BtnTreeView().Click();
                WaitObject(Get_WinRQS(), "ClrClassName", "PopupRoot",waitTime);
              
                if(Get_SubMenus().Exists){
                        Get_SubMenus().Find("Value",brancheNameToronto,10).Click();
                }
                WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTime);
                
                //Désactiver tout les filtres appliqués s'ils existent              
                var nbActiveFilter = 0;
                if (Get_WinRQS_TabTransactionBlotter_ToggleItems().Exists)
                          nbActiveFilter = Get_WinRQS_TabTransactionBlotter_ToggleItems().DataContext.NbConditionInList;
                while(nbActiveFilter > 0){
                      if (Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(nbActiveFilter).wState)
                          Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(nbActiveFilter).set_IsChecked(false);
                      nbActiveFilter -= 1;
                }
                
                Get_WinRQS_TabTransactionBlotter_DgvTransactions().Keys("^a");
                
                //Cliquer le bouton Review Selected
                Get_WinRQS_TabTransactionBlotter_BtnReviewSelected().Click();
                WaitObject(Get_CroesusApp(), "Uid", "Window_fff1", waitTime);
                
                Get_WinTransactionReview_RdBSpotcheck().set_IsChecked(true);
                
                Get_WinTransactionReview_GrpNoteTextBox().Click();
                Get_WinTransactionReview_GrpNoteTextBox().SetText(brancheNameToronto);             
                Delay(2000)    
                Get_WinTransactionReview_BtnValidate().Click();
                      
                var numberOfTries=0;  
                while (numberOfTries < 5 && Get_WinTransactionReview().Exists){
                  Get_WinTransactionReview_BtnValidate().Click(); 
                  numberOfTries++;
                } 
                Get_WinRQS().Parent.Close();
                aqObject.CheckProperty(Get_DlgConfirmation().CommentTag, "OleValue", cmpContains, brancheBDLaval);
                aqObject.CheckProperty(Get_DlgConfirmation().CommentTag, "OleValue", cmpNotContains, brancheACToronto);
                Get_DlgConfirmation_BtnContinue().Click();
                
                //Étape 9 : supprimer les spotCheck
                Log.Message("supprimer les spotCheck")
                Get_WinRQS_BottomSection_TabNotesAndAlerts().Click(); 
                Get_WinRQS_BottomSection_TabNotesAndAlerts().WaitProperty("IsSelected", true, waitTime)
                
                Get_WinRQS_BottomSection_TabNotesAndAlerts_BtnDelete().Click();
                WaitObject(Get_CroesusApp(), "Uid", "DeletionWindow_5967", waitTime);
                Get_WinDeletion_BtnDeleteForManyTransactions().Click();
                Log.PopLogFolder();
                
                //Étape 10; Valider que le message ocntient BDLaval et ACToronto
                Log.PopLogFolder();
                logEtape10 = Log.AppendFolder("Étapes 10-12: Fermer la fenêtre RQS avec Esc, changer la Pref, se conecter avec DARWIC", "", pmNormal, attr);
                
                Get_WinRQS().Parent.Keys("[Esc]");
                
                aqObject.CheckProperty(Get_DlgConfirmation().CommentTag, "OleValue", cmpContains, brancheBDLaval); 
                aqObject.CheckProperty(Get_DlgConfirmation().CommentTag, "OleValue", cmpContains, brancheACToronto);
 
                Get_DlgConfirmation_BtnClose().Click();
                Terminate_CroesusProcess();
                
               //Étape 11: Mettre l apref PREF_BULK_VALIDATION_REMINDER = ""
                Activate_Inactivate_PrefFirm("FIRM_1", "PREF_BULK_VALIDATION_REMINDER", "", vServerRQS); 
                RestartServices(vServerRQS)
                
                //Se connecter  avec DARWIC
                Login(vServerRQS, userDARWIC, pswdDARWIC, language);
                
                //Étape 12 : Valider qu'aucun message de notification qui s'affiche même si on a des transactions non validées
                Get_Toolbar_BtnRQS().Click();
                WaitObject(Get_CroesusApp(), "Uid", "AlertsManagementWindow_0621", waitTime);
                Get_WinRQS().Parent.Close();
                
                if (!Get_DlgConfirmation().Exists)
                    Log.Checkpoint("La fenêtre de confirmation n'est pas affichée ", "", pmNormal, attr);
                else 
                    Log.Error("La fenêtre de confirmation est affichée ", "", pmNormal, attr);
                Log.PopLogFolder();
            }
            catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {
              //Fermer Croesus
              Terminate_CroesusProcess();
            }
}
 
function DlgConfirmationWinValidation(choix, message){
    
            switch(choix){
                case "X":
                {                 
                    Log.Message("Fermeture de la fenêtre RQS par X");  
                    Get_WinRQS().Parent.Close();                
                    break;
                }
                case "Alt_F4":
                {  
                    Log.Message("Fermeture de la fenêtre RQS par Alt_F4");  
                    Get_WinRQS().Parent.Keys("~[F4]");               
                    break;
                }
                case "Close":
                { 
                    Log.Message("Fermeture de la fenêtre RQS par Menu_System 'Close'");
                    Get_WinRQS().Parent.SystemMenu.Click("Close");               
                    break;   
                }
                case "Esc":
                { 
                    Log.Message("Fermeture de la fenêtre RQS par 'Escape'");
                    Get_WinRQS().Parent.Keys("[Esc]");
                    break;   
                }
            } 
            if (Get_DlgConfirmation().Exists){                   
                aqObject.CheckProperty(Get_DlgConfirmation().CommentTag, "OleValue", cmpEqual, message);
                aqObject.CheckProperty(Get_DlgConfirmation_BtnContinue(), "Exists",          cmpEqual, true);
                aqObject.CheckProperty(Get_DlgConfirmation_BtnContinue(), "Isvisible",       cmpEqual, true);
                aqObject.CheckProperty(Get_DlgConfirmation_BtnContinue(), "VisibleOnScreen", cmpEqual, true);
                aqObject.CheckProperty(Get_DlgConfirmation_BtnClose(), "Exists",          cmpEqual, true);
                aqObject.CheckProperty(Get_DlgConfirmation_BtnClose(), "Isvisible",       cmpEqual, true);
                aqObject.CheckProperty(Get_DlgConfirmation_BtnClose(), "VisibleOnScreen", cmpEqual, true);
            }               
            Get_DlgConfirmation_BtnContinue().Click();          
}

function Get_WinRQS_TabTransactionBlotter_ToggleItems(){
  return Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("PART_QuickFiltersScrollViewer").WPFObject("ContentControl", "", 1).WPFObject("ItemsControl", "", 1);}