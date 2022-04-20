//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4290
    
   
    Description :Gestion des notes Clients.
    Préconditions : La préférence PREF_EDIT_NOTE=YES
                    La préférence PREF_NOTE_DELETE=YES
            
    Auteur : Asma Alaoui
    
    ref90-10-Fm-6--V9-croesus-co7x-1_5_565
    
    Date: 15/04/2019
*/

function Regression_Croes_4290_Cli_NotesManagement()
{
  try {
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4290", "Croes-4290"); 
    
    Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerClients);
    Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","YES",vServerClients);
    RestartServices(vServerClients); 
    
    var clientNum800228=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNum_4290", language+client);
    var addNote=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ajoutNote", language+client);
    var addSentence=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ajoutPhrase", language+client);
    var phrasePredefinie=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "phrasePredefinie", language+client);
    var phraseModifiee=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "phraseModifiee", language+client);

    
    //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    //Sélectionner le client 800228   
    Search_Client(clientNum800228);
    
    //Ajouter une note a partir d'info
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum800228, 10).Click();
    Get_ClientsBar_BtnInfo().Click();
    Get_WinInfo_Notes_TabGrid().Click();
    Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
    
    //Cliquer sur Ajouter et remplir les champs Nom et Phrase
    Get_WinCRUANote_BtnAddPredefinedSentences().Click();
    Get_WinAddNewSentence_TxtName().Keys(addNote);
    Get_WinAddNewSentence_TxtSentence().Keys(addSentence);
    Get_WinAddNewSentence_BtnSave().Click();
    
    //Valider l'affichage des deux notes dans Phrases prédéfinies
     aqObject.CheckProperty(Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", addNote, 10),"Exists", cmpEqual, true)
     aqObject.CheckProperty(Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", addNote, 10),"VisibleOnScreen", cmpEqual, true)
   
     //Ajouter une phrase prédéfinie "Laissé message à"
     Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", phrasePredefinie, 10).Click();
     Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
     Get_WinCRUANote_BtnSave().Click();
     
     //Valider l'affichage de la note    
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phrasePredefinie, 10),"Exists", cmpEqual, true)
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phrasePredefinie, 10),"VisibleOnScreen", cmpEqual, true)
     
     //Modifier la note ajouté 
     Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phrasePredefinie, 10).Click();
     Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
     Get_WinCRUANote_GrpNote_TxtNote().Keys("^a");
     Get_WinCRUANote_GrpNote_TxtNote().Keys(phraseModifiee);
     Get_WinCRUANote_BtnSave().Click();
     Get_WinDetailedInfo_BtnOK().Click();
     
     //Supprimer la note ajoutée
     Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum800228, 10).DblClick();
     WaitObject(Get_WinDetailedInfo(),"UID","NoteDataGrid_ddf6")
     Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phraseModifiee, 10).Click();
     Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
     Get_DlgConfirmation_BtnDelete().WaitProperty("VisibleOnScreen", true, 20000)
     Get_DlgConfirmation_BtnDelete().Click();
     
     //Valider que la note est supprimée
     if (Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phrasePredefinie, 10).Exists== true)
     Log.Error("La note ajotée existe encore")
      else
       Log.Checkpoint("la note ajoutée: "+phrasePredefinie+" est supprimée") 
     
     Get_WinDetailedInfo_BtnOK().Click();
  }  
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    Delete_PredefinedSentences(addNote, vServerClients)

  }
  finally {
    Terminate_CroesusProcess();
    Delete_PredefinedSentences(addNote, vServerClients)

    
  }   

}
