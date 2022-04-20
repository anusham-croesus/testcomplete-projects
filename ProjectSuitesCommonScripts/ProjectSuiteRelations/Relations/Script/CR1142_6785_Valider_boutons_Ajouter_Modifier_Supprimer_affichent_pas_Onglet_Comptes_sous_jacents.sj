//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
IMPORTANT pour pouvoir scripter ce CR le testlink Croes-6667 doit être absolument scripté et exécuté.  
^ C'est le cas préparatoire des CR1958 et CR1142  pour CIBC         
		 
Résumé:
Valider que les boutons: Ajouter, Modifier et Supprimer ne s’affiche plus dans l’onglet Comptes sous-jacents pour les Relations client et Relations client-conjoint (Fr, En) 
         
Analyste d'automatisation : Mathieu Gagne, Frédéric Thériault
Module: Relations
*/

function CR1142_6785_Valider_boutons_Ajouter_Modifier_Supprimer_affichent_pas_Onglet_Comptes_sous_jacents()
{
  try {
      // Lien pour TestLink
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6785","Lien du Cas de test sur Testlink");
        
      // Data pool 
      var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
      var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
      var relationNumber1 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "6785_relationNumber1", language+client);
      var relationNumber2 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "6785_relationNumber2", language+client);
       
      // Étape 1
      Log.Message("Étape 1: Se connecter avec user Keynej et aller au Module Relations.");
      Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
      Get_ModulesBar_BtnRelationships().Click();
        
      // Wait for grid relation
      Log.Message("wait for grid relation")
      WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 10);
        
      // Étape 2
      Log.Message("Étape 2: Sélectionner une Relation client 80022.")
      Get_Toolbar_BtnSearch().Click();
      Get_WinQuickSearch_TxtSearch().Keys(relationNumber1);
      Get_WinQuickSearch_BtnOK().Click();
      Get_RelationshipsClientsAccountsGrid().Find("Value", relationNumber1, 10).Click(-1, -1, skCtrl);
        
      // 2.2
      Log.Message("Faire Info relation")
      Get_RelationshipsClientsAccountsGrid().Find("Value", relationNumber1, 10).DblClick();
        
      // 2.3
      Log.Message("Sélectionner l’onglet Comptes sous-jacents.")
      Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship().Click();
        
      // 2.4 - Valider que les boutons: Ajouter, Modifier et Supprimer ne devraient pas être affiché dans l’onglet Comptes sous-jacents
      // CHECK - Les boutons: Ajouter, Modifier et Supprimer ne s’affichent pas dans l’onglet Comptes sous-jacents
      if (Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit().VisibleOnScreen
          || Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd().VisibleOnScreen
          || Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete().VisibleOnScreen)
            Log.Error("Les boutons: Ajouter, Modifier et Supprimer s’affichent dans l’onglet Comptes sous-jacents mais ne devraient pas.");
      else
            Log.Checkpoint("Les boutons: Ajouter, Modifier et Supprimer ne s’affichent pas dans l’onglet Comptes sous-jacents.");

      // Fermer fenetre Info Relation
      Log.Message("Fermer fenetre Info Relation");
      Get_WinDetailedInfo_BtnOK().Click();
      
      // Étape 3
      Log.Message("Étape 3: Sélectionner la Relation 0001A.");
      Get_Toolbar_BtnSearch().Click();
      Get_WinQuickSearch_TxtSearch().Keys(relationNumber2);
      Get_WinQuickSearch_BtnOK().Click();
      Get_RelationshipsClientsAccountsGrid().Find("Value", relationNumber1, 10).Click(-1, -1, skCtrl);
      
      // 3.1
      Log.Message("Dans la section Détails se positionner sur le 1er niveau de la hiérarchie et DblClick.");
      Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.FindChild("ClrClassName", "VirtualizingDataRecordCellPanel", 10).DblClick();
      
      // 3.2
      Log.Message("Aller sur l'onglet Comptes sous-jacents, valider que les boutons: Ajouter, Modifier et Supprimer ne devraient pas être affichés.")
      Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship().Click();
      
      // CHECK - Les boutons: Ajouter, Modifier et Supprimer ne sont pas affichés dans l’onglet Comptes sous-jacents
      if (Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit().VisibleOnScreen
          || Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd().VisibleOnScreen
          || Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete().VisibleOnScreen)
            Log.Error("Les boutons: Ajouter, Modifier et Supprimer s’affichent dans l’onglet Comptes sous-jacents mais ne devraient pas");
      else
            Log.Checkpoint("Les boutons: Ajouter, Modifier et Supprimer ne s’affichent pas dans l’onglet Comptes sous-jacents");
            
      // Fermer fenetre Info Relation
      Log.Message("Fermer fenetre Info Relation");
      Get_WinDetailedInfo_BtnOK().Click();
  }
  catch (e) {
      // S'il y a exception, en afficher le message
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
      // Fermer le processus Croesus
      Terminate_CroesusProcess();
  }
}
