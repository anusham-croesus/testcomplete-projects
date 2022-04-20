//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
     https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1278

    La préférence 'PREF_NOTE_DELETE'=YES
    Se connecter avec l'utilisateur 'COPERN'
     
     
    
     1-Choisir le module relation:Le module relation s'ouvre correctement.
     2-Sélectionner une relation qui contient une note crée hier (une note qui n'est pas crée la même journée)par l'utilisateur 'Copern'.:
     La relation est bien sélectionnée.
     3-:Cliquer sur le bouton 'Info' ensuite choisir l'onglet 'Notes'.:La fenêtre Info est ouverte et l'onglet 'Notes' est sélectionné.
     4-Sélectionner la note crée par l'utilisateur 'Copern' et qui n'est pas crée la même journée.:
       On peut pas supprimer la note et le bouton 'Supprimer' est grisé.
       
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_1278_Rel_NotDeleting_NoteThatIsNotCreatedTheSameDayButWithTheSameUser()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1278");
    
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
           
            var RelTextAddNotCROES1278=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "RelTextAddNotCROES1278", language+client);
            var textphrasePredefiniCROES1344=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "textphrasePredefiniCROES1344", language+client);
            var nameRelation1CROES1278=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation1CROES1278", language+client);
            var IACodeCROES1275=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "IACodeCROES1275", language+client);
            
           Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","YES",vServerRelations);
           RestartServices(vServerRelations);
           Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
          //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
           
         CreateRelationship(nameRelation1CROES1278,IACodeCROES1275)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1278, 10).ClickR(); 
         //Ajout d'une note avec l'option du click-right
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(RelTextAddNotCROES1278);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          var textAjoutNote=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
          Log.Message(textAjoutNote)
          Get_WinCRUANote_BtnSave().Click();
          
          //Modifier la date de création a partir de la BD
          // Obtain the current date
                    var CurrentDate = aqDateTime.Today();

                    // Convert the date/time value to a string and post it to the log
                    Today = aqConvert.DateTimeToStr(CurrentDate);
                    Log.Message("Today is " + Today);

                    // Calculate the yesterday’s date, convert the returned date to a string and post this string to the log
                    YesterdayDate = aqDateTime.AddDays(CurrentDate, -1);
                    ConvertedYesterdayDate = aqConvert.DateTimeToStr(YesterdayDate);
                    Log.Message("Yesterday was " + ConvertedYesterdayDate);
                    //
  
                    var FormatDateYesterday=aqConvert.DateTimeToFormatStr(ConvertedYesterdayDate, "%b %d %Y %#I:%M %p")
                    Log.Message(FormatDateYesterday);
          
                    UpdateDateCreation_Note(RelTextAddNotCROES1278,FormatDateYesterday,vServerRelations);

          //Cliquer sur le bouton 'Info'
          SearchRelationshipByName(nameRelation1CROES1278)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1278, 10).Click(); 
          Get_RelationshipsBar_BtnInfo().Click()
          Get_WinDetailedInfo_TabInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10).Click();
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, RelTextAddNotCROES1278);
            var textNotCROES1278= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES1278.Exists;
            Log.Message(x);
          if(textNotCROES1278.Exists && textNotCROES1278.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
           
          //Les points de vérification
         if(Get_WinInfo_Notes_TabGrid_BtnDelete().Exists && Get_WinInfo_Notes_TabGrid_BtnDelete().VisibleOnScreen )
         {
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "Enabled", cmpEqual, false);
          
         }
         else
         { 
           Log.Error("Le bouton supprimer n'est pas disponible");
         }
        Get_WinDetailedInfo_BtnOK().Click();
            
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1278)
        Terminate_CroesusProcess();
       
        
    }
    finally {
   
        Terminate_CroesusProcess();
         Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1278)
        Terminate_CroesusProcess();
     
       
        
    }
    
}