//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
     https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1275

     Préconditions : 
    La préférence 'pref_edit_note '=YES.
     
     
     1-Se connecter avec COPERN.:L'application s'ouvre correctement.
     2-Choisir le module relation:Le module relation s'ouvre correctement.
     3-Sélectionner une relation.:La relation est bien sélectionnée.
     4-Ajouter une note a cette relation a partir du bouton  'info':La note est ajoutée.
     5-Fermer l'application.:L'application se ferme correctement.
     6-Se connecter à l'application avec 'DALTOJ':L'application est ouverte
     7-Choisir le module relation:Le module relation s'ouvre correctement.
     8-Sélectionner la relation surlaquelle on a ajouté la note précédemment.:La relation est sélectionnée.
     9-Cliquer sur le bouton 'Info' ensuite choisir l'onglet 'Notes'.:La fenêtre Info est ouverte et l'onglet 'Notes' est sélectionné.
     10-Sélectionner la note crée par l'utilisateur 'COPERN'.:La note est sélectionnée.
     11-Essayer de modifier la note:On peut pas modifier la note et le libellé de la bouton 'Modifier ' a changé. Le libellé est devenue 'Consulter'.
     
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_1275_Rel_Not_ModifyingCreatedNoteWithInfoButtonTheSameDayAndByAnotherUser()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1275");
    
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
          userNameDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "username");
          passwordDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "psw");
         
         //Les variables
           
            var RelTextAddNotCROES1275=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "RelTextAddNotCROES1275", language+client);
            var textphrasePredefiniCROES1344=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "textphrasePredefiniCROES1344", language+client);
            var nameRelation1CROES1275=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation1CROES1275", language+client);
            var IACodeCROES1275=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "IACodeCROES1275", language+client);
            
            Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerRelations);
            RestartServices(vServerRelations);
          
            
          Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
          //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
           
         CreateRelationship(nameRelation1CROES1275,IACodeCROES1275)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1275, 10).Click(); 
         Get_RelationshipsBar_BtnInfo().Click()
         Get_WinDetailedInfo_TabInfo().Click();
         Get_WinInfo_Notes_TabGrid().Click();
       
         //Ajout d'une note  
         Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(RelTextAddNotCROES1275);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          var textAjoutNote=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
          Log.Message(textAjoutNote)
          Get_WinCRUANote_BtnSave().Click();
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, RelTextAddNotCROES1275);
            var textNotCROES1275= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES1275.Exists;
            Log.Message(x);
          if(textNotCROES1275.Exists && textNotCROES1275.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
            Get_WinDetailedInfo_BtnOK().Click();
            Close_Croesus_X();
          //Se connecter a  l'application avec DALTOJ
          Login(vServerRelations, userNameDALTOJ, passwordDALTOJ, language);
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          SearchRelationshipByName(nameRelation1CROES1275)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1275, 10).Click(); 
          Get_RelationshipsBar_BtnInfo().Click()
          Get_WinDetailedInfo_TabInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10).Click();
          //Les points de vérifications
          
              //Les points de vérification
         if(Get_WinInfo_Notes_TabGrid_BtnEdit().Exists && Get_WinInfo_Notes_TabGrid_BtnEdit().VisibleOnScreen )
         {
           Log.Error("Le bouton modifier existe et visble sur l'écran");
         }
         else
         { 
            if(Get_WinInfo_Notes_TabGrid_BtnDisplay().Exists && Get_WinInfo_Notes_TabGrid_BtnDisplay().VisibleOnScreen )
            {
              aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "Enabled", cmpEqual, true);
              Log.Checkpoint("Le bouton consulter existe et visible sur l'écran") 
            }
         }
          
       
        
          
          
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1275)
        Terminate_CroesusProcess();
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
         Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1275)
        Terminate_CroesusProcess();
     
       
        
    }
    
}