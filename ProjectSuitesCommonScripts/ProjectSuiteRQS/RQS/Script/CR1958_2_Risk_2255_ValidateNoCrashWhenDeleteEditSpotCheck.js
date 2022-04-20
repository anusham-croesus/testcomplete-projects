//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions

/*
      Validation la suppression ou une modification d'une validation manuelle ne cause pas un crash
      
      https://jira.croesus.com/browse/RISK-2255
      
      Analyste d'assurance qualité: Taous A.
      Analyste d'automatisation: Amine A. 
      
      Version de scriptage : ref90.17-42 */ 

function CR1958_2_Risk_2255_ValidateNoCrashWhenDeleteEditSpotCheck (){

            var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
            var waitTime   = 5000;
            
      try {   
               var brancheLaval      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_BrancheLaval", language + client);
               var brancheToronto    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_BrancheToronto", language + client);              
               
               var transactionValidationStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_TransactionValidationStatus", language + client);
               var excludingOperator           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_ExcludingOperator", language + client);              
               var spotCheckValue      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_SpotCheckValue", language + client);
               
               var TorontoTransactionNote = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_TorontoTransactionNote", language + client);
               var LavalTransactionNote   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_LavalTransactionNote", language + client);
               var LavalModifiedNote      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_LavalModifiedNote", language + client);
               
               var messageDelete = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_MessageDelete", language + client);
               var labelDeleteMany = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_LabelDeleteMany", language + client);
               var labelDeleteCurrentNote = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_LabelDeleteCurrentNote", language + client);
               var labelClose = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_LabelClose", language + client);
               
               var labelEditMany = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_LabelEditMany", language + client);
               var labelEditCurrent = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_LabelEditCurrent", language + client);
               var labelCancel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_LabelCancel", language + client);
               
               var attr = Log.CreateNewAttributes();
               attr.Bold = true;
              
                //Se connecter avec KEYNEJ
                Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
           
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
                
                //Étape 2: appliquer le fitre: Transaction Validation Status = Excluding : Spot check
                Get_WinRQS_QuickFilterClick();
                Get_WinRQS_QuickFilter_FilterField(transactionValidationStatus).Click();
                WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
                SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), excludingOperator);

                Get_WinCreateFilter_DgvValue().Find("Value", spotCheckValue, 10).Click();
                Get_WinCreateFilter_BtnApply().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);
                
                //Étape 3: Appliquer le filtre:  Transaction Validation Status = Excluding : Spot check
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Étape 3 - 10: Ajouter des spotcheks pour toutes les transactions de Toronto et Laval", "", pmNormal, attr);
                Log.Message(" Étape 2: Choisir Toronto dans le champ Current context","", pmNormal, attr);
                Get_WinRQS_BtnTreeView().Click();
                WaitObject(Get_WinRQS(), "ClrClassName", "PopupRoot",waitTime);
              
                if(Get_SubMenus().Exists){
                        Get_SubMenus().Find("Value",brancheToronto,10).Click();
                }
                WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTime);               
                
                //Étape 3 - 4: Ajouter un spotcheck pour les transactions de Toronto
                Get_WinRQS_TabTransactionBlotter_DgvTransactions().Keys("^a");
                AddSpotCheck(TorontoTransactionNote, 1, 50)              
                
                //Étape 5 - 10: Changer le Current context à Laval
                Log.Message(" Étape 2: Choisir Toronto dans le champ Current context","", pmNormal, attr);
                Get_WinRQS_BtnTreeView().Click();
                WaitObject(Get_WinRQS(), "ClrClassName", "PopupRoot",waitTime);
              
                if(Get_SubMenus().Exists){
                        Get_SubMenus().Find("Value",brancheLaval,10).Click();
                }
                WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTime);
                
                //Ajouter un spotcheck pour toutes les transactions de Laval
                for (var i=1; i<6; i++){
                    Log.Message(i)
                    AddSpotCheck(LavalTransactionNote, i, 50)
                }
                Log.PopLogFolder();
                
                //Étape 11: Désactiver le fitre
                Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(1).set_IsChecked(false);
                
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Étape 11: Supprimer un spotchek parmi les 118 et valider la fenêtre de suppression", "", pmNormal, attr);
                
                //Aller à la fin de la grille 
                var objectControl = Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer")
                var width  = objectControl.get_ActualWidth();
                var height = objectControl.get_ActualHeight();  
                
                //Sélectionner la premiere transaction de la page      
                objectControl.Click(width-7, height-43);
               
                Get_WinRQS_BottomSection_TabNotesAndAlerts().Click(); 
                Get_WinRQS_BottomSection_TabNotesAndAlerts().WaitProperty("IsSelected", true, waitTime)
                
                var objectControl = Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer") 
                var width = objectControl.get_ActualWidth();
                var j = 0;
                do{
                    objectControl.Click(width/2, 25 + j);
                    j =+ 20;
                }while(Get_WinRQS_BottomSection_TabNotesAndAlerts_TxtNote().Text != LavalTransactionNote + "5")
                
                Get_WinRQS_BottomSection_TabNotesAndAlerts_BtnDelete().Click();
                WaitObject(Get_CroesusApp(), "Uid", "DeletionWindow_5967", waitTime);
                
                //Valider les proprietées de la fenêtre: 'Deletion window'
                Log.Message("Valider les proprietées de la fenêtre: 'Deletion window'")
                aqObject.CheckProperty(Get_WinDeletion().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10), "WPFControlText", cmpEqual, messageDelete);      
                aqObject.CheckProperty(Get_WinDeletion_BtnDeleteForManyTransactions(), "WPFControlText", cmpEqual, labelDeleteMany);      
                aqObject.CheckProperty(Get_WinDeletion_BtnDeleteNoteForCurrentTransaction(), "WPFControlText", cmpEqual, labelDeleteCurrentNote);
                aqObject.CheckProperty(Get_WinDeletion_BtnCcancel(), "WPFControlText", cmpEqual, labelCancel);
                
                //Étape : 12            
                Get_WinDeletion_BtnDeleteNoteForCurrentTransaction().Click();
                
                //Validation que l'oeil n'est plus visible
                aqObject.CheckProperty(Get_WinRQS_TabTransactionBlotter_SpotcheckImage(1), "VisibleOnScreen", cmpEqual, false);
                Log.PopLogFolder();                
                
                Log.PopLogFolder();
                logEtape13 = Log.AppendFolder("Étape 13: Modifier un spotchek parmi les 117 et valider la fenêtre de modification", "", pmNormal, attr);
                var objectControl = Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer")
                 //Étape : 13   
                 var j = 0;
                 do{
                    objectControl.Click(width/2, 45 + j);
                    j =+ 20;
                 }while(Get_WinRQS_BottomSection_TabNotesAndAlerts_TxtNote().Text != LavalTransactionNote + "5")           
                Get_WinRQS_BottomSection_TabNotesAndAlerts().Click(); 
                Get_WinRQS_BottomSection_TabNotesAndAlerts().WaitProperty("IsSelected", true, waitTime)                
                Get_WinRQS_BottomSection_TabNotesAndAlerts_BtnEdit().Click();
                WaitObject(Get_CroesusApp(), "Uid", "Window_fff1", waitTime);
           
                aqObject.CheckProperty(Get_WinEditValidation_BtnEditNoteForManyTransaction(), "WPFControlText", cmpEqual, labelEditMany);      
                aqObject.CheckProperty(Get_WinEditValidation_BtnEditNoteForCurrentTransaction(), "WPFControlText", cmpEqual, labelEditCurrent);
                aqObject.CheckProperty(Get_WinEditValidation_BtnClose(), "WPFControlText", cmpEqual, labelClose);
             
                 //Étapes 14: éditer la note
                Get_WinTransactionReview_GrpNoteTextBox().Clear();
                Get_WinTransactionReview_GrpNoteTextBox().Keys(LavalModifiedNote);
                Get_WinEditValidation_BtnEditNoteForManyTransaction().Click();
                Log.Message("Valider la modifacation de la note")
                aqObject.CheckProperty(Get_WinRQS_BottomSection_TabNotesAndAlerts_TxtNote(), "Text", cmpEqual, LavalModifiedNote);
                Log.PopLogFolder();
                
                //Réinitialisation
                Log.PopLogFolder();
                logEtape15 = Log.AppendFolder("Étape 15: Supprimer tous les spotchek", "", pmNormal, attr);
                DeleteAllSpotCheck();
                Get_WinRQS().Close()
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

function Get_WinRQS_TabTransactionBlotter_ToggleItems(){
  return Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("PART_QuickFiltersScrollViewer").WPFObject("ContentControl", "", 1).WPFObject("ItemsControl", "", 1);}

function DeleteAllSpotCheck(){
                var waitTime   = 5000;
                var amongOperator = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_amongOperator", language + client);
                var allBranches   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2255_allBranches", language + client);
                
                Get_WinRQS_BtnTreeView().Click();
              WaitObject(Get_WinRQS(), "ClrClassName", "PopupRoot",1500);
              if(Get_SubMenus().Exists){
                      Get_SubMenus().Find("Content",allBranches,10).Click();
              } 
              WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTime);
                
                Get_WinRQS_TabTransactionBlotter_ToggleItems().WPFObject("ToggleButton", "", 1).WPFObject("Button", "", 1).Click();

                WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
                SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), amongOperator);

                Get_WinCreateFilter_BtnApply().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);
              
                while(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Count > 0)
                {
                Get_WinRQS_BottomSection_TabNotesAndAlerts().Click(); 
                Get_WinRQS_BottomSection_TabNotesAndAlerts().WaitProperty("IsSelected", true, waitTime)
                Get_WinRQS_BottomSection_TabNotesAndAlerts_BtnDelete().Click();
                WaitObject(Get_CroesusApp(), "Uid", "DeletionWindow_5967", waitTime);
                if(Get_WinDeletion_BtnDeleteForManyTransactions().Exists)           
                    Get_WinDeletion_BtnDeleteForManyTransactions().Click();
                else
                if (Get_WinDeletion_BtnYes().Exist)
                    Get_WinDeletion_BtnYes().Click();}
}
        
function AddSpotCheck(note, k, nbOfTransaction ){
    
            var waitTime   = 5000;
            var nbrTransactions = Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Count 
            Log.Message("nbrTransactions : "+nbrTransactions)             
             
            if (k == 5){
                var objectControl = Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer")
                var height = objectControl.get_ActualHeight();  
                var width = objectControl.get_ActualWidth();
                objectControl.Click(width-7, 25)
                Sys.Desktop.KeyDown(0x10);
                objectControl.Click(width/2, 25)
                objectControl.Click(width-7, height-43)
                objectControl.Click(width/2, height-43)
                Sys.Desktop.KeyUp(0x10);   
            }
            else {
             if (nbrTransactions < nbOfTransaction)
                    nbOfTransaction = nbrTransactions;
             for (i=0; i<nbOfTransaction; i++){
                    Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(i).set_IsSelected(true)}
            }
            //Cliquer le bouton Review Selected
            Get_WinRQS_TabTransactionBlotter_BtnReviewSelected().Click();
            WaitObject(Get_CroesusApp(), "Uid", "Window_fff1", waitTime);
                
            Get_WinTransactionReview_RdBSpotcheck().set_IsChecked(true);
                
            Get_WinTransactionReview_GrpNoteTextBox().Click();
            Get_WinTransactionReview_GrpNoteTextBox().SetText(note + k);                 
            Get_WinTransactionReview_BtnValidate().Click();
                      
            var numberOfTries=0;  
            while (numberOfTries < 5 && Get_WinTransactionReview().Exists){
                Get_WinTransactionReview_BtnValidate().Click(); 
                numberOfTries++;
            }           
} 