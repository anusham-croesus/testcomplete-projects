//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions

/*
      https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6656

      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. 
      Version de scriptage : ref90-12-Hf-109 */

function CR1958_2_6656_6530_ValidateLogicFilterByThreeFieldsAddedAndSpotcheck(){

            var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
            var waitTime = 5000;
        
            var noteText                = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6656_Note", language + client);
            var transactionBDate        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6656_transactionBDate", language + client); 
            var statusDate              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6656_statusDate", language + client); 
            var managementLevelAll      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6656_managementLevelAll", language + client);
            var managementLevelCProfile = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6656_managementLevelCProfile", language + client); 
            var statusAll               = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6656_statusAll", language + client); 
            var spotChecked             = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6656_spotChecked", language + client);
            var progressionMessage      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6656_Message", language + client);
            
            //Indices des transactions à selectionner
            var tansactionIndex2 = 1;
            var tansactionIndex5 = 4;
              
            lastStatusDate = aqConvert.StrToDate(statusDate);
            transactionBlotterDate = aqConvert.StrToDate(transactionBDate);

            try {
              // Se connecter
              Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
            
              // Attendre le boutton RQS présent et actif
              WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
              Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
              Get_Toolbar_BtnRQS().Click();
          
              // Attendre l'onglet 'Transactions' présent et actif dans la fenêtre RQS
              WaitObject(Get_CroesusApp(), "Uid", "TabItem_a70d", waitTime);
              Get_WinRQS_TabTransactionBlotter().WaitProperty("Enabled", true, waitTime)          
          
              Get_WinRQS_TabTransactionBlotter().Click();
              WaitObject(Get_CroesusApp(), "Uid", "TabItem_c461", waitTime);
              Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, waitTime);
          
              //Étape 1
 /*             //Désactiver tout les filtres appliqués s'ils existent
              var nbActiveFilter = Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("ItemsControl", "", 1).DataContext.NbConditionInList             
              while(nbActiveFilter > 0){
                      if (Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(nbActiveFilter).wState)
                          Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(nbActiveFilter).set_IsChecked(false);
                      nbActiveFilter -= 1;
              }*/
                                  
              //Selectionner les transactions #2 et #5
              Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).Items.Item(tansactionIndex2).set_IsSelected(true);
              Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).Items.Item(tansactionIndex5).set_IsSelected(true);  
          
              //Click sur 'Review Selected' et ajout d'une note
              Get_WinRQS_TabTransactionBlotter_BtnReviewSelected().Click();
              WaitObject(Get_CroesusApp(), "Uid", "Window_fff1", waitTime);
              
              //
              Get_WinTransactionReview_RdBSpotcheck().set_IsChecked(true);
              Get_WinTransactionReview_CmbTypeOfReview().set_SelectedIndex(0);
              Get_WinTransactionReview_CmbQueryCategory().set_SelectedIndex(0); 
          
              Get_WinTransactionReview_GrpNoteTextBox().SetText(noteText);
    
              var numberOfTries=0;  
              while (numberOfTries < 5 && Get_WinTransactionReview().Exists){
                  Get_WinTransactionReview_BtnValidate().Click(); 
                  numberOfTries++;
              }
          
              //Valider que les icônes des spot checked existent et visibles
              aqObject.CheckProperty(Get_WinRQS_TabTransactionBlotter_SpotcheckImage(2), "Exists", cmpEqual, true);
              aqObject.CheckProperty(Get_WinRQS_TabTransactionBlotter_SpotcheckImage(2), "Visible", cmpEqual, true);
              aqObject.CheckProperty(Get_WinRQS_TabTransactionBlotter_SpotcheckImage(2), "VisibleOnScreen", cmpEqual, true);
              aqObject.CheckProperty(Get_WinRQS_TabTransactionBlotter_SpotcheckImage(5), "Exists", cmpEqual, true);
              aqObject.CheckProperty(Get_WinRQS_TabTransactionBlotter_SpotcheckImage(5), "Visible", cmpEqual, true);
              aqObject.CheckProperty(Get_WinRQS_TabTransactionBlotter_SpotcheckImage(5), "VisibleOnScreen", cmpEqual, true);
          
              //Étape 2: Valider que le spot checked est exporté dans la fichier Excel quand le managemnet level est 'All'
              //Ouvrir la fenêtre: QueryLog
              Get_WinRQS_BtnQueryLog().Click();      
              WaitObject(Get_CroesusApp(), "Uid", "QuerylogView_b490", waitTime);
              
              //Transaction Blotter Date From = '01/25/2010' et To = '01/25/2010'
              Get_WinQueryLog_GrpTransactionBlotterDate_DateFrom().Set_Value(transactionBlotterDate);
              Get_WinQueryLog_GrpTransactionBlotterDate_DateTo().Set_Value(transactionBlotterDate);
              
              //Choisir Status = 'All'
              Get_WinQueryLog_GrpLastStatus_CmbStatus().Click();
              if(Get_SubMenus().Exists)
                          Get_SubMenus().Find("WPFControlText",statusAll,10).Click();
                          
              //Last status date From = 24/10/2019
              Get_WinQueryLog_GrpLastStatus_DateFrom().Set_Value(lastStatusDate);
              
              //choisir Management Level = 'All'
              Get_WinQueryLog_GrpClientRelationship_CmbManagementLevel().Click();
              if(Get_SubMenus().Exists)
                  Get_SubMenus().Find("WPFControlText",managementLevelAll,10).Click();
                  
              Get_WinQueryLog_BtnGenerate().Click();
              if (Get_DlgProgressCroesus().Exists)
                      if (Get_DlgProgressCroesus().DataContext.Message == progressionMessage)
                          Log.Error("Le fichier Excel ne peut être généré faute de données")
                      Get_DlgProgressCroesus_BtnOK().Click();
          
              //Fermer Excel        
              while(Sys.waitProcess("EXCEL").Exists){
                  Sys.Process("EXCEL").Terminate();
              }
              var sTempFolder = Sys.OSInfo.TempDirectory;
              var FolderPath= sTempFolder+"\CroesusTemp\\"
              Log.Message(FolderPath)
              var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
              Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains));
    
              var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);      
              var found = false;
              
              //Chercher le texte 'Spot Checked' dans le fichier Excel
              while(! myFile.IsEndOfFile()){
                  line = myFile.ReadLine();
                  // Split at each space character.
                  var textArr = line.split("	");           
                  if(aqString.Unquote(textArr[3]) == spotChecked){
                      found = true;
                      break;}
              }
              if (found)
                  Log.Checkpoint("Le spot checked est exporté dans le fichier Excel");
              else 
                  Log.Error("Le spot checked n'est pas  exporté dans le fichier Excel");
                      
              //Valider que le spot checked n'est pas exporté dans la fichier Excel quand le managemnet level est 'Client Profil'
              //Ouvrir la fenêtre: QueryLog
              Get_WinRQS_BtnQueryLog().Click();
              WaitObject(Get_CroesusApp(), "Uid", "QuerylogView_b490", waitTime);     
              
              //Transaction Blotter Date From = '01/25/2010' et To = '01/25/2010'
              Get_WinQueryLog_GrpTransactionBlotterDate_DateFrom().Set_Value(transactionBlotterDate);
              Get_WinQueryLog_GrpTransactionBlotterDate_DateTo().Set_Value(transactionBlotterDate);
              
              //Status = 'All'
              Get_WinQueryLog_GrpLastStatus_CmbStatus().Click();
              if(Get_SubMenus().Exists)
                          Get_SubMenus().Find("WPFControlText",statusAll,10).Click();
                          
              //Last status date From = 24/10/2019
              Get_WinQueryLog_GrpLastStatus_DateFrom().Set_Value(lastStatusDate);
              
              //choisir Management Level = 'Client Profil'
              Get_WinQueryLog_GrpClientRelationship_CmbManagementLevel().Click();
              if(Get_SubMenus().Exists)
                  Get_SubMenus().Find("WPFControlText",managementLevelCProfile,10).Click();
                  
              Get_WinQueryLog_BtnGenerate().Click();
              if (Get_DlgProgressCroesus().Exists)
                      if (Get_DlgProgressCroesus().DataContext.Message == progressionMessage)
                          Log.Error("Le fichier Excel ne peut être généré faute de données")
                      Get_DlgProgressCroesus_BtnOK().Click();
      
              //fermer le fichier excel
              while(Sys.waitProcess("EXCEL").Exists){
                  Sys.Process("EXCEL").Terminate();
              }
              var sTempFolder = Sys.OSInfo.TempDirectory;
              var FolderPath= sTempFolder+"\CroesusTemp\\"
              Log.Message(FolderPath)
              var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
              Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains));    
              var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
              found = false;
          
              //Chercher le texte 'Spot Checked' dans le fichier Excel
              while(! myFile.IsEndOfFile()){
                  line = myFile.ReadLine();
                  // Split at each space character.
                  var textArr = line.split("	");           
                  if(aqString.Unquote(textArr[3]) == spotChecked){
                      found = true;
                      break;}
              }
              if (!found)
                  Log.Checkpoint("Le spot check n'est pas  exporté dans le fichier Excel");
              else 
                  Log.Error("Le spot check est exporté dans le fichier Excel"); 
                 
              //Spprimer le Spot Checked   
              Log.Message("Spprimer les Spots Checked");
              Delay(2000);        
              Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer").WPFObject("DataRecordPresenter", "", 2).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("Image", "", 1).Click();
              Sys.Desktop.KeyDown(0x11);//Touche Ctl down
              Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer").WPFObject("DataRecordPresenter", "", 5).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("Image", "", 1).Click();
              Sys.Desktop.KeyUp(0x11);//Touche Ctl up
              //Tab Alertes and notes
              Get_WinRQS_BottomSection_TabNotesAndAlerts().Click(); 
              Get_WinRQS_BottomSection_TabNotesAndAlerts().WaitProperty("IsSelected", true, waitTime)
                
              Get_WinRQS_BottomSection_TabNotesAndAlerts_BtnDelete().Click();
              WaitObject(Get_CroesusApp(), "Uid", "DeletionWindow_5967", waitTime);
              Get_WinDeletion_BtnDeleteForManyTransactions().Click();
            }
            catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {
              //Fermer Croesus
              Terminate_CroesusProcess(); 
              Terminate_IEProcess();
            }
}