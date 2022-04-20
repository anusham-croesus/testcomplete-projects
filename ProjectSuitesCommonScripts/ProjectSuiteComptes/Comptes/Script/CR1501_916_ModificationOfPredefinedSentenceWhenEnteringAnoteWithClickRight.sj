//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
       préconditions:
       Se connecter avec COPERN.
       
       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-916
   
         1- Choisir le module compte.: Le module compte s'ouvre correctement.   
         2-Sélectionner un compte.:Le compte est bien sélectionné.
         3-Faire un click-right et choisir 'Ajouter une note':La fenêtre 'Ajouter une note' est ouverte.
         4-Sélectionner une phrase prédéfinie crée avec l'utilisateur copern ensuite cliquer sur le bouton modifier:
         la fenêtre de modification de la phrase prédéfinie est ouverte
         5-Modifier la phrase ensuite fermer la fenêtre 'Ajouter une note' et l'ouvrir de nouveau.:
         La phrase prédéfinie est modifiée.
        
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-8--V9-Be_1-co6x
*/


function CR1501_916_ModificationOfPredefinedSentenceWhenEnteringAnoteWithClickRight()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-916");
         
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         
         
         /*Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "NO", vServerAccounts);
         RestartServices(vServerAccounts)*/
         
         //Les variables
         var numberAccount800083=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "numberAccount800083", language+client);
         var namePredefinSentenceCROES916=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "namePredefinSentenceCROES916", language+client);
         var sentencePredefinedCROES916=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "sentencePredefinedCROES920", language+client);
         var namePredefinSentenceModifCROES916=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "namePredefinSentenceModifCROES916", language+client);
         var sentencePredefinedModifCROES916=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "sentencePredefinedModifCROES916", language+client);
         var createdBySentPrefedCROES916=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "createdBySentPrefedCROES916", language+client);
         var sentencePredefinedCROES920=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "sentencePredefinedCROES920", language+client);
         //Ajout d'une phrase prédéfinie par l'utilisateur UNI00
         Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
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
          Get_WinAddNewSentence_TxtName().Keys(namePredefinSentenceCROES916);
          Get_WinAddNewSentence_TxtSentence().Click()
		      Get_WinAddNewSentence_TxtSentence().Keys(sentencePredefinedCROES920);
          Get_WinAddNewSentence_BtnSave().Click();
          Get_WinCRUANote_BtnCancel1().Click();
          //Choisir le module compte
          Get_ModulesBar_BtnAccounts().Click();
          SearchAccount(numberAccount800083);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         
          
          
          
             //Sélectionner la phrase prédifinie ensuite la modifier
   
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES916, 10).Click();
          Get_WinCRUANote_BtnEditPredefinedSentences().Click();
         
         //Modification de la phrase prédéfinie créée parécédemment
           Get_WinAddNewSentence_TxtName().Click()
           Get_WinAddNewSentence_TxtName().Keys("[End]");
           Get_WinAddNewSentence_TxtName().Keys("[BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS]");
           Get_WinAddNewSentence_TxtName().Keys(namePredefinSentenceModifCROES916);
           Get_WinAddNewSentence_TxtSentence().Click()
           Get_WinAddNewSentence_TxtSentence().Keys("[End]");
           Get_WinAddNewSentence_TxtSentence().Keys("[BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS]");
		       Get_WinAddNewSentence_TxtSentence().Keys(sentencePredefinedModifCROES916);
           Get_WinAddNewSentence_BtnSave().Click();
           
           
           
       
          var displaySenPredefCROES916=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceModifCROES916, 10)//.WPFControlText
         if(displaySenPredefCROES916.Exists)
         {
           var textDisplaySenPredefCROES916=displaySenPredefCROES916.WPFControlText;
           Log.Message(textDisplaySenPredefCROES916)
           CheckEquals(textDisplaySenPredefCROES916,namePredefinSentenceModifCROES916,"Le nom de la phrase prédéfinie ");
           var index =displaySenPredefCROES916.Record.index
           var displayCreatedByCROES916=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue
         
            CheckEquals(displayCreatedByCROES916,createdBySentPrefedCROES916,"Créée par est ")
         }
         else 
         {
           Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
         }
         
            Get_WinCRUANote_BtnCancel1().Click();
          
          //Les points de vérification aprés avoir fermer la fenetre ajouter une note
          SearchAccount(numberAccount800083);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
          //Sélectionner la phrase prédifinie ensuite la modifier
   
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceModifCROES916, 10).Click();
         Get_WinCRUANote_BtnEditPredefinedSentences().Click();
         
         
            var displaySenPredefCROES916Afterclose=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceModifCROES916, 10)//.WPFControlText
         if(displaySenPredefCROES916Afterclose.Exists)
         {
           var textDisplaySenPredefCROES916AfterClose=displaySenPredefCROES916Afterclose.WPFControlText;
           Log.Message(textDisplaySenPredefCROES916AfterClose)
           CheckEquals(textDisplaySenPredefCROES916AfterClose,namePredefinSentenceModifCROES916,"Le nom de la phrase prédéfinie ");
           var index =displaySenPredefCROES916Afterclose.Record.index
           var displayCreatedByCROES916AfterClose=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue
         
            CheckEquals(displayCreatedByCROES916AfterClose,createdBySentPrefedCROES916,"Créée par est ")
         }
         else 
         {
           Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
         }
          Get_WinAddNewSentence_BtnSave().Click();
          Get_WinCRUANote_BtnCancel1().Click();
            
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
       /* Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerAccounts);
        RestartServices(vServerAccounts)*/
        Delete_PredefinedSentences(namePredefinSentenceCROES916, vServerAccounts)
        Delete_PredefinedSentences(namePredefinSentenceModifCROES916, vServerAccounts)
        Delete_PredefinedSentencesGRD(vServerAccounts)
       
        
        
    }
    finally {
        Terminate_CroesusProcess();
        /*Activate_Inactivate_Pref(userNameCOPERN, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerAccounts);
        RestartServices(vServerAccounts)*/
        Delete_PredefinedSentences(namePredefinSentenceCROES916, vServerAccounts)
        Delete_PredefinedSentences(namePredefinSentenceModifCROES916, vServerAccounts)
        Delete_PredefinedSentencesGRD(vServerAccounts)
      
        
    }
}

function test(){
          Get_WinAddNewSentence_TxtName().Click()
          Get_WinAddNewSentence_TxtName().Keys("[End]");
          Get_WinAddNewSentence_TxtName().Keys("[BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS][BS]");

           /*Get_WinAddNewSentence_TxtName().Keys(namePredefinSentenceModifCROES916);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().Keys(sentencePredefinedModifCROES916);
           Get_WinAddNewSentence_BtnSave().Click();*/
           
  
}