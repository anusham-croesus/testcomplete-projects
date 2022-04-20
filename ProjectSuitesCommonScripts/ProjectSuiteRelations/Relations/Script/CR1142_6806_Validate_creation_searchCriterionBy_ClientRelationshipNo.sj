//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6803");  
        Résumé: Valider la création du critère de recherche par: No relation client, Niveau de gestion, Est conjoint et État, module Clients
             
        Analyste d'automatisation : Youlia Raisper
		    Module: Relations	 
		 
 */
function CR1142_6806_Validate_creation_searchCriterionBy_ClientRelationshipNo() {
    try {
		
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6806","Lien du Cas de test sur Testlink");
         
          var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");        
          var criterion_6806 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "criterion_6806", language+client);
          var criterion_6806_1 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "criterion_6806_1", language+client);
          var managementValue= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "managementValue", language+client);  
          var clientRelationship80022 =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "clientRelationship80022", language+client);
           
          // Se connecter avec Keynej 
          Log.Message("Se connecter avec Keynej ")
          Login(vServerRelations, userName, psw, language);         
          Get_MainWindow().Maximize();
        
          GoToClientModuleSetDefaultConfiguration();
              
          Get_ClientsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_ClientRelationshipNo().Click();           

          Get_ClientsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_ManagementLevel().Click();
          
          Get_ClientsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_StatusForClients().Click();   
               
          //Les colonnes sont ajoutées dans la grille. 
          Log.Message("Les colonnes sont ajoutées dans la grille.") 
          aqObject.CheckProperty(Get_ClientsGrid_ChStatus(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",39,language));
          aqObject.CheckProperty(Get_ClientsGrid_ChManagementLevel(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",40,language));
          aqObject.CheckProperty(Get_ClientsGrid_ChClientRelationshipNo(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",42,language));
                   
          /*Appuyer sur un touche du clavier pour faire une recherche rapide par No relation client 
          Dans le champ 'Rechercher:' saisir un No relation client, par ex:80022 
          Sélectionner le champ: No relation client / Filtrer 
          Après validation supprimer le critère par le X */
          Log.Message("Appuyer sur un touche du clavier pour faire une recherche rapide");
          FilterClientByClientRelationshipNo(clientRelationship80022);          
          CheckFilterState(1,1);
          
          var nbOfRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
          for (var i = 0; i < nbOfRelationships; i++){             
              var currentClientRelationshipLinkNumberValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ClientRelationshipLinkNumber();
              
              if (currentClientRelationshipLinkNumberValue == clientRelationship80022 ){
                  Log.Checkpoint("le client Relationship No est  " + clientRelationship80022);                 
              }
              else{
                  Log.Error("le client Relationship No est différant de " + managementValue);
              }            
          }
          Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
          
          /*Appuyer sur l’icône ‘Gérer les critères de recherche’*/
          Log.Message("Appuyer sur l’icône ‘Gérer les critères de recherche’");
          Get_Toolbar_BtnManageSearchCriteria().Click();
          /*Dans la fenêtre ‘Gestionnaire de critères de recherche’  appuyer sur le bouton Ajouter*/
          Log.Message("Dans la fenêtre ‘Gestionnaire de critères de recherche’  appuyer sur le bouton Ajouter")
          Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
          Get_WinSearchCriteriaManager_BtnAdd().Click();
          WaitObject(Get_CroesusApp(),"Uid","CriteriaWindow_9bb5");
          
          /*Saisir un nom  Définition : Liste des clients (Client réel) ayant niveau de gestion différent(e) de Individuel.
          Sauvegarder et  Actualiser   */
          Log.Message("Saisir un nom  Définition : Liste des clients (Client réel) ayant niveau de gestion différent(e) de Individuel.Sauvegarder et  Actualiser ")
          Get_WinAddSearchCriterion_TxtName().Clear();
          Get_WinAddSearchCriterion_TxtName().set_Text(criterion_6806);

          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();            
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();          
          Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();          
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemManagementLevel().Click();        
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();              
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemNotEqualTo().Click();      
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemIndividual().Click();          
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
          Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
          
          
          /*La liste des clients ayant sous la colonne  le Niveau de gestion =Profil client est affichée dans la grille avec un crochet  de côté gauche de chaque client. */
          Log.Message("La liste des clients ayant sous la colonne  le Niveau de gestion =Profil client est affichée dans la grille avec un crochet rouge de côté gauche de chaque client. */")
          CheckFilterState(1,1);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual,criterion_6806);
          
          var nbOfRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
          for (var i = 0; i < nbOfRelationships; i++){             
              var currentRelationshipManagementValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ManagementLevelDescription();
              var matchesCriterionValue=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Get_MatchesCriterion();
              
              if (currentRelationshipManagementValue == managementValue && matchesCriterionValue==true){
                  Log.Checkpoint("Le Niveau de gestion =" + managementValue+" et le client est affichée dans la grille avec un crochet" );                 
              }
              else{
                  Log.Error("le Niveau de gestion différant de " + managementValue+" ou le client n'est pas affichée dans la grille avec un crochet");
              }            
          }
                  
         //Appuyer sur l’icône ‘Réafficher tout et enlever les crochets’
         Log.Message("Appuyer sur l’icône ‘Réafficher tout et enlever les crochets’");
         Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
         
         //Le critère est désactivé 
         Log.Message("Le critère est désactivé ");
         CheckFilterState(1,0);
         
         //fermer le critère
         Log.Message("fermer le critère");
         Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
         
         
         /*Appuyer sur l’icône ‘Gérer les critères de recherche’ */
         Get_Toolbar_BtnManageSearchCriteria().Click();
         
         /*Dans la fenête ‘Gestionnaire de critères de recherche’  appuyer sur le bouton Ajouter 
         Saisir un nom / Définition: Liste des clients (Cliet réel) ayant est conjoint égale(e) à Oui. 
         Sauvegarder et actualiser    */
         Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
         Get_WinSearchCriteriaManager_BtnAdd().Click();
         WaitObject(Get_CroesusApp(),"Uid","CriteriaWindow_9bb5");
         Get_WinAddSearchCriterion_TxtName().Clear();
         Get_WinAddSearchCriterion_TxtName().set_Text(criterion_6806_1);
         
         Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();            
         Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();          
         Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();                   
         Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
         Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemIsJoint().Click();         
         Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();              
         Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();        
         Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
         Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes().Click();          
         Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
         Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
         Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
         
         /*La liste des clients conjoint est affichée dans la grille avec un crochet rouge de côté gauche de chaque client.*/
         CheckFilterState(1,1);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual,criterion_6806_1); 
         
          var nbOfRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
          for (var i = 0; i < nbOfRelationships; i++){             
              var currentIsJointValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_IsJoint();
              var matchesCriterionValue=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Get_MatchesCriterion();
              
              if (currentIsJointValue == true && matchesCriterionValue==true){
                  Log.Checkpoint("L'icône de conjoint est affichée =" + managementValue+" et le client est affichée dans la grille avec un crochet" );                 
              }
              else{
                  Log.Error("L'icône de conjoint n'est pas affichée " + managementValue+" ou le client n'est pas affichée dans la grille avec un crochet");
              }            
          }
         Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
          
    } catch (e) {

          //S'il y a exception, en afficher le message
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
          Login(vServerRelations, userName, psw, language); 
             

    } finally {
          
          GoToClientModuleSetDefaultConfiguration()         
          Delete_FilterCriterion(criterion_6806, vServerRelations);
          Delete_FilterCriterion(criterion_6806_1, vServerRelations);
          Terminate_CroesusProcess();
    }
}

function GoToClientModuleSetDefaultConfiguration(){
      // Aller au Module Clients
      Log.Message("Aller au Module Clients")
      Get_ModulesBar_BtnClients().Click();
      WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
             
      //Dans la grille ajouter les colonnes: 'No relation client',  'Niveau de gestion' et 'État'
      Log.Message("Dans la grille ajouter les colonnes: 'No relation client',  'Niveau de gestion' et 'État'")   
      SetDefaultConfiguration(Get_ClientsGrid_ChName()); 
}

function CheckFilterState(filterposition,state){
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(filterposition), "IsVisible", cmpEqual, true)
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(filterposition), "wState", cmpEqual, state); // 0 - Le filtre n'est pas actif 1- Le filtre est actif   
}