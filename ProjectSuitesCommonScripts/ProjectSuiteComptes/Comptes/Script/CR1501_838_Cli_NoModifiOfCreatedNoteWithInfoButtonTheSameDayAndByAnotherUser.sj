//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
 https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-838
   
         1- Se connecter avec COPERN.:L'application s'ouvre correctement.
         2-Choisir le module compte.:Le module compte s'ouvre correctement.
         3-Sélectionner un compte par exemple le compte dont le numéro est : 800241-FS.:Le client est bien sélectionné.
         4-Ajouter une note a ce compte a partir du bouton  'info':La note est ajoutée.
         5-Fermer l'application.:L'application se ferme correctement.
         6-Se connecter à l'application avec 'DALTOJ':L'application est ouverte.
         7-Choisir le module compte.:Le module compte s'ouvre correctement.
         8-Sélectionner le compte '800241-FS' :Le compte 800241-FS'  est sélectionné.
         9-Cliquer sur le bouton 'Info' ensuite choisir l'onglet 'Notes'.:La fenêtre Info est ouverte et l'onglet 'Notes' est sélectionné.
         10-Sélectionner la note crée par l'utilisateur 'COPERN'.:La note est sélectionnée.
         11-Essayer de modifier la note:On peut pas modifier la note et le libellé de la bouton 'Modifier ' a changé. Le libellé est devenue 'Consulter'.
         
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_838_Cli_NoModifiOfCreatedNoteWithInfoButtonTheSameDayAndByAnotherUser()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-838");
         
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         userNameDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "username");
         passwordDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "psw");
         //
         //Mettre la PREF_EDIT_NOTE a YES
         //SA:La preférence PREF_EDIT_NOTE est YES sur le dump de BNC
       /*  Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerAccounts);
         RestartServices(vServerAccounts);*/
         //Les variables
         var numberAccount800283RE=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "numberAccount800283RE", language+client);
         var PortTextAddNotTestCROES838=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "PortTextAddNotTestCROES838", language+client);
         var textphrasePredefiniCROES842=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "textphrasePredefiniCROES842", language+client);
        
         
         Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module compte
         Get_ModulesBar_BtnAccounts().Click();
         SearchAccount(numberAccount800283RE);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800283RE, 10).Click();
         Get_AccountsBar_BtnInfo().Click();
         Get_WinInfo_Notes_TabGrid().Click();
         Get_WinInfo_Notes_TabGrid_BtnAdd().Click()
         
         //Ajouter une note au compte 800283-RE
         
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
      
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().Keys(PortTextAddNotTestCROES838);
         
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES842, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         var textAjoutNoteCROES838=Get_WinCRUANote_GrpNote_TxtNote().wText;
         Log.Message(textAjoutNoteCROES838)
         Get_WinCRUANote_BtnSave().Click();
         Get_WinDetailedInfo_BtnOK().Click();  
         //Fermer l'application
          Get_MainWindow().SetFocus();
          Close_Croesus_MenuBar();
         //  6-Se connecter à l'application avec 'DALTOJ':L'application est ouverte.
        Login(vServerAccounts, userNameDALTOJ, passwordDALTOJ, language);
        // 7-Choisir le module compte.:Le module compte s'ouvre correctement.
        Get_ModulesBar_BtnAccounts().Click();
        //9-Cliquer sur le bouton 'Info' ensuite choisir l'onglet 'Notes'.:La fenêtre Info est ouverte et l'onglet 'Notes' est sélectionné.
         SearchAccount(numberAccount800283RE);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800283RE, 10).Click();
         Get_AccountsBar_BtnInfo().Click();
         Get_WinInfo_Notes_TabGrid().Click();
         // 10-Sélectionner la note crée par l'utilisateur 'COPERN'.:La note est sélectionnée.
         Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value",textAjoutNoteCROES838, 10).Click();
         
         // 11-Essayer de modifier la note:On peut pas modifier la note et le libellé de la bouton 'Modifier ' a changé. Le libellé est devenue 'Consulter'.
         
         
       var checkDisplayBtnEdit= Get_WinDetailedInfo().FindChild("UID", "Button_5de5", 10)//UID du bouton modifier
       if(checkDisplayBtnEdit.Exists && checkDisplayBtnEdit.VisibleOnScreen){
         Log.Error("Le bouton  modifier existe")
       }
       else
       {
         Log.Checkpoint("Le bouton modifier n'existe pas")
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "Exists", cmpEqual, true);
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "VisibleOnScreen", cmpEqual, true);}
       }
       
    
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        /*Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerAccounts);SA: La pref est par défaut a YES sur le dump de BNC
        RestartServices(vServerAccounts);*/
        Delete_Note(PortTextAddNotTestCROES838, vServerAccounts)
        
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        /*Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerAccounts);SA: La pref est par défaut a YES sur le dump de BNC
        RestartServices(vServerAccounts);*/
        Delete_Note(PortTextAddNotTestCROES838, vServerAccounts)
      
        
    }
}
