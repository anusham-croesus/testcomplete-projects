//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
     https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1280

     Préconditions : 
     -La préférence 'PREF_NOTE_DELETE'=YES.
     -Se connecter avec l'utilisateur COPERN.
     
     1-Choisir le module relation:Le module relation s'ouvre correctement.
     2-Sélectionner une relation.:La relation est bien sélectionnée.
     3-Cliquer sur le bouton 'Info':La fenêtre info s'ouvre.
     4-Choisir l'onglet note ensuite cliquer sur le bouton 'Ajouter' pour ajouter une note.:
       L'onglet 'Note' est sélectionnée et la fenêtre d'ajout d'une note s'ouvre.
     5-Ajouter la note .:La note est ajoutée.
     6-Sélectionner la note crée ensuite cliquer sur le bouton 'Supprimer'.:Le bouton Supprimer est 
     actif et la note est supprimée.
     
     
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_1280_Rel_DeletingCreatedNoteWithInfoButtonTheSameDayAndByTheSameUser()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1280");
    
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
         //Les variables
           
            var RelTextAddNotCROES1280=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "RelTextAddNotCROES1280", language+client);
            var textphrasePredefiniCROES1344=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "textphrasePredefiniCROES1344", language+client);
            var nameRelation1CROES1280=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation1CROES1280", language+client);
            var IACodeCROES1275=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "IACodeCROES1275", language+client);
            
           Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","YES",vServerRelations);
            RestartServices(vServerRelations);
          
            
          Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
          //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
           
         CreateRelationship(nameRelation1CROES1280,IACodeCROES1275)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1280, 10).Click();
         Get_RelationshipsBar_BtnInfo().Click()
         Get_WinDetailedInfo_TabInfo().Click();
         Get_WinInfo_Notes_TabGrid().Click(); 
         //Ajout d'une note
          Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(RelTextAddNotCROES1280);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          var textAjoutNote=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
          Log.Message(textAjoutNote)
          Get_WinCRUANote_BtnSave().Click();
          
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, RelTextAddNotCROES1280);
            var textNotCROES1280= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES1280.Exists;
            Log.Message(x);
          if(textNotCROES1280.Exists && textNotCROES1280.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
            Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10).Click();
            //Les points de vérification
         if(Get_WinInfo_Notes_TabGrid_BtnDelete().Exists && Get_WinInfo_Notes_TabGrid_BtnDelete().VisibleOnScreen )
         {
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "Enabled", cmpEqual, true);
           Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
           Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
         }
         else
         { 
           Log.Error("Le bouton supprimer n'est pas disponible");
         }
         Get_WinDetailedInfo_BtnOK().Click();
          //Les points de vérification la note est supprimée
          SearchRelationshipByName(nameRelation1CROES1280)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1280, 10).Click(); 
          Get_RelationshipsBar_BtnInfo().Click()
          Get_WinDetailedInfo_TabInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
         var textNotCROES1280=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES1280.Exists;
            Log.Message(x);
          if(textNotCROES1280.Exists)
            {
             Log.Error("La note n'est pas supprimée")
            }
            else{
              Log.Checkpoint("La note est supprimée")
            }
             Get_WinDetailedInfo_BtnCancel().Click();
               
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1280)
        Terminate_CroesusProcess();
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
         Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1280)
        Terminate_CroesusProcess();
     
       
            
}
    
}