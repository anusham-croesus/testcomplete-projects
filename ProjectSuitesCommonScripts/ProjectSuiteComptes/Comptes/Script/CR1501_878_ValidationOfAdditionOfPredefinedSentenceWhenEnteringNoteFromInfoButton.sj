//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
       préconditions:
       Se connecter avec COPERN.
       
       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-878
   
         1- Choisir le module compte.: Le module compte s'ouvre correctement.   
         2-Sélectionner un compte.:Le compte est bien sélectionné.
         3-Cliquer sur le bouton 'Info' ensuite cliquer sur le bouton 'Ajouter':La fenêtre 'ajouter une note' est ouverte.
         4-Cliquer sur le bouton 'Créer nouvelle phrase' ensuite saisir une phrase.:la nouvelle phrase est saisie.
         5-Fermer la fenêtre 'Ajouter une note' ensuite ouvrir de nouveau la fenêtre 'Ajouter une note'.:
          La nouvelle phrase saisie précédemment fait partie parmi la liste des phrases prédéfinies. 
        
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_878_ValidationOfAdditionOfPredefinedSentenceWhenEnteringNoteFromInfoButton()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-878");
         
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         
         
         /*Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "NO", vServerAccounts);
         RestartServices(vServerAccounts)*/
         
         //Les variables
         var numberAccount800083=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "numberAccount800083", language+client);
         var namePredefinSentenceCROES878=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "namePredefinSentenceCROES878", language+client);
         var sentencePredefinedCROES878=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "sentencePredefinedCROES878", language+client);
        
         var createdBySentPrefedCROES916=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "createdBySentPrefedCROES916", language+client);
        
         //Ajout d'une phrase prédéfinie par l'utilisateur COPERN
         Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
         //Choisir le module compte
         Get_ModulesBar_BtnAccounts().Click();
         SearchAccount(numberAccount800083);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).Click();
         Get_AccountsBar_BtnInfo().Click();
         WaitObject(Get_CroesusApp(), "Uid", "TabItem_fc72");
         Get_WinInfo_Notes_TabGrid().Click();
         Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
         //Ajouter une note au compte 800300-NA
         Get_WinCRUANote().Parent.maximize();
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
        
          //Ajout d'une phrase prédéfinie
          //Log.Error("CROES-10996 il faut corriger le script quand l'anomalie: CROES-10996 sera corrigée ")
           Get_WinCRUANote_BtnAddPredefinedSentences().Click();
           Get_WinAddNewSentence_TxtName().Click()
           Get_WinAddNewSentence_TxtName().Keys(namePredefinSentenceCROES878);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().Keys(sentencePredefinedCROES878);
           Get_WinAddNewSentence_BtnSave().Click();
           Get_WinCRUANote_BtnCancel1().Click();
           Get_WinDetailedInfo_BtnOK().Click();
          //Choisir le module compte
          Get_ModulesBar_BtnAccounts().Click();
          SearchAccount(numberAccount800083);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         
          
       
          
             //Sélectionner la phrase prédifinie ensuite la modifier
   
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES878, 10).Click();
        
       //   Get_WinInfo_Notes_TabGrid_BtnEdit().Click()
      //    WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74") 
           
       
          var displaySenPredefCROES878=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES878, 10)//.WPFControlText
         if(displaySenPredefCROES878.Exists)
         {
           var textDisplaySenPredefCROES878=displaySenPredefCROES878.WPFControlText;
           Log.Message(textDisplaySenPredefCROES878)
           CheckEquals(textDisplaySenPredefCROES878,namePredefinSentenceCROES878,"Le nom de la phrase prédéfinie ");
           var index =displaySenPredefCROES878.Record.index
           var displayCreatedByCROES878=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue
         
            CheckEquals(displayCreatedByCROES878,createdBySentPrefedCROES916,"Créée par est ")
         }
         else 
         {
           Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
         }
         
         //Les points de vérifications
           Get_WinCRUANote_BtnEditPredefinedSentences().Click()
           aqObject.CheckProperty(Get_WinEditSentence_TxtName(), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Get_WinEditSentence_TxtName(), "Text", cmpEqual, namePredefinSentenceCROES878);
           
           aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "Text", cmpEqual, "Phrase prédéfinie CROES878");
           Get_WinEditSentence_BtnCancel().Click();
           Get_WinCRUANote_BtnCancel1().Click();
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
       /* Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerAccounts);
        RestartServices(vServerAccounts)*/
        Delete_PredefinedSentences(namePredefinSentenceCROES878, vServerAccounts)
      
        Delete_PredefinedSentencesGRD(vServerAccounts)
       
        
        
    }
    finally {
        Terminate_CroesusProcess();
        /*Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerAccounts);
        RestartServices(vServerAccounts)*/
        Delete_PredefinedSentences(namePredefinSentenceCROES878, vServerAccounts)
      
        Delete_PredefinedSentencesGRD(vServerAccounts)
      
        
    }
}
