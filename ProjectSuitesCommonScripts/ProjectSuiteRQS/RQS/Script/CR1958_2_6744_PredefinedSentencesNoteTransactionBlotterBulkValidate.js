//USEUNIT Common_functions
//USEUNIT DBA
//USEUNIT RQS_Get_functions


/**
    Description : Validate the predefined sentences notes in the transactions blotter Bulk validate
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6744
    
    Analyste d'assurance qualité : Carole T.
    Analyste d'automatisation : Amine A.
    Version de scriptage : ref90-12-Hf-74--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6744_PredefinedSentencesNoteTransactionBlotterBulkValidate()
{
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6744");
    
          try { 
                Log.Warning("Ce script doit être lancé après le cript CR1958_2_6658_Validate_Manual_Logic_Client_ID qui crée les alerts manuelles");
                
                var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
                var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                
                var brancheName  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_Branche_Toronto", language + client);
                var allBranches  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_Branche_All", language + client);
                var CreatedBy    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_CreatedBy", language + client);
                var noteText     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_noteText", language + client);
                
                var TransactionBlotterDate = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_TransactionBlotterDate", language + client);
                var SpotChecked_Toronto    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_SpotChecked_Toronto", language + client);
                var ManualAlerts_Toronto   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_ManualAlerts_Toronto", language + client);
                
                var TotalToBeValidatedTransactions_Toronto = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_TotalToBeValidatedTransactions_Toronto", language + client);
                var TotalToBeValidatedAccounts_Toronto     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_TotalToBeValidatedAccounts_Toronto", language + client);
                var TotalToBeValidatedClients_Toronto      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_TotalToBeValidatedClients_Toronto", language + client);
                var TotalToBeValidatedRelatioships_Toronto = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_TotalToBeValidatedRelatioships_Toronto", language + client);
                
                var SpotChecked_All  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_SpotChecked_All", language + client);
                var ManualAlerts_All = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_ManualAlerts_All", language + client);
                
                var TotalToBeValidatedTransactions_All = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_TotalToBeValidatedTransactions_All", language + client);
                var TotalToBeValidatedAccounts_All     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_TotalToBeValidatedAccounts_All", language + client);
                var TotalToBeValidatedClients_All      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_TotalToBeValidatedClients_All", language + client);
                var TotalToBeValidatedRelatioships_All = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_TotalToBeValidatedRelatioships_All", language + client);
                
                var nbManualAlerts         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_nbManualAlerts", language + client);
                var nbClientRelationships  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_nbClientRelationships", language + client);               
                var totalClients           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_totalClients", language + client);
                var nbSpotChecks           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_nbSpotChecks", language + client);              
                var totalTransactions      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_totalTransactions", language + client);
                var totalAccounts          = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6744_totalAccounts", language + client);
                
                var dateFormat = "%m/%d/%Y";
                if (language == "french") dateFormat = "%Y/%m/%d";               
                var toDayDate = aqConvert.DateTimeToFormatStr(aqDateTime.Today(),dateFormat);
                Log.Message(toDayDate); 
                               
                var waitTime = 3000;
                       
                Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
             
                // Attendre le boutton RQS présent et actif
                WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
                Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
                Get_Toolbar_BtnRQS().Click();
          
                // Attendre l'onglet 'Transactions' présent et actif dans la fenêtre RQS
                WaitObject(Get_CroesusApp(), "Uid", "TabItem_a70d", waitTime);
                Get_WinRQS_TabTransactionBlotter().WaitProperty("Enabled", true, waitTime);
                if(Get_WinRQS().WindowState != "Maximized")
                    Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").SystemMenu.Click("Maximize");          
          
                Get_WinRQS_TabTransactionBlotter().Click();
                WaitObject(Get_CroesusApp(), "Uid", "TabItem_c461", waitTime);
                Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, waitTime);
              
                WaitObject(Get_WinRQS(), "Uid", "Button_9072",waitTime);
                Get_WinRQS_BtnTreeView().Click();
                WaitObject(Get_WinRQS(), "ClrClassName", "PopupRoot",1500);
                if(Get_SubMenus().Exists){
                        Get_SubMenus().Find("Value",brancheName,10).Click();
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

              //Selectionner 2 premières transactions
              Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsSelected(true);
              Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).Items.Item(1).set_IsSelected(true);
            
              //Click sur 'Review Selected' et ajout d'une note
              Get_WinRQS_TabTransactionBlotter_BtnReviewSelected().Click();
              WaitObject(Get_CroesusApp(), "Uid", "Window_fff1", waitTime);
              Get_WinTransactionReview().WaitProperty("VisibleOnScreen", true, waitTime);
              Get_WinTransactionReview_GrpNoteTextBox().SetText(noteText);
              if(Get_WinTransactionReview_BtnValidate().WaitProperty("Enabled", true, waitTime))    
                      Get_WinTransactionReview_BtnValidate().Click();
    
              var numberOfTries=0;  
              while (numberOfTries < 5 && Get_WinTransactionReview().Exists){
                  Get_WinTransactionReview_BtnValidate().Click(); 
                  numberOfTries++;
              }
              //Enlever la selection
              Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer").WPFObject("DataRecordPresenter", "", 3).Click(); 

              Get_WinRQS_TabTransactionBlotter_BtnBulkValidate().Click();
                
              //Validation des données affichées dans la fenêtre de validation pour Toronto
              Log.Message("Validation des données affichées dans la fenêtre de validation pour Toronto")
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralTransactionBlotterDateTxt(), "Text", cmpEqual, TransactionBlotterDate);
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralSpotCheckedTxt(),            "Text", cmpEqual, SpotChecked_Toronto);
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralManualAlertsTxt(),           "Text", cmpEqual, ManualAlerts_Toronto);
          
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralTotalToBeValidatedTransactionsTxt(), "Text", cmpEqual, TotalToBeValidatedTransactions_Toronto);
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralTotalToBeValidatedAccountsTxt(),     "Text", cmpEqual, TotalToBeValidatedAccounts_Toronto);
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralTotalToBeValidatedClientsTxt(),      "Text", cmpEqual, TotalToBeValidatedClients_Toronto);
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralTotalToBeValidatedRelatioshipsTxt(), "Text", cmpEqual, TotalToBeValidatedRelatioships_Toronto);
          
              aqObject.CheckProperty(Get_WinBulkValidation_GrpNoteCreationDateTxt(), "Text", cmpContains, toDayDate);
              aqObject.CheckProperty(Get_WinBulkValidation_GrpNoteCreatedByTxt(),    "Text", cmpEqual,    CreatedBy);
                        
              Get_WinBulkValidation_BtnClose().Click(); 
                
                
              Get_WinRQS_BtnTreeView().Click();
              WaitObject(Get_WinRQS(), "ClrClassName", "PopupRoot",1500);
              if(Get_SubMenus().Exists){
                      Get_SubMenus().Find("Content",allBranches,10).Click();
              } 
              WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTime);
              Get_WinRQS_TabTransactionBlotter_BtnBulkValidate().Click();
                
              //Validation des données affichées dans la fenêtre de validation pour 'All'
              Log.Message("Validation des données affichées dans la fenêtre de validation pour 'All'")
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralSpotCheckedTxt(),            "Text", cmpEqual, SpotChecked_All);
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralManualAlertsTxt(),           "Text", cmpEqual, ManualAlerts_All);
          
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralTotalToBeValidatedTransactionsTxt(), "Text", cmpEqual, TotalToBeValidatedTransactions_All);
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralTotalToBeValidatedAccountsTxt(),     "Text", cmpEqual, TotalToBeValidatedAccounts_All);
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralTotalToBeValidatedClientsTxt(),      "Text", cmpEqual, TotalToBeValidatedClients_All);
              aqObject.CheckProperty(Get_WinBulkValidation_GrpGeneralTotalToBeValidatedRelatioshipsTxt(), "Text", cmpEqual, TotalToBeValidatedRelatioships_All);
          
              Get_WinBulkValidation_BtnClose().Click();  
              
              //Valider les résultats des 6 requêtes
              Log.Message("Valider les résultats des 6 requêtes");
              
              var query1 = "select count(*) from b_rqs_alert where alert_date = '2010.01.25' and alert_test_id = 8";
              CheckEquals(Execute_SQLQuery_GetResult(query1, vServerRQS),nbManualAlerts, "Nombre d'alerts manuelles ");
                   
              var query2 = "select count(distinct t1.no_link) from b_rqs_trans_blotter t1, b_trans t2 where t1.no_trans =t2.no_trans and t2.date_proc = '2010.01.25' and t1.validation_id is null and t1.HAS_MANUAL_ALERT  = 'N'";
              CheckEquals(Execute_SQLQuery_GetResult(query2, vServerRQS),nbClientRelationships, "Nombre de relations clients ");
          
              var query3 = "select count(distinct t1.no_Client) from b_rqs_trans_blotter t1, b_trans t2 where t1.no_trans =t2.no_trans  and t2.date_proc = '2010.01.25' and t1.validation_id is null and t1.HAS_MANUAL_ALERT  = 'N'";
              CheckEquals(Execute_SQLQuery_GetResult(query3, vServerRQS),totalClients, "Le total clients ");
                   
              var query4 = "select count(distinct t2.NO_CLIENT) from b_rqs_trans_blotter_validation t1,b_rqs_trans_blotter t2 where t1.validation_id =t2.validation_id  and t2.blotter_date= '2010.01.25' and t1.validation =1";
              CheckEquals(Execute_SQLQuery_GetResult(query4, vServerRQS),nbSpotChecks, "Le nombre de spot check ");
          
              var query5 = "select count(distinct t1.NO_TRANS) from b_rqs_trans_blotter t1, b_trans t2 where t1.no_trans =t2.no_trans and t2.date_proc = '2010.01.25' and t1.validation_id is null and t1.HAS_MANUAL_ALERT  = 'N'";
              CheckEquals(Execute_SQLQuery_GetResult(query5, vServerRQS),totalTransactions, "Le nombre de transactions ");
                   
              var query6 = "select count(distinct t1.NO_COMPTE ) from b_rqs_trans_blotter t1, b_trans t2 where t1.no_trans =t2.no_trans  and t2.date_proc = '2010.01.25' and t1.validation_id is null and t1.HAS_MANUAL_ALERT  = 'N'"
              CheckEquals(Execute_SQLQuery_GetResult(query6, vServerRQS),totalAccounts, "Le total des comptes ");
                
              //Supprimer les spot Checks
              Get_WinRQS_BtnTreeView().Click();
              WaitObject(Get_WinRQS(), "ClrClassName", "PopupRoot",1500);
              if(Get_SubMenus().Exists){
                        Get_SubMenus().Find("Value",brancheName,10).Click();}
              WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTime);
              //Selectionner 2 premières transactions
              Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsSelected(true);
              Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).Items.Item(1).set_IsSelected(true);
              
              Get_WinRQS_BottomSection_TabNotesAndAlerts().Click(); 
              Get_WinRQS_BottomSection_TabNotesAndAlerts().WaitProperty("IsSelected", true, waitTime)  
              Get_WinRQS_BottomSection_TabNotesAndAlerts_BtnDelete().Click();
              WaitObject(Get_CroesusApp(), "Uid", "DeletionWindow_5967", waitTime);
              Get_WinDeletion_BtnDeleteForManyTransactions().Click();
                }
        catch(e){
                Log.Error("Exception : " + e.message, VarToStr(e.stack));}
        finally {
                //Terminate Croesus process
                Terminate_CroesusProcess();
        }              
}

function Execute_SQLQuery_GetResult(queryString, vServer) //pour les requêtes qui retournent une seule valeur comme 'count'
{
    var query = queryString;	
    var Qry   = ADO.CreateADOQuery();
    
    Qry.ConnectionString = GetDBAConnectionString(vServer);	  
    Qry.SQL=query;
    Qry.Open();
    Qry.First(); 
    var result = Qry.Field(0).Value
    Qry.Close();   
    return result;
}

function Get_WinRQS_TabTransactionBlotter_ToggleItems(){
  return Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("PART_QuickFiltersScrollViewer").WPFObject("ContentControl", "", 1).WPFObject("ItemsControl", "", 1);}
