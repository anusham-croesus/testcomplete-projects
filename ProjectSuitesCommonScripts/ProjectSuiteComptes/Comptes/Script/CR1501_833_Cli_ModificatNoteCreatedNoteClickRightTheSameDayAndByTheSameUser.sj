//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
 https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-833
   
         1- Choisir le module compte.: Le module compte s'ouvre correctement.   
         2-Sélectionner un compte.:Le compte est bien sélectionné.
         3-Ajouter une note a ce compte avec l'option click-right.:La note est ajoutée.
         4-Cliquer sur le bouton 'Info':La fenêtre info du compte sélectionné est ouverte.
         5-Sélectionner la note crée ensuite cliquer sur le bouton 'Modifier'.:La fenêtre de modification d'une note est affichée.
         6-Modifier la note ensuite cliquer sur le bouton sauvegarder.:La note est modifiée.
        
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_833_Cli_ModificatNoteCreatedNoteClickRightTheSameDayAndByTheSameUser()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-833");
         
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         //Mettre la PREF_EDIT_NOTE a YES
         //SA:La preférence PREF_EDIT_NOTE est YES sur le dump de BNC
       /*  Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerAccounts);
         RestartServices(vServerAccounts);*/
         //Les variables
         var numberAccount800083=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "numberAccount800083", language+client);
         var PortTextAddNotTestCROES833=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "PortTextAddNotTestCROES833", language+client);
         var textphrasePredefiniCROES842=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "textphrasePredefiniCROES842", language+client);
         var ModifNoteCROES833=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "ModifNoteCROES833", language+client);
         
         Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module compte
         Get_ModulesBar_BtnAccounts().Click();
         SearchAccount(numberAccount800083);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).ClickR();
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         //Ajouter une note au compte 800300-NA
         
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
      
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().Keys(PortTextAddNotTestCROES833);
         
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES842, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         var textAjoutNoteCROES833=Get_WinCRUANote_GrpNote_TxtNote().Text;
         Log.Message(textAjoutNoteCROES833)
        
      
         Get_WinCRUANote_BtnSave().Click();
         
         //Sélectionner des notes ensuite modifier la note
          SearchAccount(numberAccount800083);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).Click();
          Get_AccountsBar_BtnInfo().Click();
          WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["TabItem", "Notes"])
          
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES833), 10).Click();
          Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
          Get_WinCRUANote().WaitProperty("VisibleOnScreen", true, 20000);
          
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_GrpNote_TxtNote().Keys(ModifNoteCROES833);
          var textAjoutNoteCROES833Modif=Get_WinCRUANote_GrpNote_TxtNote().Text;
          Log.Message(textAjoutNoteCROES833Modif)
          Get_WinCRUANote_BtnSave().Click();
          //Les points de vérifications
         
          var expectedNoteModif=aqString.Concat(textAjoutNoteCROES833,ModifNoteCROES833);
        
          //Les points de vérifications
           var textNotCROES833= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES833Modif), 10)
            if(textNotCROES833.Exists)
            {
              var indexCROES833=textNotCROES833.Record.index
              Log.Message(indexCROES833)
              var displayNoteCROES833=VarToString(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(indexCROES833).DataItem.Comment.OleValue)
              CheckEquals(displayNoteCROES833,expectedNoteModif,"La note est ")//La note est modifiée
              aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(), "wText", cmpEqual, expectedNoteModif);
              Log.Checkpoint("La note est modifiée")
            }
            else{
              Log.Error("La note n'est pas modifiée")
            }
            Get_WinDetailedInfo_BtnOK().Click();  
            //Les points de vérifications aprés avoir fermer la fenêtre d'info
            SearchAccount(numberAccount800083);
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).Click();
            Get_AccountsBar_BtnInfo().Click();
            Get_WinInfo_Notes_TabGrid().Click();
            Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES833Modif), 10).Click();
            
               //Les points de vérifications
           var textNotAfterCloseInfoCROES833= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES833Modif), 10)
            if(textNotAfterCloseInfoCROES833.Exists)
            {
              var indexCROES833AfterClose=textNotAfterCloseInfoCROES833.Record.index
              Log.Message(indexCROES833AfterClose)
              var displayNoteCROES833=VarToString(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(indexCROES833AfterClose).DataItem.Comment.OleValue)
              CheckEquals(displayNoteCROES833,expectedNoteModif,"La note est ")//La note est modifiée
              aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(), "wText", cmpEqual, expectedNoteModif);
              Log.Checkpoint("La note est modifiée")
            }
            else{
              Log.Error("La note n'est pas modifiée")
            }
            //Les points de vérifictions aprés avoir ouvrir la fene^tre de modification d'une note
            Get_WinInfo_Notes_TabGrid_BtnEdit().Click()
            aqObject.CheckProperty(Get_WinCRUANote_GrpNote_TxtNote(), "wText", cmpEqual, expectedNoteModif);
            Get_WinCRUANote_BtnCancel1().Click();
            //sélectionner la note 
            Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES833Modif), 10).Click();
            Get_WinInfo_Notes_TabGrid_BtnDelete().Click(); 
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
            //Les points de vérifications: la note crée précédemment est supprimée   
//           var textNotCROES833= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES833Modif), 10).Click();
//            var x=textNotCROES833.Exists;
//            Log.Message(x);
          if(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES833Modif), 10).Exists)
            {
             Log.Error("La note n'est pas supprimée")
            }
            else{
              Log.Checkpoint("La note est supprimée")
            }
             Get_WinDetailedInfo_BtnOK().Click();  
            
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        /*Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerAccounts);SA: La pref est par défaut a YES sur le dump de BNC
        RestartServices(vServerAccounts);*/
        Delete_Note(PortTextAddNotTestCROES833, vServerAccounts)
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        /*Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerAccounts);SA: La pref est par défaut a YES sur le dump de BNC
        RestartServices(vServerAccounts);*/
        Delete_Note(PortTextAddNotTestCROES833, vServerAccounts)
      
        
    }
}

