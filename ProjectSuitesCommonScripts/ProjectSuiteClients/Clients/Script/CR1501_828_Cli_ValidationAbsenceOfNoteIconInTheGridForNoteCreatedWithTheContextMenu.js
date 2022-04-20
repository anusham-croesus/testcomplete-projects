//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**

        Préconditions :
        Se connecter avec COPERN.
      
        
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-828
   
         1- Choisir le module client:Le module client s'ouvre correctement    
         2-Sélectionner un client.:Le client est bien sélectionné.
         3-Faire un click-right et choisir l'option 'Ajouter une note':
         L'option 'Ajouter une note' est présente et la fenêtre d'ajout d'une note est affichée.
         4-Saisir une note et sauvegarder.:La note est ajoutée au client.
         5-Sélectionner le client ensuite cliquer sur le bouton 'Info':La fenêtre info du client sélectionné est ouverte.
         6-Sélectionner la note crée ensuite cliquer sur le bouton 'Supprimer'.:La note est supprimée.
         7-Sélectionner le client.:L'icône de note est absente à gauche du client.
         
         
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-8--V9-Be_1-co6x
*/


function CR1501_828_Cli_ValidationAbsenceOfNoteIconInTheGridForNoteCreatedWithTheContextMenu()
{
     try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-828");
         
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
        
         //Les variables
         
         var numberClient800232=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800232", language+client);
         var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
         var ClientTextAddNotTestCROES828=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "ClientTextAddNotTestCROES828", language+client);
         var createdByNoteCROES752=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "createdByNoteCROES752", language+client);
         
         
         Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module client
         Get_ModulesBar_BtnClients().Click();
         Search_Client(numberClient800232);
         //Ajouter une note avec le click right
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800232, 10).ClickR();
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         //Ajouter une note au client 800300
         var dateCreationCROES754=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d %#I:%M");
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
      
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().Keys(ClientTextAddNotTestCROES828);
         
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         var textAjoutNoteCROES828=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
         Log.Message(textAjoutNoteCROES828)
         
         Get_WinCRUANote_BtnSave().Click();
         
         Search_Client(numberClient800232);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800232, 10).Click()
         Get_ClientsBar_BtnInfo().Click();
         //Les points de vérificationss
         Get_WinInfo_Notes_TabGrid().Click();
         
         WaitObject(Get_WinDetailedInfo(),["UID", "IsSelected"], ["TabItem_fc72", true]);
         Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",textAjoutNoteCROES828,10).Click();
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNoteCROES828);
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, ClientTextAddNotTestCROES828);
         //Clic sur le bouton supprimer
         Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
         Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
         Get_WinDetailedInfo_BtnOK().Click();
         //les poinst de vérifications :7-Sélectionner le client.:L'icône de note est absente à gauche du client.
         Search_Client(numberClient800232);
         var indexClient=Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800232, 10).Record.Index
         //Les points de vérifications
         var valuIconHasNote=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indexClient).DataItem.HasNote
         if(valuIconHasNote == true)
         {
          Log.Error("L'icône existe") 
         }
         else
         {
           Log.Checkpoint("L'icône n'existe pas")
         }
          
        
          
    }   
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_Note(ClientTextAddNotTestCROES828, vServerClients)
      
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(ClientTextAddNotTestCROES828, vServerClients)
      
        
    }
}