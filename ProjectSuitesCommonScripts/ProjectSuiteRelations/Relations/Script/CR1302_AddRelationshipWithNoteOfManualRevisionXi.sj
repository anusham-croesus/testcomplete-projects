//USEUNIT CR1302_Prerequisites
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Relationships
    CR                   :  1302
    TestLink             :  Croes-6139
    Description          :  Le but de ce cas est d'ajouter une relation avec une note de révision manuelle X p afin de valider que la date de dern. révision
                            se mets à jour correctement.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.09.Er-11
    Date                 :  15/02/2019
    
*/


function CR1302_AddRelationshipWithNoteOfManualRevisionXi() 
{
     try {
                //lien pour TestLink
                Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6139","Lien du Cas de test sur Testlink");
               
                var relationshipName_CR1302_Croes6139 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "relationshipName_CR1302_Croes6139", language+client);
                var reviewFrequency_Croes_6139 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "reviewFrequency_Croes_6139", language+client);
                var Sentence_Croes_6139 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "Sentence_Croes_6139", language+client);
                var Review = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "Review_Croes_6139", language+client);
                var MsgWarning = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "MsgWarning_Croes_6139", language+client);
                var MsgConfirmation = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "MsgConfirmation_Croes_6139", language+client);
                var reviewFrequency = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_reviewFrequency", language+client);
                
                //Se connecter à l'application avec COPERN et acceder au module Relations
                Login(vServerRelations, userName, psw, language);
                Get_ModulesBar_BtnRelationships().Click();
                Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);  
                Get_MainWindow().Maximize();
                
                //Créer une relation 
                CreateRelationship(relationshipName_CR1302_Croes6139);
                SearchRelationshipByName(relationshipName_CR1302_Croes6139);
                
                //Acceder à la fenêtre info de la relation créée
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CR1302_Croes6139, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Accéder à l'onglet Grid de la section Note
                Get_WinInfo_Notes_TabGrid().Click();
                
                //Cliquer sur le bouton Ajouter dans la section Note 
                Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
                WaitObject(Get_CroesusApp(),"Uid","NoteDetailWindow_2d5e");
                
                //Selectionner la phrase "Laissé message à" et déplacer la note à gauche
                if (language == "english")
                {
                  var GridNoteAdd =  Aliases.CroesusApp.winCRUANote.WPFObject("GroupBox", "Predefined Sentences", 2).WPFObject("PredefinedSentencesControl", "", 1).WPFObject("_noteSentenceDataGrid").WPFObject("RecordListControl", "", 1);
                }else
                {
                  var GridNoteAdd =  Aliases.CroesusApp.winCRUANote.WPFObject("GroupBox", "Phrases prédéfinies", 2).WPFObject("PredefinedSentencesControl", "", 1).WPFObject("_noteSentenceDataGrid").WPFObject("RecordListControl", "", 1);
                }
                
                var count = GridNoteAdd.Items.Count;
                for (i=0; i<count; i++)
                {
                   if (GridNoteAdd.Items.Item(i).DataItem.SentenceText == Sentence_Croes_6139 )
                   {
                      GridNoteAdd.Find(["ClrClassName","Text"],["XamTextEditor",Sentence_Croes_6139],10).DblClick();
                      break;
                    }
                }
                
                //Cocher la case Révision si ce n'est pas le cas
                if (Get_WinCRUANote_GrpNote_ChkReview().IsChecked == false)
                {
                    Get_WinCRUANote_GrpNote_ChkReview().Click() 
                }
                
                //Cliquer sur sauvegarder
                Get_WinCRUANote_BtnSave().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","NoteDetailWindow_2d5e");
                
                //Points de vérification
                //Vérifier dans info relation que le le champ fréquence affiche la valeur par défaut (Aucune)
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency(), "Text", cmpEqual, reviewFrequency_Croes_6139);
                
                //Vérifier que le champ prochaine révision n'affiche aucune date et grisé
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpNextReviewForRelationship(), "Value", cmpEqual, null);
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpNextReviewForRelationship(), "IsReadOnly", cmpEqual, true);
                 
                //Vérifier que la colonne Révision dans section Note onglet Grille = X
                var noteGrid = Aliases.CroesusApp.winDetailedInfoForRelationshipAndClient.WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Notes", 4).WPFObject("NoteSectionControl", "", 1).WPFObject("TabControl", "", 1).WPFObject("NoteGrid").WPFObject("RecordListControl", "", 1)
                var item = noteGrid.Items.Item(0).DataItem;
                aqObject.CheckProperty(item, "IsReviewDBValue", cmpEqual, Review);
                
                //Cliquer sur OK pour quitter la fenêtre info
                Get_WinDetailedInfo_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Vérifier que Fréquence = Aucune, Proch. Révision = vide, Dern. Révision = date d'aujourd'hui
                var items = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
                var count = items.Count;
                for (i=0; i<count; i++)
                {
                  if (items.Item(i).DataItem.ShortName == relationshipName_CR1302_Croes6139)
                  {
                     aqObject.CheckProperty(items.Item(i).DataItem, "ReviewFrequencyDescription", cmpEqual, reviewFrequency_Croes_6139);
                     aqObject.CheckProperty(items.Item(i).DataItem, "ReviewDate", cmpEqual, aqDateTime.Today());
                     aqObject.CheckProperty(items.Item(i).DataItem, "NextReviewDate", cmpEqual, null);
                     break;
                  }
                }
                
                //Acceder à la fenêtre info de la relation créée
                SearchRelationshipByName(relationshipName_CR1302_Croes6139);
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CR1302_Croes6139, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Accéder à l'onglet Grid de la section Note
                Get_WinInfo_Notes_TabGrid().Click();
                Get_WinInfo_Notes_TabGrid().WaitProperty("IsSelected", true, 30000)
                
                //Sélectionner la note 
                var grid =  Aliases.CroesusApp.winDetailedInfoForRelationshipAndClient.WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Notes", 4).WPFObject("NoteSectionControl", "", 1).WPFObject("TabControl", "", 1).WPFObject("NoteGrid")
                grid.FindChild(["ClrClassName","Value"],["CellValuePresenter",Review],10).Click();
                
                //Cliquer sur le bouton Supprimer
                Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
                
                //Points de vérification
                //Vérification du message warning
                aqObject.CheckProperty(Get_DlgWarning().Find(["ClrClassName","WPFControlOrdinalNo"],["TextBlock",1],10),"WPFControlText",cmpEqual, MsgWarning);
                Get_DlgWarning().Find(["ClrClassName","WPFControlText"],["Button","OK"],10).Click();
                
                //Vérification du message de confirmation
                aqObject.CheckProperty(Get_DlgConfirmation().Find(["ClrClassName","WPFControlOrdinalNo"],["TextBlock",1],10),"WPFControlText",cmpEqual, MsgConfirmation);
                Get_DlgConfirmation_BtnDelete().Click();
                
                //Cliquer sur OK pour quitter la fenêtre info
                Get_WinDetailedInfo_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Vérifier que Fréquence = Aucune, Proch. Révision = vide, Dern. Révision = vide
                var items = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
                var count = items.Count;
                for (i=0; i<count; i++)
                {
                  if (items.Item(i).DataItem.ShortName == relationshipName_CR1302_Croes6139)
                  {
                     aqObject.CheckProperty(items.Item(i).DataItem, "ReviewFrequencyDescription", cmpEqual, reviewFrequency_Croes_6139);
                     aqObject.CheckProperty(items.Item(i).DataItem, "ReviewDate", cmpEqual, null);
                     aqObject.CheckProperty(items.Item(i).DataItem, "NextReviewDate", cmpEqual, null);
                     break;
                  }
                }
                
                //Acceder à la fenêtre info de la relation créée
                SearchRelationshipByName(relationshipName_CR1302_Croes6139);
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CR1302_Croes6139, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Choisir "Annuelle" dans le champs fréquence de révision
                SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency(), reviewFrequency);
                
                //Cliquer sur OK pour quitter la fenêtre info
                Get_WinDetailedInfo_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Vérifier que Fréquence = Annuelle, Proch. Révision = date du jour + 1an, Dern. Révision = vide
                var currentDate = aqDateTime.Today(); 
                var nextYear = aqDateTime.AddMonths(currentDate, 12);
                var items = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
                var count = items.Count;
                for (i=0; i<count; i++)
                {
                  if (items.Item(i).DataItem.ShortName == relationshipName_CR1302_Croes6139)
                  {
                     aqObject.CheckProperty(items.Item(i).DataItem, "ReviewFrequencyDescription", cmpEqual, reviewFrequency);
                     aqObject.CheckProperty(items.Item(i).DataItem, "ReviewDate", cmpEqual, null);
                     aqObject.CheckProperty(items.Item(i).DataItem, "NextReviewDate", cmpEqual, nextYear);
                     break;
                  }
                }
      }
      catch (e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
      }         
      finally { 
                //Supprimer la relation créée
                 //DeleteRelationship(relationshipName_CR1302_Croes6139);
                 // Close Croesus 
                 Terminate_CroesusProcess();
                 Terminate_IEProcess();
      }    
      
}
