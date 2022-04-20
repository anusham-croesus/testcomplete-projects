//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
   https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-806
   
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2- Sélectionner un client: Le client est bien sélectionné.
         3- Faire un click-right et choisir 'Ajouter une note':La fenêtre 'Ajouter une note' est ouverte.
         4-Sélectionner une phrase prédéfinie crée avec l'utilisateur copern.:Le bouton 'Supprimer phrase' n'est pas grisé.
         5-Cliquer sur le bouton 'Supprimer phrase' ensuite fermer la fenêtre 'Ajouter une note' et l'ouvrir de nouveau.:La phrase est supprimée.
   
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_806_Cli_ValidatDeletPredefinSentenceWhenEnteringNoteWithClickRight()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-806");
         
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
         var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
         var namePredefinSentenceCROES806=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "namePredefinSentenceCROES806", language+client);
         var sentencePredefinedCROES806=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "sentencePredefinedCROES806", language+client);
         var createdBySentPrefedCROES800=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "createdBySentPrefedCROES800", language+client);
        
          Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module client
          Get_ModulesBar_BtnClients().Click();
          Search_Client(numberClient800300)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
          //Ajout d'une phrase prédéfinie
           //Log.Error("Jira CROES-10996 il faut corriger le script quand l'anomalie: CROES-10996 sera corrigée ")
           Get_WinCRUANote_BtnAddPredefinedSentences().Click();
           Get_WinAddNewSentence_TxtName().Click()
           Get_WinAddNewSentence_TxtName().set_Text(namePredefinSentenceCROES806);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().set_Text(sentencePredefinedCROES806);
           Get_WinAddNewSentence_BtnSave().Click();
           
           //Sélectionner la phrase prédéfinie et la supprimer
           Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES806, 10).Click();
           Get_WinCRUANote_BtnDeletePredefinedSentences().Click();
           
           //Vérifier que le bouton Spprimer n'est pas grisée
           aqObject.CheckProperty(Get_WinCRUANote_BtnDeletePredefinedSentences(), "Enabled", cmpEqual, true);
           //Confirmer la suppresssion
           var width = Get_DlgConfirmation().Get_Width();
           Get_DlgConfirmation().Click((width*(1/3)),73);
           
       
          var displaySenPredefCROES806=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES806, 10)
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
         var displaySenPredefAfterCloseCROES806=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES806, 10)
         if(displaySenPredefAfterCloseCROES806.Exists)
         {
           
          
            Log.Error("La phrase prédéfinie n'est pas supprimée")
         }
         else 
         {
           Log.Checkpoint("La phrase prédéfinie est supprimée")
         }
         
            Get_WinCRUANote_BtnCancel1().Click();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceCROES806, vServerClients)
        Delete_PredefinedSentencesGRD(vServerClients)
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceCROES806, vServerClients)
        Delete_PredefinedSentencesGRD(vServerClients)
      
        
    }
}
