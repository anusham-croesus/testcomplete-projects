//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
         
         //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6802");  
        Résumé: Valider la création du critère de recherche par: Niveau de gestion, Date de fermeture, Type et État
             
        Analyste d'automatisation : Youlia Raisper
		    Module: Relations
		
		 
		 
 */
function CR1142_6802_Validate_Creation_of_searchCriterion() {
    try {
		
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6802","Lien du Cas de test sur Testlink");
         
          var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "criterionName", language+client);
          var criterionName1 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "criterionName1", language+client);
          var managementValue= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "managementValue", language+client);
          var statusValue= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "statusValue", language+client);
          
          
          // Se connecter avec Keynej 
          Log.Message("Se connecter avec Keynej ") 
          Login(vServerRelations, user, psw, language);         
          Get_MainWindow().Maximize();
        
          // Aller au Module Relations
          Log.Message("Aller au Module Relations") 
          Get_ModulesBar_BtnRelationships().Click();
          WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        
          //Dans la grille ajouter les colonnes: 'Niveau de gestion' , 'État' 
          Log.Message("Dans la grille ajouter les colonnes: 'Niveau de gestion' , 'État' ")          
          Get_RelationshipsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
          
          Get_RelationshipsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_Status().Click() 
          
          Get_RelationshipsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_ManagementLevel().Click()
        
          //Les colonnes sont ajoutées dans la grille. 
          Log.Message("Les colonnes sont ajoutées dans la grille. ")
          aqObject.CheckProperty(Get_RelationshipsGrid_ChStatus(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",39,language));
          aqObject.CheckProperty(Get_RelationshipsGrid_ChManagementLevel(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",40,language));
        
          /*Appuyer sur l’icône ‘Gérer les critères de recherche’
           Dans la fenêtre ‘Gestionnaire de critères de recherche’  appuyer sur le bouton Ajouter 
           Saisir un nom: 'N gestion'*/
           Log.Message("Appuyer sur l’icône ‘Gérer les critères de recherche’Dans la fenêtre ‘Gestionnaire de critères de recherche’  appuyer sur le bouton Ajouter Saisir un nom: 'N gestion'")
           Get_Toolbar_BtnManageSearchCriteria().Click(); 
           Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
           Get_WinSearchCriteriaManager_BtnAdd().Click();
           WaitObject(Get_CroesusApp(),"Uid","CriteriaWindow_9bb5");
           Get_WinAddSearchCriterion_TxtName().Clear();
           Get_WinAddSearchCriterion_TxtName().set_Text(criterionName);
           
           /*Définition : Liste des relations ayant niveau de gestion égale(e) à Profil client. / Sauvegarder et actualiser */
           Log.Message("Définition : Liste des relations ayant niveau de gestion égale(e) à Profil client. / Sauvegarder et actualiser ")
           Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();            
           Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemManagementLevel().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemClientProfile().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
           Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
   
           //Les points de vérification : le texte de filtre
           /*Le critère de recherche est affiché en haut de la liste des relations
           La liste des relations client ayant le Niveau de gestion =Profil client est affiché dans la grille */
           Log.Message("Les points de vérification : le texte de filtre.Le critère de recherche est affiché en haut de la liste des relations.La liste des relations client ayant le Niveau de gestion =Profil client est affiché dans la grille */")
           CheckFilterState(1,1);
           aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual,criterionName);
          
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
          // Après la validation supprimer le critère en cliquant sur le X.
          Log.Message("Après la validation supprimer le critère en cliquant sur le X.")
          Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
          
          
          /*Appuyer sur l’icône ‘Gérer les critères de recherche’
          Dans la fenêtre ‘Gestionnaire de critères de recherche’  appuyer sur le bouton  Ajouter 
          Saisir un nom : 'État.
           .*/
           Log.Message("Appuyer sur l’icône ‘Gérer les critères de recherche’.Dans la fenêtre ‘Gestionnaire de critères de recherche’  appuyer sur le bouton  Ajouter . Saisir un nom : 'État.")
           Get_Toolbar_BtnManageSearchCriteria().Click(); 
           Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
           Get_WinSearchCriteriaManager_BtnAdd().Click();
           WaitObject(Get_CroesusApp(),"Uid","CriteriaWindow_9bb5");
           Get_WinAddSearchCriterion_TxtName().Clear();
           Get_WinAddSearchCriterion_TxtName().set_Text(criterionName1);
           
           /*Définition : Liste des relations ayant état égale(e) à Ouverte. / Sauvegarder et actualiser */
           Log.Message("Définition : Liste des relations ayant état égale(e) à Ouverte. / Sauvegarder et actualiser")
           Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();            
           Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemStatus().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemOpen_1().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
           Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
           Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
       
           /*Le critère de recherche est affiché en haut de la liste des relations.
           La liste des Relations Client ayant l’État = Ouverte est affichée dans la grille*/    
           Log.Message("Le critère de recherche est affiché en haut de la liste des relations.La liste des Relations Client ayant l’État = Ouverte est affichée dans la grille")
           CheckFilterState(1,1);
           aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual,criterionName1);
          

           var nbOfRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
           for (var i = 0; i < nbOfRelationships; i++){             
              var currentRelationshipStatusValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_StatusDescription();

              if (currentRelationshipStatusValue == statusValue){
                  Log.Checkpoint("l’État = Ouverte ")                 
              }
              else{
                  Log.Error("l’État différante de Ouverte")
              }            
           }
          // Après la validation supprimer le critère en cliquant sur le X.
          Log.Message("Après la validation supprimer le critère en cliquant sur le X.")
          Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
           

    } catch (e) {

        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerRelations, userName, psw, language);         
        


    } finally {
         //Remettre les colonnes par défaut 
         Log.Message("Remettre les colonnes par défaut")
         Get_MainWindow().Maximize();
         Get_ModulesBar_BtnRelationships().Click();
         Get_RelationshipsGrid_ChName().ClickR();
         Get_GridHeader_ContextualMenu_DefaultConfiguration().Click(); 
         Delete_FilterCriterion(criterionName1, vServerRelations);
         Delete_FilterCriterion(criterionName, vServerRelations);
        //Fermer le processus Croesus
         Terminate_CroesusProcess();
    }
}

function CheckFilterState(filterposition,state){
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(filterposition), "IsVisible", cmpEqual, true)
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(filterposition), "wState", cmpEqual, state); // 0 - Le filtre n'est pas actif 1- Le filtre est actif   
}




