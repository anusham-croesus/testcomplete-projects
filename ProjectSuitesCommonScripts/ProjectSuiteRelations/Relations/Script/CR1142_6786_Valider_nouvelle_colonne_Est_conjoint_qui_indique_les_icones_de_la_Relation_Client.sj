//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
IMPORTANT pour pouvoir scripter ce CR le testlink Croes-6667 doit être absolument scripté et exécuté.  
^ C'est le cas préparatoire des CR1958 et CR1142  pour CIBC         
		 
Résumé:

- Dans la colonne ‘Is joint’/’Est conjoint’ sera affichés les icônes de la Relation client et de la Relation Client conjoint (Fr, En)
- La colonne ‘Is joint’/’Est conjoint’ sera affiché par défaut dans le module Relations et module Clients (on ne devrait pas être capable de supprimer, remplacer ou ajouter la colonne ‘Is joint’/’Est conjoint’)
- La colonne ‘Is joint’/’Est conjoint’ se trouve immédiatement à gauche du nom de la Relation client 
        
Analyste d'automatisation : Mathieu Gagne, Frédéric Thériault
Module: Relations
*/

var grid;
var count;
var relationNo;
var itemIndex;


function CR1142_6786_Valider_nouvelle_colonne_Est_conjoint_qui_indique_les_icones_de_la_Relation_Client()
{
    var maxRetry = 5;

  try {
      // Lien pour TestLink
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6786","Lien du Cas de test sur Testlink");
      
      // Data pool 
      var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
      var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
      var relationNumber1 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "6786_relationNumber1", language+client); // 80028
      var relationNumber2 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "6786_relationNumber2", language+client); // 0001A              
      //var clientName      = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "clientName", language+client);
      
      // Étape 1
      Log.Message("Étape 1: Se connecter avec KEYNEJ et aller au Module Relations");
      Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
      Get_ModulesBar_BtnRelationships().Click();
        
      // Étape 2
      Log.Message("Étape 2: Valider l’affichage de la colonne  qui affiche les icônes.");
      // CHECK - La colonne de l'icone est affichée par défaut dans la grille
      if (Get_RelationshipsClientsAccountsGrid().RecordListControl.GridViewPanelAdorner.DataRecordPresenter.WPFObject("HeaderPresenter", "", 1).WPFObject("HeaderLabelArea", "", 1).WPFObject("VirtualizingDataRecordCellPanel", "", 1).WPFObject("LabelPresenter", "", 3).IsFixed
          && Get_RelationshipsClientsAccountsGrid().RecordListControl.GridViewPanelAdorner.DataRecordPresenter.WPFObject("HeaderPresenter", "", 1).WPFObject("HeaderLabelArea", "", 1).WPFObject("VirtualizingDataRecordCellPanel", "", 1).WPFObject("LabelPresenter", "", 3).IsVisible)
            Log.Checkpoint("La colonne de icônes est affichée par défaut dans la grille");
      else
            Log.Error("La colonne icônes n'est pas affichée par défaut dans la grille");
      
      // Rechercher la relation ciblée.
      Get_Toolbar_BtnSearch().Click();
      Get_WinQuickSearch_TxtSearch().Keys(relationNumber1);
      Get_WinQuickSearch_BtnOK().Click();
      
      // Find the Relations index in the grid and return the value for Realtion 80028
      grid = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
      count = grid.Count;
      relationNo = relationNumber1;
      itemIndex = findIndex();
      
      // Un bonhomme de couleur blanche dans un cadre de couleur gris foncé pour les Relations Client (comme 80028).
      if (Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(itemIndex).DataItem.IsClientRelationshipJoint == false
          && Get_RelationshipGrid_UnBonhommeIcon().Visible == true)
          Log.Checkpoint("L'icône pour la relation " + relationNumber1 + " est celui qui a un bonhomme" );
      else
          Log.Error("L'icône pour la relation " + relationNumber1 + " n'est pas celui qui a un bonhomme");
      for (tti = 1; tti <= maxRetry; tti++) {
        // Mouse over pour détecter la présence du Tooltip.
        Get_RelationshipGrid_UnBonhommeIcon().HoverMouse();
      
        if (Get_RelationshipGrid_UnBonhommeIcon().ToolTip.IsVisible == true) {
          texteTooltip = Get_RelationshipGrid_UnBonhommeIcon().ToolTip.Text;
          Log.Checkpoint("Le Tooltip '" +texteTooltip + "', est affiché.");
          break;
        }
        else {
          if (tti == maxRetry)
            Log.Error("Tooltip non détecté " +tti +" fois sur " +maxRetry +" pour la relation " +relationNo +".");
          else
            Log.Message("Tooltip non détecté " +tti +" fois sur " +maxRetry +" pour la relation " +relationNo +".");
        }
        Delay(1000);
      }
      
      // Rechercher la relation ciblée.
      Get_Toolbar_BtnSearch().Click();
      Get_WinQuickSearch_TxtSearch().Keys(relationNumber2);
      Get_WinQuickSearch_BtnOK().Click();
      
      // Find the Relations index in the grid and return the value for Realtion 0001A
      grid = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
      count = grid.Count;
      relationNo = relationNumber2;
      itemIndex = findIndex();
      
      // Deux bonhommes de couleur gris foncé pour les Relations client conjoint (comme 0001A).
      if (Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(itemIndex).DataItem.IsClientRelationshipJoint == true
          && Get_RelationshipGrid_DeuxBonshommesIcon().Visible == true)
          Log.Checkpoint("L'icône pour la relation " + relationNumber2 + " est celui qui a deux bonshommes" );
      else
          Log.Error("L'icône pour la relation " + relationNumber2 + " n'est pas celui qui a deux bonshommes");
      
      for (tti = 1; tti <= maxRetry; tti++) {
        // Mouse over pour détecter la présence du Tooltip.
        Get_RelationshipGrid_DeuxBonshommesIcon().HoverMouse();
      
        if (Get_RelationshipGrid_DeuxBonshommesIcon().ToolTip.IsVisible == true) {
          texteTooltip = Get_RelationshipGrid_DeuxBonshommesIcon().ToolTip.Text;
          Log.Checkpoint("Le Tooltip '" +texteTooltip + "', est affiché.");
          break;
        }
        else {
          if (tti == maxRetry)
            Log.Error("Tooltip non détecté " +tti +" fois sur " +maxRetry +" pour la relation " +relationNo +".");
          else
            Log.Message("Tooltip non détecté " +tti +" fois sur " +maxRetry +" pour la relation " +relationNo +".");
        }
        Delay(1000);
      }
      
      // Étape 3
      Log.Message("Étape 3: Sélectionner la relation client " +relationNumber1 +" et valider la section Détails.");
      Get_Toolbar_BtnSearch().Click();
      Get_WinQuickSearch_TxtSearch().Keys(relationNumber1);
      Get_WinQuickSearch_BtnOK().Click();
      Get_RelationshipsClientsAccountsGrid().Find("Value", relationNumber1, 10).Click();
      
      // Valider la section Détails l'image dans la section Info (bottomGroupBox) doit correspondre à la relation.
      for (bgbi = 1; bgbi <= maxRetry; bgbi++){
        if (Get_ClientsDetails_TabInfo_InfoPage_UnBonhommeIcon().Visible == true) {
          Log.Checkpoint("L'icône pour la relation " + relationNumber1 + " est celui qui a un bonhomme." );
          break;
        }
        else {
          if (bgbi == maxRetry)
            Log.Error("L'icône pour la relation " + relationNumber1 + " n'est pas celui qui a un bonhomme.");
          else
            Log.Warning("Icône non détecté " +bgbi +" fois sur " +maxRetry +" pour la relation " +relationNumber1 +".");
        }
        Delay(1000);
      }
        
      // Étape 4
      Log.Message("Étape 4: Mailler la relation " +relationNumber1 +" vers le module Clients.");
      // Faire le maillage avec les functions déjà existantes.
      Get_MenuBar_Modules().OpenMenu();
      Get_MenuBar_Modules_Clients().OpenMenu();
      Get_MenuBar_Modules_Clients_DragSelection().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
      Log.Message("Vérifier que le filtre de maillage existe.");
      CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilterByDescription(" Dragged Relationship(s) = " +relationNumber1), "Exists", cmpEqual, true);
      
      // CHECK - L’icône avec un bonhomme de couleur blanche dans un cadre gris foncé n'est pas affichée en haut à gauche du nom de chaque client.
      SetAutoTimeOut(1000);
      count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
      for (itemIndex = 1; itemIndex <= count; itemIndex++) {
         bonhommeNonVisible = CheckProperty(Get_ClientsGrid_UnBonhommeIcon(), "Visible", cmpEqual, false);
         if (bonhommeNonVisible)
            Log.Checkpoint("L’icône avec un bonhomme n'est pas affichée pour le client No. " +Get_ClientsGrid_NoClient() +"." );
        else
            Log.Error("L’icône avec un bonhomme est affichée pour le client No. " +Get_ClientsGrid_NoClient() +".");
      }
      RestoreAutoTimeOut();
      
      // CHECK - L’icône avec un bonhomme de couleur blanche dans un cadre gris foncé n'est pas affichée dans l'onglet Info de la section Détails.
      bonhommeNonVisible = CheckProperty(Get_ClientsDetails_TabInfo_InfoPage_UnBonhommeIcon(), "Visible", cmpEqual, false);
      
      if(bonhommeNonVisible)
          Log.Checkpoint("L’icône avec un bonhomme n'est pas affichée dans l'onglet Info de la section Détails." );
      else
          Log.Error("L’icône avec un bonhomme est affichée, dans l'onglet Info de la section Détails, alors qu'il ne devrait pas l'être.");
      
      // Retourner au module Relations.
      Get_ModulesBar_BtnRelationships().Click();
      
      // Étape 5
      Log.Message("Étape 5: Sélectionner la relation client conjoint " +relationNumber2 +" et valider la section Détails.");
      Get_Toolbar_BtnSearch().Click();
      Get_WinQuickSearch_TxtSearch().Keys(relationNumber2);
      Get_WinQuickSearch_BtnOK().Click();
      Get_RelationshipsClientsAccountsGrid().Find("Value", relationNumber2, 10).Click();
      
      // Valider la section Détails.
            for (bgbi = 1; bgbi <= maxRetry; bgbi++){
        if (Get_ClientsDetails_TabInfo_InfoPage_DeuxBonshommesIcon().Visible == true) {
          Log.Checkpoint("L'icône pour la relation " + relationNumber2 + " est celui qui a deux bonshommes." );
          break;
        }
        else {
          if (bgbi == maxRetry)
            Log.Error("L'icône pour la relation " + relationNumber2 + " n'est pas celui qui a deux bonshommes.");
          else
            Log.Warning("Icône non détecté " +bgbi +" fois sur " +maxRetry +" pour la relation " +relationNumber2 +".");
        }
        Delay(1000);
      }
      
      // Étape 6
      Log.Message("Étape 6: Mailler la relation " +relationNumber2 +" vers le module Clients.");
      // Faire le maillage avec les functions déjà existantes.
      Get_MenuBar_Modules().OpenMenu();
      Get_MenuBar_Modules_Clients().OpenMenu();
      Get_MenuBar_Modules_Clients_DragSelection().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
      Log.Message("Vérifier que le filtre de maillage existe.");
      CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilterByDescription(" Dragged Relationship(s) = " +relationNumber2), "Exists", cmpEqual, true);
        
      // CHECK - L’icône avec deux bonshommes est affichée du côté gauche du nom de chaque client de la Relation client conjoint.
      count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
      for (itemIndex = 1; itemIndex <= count; itemIndex++) {
         bonshommesSontVisibles = CheckProperty(Get_ClientsGrid_DeuxBonshommesIcon(), "Visible", cmpEqual, true); 
         if (bonshommesSontVisibles)
            Log.Checkpoint("L’icône avec deux bonshommes est affichée pour le client No. " +Get_ClientsGrid_NoClient() +"." );
        else
            Log.Error("L’icône avec un bonhomme n'est pas affichée pour le client No. " +Get_ClientsGrid_NoClient() +".");
      }
  }
  catch (e) {
      //S'il y a exception, en afficher le message
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
      //Fermer le processus Croesus
      Terminate_CroesusProcess();
  }
}

function findIndex()
{
     for (i = 0; i < count; i++)
     {
        if (grid.Item(i).DataItem.LinkNumber == relationNo)
              return i+1;
     }
}

// Icons de la Grille Relations, un bonhomme, deux bonshommes
function Get_RelationshipGrid_UnBonhommeIcon(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", itemIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", "1"], 10)}

function Get_RelationshipGrid_DeuxBonshommesIcon(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", itemIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", "2"], 10)}

// Icon bonhomme dans section détails Info page
function Get_ClientsDetails_TabInfo_InfoPage_UnBonhommeIcon(){return Get_RelationshipsClientsAccountsDetails().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", "1"], 10)}

function Get_ClientsDetails_TabInfo_InfoPage_DeuxBonshommesIcon(){return Get_RelationshipsClientsAccountsDetails().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", "2"], 10)}

// Icon de la Grille Clients, un bonhomme, deux bonshommes
function Get_ClientsGrid_UnBonhommeIcon(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", itemIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", "1"], 10)}
function Get_ClientsGrid_DeuxBonshommesIcon(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", itemIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", "1"], 10)}

// Trouve No Client dela Grille Clients
function Get_ClientsGrid_NoClient(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", itemIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 5], 10).Value.OleValue}