//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**

       
      https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1319
   
         1-Se connecter avec UNI00:L'application s'ouvre correctement..
         2-Choisir le module relation.:Le module relation est ouvert.
         3-Sélectionner une relation:La relation est bien sélectionnée.
         4-Faire un click-right et choisir 'Ajouter une note':La fenêtre 'Ajouter une note' est ouverte.
         5-Cliquer sur le bouton 'Créer nouvelle phrase' ensuite saisir une phrase.:La nouvelle phrase est saisie.
         6-Fermer la fenêtre 'Ajouter une note' ensuite ouvrir de nouveau la fenêtre 'Ajouter une note'.:
          La nouvelle phrase saisie précédemment fait partie parmi la liste des phrases prédéfinies.
         7-Fermer l'application.:L'application est fermée.
         8-Se connecter à l'application avec 'DALTOJ':L'application est ouverte
         9-Choisir le module relation:le module relation s'ouvre correctement.
         10-Faire un click-right et choisir l'option 'Ajouter une note'.:La fenêtre 'Ajouter une note' est ouverte.
         11-Vérifier que la phrase prédéfinie crée par UNI00 est présente parmi la liste des phrases prédéfinies.:
         La phrase prédéfinie crée par UNI00 est présente  parmi la liste des phrases prédéfinies.
        
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_1319_Rel_ValidationOfThePresenceOfPredefinedSentenceCreatedByTheUNI00User()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1319");
         //SA: j'utilise GP1859 au lieu de UNI00 parce que lui aussi son type d'accés SYSADM et il a la PREF_EDIT_FIRM_FUNCTIONS=YES

         userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
         passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
         userNameDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "username");
         passwordDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "psw");
         
         
         //Les variables
         var nameRelation1CROES1319=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation1CROES1319", language+client);
         var namePredefinSentenceCROES1319=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "namePredefinSentenceCROES1319", language+client);
         var sentencePredefinedCROES1319=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "namePredefinSentenceCROES1319", language+client);
         var createdBySentPrefedCROES1319=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "createdBySentPrefedCROES1319", language+client);
         var IACodeCROES1275=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "IACodeCROES1275", language+client);
  
        
         //Ajout d'une phrase prédéfinie par l'utilisateur GP1859
         Login(vServerRelations, userNameGP1859, passwordGP1859, language);
           //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          //Ajout d'une nouvelle relation
           Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
          SearchRelationshipByName(nameRelation1CROES1319);
          var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1319, 10);
          if (searchResult.Exists){
              Log.Message("The relationship " + nameRelation1CROES1319 + " already exists.");
          }
          else{
          Get_Toolbar_BtnAdd().Click();
          Delay(100);
          Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
          Delay(1000);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(nameRelation1CROES1319);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(nameRelation1CROES1319);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(IACodeCROES1275);
          Get_WinDetailedInfo_BtnOK().Click();
          }
          //fin d'ajout de la relation
          
          SelectRelationships(nameRelation1CROES1319)
      
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1319, 10).Click();
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1319, 10).ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
          //Ajoute d'une phrase prédéfinie
          Get_WinCRUANote().Parent.maximize();
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
        
           //Ajout d'une phrase prédéfinie
           Log.Message("CROES-10996 il faut corriger le script quand l'anomalie: CROES-10996 sera corrigée ")
           Get_WinCRUANote_BtnAddPredefinedSentences().Click();
           Get_WinAddNewSentence_TxtName().Click()
           Get_WinAddNewSentence_TxtName().set_Text(namePredefinSentenceCROES1319);
           Get_WinAddNewSentence_TxtSentence().Click()
		       Get_WinAddNewSentence_TxtSentence().set_Text(sentencePredefinedCROES1319);
           Get_WinAddNewSentence_BtnSave().Click();
           //La phrase prédéfinie esr ajoutée
             
            var displaySenPredefCROES1319=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES1319, 10)//.WPFControlText
           if(displaySenPredefCROES1319.Exists)
           {
             var textDisplaySenPredefCROES1319=displaySenPredefCROES1319.WPFControlText;
             Log.Message(textDisplaySenPredefCROES1319)
             CheckEquals(textDisplaySenPredefCROES1319,namePredefinSentenceCROES1319,"Le nom de la phrase prédéfinie ");
             var index =displaySenPredefCROES1319.Record.index
             var displayCreatedByCROES1319=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue
         
              CheckEquals(displayCreatedByCROES1319,createdBySentPrefedCROES1319,"Créée par est ")
           }
           else 
           {
             Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
           }
           Get_WinCRUANote_BtnCancel1().Click();
          
           Close_Croesus_SysMenu();
           //Se connecter avec DALTOJ
           Login(vServerRelations, userNameDALTOJ, passwordDALTOJ, language);
           
           //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          SelectRelationships(nameRelation1CROES1319)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1319, 10).Click();
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1319, 10).ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
           
           //Les poinst de vérifications
           var displaySenPredefCROES1319Daltoj=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES1319, 10)//.WPFControlText
             if(displaySenPredefCROES1319Daltoj.Exists)
             {
               Log.Checkpoint("La phrase prédéfinie ajoutée par l'utilisateur GP1859 existe  parmi la liste des phrases prédéfinies")
             }
             else 
             {
               Log.Error("La phrase prédéfinie ajoutée par l'utilisateur GP1859 n'existe pas parmi la liste des phrases prédéfinies")
             }
           
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameGP1859, passwordGP1859, language);
        DeleteRelationship(nameRelation1CROES1319)
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceCROES1319, vServerRelations)
        Delete_PredefinedSentences("", vServerRelations)
        Delete_PredefinedSentencesGRD(vServerRelations)
       
        
        
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameGP1859, passwordGP1859, language);
        DeleteRelationship(nameRelation1CROES1319)
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceCROES1319, vServerRelations)
        Delete_PredefinedSentences("", vServerRelations)
        Delete_PredefinedSentencesGRD(vServerRelations)
       
        
      
        
    }
}