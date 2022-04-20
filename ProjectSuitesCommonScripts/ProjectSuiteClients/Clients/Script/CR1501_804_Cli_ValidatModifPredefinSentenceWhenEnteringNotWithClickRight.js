//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-804
   
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2- Sélectionner un client: Le client est bien sélectionné.
         3- Faire un click-right et choisir 'Ajouter une note':La fenêtre 'Ajouter une note' est ouverte.
         4-Sélectionner une phrase prédéfinie crée avec l'utilisateur copern ensuite faire un double-clic pour la modifier.:La phrase est bien sélectionnée 
         et le champ est modifiable.
         5-Modifier la phrase ensuite fermer la fenêtre 'Ajouter une note' et l'ouvrir de nouveau.:La phrase prédéfinie est modifiée.
   
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_804_Cli_ValidatModifPredefinSentenceWhenEnteringNotWithClickRight()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-804");
         
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
         var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
         var namePredefinSentenceCROES804=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "namePredefinSentenceCROES804", language+client);
         var sentencePredefinedCROES804=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "sentencePredefinedCROES804", language+client);
         var createdBySentPrefedCROES800=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "createdBySentPrefedCROES800", language+client);
         var namePredefinSentenceModifCROES804=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "namePredefinSentenceModifCROES804", language+client);
         var sentencePredefinedModifCROES804=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "sentencePredefinedModifCROES804", language+client);
         
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
           Get_WinAddNewSentence_TxtName().set_Text(namePredefinSentenceCROES804);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().set_Text(sentencePredefinedCROES804);
           Get_WinAddNewSentence_BtnSave().Click();
          
     
           Get_WinCRUANote_BtnCancel1().Click();
           Search_Client(numberClient800300)
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).ClickR();
           Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
           Get_WinCRUANote().Parent.maximize();
           //Les points de vérifications
           
          //Sélectionner la phrase prédifinie ensuite la modifier
   
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES804, 10).Click();
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
         
            Get_WinCRUANote_BtnCancel1().Click();
          
          
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceCROES804, vServerClients)
        Delete_PredefinedSentences(namePredefinSentenceModifCROES804, vServerClients)
        Delete_PredefinedSentencesGRD(vServerClients)
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceCROES804, vServerClients)
        Delete_PredefinedSentences(namePredefinSentenceModifCROES804, vServerClients)
        Delete_PredefinedSentencesGRD(vServerClients)
      
        
    }
}
