//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
       préconditions:
       Se connecter avec COPERN. Mettre  la préférence: PREF_EDIT_FIRM_FUNCTIONS=NON
       
       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-920
   
         1- Choisir le module compte.: Le module compte s'ouvre correctement.   
         2-Sélectionner un compte.:Le compte est bien sélectionné.
         3-Faire un click-right et choisir 'Ajouter une note':La fenêtre 'Ajouter une note' est ouverte.
         4-Sélectionner une phrase prédéfinie crée avec l'utilisateur 'UNI00'.:
         Le bouton 'Supprimer' est grisé.
        
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-8--V9-Be_1-co6x
*/


function CR1501_920_NoDeletePredefinePhraseWhenEnteringANoteWithClickRightAndOtherUser()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-920");
         
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
         passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
         
         Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "NO", vServerAccounts);
         RestartServices(vServerAccounts)
         
         //Les variables
         var numberAccount800083=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "numberAccount800083", language+client);
         var namePredefinSentenceCROES920=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "namePredefinSentenceCROES920", language+client);
         var sentencePredefinedCROES920=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "sentencePredefinedCROES920", language+client);
         //Ajout d'une phrase prédéfinie par l'utilisateur UNI00
         Login(vServerAccounts, userNameUNI00, passwordUNI00, language);
         //Choisir le module compte
         Get_ModulesBar_BtnAccounts().Click();
         SearchAccount(numberAccount800083);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).ClickR();
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         //Ajouter une note au compte 800300-NA
         Get_WinCRUANote().Parent.maximize();
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
        
          //Ajout d'une phrase prédéfinie
          //Log.Error("CROES-10996 il faut corriger le script quand l'anomalie: CROES-10996 sera corrigée ")
           Get_WinCRUANote_BtnAddPredefinedSentences().Click();
           Get_WinAddNewSentence_TxtName().Click()
           Get_WinAddNewSentence_TxtName().Keys(namePredefinSentenceCROES920);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().Keys(sentencePredefinedCROES920);
           Get_WinAddNewSentence_BtnSave().Click();
          
         // se connecter avec copern
         Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
         Get_ModulesBar_BtnAccounts().Click();
         SearchAccount(numberAccount800083);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).ClickR();
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         //Sélectionner la phrase prédéfinie crée par UNI00
       
         Get_WinCRUANote().Parent.maximize();
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES920, 10).Click();//.WPFControlText
         //Les points de vérifications
        
        aqObject.CheckProperty(Get_WinCRUANote_BtnDeletePredefinedSentences(), "Enabled", cmpEqual, false);
            
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerAccounts);
        RestartServices(vServerAccounts)
        Delete_PredefinedSentences(namePredefinSentenceCROES920, vServerAccounts)
        Delete_PredefinedSentencesGRD(vServerAccounts)
       
        
        
    }
    finally {
        Terminate_CroesusProcess();
        Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerAccounts);
        RestartServices(vServerAccounts)
        Delete_PredefinedSentences(namePredefinSentenceCROES920, vServerAccounts)
        Delete_PredefinedSentencesGRD(vServerAccounts)
      
        
    }
}

