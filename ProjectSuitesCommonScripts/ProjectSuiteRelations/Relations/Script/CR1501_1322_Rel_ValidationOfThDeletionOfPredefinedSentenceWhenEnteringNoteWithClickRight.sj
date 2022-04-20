//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR1501_1325_Rel_NoDeletPredefinedSentenceWhenEnteringNoteWithInfoAndOtherUser


/**
     
       Préconditions
       Se connecter avec COPERN.
       
      https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1322
   
         1-Choisir le module relation.:Le module relation s'ouvre correctement.
         2-Sélectionner une relation:La relation est bien sélectionnée.
         3-Faire un click-right et choisir 'Ajouter une note':La fenêtre 'ajouter une note' est ouverte.
         4-Sélectionner une phrase prédéfinie crée avec l'utilisateur copern.:Le bouton 'Supprimer phrase' n'est pas grisé.
         5-Cliquer sur le bouton 'Supprimer phrase' ensuite fermer la fenêtre 'Ajouter une note' et l'ouvrir de nouveau.:
         La phrase est supprimée.
         
        
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_1322_Rel_ValidationOfThDeletionOfPredefinedSentenceWhenEnteringNoteWithClickRight()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1322");
        
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
         var nameRelation1CROES1322=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation1CROES1322", language+client);
         var namePredefinSentenceCROES1322=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "namePredefinSentenceCROES1322", language+client);
         var sentencePredefinedCROES1322=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "namePredefinSentenceCROES1322", language+client);
         var createdBySentPrefedCROES1319=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "createdBySentPrefedCROES1319", language+client);
         var IACodeCROES1275=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "IACodeCROES1275", language+client);
         
         //Ajout d'une phrase prédéfinie par l'utilisateur GP1859
         Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
           //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          //Ajout d'une nouvelle relation
           Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
          SearchRelationshipByName(nameRelation1CROES1322);
          var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1322, 10);
          if (searchResult.Exists){
              Log.Message("The relationship " + nameRelation1CROES1322 + " already exists.");
          }
          else{
          Get_Toolbar_BtnAdd().Click();
          Delay(100);
          Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
          Delay(1000);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(nameRelation1CROES1322);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(nameRelation1CROES1322);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(IACodeCROES1275);
          Get_WinDetailedInfo_BtnOK().Click();
          }
          //fin d'ajout de la relation
          
          SearchRelationshipByName(nameRelation1CROES1322)
      
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1322, 10).Click();
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1322, 10).ClickR();
           Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
          //Ajoute d'une phrase prédéfinie avec l'option click-right
          Get_WinCRUANote().Parent.maximize();
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
        
           //Ajout d'une phrase prédéfinie
           Log.Message("CROES-10996 il faut corriger le script quand l'anomalie: CROES-10996 sera corrigée ")
           Get_WinCRUANote_BtnAddPredefinedSentences().Click();
           Get_WinAddNewSentence_TxtName().Click()
           Get_WinAddNewSentence_TxtName().set_Text(namePredefinSentenceCROES1322);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().set_Text(sentencePredefinedCROES1322);
           Get_WinAddNewSentence_BtnSave().Click();
           //La phrase prédéfinie esr ajoutée
             
            var displaySenPredefCROES1322=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES1322, 10)//.WPFControlText
           if(displaySenPredefCROES1322.Exists)
           {
             var textDisplaySenPredefCROES1322=displaySenPredefCROES1322.WPFControlText;
             Log.Message(textDisplaySenPredefCROES1322)
             CheckEquals(textDisplaySenPredefCROES1322,namePredefinSentenceCROES1322,"Le nom de la phrase prédéfinie ");
             var index =displaySenPredefCROES1322.Record.index
             var displayCreatedByCROES1322=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue
         
              CheckEquals(displayCreatedByCROES1322,createdBySentPrefedCROES1319,"Créée par est ")
           }
           else 
           {
             Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
           }
           Get_WinCRUANote_BtnCancel1().Click();
          
          //Suppression de la pharse prédéfinie
          SelectRelationships(nameRelation1CROES1322)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1322, 10).Click();
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1322, 10).ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES1322, 10).Click()//.WPFControlText
          Get_WinCRUANote_BtnDeletePredefinedSentences().Click() 
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
          Get_WinCRUANote_BtnCancel1().Click();
          //Les poinst de vérifications
          SearchRelationshipByName(nameRelation1CROES1322)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1322, 10).Click();
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1322, 10).ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
          //
          var displayPredefinedSentence=  Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES1322, 10);
            if(displayPredefinedSentence.Exists && displayPredefinedSentence.VisibleOnScreen )
           {
             Log.Error("La phrase prédéfinie n'est pas supprimée")
           }
           else
           {
             Log.Checkpoint("La phrase prédéfinie est supprimée")
           }
           
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        SearchRelationshipByName(nameRelation1CROES1322)
        DeletePrefdefinSentence(namePredefinSentenceCROES1322,nameRelation1CROES1322)
        DeleteRelationship(nameRelation1CROES1322)
        Terminate_CroesusProcess();
        /*Delete_PredefinedSentences(namePredefinSentenceCROES1322, vServerRelations)
        Delete_PredefinedSentences("", vServerRelations)
        Delete_PredefinedSentencesGRD(vServerRelations)*/
        Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerRelations);
         RestartServices(vServerRelations)
        
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        SearchRelationshipByName(nameRelation1CROES1322)
        DeletePrefdefinSentence(namePredefinSentenceCROES1322,nameRelation1CROES1322)
        DeleteRelationship(nameRelation1CROES1322)
        Terminate_CroesusProcess()
       /* Delete_PredefinedSentences(namePredefinSentenceCROES1322, vServerRelations)
        Delete_PredefinedSentences("", vServerRelations)
        Delete_PredefinedSentencesGRD(vServerRelations);*/
        Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerRelations);
        RestartServices(vServerRelations)
        
      
    }
}