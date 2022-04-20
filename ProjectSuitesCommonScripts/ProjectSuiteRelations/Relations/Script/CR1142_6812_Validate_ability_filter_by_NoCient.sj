//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
         
         //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6812");  
        Résumé:Valider la capacité de filtrer par 'No relation client', module Clients (Fr, En)
             
        Analyste d'automatisation : Youlia Raisper
		    Module: Relations
		
		 
		 
 */
function CR1142_6812_Validate_ability_filter_by_NoCient() {
    try {
		
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6812","Lien du Cas de test sur Testlink");
         
          var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var clientRelationshipNo = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "clientRelationshipNo", language+client);
          var client80022 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "client80022", language+client);
          var FilterDescription = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "FilterDescription", language+client);  
                 
          // Se connecter avec Keynej 
          Log.Message("Se connecter avec Keynej ") 
          Login(vServerRelations, user, psw, language);         
          Get_MainWindow().Maximize();
        
          // Aller au Module Clients
          Log.Message("Aller au Module Clients") 
          Get_ModulesBar_BtnClients().Click();
          WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
                   
          Log.Message("Set the default configuration of columns in the grid") 
          SetDefaultConfiguration(Get_ClientsGrid_ChName());
          
          //Ajouter la colonne 'No relation client'
          Log.Message("Ajouter la colonne 'No relation client'") 
          Get_ClientsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_ClientRelationshipNo().Click() 
          
          //La colonne 'No relation client' est ajoutée dans la grille 
          Log.Message("La colonne 'No relation client' est ajoutée dans la grille ")
          aqObject.CheckProperty(Get_ClientsGrid_ChClientRelationshipNo(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",42,language));
         
          /*Appuyer sur l’icône Filtres (Y+) sur la barre d’outils 
          Sélectionner le champ - No relation client / Opérateur: contenant  /  Valeur: 80022 / Appliquer*/          
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click()
          Get_Toolbar_BtnQuickFilters_ContextMenu_ClientRelationshipNo().Click();
          Get_WinCreateFilter_CmbOperator().DropDown();
          Get_WinCRUFilter_CmbOperator_ItemContaining().Click();
          Get_WinCreateFilter_TxtValue().keys(client80022);
          Get_WinCreateFilter_BtnApply().Click();
                                   
          //Dans la grille sont affichés les MyClients ID dont No relation client = 80022
          Log.Message("Le critère de recherche est affiché en haut de la liste des relations.La liste des Relations Client ayant l’État = Ouverte est affichée dans la grille")
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif 
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual,FilterDescription);
          

           var nbOfRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
           for (var i = 0; i < nbOfRelationships; i++){             
              var currentClientNumber = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ClientRelationshipLinkNumber();

              if (currentClientNumber == client80022){
                  Log.Checkpoint("Le numéro de client correspond au filtre appliqué")                 
              }
              else{
                  Log.Error("Le numéro de client ne correspond pas au filtre appliqué")
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
         Get_MainWindow().Maximize();
         Get_ModulesBar_BtnClients().Click();
         //Remettre les colonnes par défaut 
         Log.Message("Set the default configuration of columns in the grid") 
         SetDefaultConfiguration(Get_ClientsGrid_ChName()); 
         //Fermer le processus Croesus
         Terminate_CroesusProcess();
    }
}
