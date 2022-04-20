//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
         
         //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6801");  
        Résumé: Valider la capacité de filtrer par Type de relation - Relation Client, module Relations (Fr, En)
             
        Analyste d'automatisation : Youlia Raisper
		    Module: Relations
		
		 
		 
 */
function CR1142_6801_Validate_filter_by_RelatioshipType() {
    try {
		
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6801","Lien du Cas de test sur Testlink");
         
          var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var typeValue = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "typeValue", language+client);
          var typeValueND= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "typeValueND", language+client);
          
          // Se connecter avec Keynej
          Log.Message("Se connecter avec Keynej") 
          Login(vServerRelations, user, psw, language);         
          Get_MainWindow().Maximize();
        
          // Aller au Module Relations
          Log.Message("Aller au Module Relations") 
          Get_ModulesBar_BtnRelationships().Click();
          WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        
          //Ajouter la colonne Type 
          Log.Message("Ajouter la colonne Type")         
          Get_RelationshipsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
          
          Get_RelationshipsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_Type().Click(); 
        
          //La colonne Type est ajoutée dans la grille. 
          Log.Message("La colonne Type est ajoutée dans la grille")
          aqObject.CheckProperty(Get_RelationshipsGrid_ChType(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",20,language));
        
          //Appuyer sur l’icône Filtres (Y+) sur la barre d’outils / Sélectionner le champ - Type / Opérateur: parmi  /  Valeur: Relation client / Appliquer
          //Afficher la fenêtre « Ajouter un filter » en cliquant l'icone (Y) en haut a gauche
          Log.Message("Appuyer sur l’icône Filtres (Y+) sur la barre d’outils / Sélectionner le champ - Type / Opérateur: parmi  /  Valeur: Relation client / Appliquer ")
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click()
          Get_Toolbar_BtnQuickFilters_ContextMenu_Type().Click();
          Get_WinCreateFilter_CmbOperator().Click();
          Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
          Get_WinCreateFilter_DgvValue().Find("Value",typeValue,10).Click();
          Get_WinCreateFilter_BtnApply().Click();
       
          //Dans la colonne 'Type' sont affichées uniquement 'Relation Client'.  
          Log.Message("Dans la colonne 'Type' sont affichées uniquement 'Relation Client'")      
          var nbOfRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
          for (var i = 0; i < nbOfRelationships; i++){             
              var currentRelationshipTypeValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_Type3Description();

              if (currentRelationshipTypeValue == typeValue){
                  Log.Checkpoint("Le type de relation correspond au filtre appliqué ")                 
              }
              else{
                  Log.Error("Malgre le filtre 'Relation client' , dans la colonne Type il y a une relation d'autre type.")
              }            
          }
       
          //Appuyer sur le crayon pour modifier le filtre / Opérateur: excluant / Valeur : Relation client / Appliquer
          Log.Message("Appuyer sur le crayon pour modifier le filtre / Opérateur: excluant / Valeur : Relation client / Appliquer") 
          var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
          Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-45, 13);
          Get_WinCreateFilter_CmbOperator().Click();
          Get_WinCRUFilter_CmbOperator_ItemExcluding().Click();
          Get_WinCreateFilter_DgvValue().Find("Value",typeValue,10).Click();
          Get_WinCreateFilter_BtnApply().Click();
       
          //Dans la grille sont affichées les autres types de relations, en excluant les types 'Relation Client' 
          //On devrait voir n/d sous la colone Type 
          Log.Message("Dans la grille sont affichées les autres types de relations, en excluant les types 'Relation Client'")  
          Log.Message("On devrait voir n/d sous la colone Type ")      
          var nbOfRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
          for (var i = 0; i < nbOfRelationships; i++){             
              var currentRelationshipTypeValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_Type3Description();

              if (currentRelationshipTypeValue == typeValueND){
                  Log.Checkpoint("Le type de relation correspond au filtre appliqué ")                  
              }
              else{
                  Log.Error("Malgre le filtre 'Relation client' , dans la colonne Type il y a une relation d'autre type.")
              }            
          }
          //Supprimer le filtre par le X
          Log.Message("Supprimer le filtre par le X") 
          Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
          
        

    } catch (e) {

        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerRelations, userName, psw, language);         
        Get_MainWindow().Maximize();
       

    } finally {
        //Remettre les colonnes par défaut 
        Log.Message("Remettre les colonnes par défaut") 
        Get_ModulesBar_BtnRelationships().Click();
        Get_RelationshipsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}






