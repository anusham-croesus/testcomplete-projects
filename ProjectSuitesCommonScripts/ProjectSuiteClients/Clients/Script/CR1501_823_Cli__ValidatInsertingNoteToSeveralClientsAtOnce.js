//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-823
   
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2- Sélectionner 6 clients.:Les clients sont bien sélectionnés.
         3-Faire un click-right et choisir l'option 'Ajouter une note'.:La fenêtre 'Ajouter une note à 6 clients' s'affiche correctement.
         4-Côcher le choix '6 Clients sélectionnés'.:Le choix '6 Clients sélectionnés' est bien côché.
         5-Ajouter 'heure & date',  une phrase prédéfinie ensuite cliquer sur le bouton sauvegarder.:La phrase prédéfinie et ''heure & date ' sont insérés correctemet.
         La fenêtre 'ajouter une note à 6 clients' est fermée.
         6-Ouvrir la fenêtre info de chaque client(6 sélectionnés précédemment) ensuite sélectionner l'onglet note.:La note est bien ajoutée sur chaque client.
         
         
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_823_Cli__ValidatInsertingNoteToSeveralClientsAtOnce()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-823");
         
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
          
         
         
         //Les variables
         
         var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
         var PortTextAddNotTestCROES823=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "PortTextAddNotTestCROES823", language+client);
         
         
         Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
          //Choisir le module client
          Get_ModulesBar_BtnClients().Click();
         
          
          
           var arrayContentOfNumber = new Array();
          
            for(i = 0; i < 6; i++){
              firstRowDescription = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientNumber);
            
            arrayContentOfNumber.push(firstRowDescription);
            Log.Message(arrayContentOfNumber[i])
            
           
          }
          // sélectionner les 6 premiers clients
          
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayContentOfNumber[0], 10).Click();
           //Maintenir la touche SHIFT enfoncée
           Sys.Desktop.KeyDown(0x10);
           
           //Sélectionner le 6 éme élmenet 
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayContentOfNumber[5], 10).Click(); 
           //Relâcher la touche Shift
           Sys.Desktop.KeyUp(0x10);
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayContentOfNumber[5], 10).ClickR(); 
           Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         
           //Ajouter une note aux 6 clients
           Get_WinCRUANote_GrpNote_RdoSelectedPositions().Set_IsChecked(true);
           WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
           Get_WinCRUANote_GrpNote_TxtNote().Click()
           Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotTestCROES823);
         
           Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
           Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
           Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
           WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
           var textAjoutNoteCROES823=Get_WinCRUANote_GrpNote_TxtNote().Text;
           Log.Message(textAjoutNoteCROES823)
           Get_WinCRUANote_BtnSave().Click();
   
          //Les points de vérifications
            for(n = 0; n < 6; n++)
        {
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayContentOfNumber[n], 10).DblClick(); 
        
         Get_WinInfo_Notes_TabGrid().Click();
          // Les points de vérifications : la note a été bien ajouté
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNoteCROES823);
          
            var textNotCROES823= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES823), 10)
            var x=textNotCROES823.Exists;
            Log.Message(x);
          if(textNotCROES823.Exists)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
             Get_WinDetailedInfo_BtnCancel().Click();
            
        }
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotTestCROES823, vServerClients)
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotTestCROES823, vServerClients)
      
        
    }
}