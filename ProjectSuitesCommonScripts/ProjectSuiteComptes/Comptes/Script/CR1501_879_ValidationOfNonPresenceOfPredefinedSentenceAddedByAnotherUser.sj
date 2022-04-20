//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**

       
       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-879
   
         1-Se connecter avec Copern:L'application s'ouvre correctement.
         2-Choisir le module compte.:Le module compte est ouvert.
         3-Sélectionner un compte:Le compte est bien sélectionné.
         4-Faire un click-right et choisir 'Ajouter une note':La fenêtre 'Ajouter une note' est ouverte.
         5-Cliquer sur le bouton 'Créer nouvelle phrase' ensuite saisir une phrase.:La nouvelle phrase est saisie.
         6-Fermer la fenêtre 'Ajouter une note' ensuite ouvrir de nouveau la fenêtre 'Ajouter une note'.:La nouvelle phrase saisie précédemment fait partie
          parmi la liste des phrases prédéfinies.
         7-Fermer l'application.:L'application est fermée.
         8-Se connecter à l'application avec 'DALTOJ':L'application est ouverte
         9-Choisir le module compte:le module compte s'ouvre correctement.
         10-Faire un click-right et choisir l'option 'Ajouter une note'.:La fenêtre 'Ajouter une note' est ouverte.
         11-Vérifier que la phrase prédéfinie crée par copern n'existe pas parmi la liste des phrases prédéfinies.:La phrase prédéfinie crée par Copern est n'existe
          pas parmi la liste des phrases prédéfinies.
         
        
        
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_879_ValidationOfNonPresenceOfPredefinedSentenceAddedByAnotherUser()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-879");
         
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         userNameDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "username");
         passwordDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "psw");
         
         
         Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "NO", vServerAccounts);
         RestartServices(vServerAccounts)
         
         //Les variables
         var numberAccount800083=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "numberAccount800083", language+client);
         var namePredefinSentenceCROES879=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "namePredefinSentenceCROES879", language+client);
         var sentencePredefinedCROES879=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "sentencePredefinedCROES879", language+client);
        
         var createdBySentPrefedCROES879=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "createdBySentPrefedCROES879", language+client);
        
         //Ajout d'une phrase prédéfinie par l'utilisateur COPERN
         Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
         //Choisir le module compte
         Get_ModulesBar_BtnAccounts().Click();
         SearchAccount(numberAccount800083);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).Click();
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).ClickR();
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         
       
        
         //Ajouter une note au compte 800300-NA
         Get_WinCRUANote().Parent.maximize();
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
        
          //Ajout d'une phrase prédéfinie
          //Log.Error("CROES-10996 il faut corriger le script quand l'anomalie: CROES-10996 sera corrigée ")
           Get_WinCRUANote_BtnAddPredefinedSentences().Click();
           Get_WinAddNewSentence_TxtName().Click()
           Get_WinAddNewSentence_TxtName().Keys(namePredefinSentenceCROES879);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().Keys(sentencePredefinedCROES879);
           Get_WinAddNewSentence_BtnSave().Click();
           //La phrase prédéfinie esr ajoutée
             
            var displaySenPredefCROES879=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES879, 10)//.WPFControlText
           if(displaySenPredefCROES879.Exists)
           {
             var textDisplaySenPredefCROES879=displaySenPredefCROES879.WPFControlText;
             Log.Message(textDisplaySenPredefCROES879)
             CheckEquals(textDisplaySenPredefCROES879,namePredefinSentenceCROES879,"Le nom de la phrase prédéfinie ");
             var index =displaySenPredefCROES879.Record.index
             var displayCreatedByCROES879=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue
         
              CheckEquals(displayCreatedByCROES879,createdBySentPrefedCROES879,"Créée par est ")
           }
           else 
           {
             Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
           }
           Get_WinCRUANote_BtnCancel1().Click();
          
           Close_Croesus_SysMenu();
           //Se connecter avec DALTOJ
           Login(vServerAccounts, userNameDALTOJ, passwordDALTOJ, language);
           
           //Choisir le module compte
           Get_ModulesBar_BtnAccounts().Click();
           SearchAccount(numberAccount800083);
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).Click();
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).ClickR();
           Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
           
           //Les poinst de vérifications
           var displaySenPredefCROES879Daltoj=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES879, 10)//.WPFControlText
             if(displaySenPredefCROES879Daltoj.Exists)
             {
               Log.Error("La phrase prédéfinie ajoutée ar l'utilisateur copern existe  parmi la liste des phrases prédéfinies")
             }
             else 
             {
               Log.Checkpoint("La phrase prédéfinie ajoutée par l'utilisateur copern n'existe pas parmi la liste des phrases prédéfinies")
             }
           
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
      Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerAccounts);
        RestartServices(vServerAccounts)
        Delete_PredefinedSentences(namePredefinSentenceCROES879, vServerAccounts)
      
        Delete_PredefinedSentencesGRD(vServerAccounts)
       
        
        
    }
    finally {
        Terminate_CroesusProcess();
        Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerAccounts);
        RestartServices(vServerAccounts)
        Delete_PredefinedSentences(namePredefinSentenceCROES879, vServerAccounts)
      
        Delete_PredefinedSentencesGRD(vServerAccounts)
      
        
    }
}
