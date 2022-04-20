//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT Performance_RCMBtn

/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

function Performance_RCM_AddSpotCheckOneTransaction(){

        var StopWatchObj   = HISUtils.StopWatch;
        var SoughtForValue = "Performance_RCM_AddSpotCheckOneTransaction";
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var waitTime = 5000;
        //indice de la transaction à selectionner
        var tansactionIndex = 0;
        //Texte de la note
        var noteText = "RCM ajout de Spot Check, une transaction";
        var column=FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue)

        try {
          // Se connecte
          Login(vServerPerformance, userNamePerformance, pswPerformance, language);
            
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
          
          //Désactiver tout les filtres appliqués s'ils existent
          var nbActiveFilter = Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("ItemsControl", "", 1).DataContext.NbConditionInList             
          while(nbActiveFilter > 0){
                  if (Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(nbActiveFilter).wState)
                      Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(nbActiveFilter).set_IsChecked(false);
                  nbActiveFilter -= 1;
          }
          
          //Selectionner une transaction #1
          Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).Items.Item(tansactionIndex).set_IsSelected(true);  

                                               
          //Click sur 'Review Selected' et ajout d'une note
          Get_WinRQS_TabTransactionBlotter_BtnReviewSelected().Click();
          WaitObject(Get_CroesusApp(), "Uid", "Window_fff1", waitTime);
          Get_WinTransactionReview().WaitProperty("VisibleOnScreen", true, waitTime);
          Get_WinTransactionReview_GrpNoteTextBox().Keys(noteText);
        
//          if(Get_WinTransactionReview_BtnValidate().WaitProperty("Enabled", true, waitTime))    
//                  Get_WinTransactionReview_BtnValidate().Click();
//    
//          var numberOfTries=0;  
//          while (numberOfTries < 5 && Get_WinTransactionReview().Exists){
//              Get_WinTransactionReview_BtnValidate().Click(); 
//              numberOfTries++;
//          }
                  
           Get_WinTransactionReview_BtnValidate().Waitproperty("IsEnabled",true,waitTime) ;       
          //Mesurer la performance de 
          StopWatchObj.Start(); 
          Get_WinTransactionReview_BtnValidate().Click();        
//          while(Get_WinTransactionReview().Exists){
//            Delay(1);
//          };
          Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WaitProperty("DataContext.DataItem.ValidationStatus","SpotCheckValidate",waitTimeShort);
          //WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Window_fff1", waitTimeShort);
          //Get_CroesusApp().WaitProperty("VisibleOnScreen", true, waitTime); 
          var timeSpotted=StopWatchObj.Split()/1000          
          StopWatchObj.Stop();
                
          // Écrit le résultat dans le fichier Excel
          Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
          /*var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), timeSpotted);*/
          
          var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);  
          
          //Spprimer le Spot Check
          /*Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").Keys("~[F4]");
          Get_Toolbar_BtnRQS().Click();
          WaitObject(Get_CroesusApp(), "Uid", "TabItem_a70d", waitTime);
          Get_WinRQS_TabTransactionBlotter().WaitProperty("Enabled", true, waitTime)          
          
          Get_WinRQS_TabTransactionBlotter().Click();
          WaitObject(Get_CroesusApp(), "Uid", "TabItem_c461", waitTime);
          Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, waitTime)*/
          
          
          Get_WinRQS_BottomSection_TabNotesAndAlerts().Click(); 
          Get_WinRQS_BottomSection_TabNotesAndAlerts().WaitProperty("IsSelected", true, waitTime)  
          Get_WinRQS_BottomSection_TabNotesAndAlerts_BtnDelete().Click();
          WaitObject(Get_CroesusApp(), "Uid", "DeletionWindow_5967", waitTime);
          Get_WinDeletion_BtnYes().Click();
          
          //fermer la fenêtre 
          Get_WinRQS().Close();
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
          //Fermer Croesus
          TerminateProcess("CroesusClient"); 
        }
}