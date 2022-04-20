//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-800
   
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2- Sélectionner un client qui contient des notes.: Le client est bien sélectionné.
         3- Faire un click-right et choisir 'Ajouter une note':La fenêtre 'Ajouter une note' est ouverte.
         4-Cliquer sur le bouton 'Créer nouvelle phrase' ensuite saisir une phrase.:La nouvelle phrase est saisie.
         5-Fermer la fenêtre 'Ajouter une note' ensuite ouvrir de nouveau la fenêtre 'Ajouter une note'.:La nouvelle phrase saisie précédemment fait
          partie parmi la liste des phrases prédéfinies.
   
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_800_804_806_Cli_ValidatAdditionModifDeletePredefinSentenceWhenEnteringNotWithClickRight()
{
    try {
         
         
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
         var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
         var PortTextAddNotTestCROES800=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "PortTextAddNotTestCROES800", language+client);
         var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
         var userCreerFiltreCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "userCreerFiltreCROES790", language+client);
         var NameFiltrExpluaNicolaCopernic=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "NameFiltrExpluaNicolaCopernic", language+client);
         var namePredefinSentenceCROES800=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "namePredefinSentenceCROES800", language+client);
         var sentencePredefinedModCROES800=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "sentencePredefinedModCROES800", language+client);
         var createdBySentPrefedCROES800=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "createdBySentPrefedCROES800", language+client);
         var textNoteCompletCROES800=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textNoteCompletCROES800", language+client);
         var namePredefinSentenceModifCROES804=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "namePredefinSentenceModifCROES804", language+client);
         var sentencePredefinedModifCROES804=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "sentencePredefinedModifCROES804", language+client);
         
         Log.PopLogFolder();
         logEtape1 = Log.AppendFolder("Étape 1: Le cas de test Croes-800 ");     
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-800");
          Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module client
          Get_ModulesBar_BtnClients().Click();
          //Sélectionner le client 800300
         
         Search_Client(numberClient800300)
         
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
          //Ajouter une note au client 800300
          Get_ClientsBar_BtnInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
         
           Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
           
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotTestCROES800);
          
          var textAjoutNoteCROES790=Get_WinCRUANote_GrpNote_TxtNote().Text;
          Log.Message(textAjoutNoteCROES790)
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_BtnSave().Click();
      
          Get_WinDetailedInfo_BtnCancel().Click()
          //Cliquer sur le bouton Info 
          Search_Client(numberClient800300)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
          //Ajout d'une phrase prédéfinie
           //Log.Warning("Jira CROES-10996 il faut corriger le script quand l'anomalie: CROES-10996 sera corrigée ")
           Get_WinCRUANote_BtnAddPredefinedSentences().Click();
           Get_WinAddNewSentence_TxtName().Click()
           Get_WinAddNewSentence_TxtName().set_Text(namePredefinSentenceCROES800);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().set_Text(sentencePredefinedModCROES800);
           Get_WinAddNewSentence_BtnSave().Click();
          
          /*  5-Fermer la fenêtre 'Ajouter une note' ensuite ouvrir de nouveau la fenêtre 'Ajouter une note'.:La nouvelle phrase saisie précédemment fait
          partie parmi la liste des phrases prédéfinies.*/
           Get_WinCRUANote_BtnCancel1().Click();
           Search_Client(numberClient800300)
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).ClickR();
           Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
           Get_WinCRUANote().Parent.maximize();
           //Les points de vérifications
   
          var displaySenPredefCROES800=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES800, 10)//.WPFControlText
         if(displaySenPredefCROES800.Exists)
         {
           var textDisplaySenPredefCROES800=displaySenPredefCROES800.WPFControlText;
           Log.Message(textDisplaySenPredefCROES800)
           CheckEquals(textDisplaySenPredefCROES800,namePredefinSentenceCROES800,"Le nom de la phrase prédéfinie ");
           var index =displaySenPredefCROES800.Record.index
           var displayCreatedByCROES800=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue
         
            CheckEquals(displayCreatedByCROES800,createdBySentPrefedCROES800,"Créée par est ")
         }
         else 
         {
           Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
         }
/***************************************************Début du partie du cas de test Croes-804************************************************************************************/         
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Le cas de test Croes-804 ");     
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-804");

         //Sélectionner la phrase prédifinie ensuite la modifier
   
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES800, 10).Click();
         Get_WinCRUANote_BtnEditPredefinedSentences().Click();
         
         //Modification de la phrase prédéfinie créée parécédemment
           Get_WinAddNewSentence_TxtName().Click()
           Get_WinAddNewSentence_TxtName().set_Text(namePredefinSentenceModifCROES804);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().set_Text(sentencePredefinedModifCROES804);
           Get_WinAddNewSentence_BtnSave().Click();
           
           
           
       
          var displaySenPredefCROES804=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceModifCROES804, 10)//.WPFControlText
         if(displaySenPredefCROES804.Exists)
         {
           var textDisplaySenPredefCROES804=displaySenPredefCROES804.WPFControlText;
           Log.Message(textDisplaySenPredefCROES804)
           CheckEquals(textDisplaySenPredefCROES804,namePredefinSentenceModifCROES804,"Le nom de la phrase prédéfinie ");
           var index =displaySenPredefCROES804.Record.index
           var displayCreatedByCROES804=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue
         
            CheckEquals(displayCreatedByCROES804,createdBySentPrefedCROES800,"Créée par est ")
         }
         else 
         {
           Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
         }
         



/***************************************************Fin du partie du cas de test Croes-804************************************************************************************/         
 


/***************************************************Début du partie du cas de test Croes-806************************************************************************************/         
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Le cas de test Croes-806 ");     
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-806");
         
           //Sélectionner la phrase prédéfinie et la supprimer
           Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceModifCROES804, 10).Click();
           Get_WinCRUANote_BtnDeletePredefinedSentences().Click();
           
           //Vérifier que le bouton Spprimer n'est pas grisée
           aqObject.CheckProperty(Get_WinCRUANote_BtnDeletePredefinedSentences(), "Enabled", cmpEqual, true);
           //Confirmer la suppresssion
           var width = Get_DlgConfirmation().Get_Width();
           Get_DlgConfirmation().Click((width*(1/3)),73);
           
       
          var displaySenPredefCROES806=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceModifCROES804, 10)
         if(displaySenPredefCROES806.Exists)
         {
           
          
            Log.Error("La phrase prédéfinie n'est pas supprimée")
         }
         else 
         {
           Log.Checkpoint("La phrase prédéfinie est supprimée")
         }
         
            Get_WinCRUANote_BtnCancel1().Click();
          
         // Ouvrir de nouveau la fenêtre d'ajout d'une note et vérifié de nouveau que la phrase pédéfinie est supprimée
         Search_Client(numberClient800300)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).ClickR();
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         var displaySenPredefAfterCloseCROES806=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceModifCROES804, 10)
         if(displaySenPredefAfterCloseCROES806.Exists)
         {
           
          
            Log.Error("La phrase prédéfinie n'est pas supprimée")
         }
         else 
         {
           Log.Checkpoint("La phrase prédéfinie est supprimée")
         }
         

/***************************************************Fin du partie du cas de test Croes-806************************************************************************************/         
 
           Get_WinCRUANote_BtnCancel1().Click();
          
          
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceCROES800, vServerClients)
        Delete_PredefinedSentencesGRD(vServerClients)
        Delete_Note(textNoteCompletCROES800, vServerClients)
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceCROES800, vServerClients)
        Delete_PredefinedSentencesGRD(vServerClients)
        Delete_Note(textNoteCompletCROES800, vServerClients)
        
    }
}
