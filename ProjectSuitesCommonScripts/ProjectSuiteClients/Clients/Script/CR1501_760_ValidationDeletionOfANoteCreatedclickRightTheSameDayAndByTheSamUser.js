//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**

        Préconditions :
        La préférence 'PREF_NOTE_DELETE'=YES.
        Se connecter avec COPERN.

        
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-760
   
         1- Choisir le module client:Le module client s'ouvre correctement    
         2-Sélectionner un client.:Le client est bien sélectionné.
         3-Ajouter une note a ce client avec l'option click-right.:La note est ajoutée.
         4-Cliquer sur le bouton 'Info':La fenêtre info du client sélectionné est ouverte.
         5-Sélectionner la note crée ensuite cliquer sur le bouton 'Supprimer'.:La note est supprimée.
         
    Auteur : Sana Ayaz
    
    Version de scriptage:		ref90-08-Dy-8--V9-Be_1-co6x
*/


function CR1501_760_ValidationDeletionOfANoteCreatedclickRightTheSameDayAndByTheSamUser()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-760");
         
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
          
          Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","YES",vServerClients);
          RestartServices(vServerClients);

         //Les variables
         
         var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
         var ClientTextAddNotTestCROES760=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "ClientTextAddNotTestCROES760", language+client);
         var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
       
         Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module client
         Get_ModulesBar_BtnClients().Click();
         Search_Client(numberClient800300);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).ClickR();
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         //Ajouter une note au client 800300
       
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
      
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().Keys(ClientTextAddNotTestCROES760);
         
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         var textAjoutNoteCROES760=Get_WinCRUANote_GrpNote_TxtNote().Text;
         Log.Message(textAjoutNoteCROES760)
         
         Get_WinCRUANote_BtnSave().Click();
         
         
          Search_Client(numberClient800300);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).DblClick();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES760), 10).Click();
          
         
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNoteCROES760);
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, ClientTextAddNotTestCROES760);
          
            
          Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
          
            
          //Les points de vérifications
          
            var textNotCROES760= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES760), 10)
            var x=textNotCROES760.Exists;
            Log.Message(x);
          if(textNotCROES760.Exists)
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
        Delete_Note(ClientTextAddNotTestCROES760, vServerClients)
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(ClientTextAddNotTestCROES760, vServerClients)
      
        
    }
}
