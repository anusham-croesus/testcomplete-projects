//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*         
IMPORTANT pour pouvoir scripter ce CR le testlink Croes-6667 doit être absolument scripté et exécuté.  
C'est le cas préparatoire des CR1958 et CR1142  pour CIBC         
		 
Résumé:
On ne devrait pas avoir la possibilité de modifier ou de supprimer les données d’une Relation client.
         
Analyste d'automatisation : Mathieu Gagne, Frédéric Thériault
Module: Relations
*/
var relationshipNo;
var loopCount = 0;
var choixDeroulant;

function CR1142_6784_Valider_impossibilite_de_modifier_supprimer_donn_es_Relation_Client_module_Relations() {
  try {
      // Lien pour TestLink
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6784","Lien du Cas de test sur Testlink");
      
      // Data pool
      var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
      var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
      var relationNumber1 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "6784_relationNumber1", language+client);
      var relationNumber2 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "6784_relationNumber2", language+client);
      var expectedType    = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "6784_expectedType", language+client); //FR - Relation Client EN - Client Relationship
      var columnType      = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "6784_columnType", language+client);
        
      // Étape 1
      Log.Message("Étape 1: Se connecter avec user Keynej et aller au Module Relations.");
      Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        
      // Aller au Module Relations
      Get_ModulesBar_BtnRelationships().Click();
        
      // Wait for grid relation
      WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 10);
        
      // Étape 2
      Log.Message("Étape 2: Ajouter la colonne Type et selectionner la relation 80028.");
        
      // Ajouter la colonne Type
      Add_ColumnByLabel(Get_AccountsGrid_ChBalance(), columnType);

      // Sélectionner la relation 80028
      relationshipNo = relationNumber1;
      ValiderSectionSuivi_FenetreInfoRelations();
      
      // Étape 6
      Log.Message("Étape 6: Sélectionner une Relation client conjoint 0001A ")
      relationshipNo = relationNumber2;
      ValiderSectionSuivi_FenetreInfoRelations();
  }
  catch (e) {
      //S'il y a exception, en afficher le message
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
      // Cleanup - remove column type
      Log.Message("cleanup - remove column type")
      DeleteColumn(Get_RelationshipsGrid_ChType())
      
      //Fermer le processus Croesus
      Terminate_CroesusProcess();
  }
}

function ValiderSectionSuivi_FenetreInfoRelations() {
  try {
    var loopCount = 0;
    var expectedType    = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "6784_expectedType", language+client); //FR - Relation Client EN - Client Relationship
    
    // Sélectionner la relation
    Get_RelationshipsClientsAccountsGrid().Find("Value", relationshipNo, 10).Click(-1, -1, skCtrl);
        
    //CHECK - Sous la colonne Type le la relation est affichée 'Relation client'
    Log.Message("Sous la colonne Type le la relation " +relationshipNo +" est affichée 'Relation client'");
    var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
    var gridCount = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count; //28
    var isFoundCount = 0;

    for (i = 0; i < gridCount; i++) {
    	if (grid.Items.Item(i).IsSelected && grid.Items.Item(i).DataItem.Type3Description.OleValue == expectedType)
    		isFoundCount++;
    }

    if (isFoundCount == 1)
    	Log.Checkpoint("'Relation client' est affichée  dans la colonne type");
    else
    	Log.Error("'Relation client' n'est pas affichée dans la colonne type");
        
    // Étape 3
    Log.Message("Étape 3: Cliquer sur le bouton Info de la relation " +relationshipNo +" et valider que dans la section Follow up, les champs sont éditables, sauf le champ Interlocutor.");
    
    Get_RelationshipsBar_BtnInfo().Click();
    
    choixDeroulant = 2;
    SelectionnerSegmentation();
    SelectionnerContactPerson();
    SelectionnerAccountManager();
    SelectionnerCommunication();
      
    // Representative non éditable: CheckBox .Enabled == false  UniTextField .IsReadOnly == true  UniButton .Enabled == false
    
    if (Get_WinRelationshipInfo_GrpFollowUp_CheckBoxRepresentative().Enabled == false
        && Get_WinRelationshipInfo_GrpFollowUp_TextFieldRepresentative().IsReadOnly == true
        && Get_WinRelationshipInfo_GrpFollowUp_ButtonRepresentative().Enabled == false)
          Log.Checkpoint("Les contrôles du Representative sont grisés (ne sont pas éditables).");
    else
          Log.Error("Certains contrôles du Representative sont éditables, mais ne devraient pas l'être.");
        
    // Fermer fenetre Info Relation
    Log.Message("Fermer la fenêtre Info Relation");
    Get_WinDetailedInfo_BtnOK().Click();
    
    // Revenir dans Info pour valider que les donnés sélectionnées sont bien enregistrées.
    Get_RelationshipsBar_BtnInfo().Click();
    if (Get_WinRelationshipInfo_GrpFollowUp_CmbSegmentation().Text == choix1
    && Get_WinRelationshipInfo_GrpFollowUp_CmbContactPerson().Text == choix2
    && Get_WinRelationshipInfo_GrpFollowUp_CmbAccountManager().Text == choix3
    && Get_WinRelationshipInfo_GrpFollowUp_CmbCommunication().Text == choix4) {
      Log.Checkpoint("Choix ont été conservés dans la section Follow up de la fenêtre Relationship Info.");
    }
    else
        Log.Error("Les choix dans Follow up, n'ont pas été conservés à la réouverture de la fenêtre Relationship Info.");
        
    // Étape 4
    Log.Message("Étape 4: Cliquer sur l'onglet Adresses tous les champs devraient être grisé.")
    Get_WinDetailedInfo_TabAddresses().Click();
        
    //CHECK - Tous les champs sont grisés.
        
    if (language == "french")
        testFRaddr();
    else
        testENaddr();
        
    // Fermer fenetre Info Relation
    Log.Message("Fermer la fenêtre Info Relation");
    Get_WinDetailedInfo_BtnOK().Click();
        
    //wait for grid relation
    WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 10);
    
    // Étape 5
    Log.Message("Étape 5: Toujours sur la relation " +relationshipNo +", Dans la barre d'outils l’icône '-' Supprimer devrait être désactivée.")
    if(Get_Toolbar_BtnDelete().Enabled == false)
        Log.Checkpoint("Button Supprimer est désactivée");
    else
        Log.Error("Button Supprimer est désactivée");
  }
  catch (e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Log.Message("Retour aux valeurs par défaut de la fenêtre Info. relation, section Follow up.");
    Get_RelationshipsBar_BtnInfo().Click();
    
    choixDeroulant = 1;
    SelectionnerSegmentation();
    SelectionnerContactPerson();
    SelectionnerAccountManager();
    SelectionnerCommunication();
    
    Get_WinDetailedInfo_BtnOK().Click();
  }
}

function SelectionnerSegmentation()
{
  if (Get_WinRelationshipInfo_GrpFollowUp_CmbSegmentation().Enabled) {
      Log.Checkpoint("Le menu déroulant Segmentation est éditable.");
      do {
          Get_WinRelationshipInfo_GrpFollowUp_CmbSegmentation().Click();
          choix1 = Get_WinRelationshipInfo_GrpFollowUp_CmbBoxItemNo(choixDeroulant).WPFControlText;
          Get_WinRelationshipInfo_GrpFollowUp_CmbBoxItemNo(choixDeroulant).Click();
          loopCount = loopCount+1;
      } while (Get_WinRelationshipInfo_GrpFollowUp_CmbSegmentation().Text != choix1 && loopCount < 3);
      if (Get_WinRelationshipInfo_GrpFollowUp_CmbSegmentation().Text != choix1 && loopCount == 3)
          Log.Error("La sélection de " +choix1 +" dans le menu déroulant, ne se fait pas correctement.");
      loopCount = 0;
  }
  else
      Log.Error("Le menu déroulant Segmentation N'EST PAS éditable.");
}

function SelectionnerContactPerson()
{
  if (Get_WinRelationshipInfo_GrpFollowUp_CmbContactPerson().Enabled) {
      Log.Checkpoint("Le menu déroulant Contact Person est éditable.");
      do {
          Get_WinRelationshipInfo_GrpFollowUp_CmbContactPerson().Click();
          choix2 = Get_WinRelationshipInfo_GrpFollowUp_CmbBoxItemNo(choixDeroulant).WPFControlText;
          Get_WinRelationshipInfo_GrpFollowUp_CmbBoxItemNo(choixDeroulant).Click();
          loopCount = loopCount+1;
      } while (Get_WinRelationshipInfo_GrpFollowUp_CmbContactPerson().Text != choix2 && loopCount < 3);
      if (Get_WinRelationshipInfo_GrpFollowUp_CmbContactPerson().Text != choix2 && loopCount == 3)
          Log.Error("La sélection de " +choix2 +" dans le menu déroulant, ne se fait pas correctement.");
      loopCount = 0;
  }
  else
      Log.Error("Le menu déroulant Contact Person N'EST PAS éditable.");
}

function SelectionnerAccountManager()
{
  if (Get_WinRelationshipInfo_GrpFollowUp_CmbAccountManager().Enabled) {
        Log.Checkpoint("Le menu déroulant Account Manager est éditable.");
        do {
            Get_WinRelationshipInfo_GrpFollowUp_CmbAccountManager().Click();
            choix3 = Get_WinRelationshipInfo_GrpFollowUp_CmbBoxItemNo(choixDeroulant).WPFControlText;
            Get_WinRelationshipInfo_GrpFollowUp_CmbBoxItemNo(choixDeroulant).Click();
            loopCount = loopCount+1;
        } while (Get_WinRelationshipInfo_GrpFollowUp_CmbAccountManager().Text != choix3 && loopCount < 3);
        if (Get_WinRelationshipInfo_GrpFollowUp_CmbAccountManager().Text != choix3 && loopCount == 3)
            Log.Error("La sélection de " +choix3 +" dans le menu déroulant, ne se fait pas correctement.");
        loopCount = 0;
    }
    else
        Log.Error("Le menu déroulant Account Manager N'EST PAS éditable.");
}

function SelectionnerCommunication()
{
  if (Get_WinRelationshipInfo_GrpFollowUp_CmbCommunication().Enabled) {
      Log.Checkpoint("Le menu déroulant Communication est éditable.");
      do {
          Get_WinRelationshipInfo_GrpFollowUp_CmbCommunication().Click();
          choix4 = Get_WinRelationshipInfo_GrpFollowUp_CmbBoxItemNo(choixDeroulant).WPFControlText;
          Get_WinRelationshipInfo_GrpFollowUp_CmbBoxItemNo(choixDeroulant).Click();
          loopCount = loopCount+1;
      } while (Get_WinRelationshipInfo_GrpFollowUp_CmbCommunication().Text != choix4 && loopCount < 3);
      if (Get_WinRelationshipInfo_GrpFollowUp_CmbCommunication().Text != choix4 && loopCount == 3)
          Log.Error("La sélection de" +choix4 +" dans le menu déroulant, ne se fait pas correctement.");
      loopCount = 0;
  }
  else
    Log.Error("Le menu déroulant Communication N'EST PAS éditable.");
}

function testFRaddr() // test si les champs sont bel et bien grisee  - info  relation / address tab
{
	if (Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Adresses", 1).WPFObject("UniButton", "Aj_outer", 1).Enabled == false
      && Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Adresses", 1).WPFObject("UniButton", "Mo_difier", 2).Enabled == false
			&& Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Adresses", 1).WPFObject("UniButton", "S_upprimer", 3).Enabled == false
			&& Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Téléphones", 2).WPFObject("UniButton", "Aj_outer", 1).Enabled == false
			&& Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Téléphones", 2).WPFObject("UniButton", "Mo_difier", 2).Enabled == false
			&& Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Téléphones", 2).WPFObject("UniButton", "S_upprimer", 3).Enabled == false)
  				Log.Checkpoint("address - tous les champs sont grisés (en lecture seule)");
			else 
  				Log.Error("address - les champs sont PAS grisés (PAS en lecture seule)");
}


function testENaddr()  // test si les champs sont bel et bien grisee  - info  relation / address tab
{
	if (Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Addresses", 1).WPFObject("UniButton", "A_dd", 1).Enabled  == false
      && Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Addresses", 1).WPFObject("UniButton", "_Edit", 2).Enabled  == false
      && Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Addresses", 1).WPFObject("UniButton", "De_lete", 3).Enabled  == false
      && Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Telephones", 2).WPFObject("UniButton", "A_dd", 1).Enabled  == false
      && Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Telephones", 2).WPFObject("UniButton", "_Edit", 2).Enabled  == false
      && Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Telephones", 2).WPFObject("UniButton", "De_lete", 3).Enabled == false)
  				Log.Checkpoint("address - tous les champs sont grisés (en lecture seule)");
			else
  				Log.Error("address - les champs sont PAS grisés (PAS en lecture seule)");
}
