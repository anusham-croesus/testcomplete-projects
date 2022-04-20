//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**

        Préconditions :
        Se connecter avec COPERN.
        La préférence pref_edit_note=YES

        
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-754
   
         1- Choisir le module client:Le module client s'ouvre correctement    
         2-Sélectionner un client.:Le client est bien sélectionné.
         3-Ajouter une note a ce client avec l'option click-right.:La note est ajoutée.
         4-Cliquer sur le bouton 'Info':La fenêtre info du client sélectionné est ouverte.
         5-Sélectionner la note crée ensuite cliquer sur le bouton 'Modifier'.:La fenêtre de modification d'une note 
         est affichée.
         6-Modifier la note ensuite cliquer sur le bouton sauvegarder.:La note est modifiée.
         
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-8--V9-Be_1-co6x
*/


function CR1501_754_ModificationOfANotClickRightCreatedTheSameDayAndByTheSameUser()
{
     try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-754");
         
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerClients);
         RestartServices(vServerClients);
         //Les variables
         
         var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
         var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
         var ClientTextAddNotTestCROES754=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "ClientTextAddNotTestCROES757", language+client);
         var ClientTextAddNotTestCROES754Modif=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "ClientTextAddNotTestCROES754Modif", language+client);
         var createdByNoteCROES752=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "createdByNoteCROES752", language+client);
         
         
         Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module client
         Get_ModulesBar_BtnClients().Click();
         Search_Client(numberClient800300);
         //Ajouter une note avec le click right
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).ClickR();
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         //Ajouter une note au client 800300
         var dateCreationCROES754=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d %#I:%M");
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
      
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().Keys(ClientTextAddNotTestCROES754);
         
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         var textAjoutNoteCROES754=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
         Log.Message(textAjoutNoteCROES754)
         
         Get_WinCRUANote_BtnSave().Click();
         
         Search_Client(numberClient800300);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click()
         Get_ClientsBar_BtnInfo().Click();
         //Les points de vérificationss
         Get_WinInfo_Notes_TabGrid().Click();
         
         WaitObject(Get_WinDetailedInfo(),["UID", "IsSelected"], ["TabItem_fc72", true]);
         Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",textAjoutNoteCROES754,10).Click();
         //Clic sur le bouton modifier
         Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
          var dateModificationCROES754=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d %#I:%M");
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
      
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().Keys(ClientTextAddNotTestCROES754Modif);
         
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         var textAjoutNoteCROES754AfterModified=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
         Log.Message(textAjoutNoteCROES754AfterModified)
         
         Get_WinCRUANote_BtnSave().Click();
        
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNoteCROES754AfterModified);
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, ClientTextAddNotTestCROES754Modif);
         Get_WinDetailedInfo_BtnOK().Click();
         //Les points de vérification
       
          Search_Client(numberClient800300);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).DblClick();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES754AfterModified), 10).Click();
          
         
          
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNoteCROES754AfterModified);
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, ClientTextAddNotTestCROES754Modif);
            var textNotCROES754= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES754AfterModified), 10)
            
          if(textNotCROES754.Exists)
            {
              var indexCROES754=textNotCROES754.Record.index
              Log.Message(indexCROES754)
            
              var displayEffectiveDateCROES754=Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(indexCROES754).DataItem.EffectiveDate
              var displayCreationDateCROES754=aqConvert.DateTimeToFormatStr(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(indexCROES754).DataItem.DateCreat, "%Y/%m/%d %#I:%M")
              var displayCreatedByCROES754=VarToString(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(indexCROES754).DataItem.FullName.OleValue)
              var displayNoteCROES754=VarToString(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(indexCROES754).DataItem.Comment.OleValue)
              var displayModificationDateCROES754=aqConvert.DateTimeToFormatStr(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(indexCROES754).DataItem.DateMaj, "%Y/%m/%d %#I:%M")
              
             CheckEquals(displayEffectiveDateCROES754,null,"Date de référence est") 
             
             CheckEquals(displayCreationDateCROES754,dateCreationCROES754,"Date de création est")
             CheckEquals(displayCreatedByCROES754,createdByNoteCROES752," Créée par est ")
             CheckEquals(displayNoteCROES754,textAjoutNoteCROES754AfterModified,"La note est ")//La note est
             //Les points de vérifications pour la date de modification
                   if(Get_WinInfo_Notes_TabGrid_DgvNotes_ChModificationDate().Exists)
                   {
                       CheckEquals(displayModificationDateCROES754,dateModificationCROES754,"Date de modification est")
             
                   }
                   //Si la colonne date de modification n'exite pas il faut l'ajouter
                   else
                   {
                     Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR(); 
                     Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                     Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click(); 
                     CheckEquals(displayModificationDateCROES754,dateModificationCROES754,"Date de modification est")
                     Get_WinInfo_Notes_TabGrid_DgvNotes_ChModificationDate().Click();
                     Get_WinInfo_Notes_TabGrid_DgvNotes_ChModificationDate().ClickR();
                     Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
                    
               
                   }
            }
            else{
              Log.Error("La note n'est pas modifiée")
            }
             Get_WinDetailedInfo_BtnCancel().Click();
            
         
         
         
          
        
          
    }   
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_Note(ClientTextAddNotTestCROES754, vServerClients)
        Delete_Note(textAjoutNoteCROES754AfterModified, vServerClients)
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(ClientTextAddNotTestCROES754, vServerClients)
        Delete_Note(textAjoutNoteCROES754AfterModified, vServerClients)
        
    }
}
