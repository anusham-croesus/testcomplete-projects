//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Vérifier la presence des filtres actifs après redémarrage de l'application
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-675
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0675_Rel_Check_the_presence_of_the_active_filters_after_restarting_the_application()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-675", "CR1352_0675_Rel_Check_the_presence_of_the_active_filters_after_restarting_the_application()");
    Log.Message("Vérifier la presence des filtres actifs après redémarrage de l'application.");
    
    try {
        var expectedIACode = "BD88";
        var expectedname="#1 TEST";
        var filterNamePrefix = "test0675_";
        var nbOfFilters = 2;
        
        Log.Message("Start Croesus and go to Realtionships module.")
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        
        Log.Message("Add " + nbOfFilters + " filters.");
        for (var i=1; i<=nbOfFilters; i++){
        
            var filterName = filterNamePrefix + IntToStr(i);
            Log.Message("Add filter '" + filterName + "'.");
            
            //Supprimer par requête le filtre s'il existe
            Delete_FilterCriterion(filterName, vServerRelations);
            
            //Accéder au module Relations et cliquer sur le bouton Filtres Y, cliquer sur "Ajouter un filtre"
            //Créer un filtre avec un accès Utilisateur
            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
            Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
            Get_WinCRUFilter_GrpDefinition_CmbAccess().set_IsDropDownOpen(true);
            Get_WinCRUFilter_CmbAccess_ItemUser().Click();
            Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
            if (i == 1){           
              Get_WinCRUFilter_CmbField_Item("Code de CP", "IA Code").Click();
              Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
              Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
              Get_WinCRUFilter_GrpCondition_TxtValue().Keys(expectedIACode);
            }
            else {
              Get_WinCRUFilter_CmbField_Item("Nom", "Name").Click();
              Get_WinCRUFilter_GrpCondition_TxtValue().Keys(expectedname);
            }            
            Get_WinCRUFilter_BtnOK().Click();
          
            //Cliquer sur OK si le message "Le filtre que vous avez appliqué ne contient aucune donnée" apparaît
            SetAutoTimeOut();
            if (Get_DlgWarning().Exists){
                Log.Message("There was a Warning Dialog Box.");
                Get_DlgWarning_BtnOK().Click();
            }
            RestoreAutoTimeOut();
        }
        
        //Vérifier que tous les filtres sont actifs
        Log.Message("Check if all filters are activated.")
        for (var i=1; i<=nbOfFilters; i++){
            if (Get_RelationshipsClientsAccountsGrid_BtnFilter(i).Exists && Get_RelationshipsClientsAccountsGrid_BtnFilter(i).IsVisible)
                CheckEquals(Get_RelationshipsClientsAccountsGrid_BtnFilter(i).DataContext.IsFilterActivated, true, "The filter N°" + i + " DataContext 'IsFilterActivated' property");
            else
                Log.Error("The filter N°" + i + " is not displayed.");
        }
        
        //Redémarrer l'application Croesus et accéder au module Relations
        Log.Message("Restart Croesus and go to Realtionships module.")
        Close_Croesus_X();
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        
        //Vérifier que les filtres activés avant la fermeture de l'application sont toujours présents et actifs
        Log.Message("Check if filters are activated after Croesus has restarted.")
        for (var i=1; i<=nbOfFilters; i++){
            if (Get_RelationshipsClientsAccountsGrid_BtnFilter(i).Exists && Get_RelationshipsClientsAccountsGrid_BtnFilter(i).IsVisible)
                CheckEquals(Get_RelationshipsClientsAccountsGrid_BtnFilter(i).DataContext.IsFilterActivated, true, "The filter N°" + i + " DataContext 'IsFilterActivated' property");
            else
                Log.Error("The filter N°" + i + " is not displayed.");
        }
        
        //Fermer les filtres
        for (var i=1; i<=nbOfFilters; i++){
            if (!Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists)
                break;
            Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnRemove(1).Click();
            Delay(2000);
        }
        
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        for (var i=1; i<=nbOfFilters; i++){
            var filterName = filterNamePrefix + IntToStr(i);
            Delete_FilterCriterion(filterName, vServerRelations);
        }
        Terminate_CroesusProcess();
    }
}