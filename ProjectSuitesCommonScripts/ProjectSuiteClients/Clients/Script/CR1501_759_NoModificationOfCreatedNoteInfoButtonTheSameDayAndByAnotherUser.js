//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**

        Préconditions :
        La preference PREF_EDIT_NOTE=YES.
       
        
        https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-759
   
         1-Se connecter avec COPERN.:L'application s'ouvre correctement.
         2- Choisir le module client: Le module client s'ouvre correctement.      
         3-Sélectionner un client par exemple le client : ANNY ALARY dont le numéro est : 800300:Le client est bien sélectionné.
         4-Ajouter une note a ce client a partir du bouton  'info':La note est ajoutée.
         5-Fermer l'application.:L'application se ferme correctement.
         6-Se connecter à l'application avec 'DALTOJ':L'application est ouverte
         7-Choisir le module client:Le module client s'ouvre correctement.
         8-Sélectionner le client '800300' :Le client 800300'  est sélectionné.
         9-Cliquer sur le bouton 'Info' ensuite choisir l'onglet 'Notes'.:La fenêtre Info est ouverte 
         et l'onglet 'Notes' est sélectionné.
         10-Sélectionner la note crée par l'utilisateur 'COPERN'.:La note est sélectionnée.
         11-Essayer de modifier la note:On peut pas modifier la note et le libellé
          de la bouton 'Modifier ' a changé. Le libellé est devenue 'Consulter'.
         
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-8--V9-Be_1-co6x
*/


function CR1501_759_NoModificationOfCreatedNoteInfoButtonTheSameDayAndByAnotherUser()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-759");
         
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         userNameDALTOJ= ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "username");
         passwordDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "psw");
          
        /* Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerClients);
         RestartServices(vServerClients);*/
         //Les variables
         
         var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
         var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
         var ClientTextAddNotTestCROES759=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "ClientTextAddNotTestCROES759", language+client);
         var ClientTextModNotTestCROES759=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "ClientTextModNotTestCROES759", language+client);
         
         Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module client
         Get_ModulesBar_BtnClients().Click();
         Search_Client(numberClient800300);
         //Ajouter une note a partir d'info
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
         Get_ClientsBar_BtnInfo().Click();
         Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
        
         //Ajouter une note au client 800300
       
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
      
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().Keys(ClientTextAddNotTestCROES759);
         
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         var textAjoutNoteCROES759=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
         Log.Message(textAjoutNoteCROES759)
         
         Get_WinCRUANote_BtnSave().Click();
         //sélectionner la note ensuite sur le bouton modifier 
         Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES759), 10).Click();
         Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         
         
         Get_WinCRUANote_GrpNote_TxtNote().Clear();
         Get_WinCRUANote_GrpNote_TxtNote().Keys(ClientTextModNotTestCROES759);
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         var textModifNoteCROES759=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
         Log.Message(textModifNoteCROES759)
          Get_WinCRUANote_BtnSave().Click();
          //Les points de vérifications 
            var textNotCROES759= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textModifNoteCROES759), 10)
            var x=textNotCROES759.Exists;
            Log.Message(x);
          if(textNotCROES759.Exists)
            {
              var indexCROES759=textNotCROES759.Record.index
              Log.Message(indexCROES759)
            
              var displayNoteCROES759=VarToString(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(indexCROES759).DataItem.Comment.OleValue)
              
            CheckEquals(displayNoteCROES759,textModifNoteCROES759,"La note est ")//La note est
            
            }
            else{
              Log.Error("La note n'est pas modifié")
            }

                  
         Get_WinDetailedInfo_BtnOK().Click();

          Close_Croesus_X();
          // se connecter avec DALTOJ
          Login(vServerClients, userNameDALTOJ, passwordDALTOJ, language);
          Get_ModulesBar_BtnClients().Click();
          Search_Client(numberClient800300);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click()
         Get_ClientsBar_BtnInfo().Click();
         //Les points de vérificationss
         Get_WinInfo_Notes_TabGrid().Click();
         //Vérifier qu'on peut pas modifier la note
         WaitObject(Get_WinDetailedInfo(),["UID", "IsSelected"], ["TabItem_fc72", true]);
         Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",textModifNoteCROES759,10).Click();
         
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
        Delete_Note(ClientTextAddNotTestCROES759, vServerClients)
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(ClientTextAddNotTestCROES759, vServerClients)
      
        
    }
}

function test()
{
       
         var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
         var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
         var ClientTextAddNotTestCROES759=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "ClientTextAddNotTestCROES759", language+client);
         var ClientTextModNotTestCROES759=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "ClientTextModNotTestCROES759", language+client);
         
  
         Get_WinCRUANote_GrpNote_TxtNote().Clear();
         Get_WinCRUANote_GrpNote_TxtNote().Keys(ClientTextModNotTestCROES759);
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         var textModifNoteCROES759=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
         Log.Message(textModifNoteCROES759)
         
}