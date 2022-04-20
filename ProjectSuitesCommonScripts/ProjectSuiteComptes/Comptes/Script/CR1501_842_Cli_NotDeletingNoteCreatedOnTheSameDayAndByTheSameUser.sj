//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
 https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-842
   
         1- Choisir le module compte.: Le module compte s'ouvre correctement.   
         2-Sélectionner un compte.:Le compte est bien sélectionné.
         3-Ajouter une note a ce compte avec l'option click-right.:La note est ajoutée.
         4-Cliquer sur le bouton 'Info':La fenêtre info du compte sélectionné est ouverte.
         5-La fenêtre info du compte sélectionné est ouverte.:On peut pas supprimer la note et le bouton 'Supprimer' est grisé.
            
        
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_842_Cli_NotDeletingNoteCreatedOnTheSameDayAndByTheSameUser()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-842");
         
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         //Mettre la PREF_NOTE_DELETE a NO
         Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","NO",vServerAccounts);
         RestartServices(vServerAccounts);
         //Les variables
         var numberAccount800083=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "numberAccount800083", language+client);
         var PortTextAddNotTestCROES842=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "PortTextAddNotTestCROES842", language+client);
         var textphrasePredefiniCROES842=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "textphrasePredefiniCROES842", language+client);
       
         
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
         Get_WinCRUANote_GrpNote_TxtNote().Keys(PortTextAddNotTestCROES842);
         
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES842, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         var textAjoutNoteCROES842=Get_WinCRUANote_GrpNote_TxtNote().Text;
         Log.Message(textAjoutNoteCROES842)
        
      
         Get_WinCRUANote_BtnSave().Click();
         
         //Sélectionner des notes ensuite clique
          SearchAccount(numberAccount800083);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).Click();
          Get_AccountsBar_BtnInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES842), 10).Click();
         //Les points de vérifications
     
          
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "Enabled", cmpEqual, false);
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "Exists", cmpEqual, true);
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "VisibleOnScreen", cmpEqual, true);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","YES",vServerAccounts);
        RestartServices(vServerAccounts);
        Delete_Note(PortTextAddNotTestCROES842, vServerAccounts)
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","YES",vServerAccounts);
        RestartServices(vServerAccounts);
        Delete_Note(PortTextAddNotTestCROES842, vServerAccounts)
      
        
    }
}
