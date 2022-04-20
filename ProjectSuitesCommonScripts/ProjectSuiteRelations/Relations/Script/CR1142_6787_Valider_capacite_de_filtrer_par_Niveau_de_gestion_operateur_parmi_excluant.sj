//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
        lien pour TestLink :
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6787");
	 
        Résumé :

        Valider la capacité de filtrer par 'Niveau de gestion', operateurs: ‘parmi’, ‘excluant’, ‘est à blanc’, ‘n’est pas à blanc’; 
        Les Valeurs possibles : Profil client et Individuel 
        
        Analyste d'automatisation : Mathieu Gagne
        Auteur révision : Frédéric Thériault
        
        Version de scriptage : ref90-12-Hf-46--V9-croesus-co7x-1_8_2_653
        
		Module: Relations
**/
function CR1142_6787_Valider_capacite_de_filtrer_par_Niveau_de_gestion_operateur_parmi_excluant()
{
  try {
      //lien pour TestLink
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6787","Lien du Cas de test sur Testlink");
        
      //data pool
      var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
      var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
      var relationNumber1_6787 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "relationShipNo", language+client); // 0001A
      var relationNumber2_6787 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "relationShipNo_6787", language+client); // 80028
      var ManagementLevel_6787 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "columnType_6787", language+client); //Niveau de gestion, Management Level  
      var ManagementLevelDescription1_6787 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "ManagementLevelDescription1_6787", language+client); //Profil client, Client Profile 
      var ManagementLevelDescription2_6787 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "ManagementLevelDescription2_6787", language+client); //Individuel, Individual
      
      // Se connecter avec Keynej 
      Login(vServerRelations, userName, password, language);
        
      // Aller au Module Relations
      Log.Message("Aller au Module Relations");
      Get_ModulesBar_BtnRelationships().Click();
  
      //Clic droit sur l’en-tête d’une colonne --> Ajouter une colonne -->  Sélectionner le champ 'Niveau de gestion'
      Log.Message("Ajouter la colonne Niveau de gestion");
      var columnClickR = Get_RelationshipsClientsAccountsPlugin().CRMGrid.RecordListControl.GridViewPanelAdorner.DataRecordPresenter.WPFObject("HeaderPresenter", "", 1).WPFObject("HeaderLabelArea", "", 1).WPFObject("VirtualizingDataRecordCellPanel", "", 1).WPFObject("LabelPresenter", "", 1);
      Add_ColumnByLabel(columnClickR ,ManagementLevel_6787);
        
      //Sélectionner la relation 0001A 
      Log.Message("Sélectionner une Relation client 0001A ");
      SearchRelationshipByNo(relationNumber1_6787);
        
      // Pour valider le contenu de niveau de gestion - Relation 0001A: Niveau de gestion = Profil Client
      //          1- find the Relations index in the grid and return the value for Realtion 0001A
      Log.Message("valider le contenu de niveau de gestion - Relation 0001A");
      var index1_0001A = findIndex_6787(relationNumber1_6787);
      //          2- Validate info of the "Niveau de gestion" field 
      if (Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(index1_0001A).DataItem.ManagementLevelDescription == ManagementLevelDescription1_6787)
          Log.Checkpoint("Relation 0001A: Niveau de gestion = " + ManagementLevelDescription1_6787 );
      else
          Log.Error("Relation 0001A: Niveau de gestion != " + ManagementLevelDescription1_6787);

      // Sélectionner la relation 80021 et valider le contenu de niveau de gestion
      Log.Message("sélectionner la relation 80021");
      SearchRelationshipByNo(relationNumber2_6787);
        
      // Pour valider le contenu de niveau de gestion - Relation 80021: Niveau de gestion = Individuel
      //          1- find the Relations index in the grid and return the value for Realtion 80021
      Log.Message("valider le contenu de niveau de gestion - Relation 80021");
        
      var index2_80021 = findIndex_6787(relationNumber2_6787);
      //          2- Validate info of the "Niveau de gestion" field 
      if (Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(index2_80021).DataItem.ManagementLevelDescription == ManagementLevelDescription2_6787)
          Log.Checkpoint("Relation 80021: Niveau de gestion = " + ManagementLevelDescription2_6787 );
      else
          Log.Error("Relation 80021: Niveau de gestion != " + ManagementLevelDescription2_6787 );
      
      
      // Appuyer sur le filtre (Y+)  (au-dessous de nom du module Relations)
      Log.Message("Appuyer sur le filtre (Y+)");
      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
      
      // Sélectionner le champ Niveau de gestion
      Log.Message("Sélectionner le champ Niveau de gestion");
      Get_Toolbar_BtnQuickFilters_ContextMenu_Item(ManagementLevel_6787).Click();
      
      
      // Dans la fenêtre ‘Créer un filtre’ le champ:  Niveau de gestion s’affiche par défaut.
      Log.Message("Niveau de gestion s’affiche par défaut");
      if (Get_WinCreateFilter_TxtField().Text == 'Niveau de gestion' || Get_WinCreateFilter_TxtField().Text == 'Management Level')
          Log.Checkpoint("Dans la fenêtre ‘Créer un filtre’ le champ:  Niveau de gestion s’affiche par défaut.");
      else
          Log.Error("Dans la fenêtre ‘Créer un filtre’ le champ:  Niveau de gestion ne s’affiche PAS par défaut.");

      // Sélectionner Operateur: parmi  /  Valeur : Individuel
      Log.Message("Sélectionner Operateur: parmi  /  Valeur : Individuel");
      Get_WinCreateFilter_CmbOperator().Click();
      Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
      
      if (language == "french")
          Get_WinCreateFilter().Click(70,55);//FR
      else
          Get_WinCreateFilter().Click(70,70);//EN
        
      // Appuyer sur le bouton appliquer
      Log.Message("Appuyer sur le bouton appliquer");
      Get_WinCreateFilter_BtnApply().Click();
        
      // La liste des Relations client ayant le Niveau de gestion = Individuel est affichée dans la grille
      Log.Message("Valider que la liste des Relations client ayant le Niveau de gestion = Individuel");
      var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
      var count = grid.Count;
      
      for (i = 0; i < count; i++) {
          if (Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.ManagementLevelDescription == ManagementLevelDescription2_6787)
              Log.Checkpoint("client # " + i + "de la grille a le Niveau de gestion = Individuel");
          else
              Log.Error("client # " + i + "de la grille n'a PAS le Niveau de gestion = Individuel");
      }
      
      // Cliquer sur le 'X' du filtre pour supprimer
      Log.Message("cliquer sur le 'X' du filtre pour supprimer");
      Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
      
      // Appuyer sur l’icône Filtre (Y+)
      Log.Message("Appuyer sur l’icône Filtre (Y+)");
      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();

         
      // Dans la barre d’outils / Sélectionner le champ Niveau de gestion
      Log.Message("dans la barre d’outils / Sélectionner le champ Niveau de gestion");
      Get_Toolbar_BtnQuickFilters_ContextMenu_Item(ManagementLevel_6787).Click();
      
      
      // Sélectionner les options suivantes:  Operateur: excluant / Valeur : Individuel
      Log.Message("Sélectionner les options suivantes:  Operateur: excluant / Valeur : Individuel");
      Get_WinCreateFilter_CmbOperator().Click();
      Get_WinCRUFilter_CmbOperator_ItemExcluding().Click();

      if (language == "french")
          Get_WinCreateFilter().Click(70,55);//FR
      else
          Get_WinCreateFilter().Click(70,70);//EN
        
      // Appuyer sur le bouton appliquer
      Log.Message("Appuyer sur le bouton appliquer");
      Get_WinCreateFilter_BtnApply().Click();
      
      // Les Relations client avec le niveau de gestion ‘Client Profil’ sont affichées dans la grille.
      Log.Message("Les Relations client avec le niveau de gestion ‘Client Profil’ sont affichées dans la grille");
      var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
      var count = grid.Count;
      
      
      for (i = 0; i < count; i++) {
          if (Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.ManagementLevelDescription == ManagementLevelDescription1_6787 
          || Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.ManagementLevelDescription == null)
              Log.Checkpoint("client # " + (i+1) + "de la grille a le Niveau de gestion = Client Profil OU n'a pas de Niveau de gestion (vide)");
          else
              Log.Error("client # " + (i+1) + "de la grille n'a PAS le Niveau de gestion = Client Profil ou n'est pas vide");
      }
      
      // Cliquer sur le 'X' du filtre pour supprimer
      Log.Message("cliquer sur le 'X' du filtre pour supprimer");
      Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
  }
  catch (e) {
      if (Sys.WaitProcess("CroesusClient", 2000).Exists == false)
          Login(vServerRelations, userName, password, language);
      
      //S'il y a exception, en afficher le message
      Log.Error("Exception: " + e.message, VarToStr(e.stack));

  }
  finally {
      if (Sys.WaitProcess("CroesusClient", 2000).Exists) {
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          SetDefaultConfiguration(Get_ClientsGrid_ChName());
          Terminate_CroesusProcess();
      }
  }
}


function findIndex_6787(relationNumber)
{
  var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
  var count = grid.Count;
  for (i = 0; i < count; i++) {
      if (grid.Item(i).DataItem.LinkNumber == relationNumber)
          return i;
  }
}


function Get_RelationshipsGrid_ChManagementLevel()
{
  if (language=="french")
      return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Niveau de gestion"], 10);
  else
      return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Management Level"], 10);
}
