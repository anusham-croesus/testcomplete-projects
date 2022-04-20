//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT DBA


/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6655
  
    Analyste de l'équipe test auto :Ayaz Sana
    Analyste d'automatisation:Carole Turcotte
    Version de scriptage: ref90-12-Hf-46
**/

function CR1958_2_6655_ValidateLogicFilterByThreeFieldsAddedManualAlert()
{
   try {
      
               //Variables             
             
               var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
               var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
               
               var  waitTime = 5000;
               var CR1958_2_6655_ManualNote= ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6655_ManualNote", language + client);
               var CR1958_2_6655_ReviewType= ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6655_ReviewType", language + client);
               var CR1958_2_6655_QueryCategory= ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6655_QueryCategory", language + client);
               var transactionBDate = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6656_transactionBDate", language + client); 
               var statusDateFrom              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6655_statusDateFrom", language + client); 
               var statusAll= ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6656_statusAll", language + client); 
               var CR1958_2_6655_NameStartWith=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6655_NameStartWith", language + client); 
               var CR1958_6655_Pourcentage=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_6655_Pourcentage", language + client); 
               var CR1958_6655_NotDataAvaible=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_6655_NotDataAvaible", language + client);
            
               transactionBlotterDate = aqConvert.StrToDate(transactionBDate);
               lastStatusDate = aqConvert.StrToDate(statusDateFrom);
               
            
               //Lien Testlink
               Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6655");
               
//Étape 1      
      /********************************************* Étape 1**************************************************************************************/
               Log.Message("L'étape 1 du cas de test Croes-6655 ")
               //Se connecter avec Keynej
               Log.Message("******************** Login *******************");
               Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
               Get_Toolbar_BtnRQS().WaitProperty("IsEnabled", true, 30000);
               Get_Toolbar_BtnRQS().Click();
               var nbOfTries = 0;
               do {
                    Get_WinRQS_TabTransactionBlotter().Click();
               } while (++nbOfTries < 3 && !Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, 40000))
               
              // Get_WinRQS_TabTransactionBlotter_BtnBulkValidate().Click();
              //Sélectionner le premier  et le 4 ième enregistrements du browser et cliquer sur Review Select
      			  Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).Click();
      			  Sys.Desktop.KeyDown(0x11); //Press Ctrl
      			  Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "4"], 10).Click();
      			  Sys.Desktop.KeyUp(0x11); //Release Ctrl  
      			  //Cliquer sur le bouton Review Select
              Get_WinRQS_TabTransactionBlotter_BtnReviewSelected().Click();
			  
      			  Log.message("**********************cocher la case Manual alert ensuite Saisir dans le champ Note: Manual Test --> Validate**************************");
              Get_WinTransactionReview_RdBManualAlerte().Click();
              Get_WinTransactionReview_GrpNoteTextBox().Settext(CR1958_2_6655_ManualNote);
              WaitObject(Get_CroesusApp(), "Uid", "Button_c9dd");
                 var numberOfTries=0;  
              while (numberOfTries < 5 && Get_WinTransactionReview().Exists){
                  Get_WinTransactionReview_BtnValidate().Click(); 
                  numberOfTries++;
              }
              //Sélectionner le 1er enregistrement et aller dans l'onglet Notes and Alerts en bas.  
              Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).Click();
              Get_WinRQS_BottomSection_TabNotesAndAlerts().Click(); 
              Get_WinRQS_BottomSection_TabNotesAndAlerts().WaitProperty("IsSelected", true, waitTime)  
              //Dans le browser un icone  est affiché Sous la colonne débutant par Pro 
              Log.Message("Je ne vérifie pas à partir du script l'image par rapport à l’icône mais je vérifie par rapport à la valeur de la propriété HasContent est à true quand il y a une icône.")
            /*Dans le browser un icone  est affiché Sous la colonne débutant par Pro 

                  En bas dans l'onglet Notes and Alerts:

                    Review type: Daily Trade

                     Query category; CRM

                     Note: Manual Test*/
                     
              //  Aliases.CroesusApp.winRQS.WPFObject("TabControl", "", 1).WPFObject("_blotterControl").WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer").WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3)
              //les poinst de vérifications 
              var hasIconeLine1= Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "3"], 10).HasContent;
              var hasIconeLine2= Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "3"], 10).HasContent;
               if(hasIconeLine1 == true && hasIconeLine2 == true )
                   {
                    Log.Checkpoint("L'icône existe pour la première  et la deuxième ligne") //Checkpoint
                   }
                   else
                   {
                     Log.Error("L'icône n'existe pour la première  et la deuxième ligne")
                   }
               /*Les points de vérifications pour la partie: En bas dans l'onglet Notes and Alerts:

                        Review type: Daily Trade

                         Query category; CRM

                         Note: Manual Test*/
                var noteDisplay=          Get_WinRQS_BottomSection_TabNotesAndAlerts_DgvNotesAndAlerts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.LatestNote//note
                var reviewTypeDisplay=    Get_WinRQS_BottomSection_TabNotesAndAlerts_DgvNotesAndAlerts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ReviewTypeDescription
                var queryCategoryDispaly= Get_WinRQS_BottomSection_TabNotesAndAlerts_DgvNotesAndAlerts().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.QueryCategoryDescription
                //Les points de vérifications
                CheckEquals(noteDisplay,CR1958_2_6655_ManualNote,"La colonne note affichée est ")
                CheckEquals(reviewTypeDisplay,CR1958_2_6655_ReviewType,"La colonne type de révision est ")
                CheckEquals(queryCategoryDispaly,CR1958_2_6655_QueryCategory,"La colonne catégorie de la requête affichée est ")
               //Cliquer sur Query Log
                Get_WinRQS_BtnQueryLog().Click();
                WaitObject(Get_CroesusApp(), "Uid", "QuerylogView_b490", waitTime);     
               //Transaction Blotter Date From = '01/25/2010' et To = '01/25/2010'
                Get_WinQueryLog_GrpTransactionBlotterDate_DateFrom().Set_Value(transactionBlotterDate);
                Get_WinQueryLog_GrpTransactionBlotterDate_DateTo().Set_Value(transactionBlotterDate);     
                //Choisir Status = 'All'
                Get_WinQueryLog_GrpLastStatus_CmbStatus().Click();
                if(Get_SubMenus().Exists)
                    Get_SubMenus().Find("WPFControlText",statusAll,10).Click();
                // /Last status: From 01/25/2010 to : Today
                Get_WinQueryLog_GrpLastStatus_DateFrom().Set_Value(lastStatusDate);
                Log.Message("J'ai pas modifié la zone date To: parce que la date qui est par défaut c'est la date du jour")
                /*    Dans Client relationship or client
                      Name(starts with): écrire  MULTIPLE  --> Generate*/ 
                      Get_WinQueryLog_GrpClientRelationshipOrClientTxtNameStartsWith().set_Text(CR1958_2_6655_NameStartWith);
                      Get_WinQueryLog_GrpClientRelationshipOrClientTxtNameStartsWith().Click();      
                      Get_WinQueryLog_BtnGenerate().Click();
               //Les points de vérifications du message affiché
                 var LabelPourcentage=Get_WinReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Label", "2"], 10).WPFControlText
                 var LabelnoDataAvaibl=Get_WinReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Label", "3"], 10).WPFControlText
                 CheckEquals(LabelPourcentage,CR1958_6655_Pourcentage,"Le message 100% est affiché")
                 CheckEquals(LabelnoDataAvaibl,CR1958_6655_NotDataAvaible,"Le message No data available est affiché  ") 
                 Log.Message("D'aprés Taous on peut pas supprimer les alertes manuelles donc c'est pourquoi j'ai pas supprimé les alertes manuelles")  
                      
                      
                      


			  
   
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    
        Terminate_CroesusProcess();
        
      
        
    }
}