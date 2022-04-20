//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Vérifier l'espace disponible pour plusieurs filtres
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-685
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0685_Rel_Check_the_space_available_for_multiple_filters()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-685", "CR1352_0685_Rel_Check_the_space_available_for_multiple_filters()");
    
    try {
        var expectedIACode = "0AED";
        var filterNamePrefix = "test_test_test_test_test_test_test_test_test_685_";
        
        //Appliquer autant de filtres qu'il faut pour remplir la barre jusqu'à ce qu'un scroll apparaisse
        Log.Message("Appliquer autant de filtres qu'il faut pour remplir la barre jusqu'à ce qu'un scroll apparaisse.");
        var maxNbOfFilters = 8;
        var isFirstFilterVisible = false;
        var isLastFilterVisible = false;
        var filterMaxIndex = 0;
        
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        
        do {
            filterMaxIndex ++;
            var filterName = filterNamePrefix + IntToStr(filterMaxIndex);
            Log.Message("Add filter '" + filterName + "'.");
            var cmbFieldfrench = GetData(filePath_Relations, "CR1352", 165 + filterMaxIndex, language);
            var cmbFieldenglish = GetData(filePath_Relations, "CR1352", 165 + filterMaxIndex, language);
            
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
            Get_WinCRUFilter_CmbField_Item(cmbFieldfrench, cmbFieldenglish).Click();
            Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
            Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
            Get_WinCRUFilter_GrpCondition_TxtValue().Keys(expectedIACode);
            Get_WinCRUFilter_BtnOK().Click();
            
            //Cliquer sur OK si le message "Le filtre que vous avez appliqué ne contient aucune donnée" apparaît
            SetAutoTimeOut();
            if (Get_DlgWarning().Exists){
                Log.Message("There was a Warning Dialog Box.");
                Get_DlgWarning_BtnOK().Click();
            }
            RestoreAutoTimeOut();
            
            //Vérifier si le premier filtre est visible à l'écran
            var firstFilter = Get_RelationshipsClientsAccountsGrid_BtnFilter(1);
            isFirstFilterVisible = (firstFilter.Exists && firstFilter.IsVisible && firstFilter.VisibleOnScreen);
            
            //Vérifier si le dernier filtre est visible à l'écran
            var lastFilter = Get_RelationshipsClientsAccountsGrid_BtnFilter(filterMaxIndex);
            isLastFilterVisible = (lastFilter.Exists && lastFilter.IsVisible && lastFilter.VisibleOnScreen);
            
            //Ajuster le nombre maximum de filtres à essayer d'ajouter
            if (filterMaxIndex == 1){
                if (!lastFilter.Exists || !isFirstFilterVisible)
                    return Log.Error("The was issue with the First filter.");
                
                maxNbOfFilters = 3 * Math.ceil(Get_MainWindow().Width / lastFilter.Width);
                Log.Message("Maximum number of filters to attempt to add = " + maxNbOfFilters);
            }
        } while (isFirstFilterVisible && isLastFilterVisible && filterMaxIndex < maxNbOfFilters)
        
        if (isFirstFilterVisible && isLastFilterVisible){
            Log.Error("Both first and last filters are visible after adding maximum number of " + maxNbOfFilters + " filters.");
        }
        
        if (!isFirstFilterVisible){
            Log.Message("First filter hidden after " + filterMaxIndex + " filters were added.");
        
            //Scroll pour rendre visible le premier filtre
            Log.Message("Scroll to make visible the first filter.");
            Log.Message("If the first filter become visible after clicking in the expected scroll bar, it means the scroll bar were present.");
            for (var i=1; i<=3; i++){
                Get_RelationshipsClientsAccountsGrid().Click(40, 35);
            }
            
            //Vérifier que le premier filtre est maintenant visible
            Log.Message("Check if the first filter is now visible.");
            firstFilter = Get_RelationshipsClientsAccountsGrid_BtnFilter(1);
            if (firstFilter.Exists && firstFilter.IsVisible && firstFilter.VisibleOnScreen)
                Log.Checkpoint("The first filter is now visible, upon scroll.");
            else
                Log.Error("The first filter is not visible upon scroll.");
        }
        
        if (!isLastFilterVisible){
            Log.Message("Last filter hidden after " + filterMaxIndex + " filters were added.");
        
            //Scroll pour rendre visible le dernier filtre
            Log.Message("Scroll to make visible the last filter.");
            Log.Message("If the last filter become visible after clicking in the expected scroll bar, it means the scroll bar were present.");
            for (var i=1; i<=4; i++){
                Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 85, 30)
            }
        
            //Vérifier que le dernier filtre est maintenant visible
            Log.Message("Check if the last filter is now visible.");
            lastFilter = Get_RelationshipsClientsAccountsGrid_BtnFilter(filterMaxIndex);
            if (lastFilter.Exists && lastFilter.IsVisible && lastFilter.VisibleOnScreen)
                Log.Checkpoint("The last filter is now visible, upon scroll.");
            else
                Log.Error("The last filter is not visible upon scroll.");
        }
        
        //Fermer les filtres
        for (var i=1; i<=3; i++)
            Get_RelationshipsClientsAccountsGrid().Click(40, 35);
        
        for (var i=1; i<=filterMaxIndex; i++){
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
        for (var i = 1; i <= filterMaxIndex; i++){
            var filterName = filterNamePrefix + IntToStr(i);
            Delete_FilterCriterion(filterName, vServerRelations);
        }
        Terminate_CroesusProcess();
    }
}
