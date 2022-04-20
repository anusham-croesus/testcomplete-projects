//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
  Description : Note sur position
  
  Regrouper les cas suivants:
  Croes-671 Validation de l'ajout d'une phrase prédéfinie
  Croes-677 Validation de la modification d'une phrase prédéfinie lors de la saisie d'une note avec 'Info'
  Croes-690 Validation des champs grisés au bas de la fenêtre sont en lecture seule lors de l'ajout d'une note
  Croes-566 - La recherche avec le filtre par 'Note' et Opérateur 'ne contenant pas'
  Croes-1246 Validation de la modification d'un filtre de recherche
  Croes-1247 Validation de la suppression d'un filtre de recherche
  Croes-729+735 Validation de la présence des notes dans la fenêtre des 'Activités' du module client
  Croes-736 Validation d'information selon les colonnes de la fenêtre 'Activité du module compte
  Croes-731 Validation de la présence des notes dans la fenêtre des 'Activités' du module relation
  Croes-693 Validation que la section des phrases prédéfinies est absente lors de consultation d'une note

    
  Analyste d'assurance qualité : Karima Mo
  Analyste d'automatisation : Emna IHM  
  Version de scriptage:		ref90-21-2020-11-34
*/


 function CR1501_OptiTCVE_3669_NoteOnPosition()
 {  
    try{
      //Afficher le lien de cas de test global
      Log.Link("https://jira.croesus.com/browse/TCVE-3669", "Cas de test sur Jira: TCVE-3669");  
      
      var copern = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
      var pswCopern = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");         
      
     //Les variables
      var numberAccount800300NA = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800300NA", language+client);
      var namePredefinSentenceCROES671 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "namePredefinSentenceCROES671", language+client);
      var sentencePredefinedCROES671 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "sentencePredefinedCROES671", language+client);
      var createdBySentPrefedCROES671 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "createdBySentPrefedCROES671", language+client);
      var positionDescripCROES566 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "positionDescripCROES566", language+client);
          
      Log.Message("se connercter avec Copern");
      Login(vServerPortefeuille, copern, pswCopern, language);
          
      //********************************** Étape 1 : Validation de l'ajout d'une phrase prédéfinie lors de la saisie d'une note avec un click-right **********************************/
      Log.AppendFolder("Étape 1: Croes-671 - Valider l'ajout d'une phrase prédéfinie lors de la saisie d'une note avec un click-right");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-671", "Cas de test TestLink: Croes-671");  
     //**********************************************************************************************************************************************************************/
    
      Log.Message("Choisir le module comptes"); 
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);    
      Get_MainWindow().Maximize();
      
      Log.Message("Sélectionner le compte "+numberAccount800300NA);
      Search_Account(numberAccount800300NA);
      //Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800300NA, 10).Click();
          
      Log.Message("Mailler vers le module portefeuille");
      Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800300NA, 10), Get_ModulesBar_BtnPortfolio());
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");        
      
      Log.Message("Sélectionner la position "+positionDescripCROES566+", right clic --> Ajouter une note");
      Search_PositionByDescription(positionDescripCROES566);  
      Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).ClickR();
      Get_PortfolioGrid_ContextualMenu_AddANote().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["NoteDetailWindow_2d5e", true]); 
      
      //********************************** Étape 3 : Validation des champs grisés au bas de la fenêtre sont en lecture seule lors de l'ajout d'une note **********************************/
      Log.AppendFolder("Étape 3: Croes-690 - Valider que les champs grisés au bas de la fenêtre sont en lecture seule lors de l'ajout d'une note.");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-690", "Cas de test TestLink: Croes-690");  
      //**********************************************************************************************************************************************************************/
    
      Log.Message("Valider que le contenu des champs 'Position', 'Date de création' et 'Créée par' est grisé.");
      Log.Message("Valider le contenu du champ position.");
      aqObject.CheckProperty(Get_WinCRUANote_TxtPositionForPositionAndSecurity(), "Enabled", cmpEqual, false);
      aqObject.CheckProperty(Get_WinCRUANote_TxtPositionForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
      Log.Message("Valider le contenu du champ date de création.");
      aqObject.CheckProperty(Get_WinCRUANote_TxtCreationDateForPositionAndSecurity(), "Enabled", cmpEqual, false);
      aqObject.CheckProperty(Get_WinCRUANote_TxtCreationDateForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
      Log.Message("Valider le contenu du champ Créée par.");
      aqObject.CheckProperty(Get_WinCRUANote_TxtCreatedByForPositionAndSecurity(), "Enabled", cmpEqual, false);
      aqObject.CheckProperty(Get_WinCRUANote_TxtCreatedByForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
      
      Log.PopLogFolder();
      
      //**********************************************************************************************************************************************************************/           
      Log.Message("Ajout d'une phrase prédéfinie name: "+namePredefinSentenceCROES671+" sentence: "+sentencePredefinedCROES671);
      Get_WinCRUANote_BtnAddPredefinedSentences().Click();
      Get_WinAddNewSentence_TxtName().Click()
      Get_WinAddNewSentence_TxtName().set_Text(namePredefinSentenceCROES671);
      Get_WinAddNewSentence_TxtSentence().Click()
      Get_WinAddNewSentence_TxtSentence().set_Text(sentencePredefinedCROES671);
      Get_WinAddNewSentence_BtnSave().Click();
      Get_WinCRUANote_BtnCancel1().Click();
      
      Log.Message("Sélectionner la position "+positionDescripCROES566+", right clic --> Ajouter une note");
      Search_PositionByDescription(positionDescripCROES566)  
      Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).ClickR();
      Get_PortfolioGrid_ContextualMenu_AddANote().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["NoteDetailWindow_2d5e", true]); 
      
      Log.Message("Les points de vérifications: Vérifier que la nouvelle phrase saisie est ajoutée à la liste des phrases prédéfinies");
      var displaySenPredefName=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", namePredefinSentenceCROES671, 10);
      aqObject.CheckProperty(displaySenPredefName, "Exists", cmpEqual, true);
      aqObject.CheckProperty(displaySenPredefName, "VisibleOnScreen", cmpEqual, true);      
      aqObject.CheckProperty(displaySenPredefName, "Enabled", cmpEqual, true);      
      aqObject.CheckProperty(displaySenPredefName.DataContext.DataItem, "Description", cmpEqual, namePredefinSentenceCROES671);
      aqObject.CheckProperty(displaySenPredefName.DataContext.DataItem, "SentenceText", cmpEqual, sentencePredefinedCROES671);
      Log.Message("CROES-10547");
      aqObject.CheckProperty(displaySenPredefName.DataContext.DataItem, "FullName", cmpEqual, createdBySentPrefedCROES671); //créé par Croesus Sysadm      
            
      Log.PopLogFolder();
      
      //********************************** Étape 2 : Validation de la modification d'une phrase prédéfinie lors de la saisie d'une note avec 'Info' **********************************/
      Log.AppendFolder("Étape 2: Croes-677 - Validation de la modification d'une phrase prédéfinie lors de la saisie d'une note avec 'Info'");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-677", "Cas de test TestLink: Croes-677");  
     //**********************************************************************************************************************************************************************/
    
      var namePredefinSentenceModCROES677=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "namePredefinSentenceModCROES677", language+client);
      var sentencePredefinedModCROES677=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "sentencePredefinedModCROES677", language+client);
          
      Log.Message("Sélectionner la phrase prédéfinie ajoutéé dans l'étape1 puis faire un double clic pour la modifier");
      Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", namePredefinSentenceCROES671, 10).Click(); 
      Get_WinCRUANote_BtnEditPredefinedSentences().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["PredefSentenceSaveWindow_1986", true]); 
      Get_WinEditSentence_TxtName().Click()
      Get_WinEditSentence_TxtName().set_Text(namePredefinSentenceModCROES677);
      Get_WinEditSentence_TxtSentence().Click()
      Get_WinEditSentence_TxtSentence().set_Text(sentencePredefinedModCROES677);
      Get_WinEditSentence_BtnSave().Click();
      Get_WinCRUANote_BtnCancel1().Click();
      
      Log.Message("Sélectionner la position "+positionDescripCROES566+" et ouvrir la fenetre info");
      Search_PositionByDescription(positionDescripCROES566);  
      Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).Click();
      Get_PortfolioBar_BtnInfo().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_dca0", true]);//attendre que le TabNotes soit visible
      
      Get_WinPositionInfo_TabNotes().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_fc72", true]);//attendre que le TabGrid soit visible
      Get_WinInfo_Notes_TabGrid().Click();
      Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["NoteDetailWindow_2d5e", true]); 
      
      Log.Message("Les points de vérifications: Vérifier que la phrase prédéfinie est modifiée. Name: "+namePredefinSentenceModCROES677+" sentence: "+sentencePredefinedModCROES677);
      var displaySenPredefNameModif=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", namePredefinSentenceModCROES677, 10);
      aqObject.CheckProperty(displaySenPredefNameModif, "Exists", cmpEqual, true);
      aqObject.CheckProperty(displaySenPredefNameModif, "VisibleOnScreen", cmpEqual, true);
      aqObject.CheckProperty(displaySenPredefNameModif, "Enabled", cmpEqual, true);
      aqObject.CheckProperty(displaySenPredefNameModif.DataContext.DataItem, "Description", cmpEqual, namePredefinSentenceModCROES677);
      aqObject.CheckProperty(displaySenPredefNameModif.DataContext.DataItem, "SentenceText", cmpEqual, sentencePredefinedModCROES677);
                  
      Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", namePredefinSentenceModCROES677, 10).Click();
      Get_WinCRUANote_BtnEditPredefinedSentences().WaitProperty("IsEnabled", true, 30000);
      Get_WinCRUANote_BtnEditPredefinedSentences().Click();
      
      //Les points de vérifications
      aqObject.CheckProperty(Get_WinEditSentence_TxtName(), "Text", cmpEqual, namePredefinSentenceModCROES677);
      aqObject.CheckProperty(Get_WinEditSentence_TxtName(), "Enabled", cmpEqual, true);
      aqObject.CheckProperty(Get_WinEditSentence_TxtName(), "Exists", cmpEqual, true);
      aqObject.CheckProperty(Get_WinEditSentence_TxtName(), "VisibleOnScreen", cmpEqual, true);
          
      aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "Text", cmpEqual, sentencePredefinedModCROES677);
      aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "Enabled", cmpEqual, true);
      aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "Exists", cmpEqual, true);
      aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "VisibleOnScreen", cmpEqual, true);
          
      Get_WinEditSentence_BtnCancel().Click();            
      
      Log.PopLogFolder();
      
      //********************************** Étape 4 : Cliquer sur la petite flèche dirigée vers la gauche pour ajouter la note qu'on a mit dans la phrase prédéfinie  puis Sauvegarder **********************************/
      Log.AppendFolder("Étape 4: Cliquer sur la petite flèche dirigée vers la gauche pour ajouter une note contenant la phrase prédéfinie déjà ajoutée puis Sauvegarder");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/browse/TCVE-3669", "Étape 4 de TCVE-3669");  
     //**********************************************************************************************************************************************************************/
     Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
     Get_WinCRUANote_BtnSave().Click();
     WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_fc72", true]);//attendre que le TabGrid soit visible
     
     var positionNote = sentencePredefinedModCROES677;
     Log.Message("Valider l'ajout de la note contenant la phrase prédéfinie: "+sentencePredefinedModCROES677);
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, positionNote);
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", positionNote, 10),"Exists", cmpEqual, true);
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", positionNote, 10),"VisibleOnScreen", cmpEqual, true);
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", positionNote, 10).DataContext.DataItem,"Comment", cmpEqual, positionNote);
     
     //Récupérer la date de création de la note pour l'utiliser après dans Croes-729
     var positionNoteDateCreation = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", positionNote, 10).DataContext.DataItem.DateCreat.OleValue;
     
     Get_WinPositionInfo_BtnOK().Click();     
      
     Log.PopLogFolder();
     
     //********************************** Étape 5 : La recherche avec le filtre par 'Note' et Opérateur 'ne contenant pas' **********************************/
      Log.AppendFolder("Étape 5: Croes-566 - La recherche avec le filtre par 'Note' et Opérateur 'ne contenant pas'");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-566", "Cas de test TestLink: Croes-566");  
     //**********************************************************************************************************************************************************************/
    
      var donesNotContaiNoteCROES566 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "donesNotContaiNoteCROES566", language+client);
      var descriptionFiltreNoteCROES566 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "descriptionFiltreNoteCROES566", language+client);
      var PortTextAddNotTestCROES566=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES566", language+client);
      
      Log.Message("Sélectionner la position "+positionDescripCROES566+" et ouvrir la fenetre info");
      Search_PositionByDescription(positionDescripCROES566);  
      Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).Click();
      Get_PortfolioBar_BtnInfo().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_dca0", true]);//attendre que le TabNotes soit visible
      
      Get_WinPositionInfo_TabNotes().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_fc72", true]);//attendre que le TabGrid soit visible
      Get_WinInfo_Notes_TabGrid().Click();
      
      Log.Message("Ajouter une note test pour tester le filtre à créer.");
      Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
      Get_WinCRUANote_GrpNote_TxtNote().Click()
      Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotTestCROES566);
      Get_WinCRUANote_GrpNote_TxtNote().Click()
      Get_WinCRUANote_BtnSave().WaitProperty("IsEnabled", true, 30000);
      Get_WinCRUANote_BtnSave().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_fc72", true]);//attendre que le TabGrid soit visible
      
      Log.Message("Cliquer sur filtre et choisir le filtre 'Note' et Opérateur 'ne contenant pas' Valeur = "+donesNotContaiNoteCROES566);
      Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10);
      Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_Note().Click();
      Get_WinCreateFilter_CmbOperator().Click();
      Get_WinCreateFilter_CmbOperator_ItemNotContaining().Click();
      Get_WinCreateFilter_TxtValue().Click();
      Get_WinCreateFilter_TxtValue().SetText(donesNotContaiNoteCROES566);
      Get_WinCreateFilter_BtnApply().Click();
      
      //Les points de vérification 
      Log.Message("Valider que le filtre créé "+descriptionFiltreNoteCROES566+" existe et actif.");
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "Exists", cmpEqual, true);
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, descriptionFiltreNoteCROES566);
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  */
      
      Log.Message("Valider que la note créé à l'étape précédente est affichée.");
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, positionNote);
      var displayNoteAfterFiltre = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", positionNote, 10);
      aqObject.CheckProperty(displayNoteAfterFiltre, "Exists", cmpEqual, true);
      aqObject.CheckProperty(displayNoteAfterFiltre, "VisibleOnScreen", cmpEqual, true);
      aqObject.CheckProperty(displayNoteAfterFiltre, "Enabled", cmpEqual, true);
      aqObject.CheckProperty(displayNoteAfterFiltre.DataContext.DataItem, "Comment", cmpEqual, positionNote);  
      
      Log.Message("Valider que la note "+PortTextAddNotTestCROES566+" ne s'affiche pas car elle contient le mot "+donesNotContaiNoteCROES566);
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", PortTextAddNotTestCROES566, 10), "Exists", cmpEqual, false);          
      
      Log.PopLogFolder();
      
      //********************************** Étape 6 : Validation de la modification d'un filtre de recherche **********************************/
      Log.AppendFolder("Étape 6: Croes-1246 - Valider de la modification d'un filtre de recherche");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1246", "Cas de test TestLink: Croes-1246");  
     //**********************************************************************************************************************************************************************/
      
      var descriptionUpdatedFiltreNote = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "DescriptionUpdatedFiltreNoteCroes1246", language+client);;
     
      Log.Message("Cliquer sur le crayon du filtre pour le modifier.:La fenêtre de modification d'un filter est ouverte.");
      var descriptionFilter=Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext.FilterDescription.OleValue
      Log.Message(descriptionFilter)
      Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilterByDescription_BtnEditView(descriptionFilter).Click();
      
      Log.Message("Choisir Opérateur 'contenant' Valeur = "+donesNotContaiNoteCROES566);          
      Get_WinCreateFilter_CmbOperator().Click();
      Get_WinCreateFilter_CmbOperator_ItemContaining().Click();
      Get_WinCreateFilter_BtnApply().Click();
      
      //Les points de vérification 
      Log.Message("Valider que le filtre est modifié: "+descriptionUpdatedFiltreNote+" existe et actif.");
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "Exists", cmpEqual, true);
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, descriptionUpdatedFiltreNote);
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  */
      
      Log.Message("Valider que la note "+PortTextAddNotTestCROES566+" est affichée.");
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, PortTextAddNotTestCROES566);
      var displayNoteAfterFiltre = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", PortTextAddNotTestCROES566, 10);
      aqObject.CheckProperty(displayNoteAfterFiltre, "Exists", cmpEqual, true);
      aqObject.CheckProperty(displayNoteAfterFiltre, "VisibleOnScreen", cmpEqual, true);
      aqObject.CheckProperty(displayNoteAfterFiltre, "Enabled", cmpEqual, true);
      aqObject.CheckProperty(displayNoteAfterFiltre.DataContext.DataItem, "Comment", cmpEqual, PortTextAddNotTestCROES566);  
      
      Log.Message("Valider que la note "+positionNote+" ne s'affiche pas car elle ne contient pas le mot "+donesNotContaiNoteCROES566);
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", positionNote, 10), "Exists", cmpEqual, false);          
      
      Log.PopLogFolder();
      
      //********************************** Étape 7 : Validation de la suppression d'un filtre de recherche **********************************/
      Log.AppendFolder("Étape 7: Croes-1247 - Validation de la suppression d'un filtre de recherche");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1247", "Cas de test TestLink: Croes-1247");  
     //**********************************************************************************************************************************************************************/
    
      Log.Message("Cliquer sur le X pour retirer le filtre "+descriptionUpdatedFiltreNote);
      
      descriptionFilter=Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext.FilterDescription.OleValue
      Log.Message(descriptionFilter)
      Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilterByDescription_BtnRemove(descriptionFilter).Click();
      //Les poins de vérifications
          
      var existenceFiltre= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("WPFControlText",descriptionFilter,10);
      if(existenceFiltre.Exists && existenceFiltre.VisibleOnScreen)
        Log.Error("Le filtre "+descriptionFilter+" n'est pas supprimé");
      else
        Log.Checkpoint("Le filtre "+descriptionFilter+" est  supprimé");
              
      //Fermer la fenetre Info position
      Get_WinPositionInfo_BtnOK().Click();
      
      Log.Message("Supprimer la note test de la BD.");    
      Delete_Note(PortTextAddNotTestCROES566, vServerPortefeuille);
           
      Log.PopLogFolder();
      
      //********************************** Étape 8 : Validation de la présence des notes dans la fenêtre des 'Activités' du module client **********************************/
      Log.AppendFolder("Étape 8: Croes-729+735 - Validation de la présence des notes dans la fenêtre des 'Activités' du module client");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-729", "Cas de test TestLink: Croes-729+735");  
     //**********************************************************************************************************************************************************************/
      
      var TypeActiviteCROES729 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "TypeActiviteCROES729", language+client); 
      var ActivCreateByCROES729 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivCreateByCROES729", language+client);
      var ActivSourceCROES566=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivSourceCROES566", language+client);
      
      if(language == "french")    
        var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d");
      else
         var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y");
      
      Log.Message("Mailler la position "+positionDescripCROES566+" vers le module client.");
      Search_PositionByDescription(positionDescripCROES566);  
      Drag(Get_Portfolio_AssetClassesGrid().Find("Value", positionDescripCROES566,10), Get_ModulesBar_BtnClients());
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
        
      Log.Message("Cliquer sur le bouton 'Activité'.");
      Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
           
      Log.Message("Côcher le choix 'Inclure les éléments sous-jacents’.");
      Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems().set_IsChecked(true);
      Get_WinActivities_GrpActivities_GrpActivityType_CmbActivityType().Keys(TypeActiviteCROES729);
      
      Log.Message("Valider que la note crée sur la position "+positionDescripCROES566+" est présente.");
      var findPostionNote = Get_WinActivities_LstActivities().Find("Value", positionNote, 10);
      if (findPostionNote.Exists && findPostionNote.VisibleOnScreen)
        if(Get_WinActivities_LstActivities().Find("Value", positionNote, 10).DataContext.DataItem.ReferenceName == positionDescripCROES566)
          Log.Checkpoint("La note existe sur la liste des activité.");
        else
          Log.Error("La note n'existe pas sur la liste des activité.");
      
          
      Log.Message("Valider les colonnes de la fenêtre 'Activité'.");
      var displayActivDate = Get_WinActivities_LstActivities().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("XamTextEditor", "", 1).DisplayText; //Hf-12
      var displayActivType = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.TypeDescription;
      var displayActivSource = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.ReferenceNo;
      var displayActivName = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.ReferenceName;
      var displayActivCreatedBy = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.OwnerName;
      var displayActivDescription = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.Description;  
      
      Log.Message("Anomalie TCVE-396: Problème d’affichage des dates dans la fenêtre Activités. Voir section Details.","Validation ignorée pour le moment suite à la demande de Karima Me.");
      //CheckEquals(displayActivDate, ToDay, "Activty Date ");
        
      CheckEquals(displayActivType, TypeActiviteCROES729,"Activty Type ");
      CheckEquals(displayActivSource, ActivSourceCROES566, "Source ");
      Log.Message("CROES-10935");
      CheckEquals(displayActivName, positionDescripCROES566, "Activty Name ");
      CheckEquals(displayActivCreatedBy, ActivCreateByCROES729, "Activty CreatedBy ");
      CheckEquals(displayActivDescription, positionNote, "Activty Description ");
       
      Log.Message("Validation de la partie Details.");
      Get_WinActivities_LstActivities().Find("Value", positionNote, 10).Click();
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtSource(), "Text", cmpEqual, ActivSourceCROES566);
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtEffectiveDate(), "Text", cmpEqual, "");
      
      Log.Message("Anomalie TCVE-396: Problème d’affichage des dates dans la fenêtre Activités.");
      if (language == "french"){
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(positionNoteDateCreation, "%Y/%m/%d %H:%M"));
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%Y/%m/%d"));
      }              
      if (language == "english"){
          if (client == "CIBC"){
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(positionNoteDateCreation, "%m/%d/%Y %I:%M"));
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%m/%d/%Y %#I:%M"))
          }
          else {
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(positionNoteDateCreation, "%m/%d/%Y %H:%M"));
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%m/%d/%Y"));
          }
      }
      
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtUpdateDate(), "Text", cmpEqual, "");
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreatedByDate(), "Text", cmpEqual, ActivCreateByCROES729);
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtDescription(), "Text", cmpEqual, positionNote);
      
      Get_WinActivities_BtnClose().WaitProperty("Enabled", true, 30000);
      Get_WinActivities_BtnClose().Click();
      
      Log.PopLogFolder();
      
      //********************************** Étape 8_1 : Validation de la présence des notes dans la fenêtre des 'Activités' du module Clients. Faire le test pour un titre qui n'as pas de symbole **********************************/
      Log.AppendFolder("Étape 8_1: Croes-735 - Validation de la présence des notes dans la fenêtre des 'Activités' du module clients. Faire le test pour un titre qui n'as pas de symbole.");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-735", "Cas de test TestLink: Croes-735");  
     //**********************************************************************************************************************************************************************/
     
      var numberClient800205=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberClient800205", language+client);
      var numberAccount800205NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800205NA", language+client);
      var SecurityNoteCROES735=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES735", language+client);
      var ActivSourceCROES735=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivSourceCROES735", language+client);
      var positionDescripCROES735=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "positionDescripCROES735", language+client);
      var securityPositionCROES735=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "symbolPositionCROES735", language+client);
      var DescriTitreCROES735=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "DescriTitreCROES735", language+client);
        
      Log.Message("Aller dans le module Clients puis sélectionner le client "+numberClient800205); 
      Get_ModulesBar_BtnClients().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071"); 
      Search_Client(numberClient800205);
      
      Log.Message("Mailler vers le module titre le client "+numberClient800205);
      Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800205, 10), Get_ModulesBar_BtnSecurities());
      Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b");
      
      Log.Message("Sélectionner le titre "+securityPositionCROES735+" puis le mailler vers le module Portefeuille."); 
      Search_Security(securityPositionCROES735);
      Get_SecurityGrid().FindChild("Value", securityPositionCROES735, 10).Click();
      
      Drag(Get_SecurityGrid().FindChild("Value", securityPositionCROES735, 10), Get_ModulesBar_BtnPortfolio());
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
      Log.Message("Sélectionner la position "+securityPositionCROES735+" et ouvrir la fenetre info"); 
      Get_Portfolio_PositionsGrid().FindChild("Value", securityPositionCROES735, 10).Click();
        
      Get_PortfolioBar_BtnInfo().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_dca0", true]);//attendre que le TabNotes soit visible
      
      Get_WinPositionInfo_TabNotes().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_fc72", true]);//attendre que le TabGrid soit visible
      Get_WinInfo_Notes_TabGrid().Click();
      
      Log.Message("Ajouter une note et sauvegarder à la position "+securityPositionCROES735);
      Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
      Get_WinCRUANote_GrpNote_TxtNote().Click()
      Get_WinCRUANote_GrpNote_TxtNote().set_Text(SecurityNoteCROES735);
      Get_WinCRUANote_GrpNote_TxtNote().Click()
      Get_WinCRUANote_BtnSave().WaitProperty("IsEnabled", true, 30000);
      Get_WinCRUANote_BtnSave().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_fc72", true]);//attendre que le TabGrid soit visible
      
      Log.Message("Valider l'ajout de la note: "+SecurityNoteCROES735);
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, SecurityNoteCROES735);
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", SecurityNoteCROES735, 10),"Exists", cmpEqual, true);
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", SecurityNoteCROES735, 10),"VisibleOnScreen", cmpEqual, true);
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", SecurityNoteCROES735, 10).DataContext.DataItem,"Comment", cmpEqual, SecurityNoteCROES735);
     
      //Récupérer la date de création de la note pour l'utiliser après
      var positionNoteDateCreationCROES735 = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", SecurityNoteCROES735, 10).DataContext.DataItem.DateCreat.OleValue;
     
      Get_WinPositionInfo_BtnOK().Click();
      
      Log.Message("Mailler la position "+securityPositionCROES735+" vers le module client.");  
      Drag(Get_Portfolio_AssetClassesGrid().Find("Value", securityPositionCROES735,10), Get_ModulesBar_BtnClients());
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
        
      Log.Message("Cliquer sur le bouton 'Activité'.");
      Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
           
      Log.Message("Côcher le choix 'Inclure les éléments sous-jacents’.");
      Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems().set_IsChecked(true);
      Get_WinActivities_GrpActivities_GrpActivityType_CmbActivityType().Keys(TypeActiviteCROES729);
      
      Log.Message("Valider que la note crée sur la position "+securityPositionCROES735+" est présente.");
      var findPostionNote = Get_WinActivities_LstActivities().Find("Value", SecurityNoteCROES735, 10);
      if (findPostionNote.Exists && findPostionNote.VisibleOnScreen)
        if(Get_WinActivities_LstActivities().Find("Value", SecurityNoteCROES735, 10).DataContext.DataItem.ReferenceName == DescriTitreCROES735)
          Log.Checkpoint("La note existe sur la liste des activité.");
        else
          Log.Error("La note n'existe pas sur la liste des activité.");      
          
      Log.Message("Valider les colonnes de la fenêtre 'Activité'.");
      var displayActivDate = Get_WinActivities_LstActivities().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("XamTextEditor", "", 1).DisplayText; //Hf-12
      var displayActivType = Get_WinActivities_LstActivities().Find("Value", SecurityNoteCROES735, 10).DataContext.DataItem.TypeDescription;
      var displayActivSource = Get_WinActivities_LstActivities().Find("Value", SecurityNoteCROES735, 10).DataContext.DataItem.ReferenceNo;
      var displayActivName = Get_WinActivities_LstActivities().Find("Value", SecurityNoteCROES735, 10).DataContext.DataItem.ReferenceName;
      var displayActivCreatedBy = Get_WinActivities_LstActivities().Find("Value", SecurityNoteCROES735, 10).DataContext.DataItem.OwnerName;
      var displayActivDescription = Get_WinActivities_LstActivities().Find("Value", SecurityNoteCROES735, 10).DataContext.DataItem.Description;  
      
      Log.Message("Anomalie TCVE-396: Problème d’affichage des dates dans la fenêtre Activités. Voir section Details.","Validation ignorée pour le moment suite à la demande de Karima Me.");
      //CheckEquals(displayActivDate, ToDay, "Activty Date ");
        
      CheckEquals(displayActivType, TypeActiviteCROES729,"Activty Type ");
      CheckEquals(displayActivSource, ActivSourceCROES735, "Source ");
      Log.Message("CROES-10935");
      CheckEquals(displayActivName, DescriTitreCROES735, "Activty Name ");
      CheckEquals(displayActivCreatedBy, ActivCreateByCROES729, "Activty CreatedBy ");
      CheckEquals(displayActivDescription, SecurityNoteCROES735, "Activty Description ");
       
      Log.Message("Validation de la partie Details.");
      Get_WinActivities_LstActivities().Find("Value", SecurityNoteCROES735, 10).Click();
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtSource(), "Text", cmpEqual, ActivSourceCROES735);
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtEffectiveDate(), "Text", cmpEqual, "");
      
      Log.Message("Anomalie TCVE-396: Problème d’affichage des dates dans la fenêtre Activités.");
      if (language == "french"){
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(positionNoteDateCreationCROES735, "%Y/%m/%d %H:%M"));
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%Y/%m/%d"));
      }              
      if (language == "english"){
          if (client == "CIBC"){
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(positionNoteDateCreationCROES735, "%m/%d/%Y %I:%M"));
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%m/%d/%Y %#I:%M"))
          }
          else {
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(positionNoteDateCreationCROES735, "%m/%d/%Y %H:%M"));
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%m/%d/%Y"));
          }
      }
      
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtUpdateDate(), "Text", cmpEqual, "");
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreatedByDate(), "Text", cmpEqual, ActivCreateByCROES729);
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtDescription(), "Text", cmpEqual, SecurityNoteCROES735);
      
      Get_WinActivities_BtnClose().WaitProperty("Enabled", true, 30000);
      Get_WinActivities_BtnClose().Click();
      
      Log.PopLogFolder();
      
      //********************************** Étape 9 : Validation d'information selon les colonnes de la fenêtre 'Activité du module compte **********************************/
      Log.AppendFolder("Étape 9: Croes-736 - Validation d'information selon les colonnes de la fenêtre 'Activité du module compte");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-736", "Cas de test TestLink: Croes-736");  
     //**********************************************************************************************************************************************************************/
      
      Log.Message("Retourner vers module comptes."); 
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);    
      Get_MainWindow().Maximize();
      
      Log.Message("Sélectionner le compte "+numberAccount800300NA);
      Search_Account(numberAccount800300NA);
          
      Log.Message("Mailler vers le module portefeuille");
      Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800300NA, 10), Get_ModulesBar_BtnPortfolio());
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");   
      
      Log.Message("Sélectionner la position "+positionDescripCROES566);
      Search_PositionByDescription(positionDescripCROES566);  
      Drag(Get_Portfolio_AssetClassesGrid().Find("Value", positionDescripCROES566,10), Get_ModulesBar_BtnAccounts());
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
        
      Log.Message("Cliquer sur le bouton 'Activité'.");
      Get_RelationshipsClientsAccountsBar_BtnActivities().Click(); 
      
      Log.Message("Côcher le choix 'Inclure les éléments sous-jacents’.");
      Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems().set_IsChecked(true);
      Get_WinActivities_GrpActivities_GrpActivityType_CmbActivityType().Keys(TypeActiviteCROES729);
      
      Log.Message("Valider que la note crée sur la position "+positionDescripCROES566+" est présente.");
      var findPostionNote = Get_WinActivities_LstActivities().Find("Value", positionNote, 10);
      if (findPostionNote.Exists && findPostionNote.VisibleOnScreen)
        if(Get_WinActivities_LstActivities().Find("Value", positionNote, 10).DataContext.DataItem.ReferenceName == positionDescripCROES566)
          Log.Checkpoint("La note existe sur la liste des activité.");
        else
          Log.Error("La note n'existe pas sur la liste des activité.");
         
      Log.Message("Valider les colonnes de la fenêtre 'Activité'.");
      var displayActivDate = Get_WinActivities_LstActivities().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("XamTextEditor", "", 1).DisplayText; //Hf-12
      var displayActivType = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.TypeDescription;
      var displayActivSource = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.ReferenceNo;
      var displayActivName = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.ReferenceName;
      var displayActivCreatedBy = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.OwnerName;
      var displayActivDescription = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.Description;  
      
      Log.Message("Anomalie TCVE-396: Problème d’affichage des dates dans la fenêtre Activités. Voir section Details.","Validation ignorée pour le moment suite à la demande de Karima Me.");
      //CheckEquals(displayActivDate, ToDay, "Activty Date ");
        
      CheckEquals(displayActivType, TypeActiviteCROES729,"Activty Type ");
      CheckEquals(displayActivSource, ActivSourceCROES566, "Source ");
      Log.Message("CROES-10935");
      CheckEquals(displayActivName, positionDescripCROES566, "Activty Name ");
      CheckEquals(displayActivCreatedBy, ActivCreateByCROES729, "Activty CreatedBy ");
      CheckEquals(displayActivDescription, positionNote, "Activty Description ");
      
      Log.Message("Validation de la partie Details.");
      Get_WinActivities_LstActivities().Find("Value", positionNote, 10).Click();
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtSource(), "Text", cmpEqual, ActivSourceCROES566);
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtEffectiveDate(), "Text", cmpEqual, "");
      
      Log.Message("Anomalie TCVE-396: Problème d’affichage des dates dans la fenêtre Activités.");
      if (language == "french"){
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(positionNoteDateCreation, "%Y/%m/%d %H:%M"));
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%Y/%m/%d"));
      }              
      if (language == "english"){
          if (client == "CIBC"){
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(positionNoteDateCreation, "%m/%d/%Y %I:%M"));
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%m/%d/%Y %#I:%M"))
          }
          else {
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(positionNoteDateCreation, "%m/%d/%Y %H:%M"));
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%m/%d/%Y"));
          }
      }
      
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtUpdateDate(), "Text", cmpEqual, "");
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreatedByDate(), "Text", cmpEqual, ActivCreateByCROES729);
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtDescription(), "Text", cmpEqual, positionNote);
      
      Get_WinActivities_BtnClose().WaitProperty("Enabled", true, 30000);
      Get_WinActivities_BtnClose().Click();
      
      Log.PopLogFolder();
      
      //********************************** Étape 10 : Validation de la présence des notes dans la fenêtre des 'Activités' du module relation **********************************/
      Log.AppendFolder("Étape 10: Croes-731 - Validation de la présence des notes dans la fenêtre des 'Activités' du module relation");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-731", "Cas de test TestLink: Croes-731");  
     //**********************************************************************************************************************************************************************/
       
      Log.Message("Retourner dans le module Portefeuille puis sélectionner la position "+positionDescripCROES566); 
      Get_ModulesBar_BtnPortfolio().Click();
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd"); 
      
      Log.Message("Sélectionner la position "+positionDescripCROES566);
      Search_PositionByDescription(positionDescripCROES566);  
      Drag(Get_Portfolio_AssetClassesGrid().Find("Value", positionDescripCROES566,10), Get_ModulesBar_BtnRelationships());
      Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
        
      Log.Message("Cliquer sur le bouton 'Activité'.");
      Get_RelationshipsClientsAccountsBar_BtnActivities().Click(); 
      
      Log.Message("Côcher le choix 'Inclure les éléments sous-jacents’.");
      Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems().set_IsChecked(true);
      Get_WinActivities_GrpActivities_GrpActivityType_CmbActivityType().Keys(TypeActiviteCROES729);
      
      Log.Message("Valider que la note crée sur la position "+positionDescripCROES566+" est présente.");
      var findPostionNote = Get_WinActivities_LstActivities().Find("Value", positionNote, 10);
      if (findPostionNote.Exists && findPostionNote.VisibleOnScreen)
        if(Get_WinActivities_LstActivities().Find("Value", positionNote, 10).DataContext.DataItem.ReferenceName == positionDescripCROES566)
          Log.Checkpoint("La note existe sur la liste des activité.");
        else
          Log.Error("La note n'existe pas sur la liste des activité.");
         
      Log.Message("Valider les colonnes de la fenêtre 'Activité'.");
      var displayActivDate = Get_WinActivities_LstActivities().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("XamTextEditor", "", 1).DisplayText; //Hf-12
      var displayActivType = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.TypeDescription;
      var displayActivSource = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.ReferenceNo;
      var displayActivName = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.ReferenceName;
      var displayActivCreatedBy = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.OwnerName;
      var displayActivDescription = Get_WinActivities_LstActivities().Find("Value", positionDescripCROES566, 10).DataContext.DataItem.Description;  
      
      Log.Message("Anomalie TCVE-396: Problème d’affichage des dates dans la fenêtre Activités. Voir section Details.","Validation ignorée pour le moment suite à la demande de Karima Me.");
      //CheckEquals(displayActivDate, ToDay, "Activty Date ");
        
      CheckEquals(displayActivType, TypeActiviteCROES729,"Activty Type ");
      CheckEquals(displayActivSource, ActivSourceCROES566, "Source ");
      Log.Message("CROES-10935");
      CheckEquals(displayActivName, positionDescripCROES566, "Activty Name ");
      CheckEquals(displayActivCreatedBy, ActivCreateByCROES729, "Activty CreatedBy ");
      CheckEquals(displayActivDescription, positionNote, "Activty Description ");
       
      Log.Message("Validation de la partie Details.");
      Get_WinActivities_LstActivities().Find("Value", positionNote, 10).Click();
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtSource(), "Text", cmpEqual, ActivSourceCROES566);
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtEffectiveDate(), "Text", cmpEqual, "");
      
      Log.Message("Anomalie TCVE-396: Problème d’affichage des dates dans la fenêtre Activités.");
      if (language == "french"){
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(positionNoteDateCreation, "%Y/%m/%d %H:%M"));
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%Y/%m/%d"));
      }              
      if (language == "english"){
          if (client == "CIBC"){
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(positionNoteDateCreation, "%m/%d/%Y %I:%M"));
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%m/%d/%Y %#I:%M"))
          }
          else {
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(positionNoteDateCreation, "%m/%d/%Y %H:%M"));
              aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%m/%d/%Y"));
          }
      }
      
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtUpdateDate(), "Text", cmpEqual, "");
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreatedByDate(), "Text", cmpEqual, ActivCreateByCROES729);
      aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtDescription(), "Text", cmpEqual, positionNote);
      
      Get_WinActivities_BtnClose().WaitProperty("Enabled", true, 30000);
      Get_WinActivities_BtnClose().Click();
      
      Log.PopLogFolder();
         
      //********************************** Étape 11 : Valider que la section des phrases prédéfinies est absente lors de consultation d'une note **********************************/
      Log.AppendFolder("Étape 11: Croes-693 - Valider que la section des phrases prédéfinies est absente lors de consultation d'une note");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-693", "Cas de test TestLink: Croes-693");  
     //**********************************************************************************************************************************************************************/
     
      var keynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
      var pswKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw"); 
      var SectionPredefinedSentencesCROES693=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "SectionPredefinedSentencesCROES693", language+client);
      
      Log.Message("Se déconnecter de l'application et se reconnecter avec le user KEYNEJ"); 
      //Fermer Croesus
      Log.Message("Fermer Croesus")
      Close_Croesus_X();
      
      //Fermer le processus Croesus
      Terminate_CroesusProcess();       
      Login(vServerPortefeuille, keynej, pswKeynej, language);
      
      Log.Message("Choisir le module comptes"); 
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);    
      Get_MainWindow().Maximize();
      
      Log.Message("Sélectionner le compte "+numberAccount800300NA);
      Search_Account(numberAccount800300NA);
          
      Log.Message("Mailler vers le module portefeuille");
      Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800300NA, 10), Get_ModulesBar_BtnPortfolio());
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");        
      
      Log.Message("Sélectionner la position "+positionDescripCROES566+" et ouvrir la fenetre info");
      Search_PositionByDescription(positionDescripCROES566);  
      Get_Portfolio_AssetClassesGrid().Find("Value", positionDescripCROES566,10).Click();
      Get_PortfolioBar_BtnInfo().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_dca0", true]);//attendre que le TabNotes sera visible
      
      Get_WinPositionInfo_TabNotes().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_fc72", true]);//attendre que le TabGrid sera visible
      Get_WinInfo_Notes_TabGrid().Click();
      
      Log.Message("Cliquer sur le bouton Consulter pour consulter la note");
      Get_WinInfo_Notes_TabGrid_BtnDisplay().Click();      
      
      Log.Message("Vérifier que la section des phrases prédéfinies est absente");
      var existancePredefinedSentenceSection=  Get_WinNoteDetail().FindChild("WPFControlText", SectionPredefinedSentencesCROES693, 10).Exists;
      var visibleOnScreenPredefinedSentenceSection=  Get_WinNoteDetail().FindChild("WPFControlText", SectionPredefinedSentencesCROES693, 10).VisibleOnScreen;
           
      if(existancePredefinedSentenceSection && visibleOnScreenPredefinedSentenceSection)
        Log.Error("La section des phrases prédéfinies est présente alors qu'elle doit pas être présente.");
      else
        Log.Checkpoint("La section des phrases prédéfinies est absente.");
      
      Get_WinCRUANote_BtnClose().Click();
      Get_WinPositionInfo_BtnOK().Click(); 
      
      Log.PopLogFolder();
     
    }
    catch(e) 
    {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally{
      
      //Fermer Croesus
      Log.Message("Fermer Croesus")
      Close_Croesus_X();
  	  
      //Supprimer les notes créées
      Delete_Note(positionNote, vServerPortefeuille);
      Delete_Note(SecurityNoteCROES735, vServerPortefeuille);
      Delete_PredefinedSentences(namePredefinSentenceCROES671, vServerPortefeuille);
      Delete_PredefinedSentences(namePredefinSentenceModCROES677, vServerPortefeuille);
      Delete_PredefinedSentencesGRD(vServerPortefeuille);
      
      //Fermer le processus Croesus
      Terminate_CroesusProcess();         
      Runner.Stop(true)  
    
    }   
 }
 
 function Test(){
   var namePredefinSentenceCROES671 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "namePredefinSentenceCROES671", language+client);
    var namePredefinSentenceModCROES677=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "namePredefinSentenceModCROES677", language+client);
      var sentencePredefinedModCROES677=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "sentencePredefinedModCROES677", language+client);
      Log.Message("Sélectionner la phrase prédéfinie ajoutéé dans l'étape1 puis faire un double clic pour la modifier");
      Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", namePredefinSentenceCROES671, 10).Click(); 
      Get_WinCRUANote_BtnEditPredefinedSentences().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["PredefSentenceSaveWindow_1986", true]); 
      Get_WinEditSentence_TxtName().Click()
      Get_WinEditSentence_TxtName().set_Text(namePredefinSentenceModCROES677);
      Get_WinEditSentence_TxtSentence().Click()
      Get_WinEditSentence_TxtSentence().set_Text(sentencePredefinedModCROES677);
      Get_WinEditSentence_BtnSave().Click();
      Get_WinCRUANote_BtnCancel1().Click();
      Get_WinPositionInfo_BtnOK().Click();
 }
 