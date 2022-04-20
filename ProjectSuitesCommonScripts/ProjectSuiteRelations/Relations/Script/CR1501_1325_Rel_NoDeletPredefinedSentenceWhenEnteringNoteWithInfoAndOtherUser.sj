//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
     
       Préconditions
       Se connecter avec COPERN.
       
      https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1325
   
         1-Choisir le module relation.:Le module relation s'ouvre correctement.
         2-Sélectionner une relation:La relation est bien sélectionnée.
         3-Cliquer sur le bouton 'Info' ensuite cliquer sur le bouton 'Ajouter'.:La fenêtre 'Ajouter une note' est ouverte.
         4-Sélectionner une phrase prédéfinie crée avec l'utilisateur 'UNI00'.:Le bouton 'Supprimer' est grisé.
       
        
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_1325_Rel_NoDeletPredefinedSentenceWhenEnteringNoteWithInfoAndOtherUser()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1325");
         //SA: j'utilise GP1859 au lieu de UNI00 parce que lui aussi son type d'accés SYSADM et il a la PREF_EDIT_FIRM_FUNCTIONS=YES

         userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
         passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         
         //Les variables
         var nameRelation1CROES1325=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation1CROES1325", language+client);
         var namePredefinSentenceCROES1325=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "namePredefinSentenceCROES1325", language+client);
         var sentencePredefinedCROES1325=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "namePredefinSentenceCROES1325", language+client);
         var createdBySentPrefedCROES1319=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "createdBySentPrefedCROES1319", language+client);
         var IACodeCROES1275=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "IACodeCROES1275", language+client);
         
         Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "NO", vServerRelations);
         RestartServices(vServerRelations)
         
        
         //Ajout d'une phrase prédéfinie par l'utilisateur GP1859
         Login(vServerRelations, userNameGP1859, passwordGP1859, language);
           //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          //Ajout d'une nouvelle relation
           Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
          SearchRelationshipByName(nameRelation1CROES1325);
          var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1325, 10);
          if (searchResult.Exists){
              Log.Message("The relationship " + nameRelation1CROES1325 + " already exists.");
          }
          else{
          Get_Toolbar_BtnAdd().Click();
          Delay(100);
          Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
          Delay(1000);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(nameRelation1CROES1325);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(nameRelation1CROES1325);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(IACodeCROES1275);
          Get_WinDetailedInfo_BtnOK().Click();
          }
          //fin d'ajout de la relation
          
          SelectRelationships(nameRelation1CROES1325)
      
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1325, 10).Click();
          Get_RelationshipsBar_BtnInfo().Click()
         Get_WinDetailedInfo_TabInfo().Click();
         Get_WinInfo_Notes_TabGrid().Click();
         //Ajout d'une note  
         Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          //Ajoute d'une phrase prédéfinie
          Get_WinCRUANote().Parent.maximize();
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
        
           //Ajout d'une phrase prédéfinie
           Log.Message("CROES-10996 il faut corriger le script quand l'anomalie: CROES-10996 sera corrigée ")
           Get_WinCRUANote_BtnAddPredefinedSentences().Click();
           Get_WinAddNewSentence_TxtName().Click()
           Get_WinAddNewSentence_TxtName().set_Text(namePredefinSentenceCROES1325);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().set_Text(sentencePredefinedCROES1325);
           Get_WinAddNewSentence_BtnSave().Click();
           //La phrase prédéfinie esr ajoutée
             
            var displaySenPredefCROES1325=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES1325, 10)//.WPFControlText
           if(displaySenPredefCROES1325.Exists)
           {
             var textDisplaySenPredefCROES1325=displaySenPredefCROES1325.WPFControlText;
             Log.Message(textDisplaySenPredefCROES1325)
             CheckEquals(textDisplaySenPredefCROES1325,namePredefinSentenceCROES1325,"Le nom de la phrase prédéfinie ");
             var index =displaySenPredefCROES1325.Record.index
             var displayCreatedByCROES1325=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue
         
              CheckEquals(displayCreatedByCROES1325,createdBySentPrefedCROES1319,"Créée par est ")
           }
           else 
           {
             Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
           }
           Get_WinCRUANote_BtnCancel1().Click();
           Get_WinDetailedInfo_BtnOK().Click();
           Close_Croesus_SysMenu();
           //Se connecter avec COPERN
           Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
           
           //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          SelectRelationships(nameRelation1CROES1325)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1325, 10).Click();
          Get_RelationshipsBar_BtnInfo().Click()
          Get_WinDetailedInfo_TabInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
       
         //Ajout d'une note  
         Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
           
           //Les poinst de vérifications
           Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES1325, 10).Click();
           if(Get_WinCRUANote_BtnDeletePredefinedSentences().Exists && Get_WinCRUANote_BtnDeletePredefinedSentences().VisibleOnScreen )
           {
             aqObject.CheckProperty(Get_WinCRUANote_BtnDeletePredefinedSentences(), "Enabled", cmpEqual, false);
           }
           else
           {
             Log.Error("Le bouton supprimer n'existe pas")
           }
           
           
           
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameGP1859, passwordGP1859, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        SearchRelationshipByName(nameRelation1CROES1325)
        DeletePrefdefinSentence(namePredefinSentenceCROES1325,nameRelation1CROES1325)
         Get_WinCRUANote_BtnCancel1().Click();
        DeleteRelationship(nameRelation1CROES1325)
        Terminate_CroesusProcess();
        /*Delete_PredefinedSentences(namePredefinSentenceCROES1325, vServerRelations)
        Delete_PredefinedSentences("", vServerRelations)
        Delete_PredefinedSentencesGRD(vServerRelations)*/
        Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerRelations);
         RestartServices(vServerRelations)
        
        
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameGP1859, passwordGP1859, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
           SearchRelationshipByName(nameRelation1CROES1325)
        DeletePrefdefinSentence(namePredefinSentenceCROES1325,nameRelation1CROES1325)
         Get_WinCRUANote_BtnCancel1().Click();
        DeleteRelationship(nameRelation1CROES1325)
        Terminate_CroesusProcess()
       /* Delete_PredefinedSentences(namePredefinSentenceCROES1325, vServerRelations)
        Delete_PredefinedSentences("", vServerRelations)
        Delete_PredefinedSentencesGRD(vServerRelations);*/
        Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerRelations);
         RestartServices(vServerRelations)
        
      
        
    }
}
function DeletePrefdefinSentence(namePredefinSentence,nameRelation)
{
  Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation, 10).Click();
  Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation, 10).ClickR();
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
  var existenPredefineSentence=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", namePredefinSentence, 10)
  if(existenPredefineSentence.Exists &&  existenPredefineSentence.VisibleOnScreen )
  {
  Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", namePredefinSentence, 10).Click();
  Get_WinCRUANote_BtnDeletePredefinedSentences().Click();
  Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
  }
  else
  {
    Log.Message("La phrase prédéfinie n'existe pas parmi la liste des phrases prédéfinies")
  
  Get_WinCRUANote_BtnCancel1().Click();
  return;
  }
  
}