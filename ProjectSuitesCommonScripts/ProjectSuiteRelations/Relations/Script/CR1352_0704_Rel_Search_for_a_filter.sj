//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Rechercher un filtre
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-704
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0704_Rel_Search_for_a_filter()
{
    var randomFilter;
    var nbOfFilters = 10;
    var arrayOfFilters = new Array();
    var arrayOfPossibleChars = new Array();
    var filterNameRoot = "_test0704_";
    
    try {
        //Remplir le tableau des caractères possibles qui seront utilisés pour le premier caractère du nom des filtres
        for (var i = 48; i <= 57; i++) arrayOfPossibleChars.push(Chr(i)); //Les chiffres
        for (var i = 65; i <= 90; i++) arrayOfPossibleChars.push(Chr(i)); //Les lettres majuscules
        for (var i = 97; i <= 122; i++) arrayOfPossibleChars.push(Chr(i)); //Les lettres minuscules
        
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Remplir le tableau des noms des filtres et créer les filtres
        for (var i = 0; i < nbOfFilters; i++){
            randomChar = arrayOfPossibleChars[Math.round(Math.random()*(arrayOfPossibleChars.length - 1))];
            filterName = randomChar + filterNameRoot + IntToStr(i);
            arrayOfFilters.push(filterName);
            
            //Supprimer par requête le filtre s'il existe
            Delete_FilterCriterion(filterName, vServerRelations);
            
            //Créer le filtre
            Log.Message("Add the filter : " + filterName);
            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
            Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
            Get_WinCRUFilter_GrpDefinition_CmbAccess().set_IsDropDownOpen(true);
            Get_WinCRUFilter_CmbAccess_ItemUser().Click();
            Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
            Get_WinCRUFilter_CmbField_Item("Code de CP", "IA Code").Click();
            Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
            Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
            Get_WinCRUFilter_GrpCondition_TxtValue().Keys("0AED");
            Get_WinCRUFilter_BtnOK().Click();
        
            //Cliquer sur OK si le message "Le filtre que vous avez appliqué ne contient aucune donnée" apparaît
          if (Get_DlgWarning().Exists){
              Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
          }
            
            //Fermer le filtre dans la barre
            Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
            
        }
        
        //Choisir au hasard un filtre à rechercher
        randomFilter = arrayOfFilters[Math.round(Math.random()*(arrayOfFilters.length - 1))];
        Log.Message("The random filter to search is : " + randomFilter);
        
        //Cliquer sur le bouton Filtres Y, cliquer sur "Gérer les filtres"
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        if (!Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Exists){
            Log.Error("The Filter Manager window not displayed ; this is not expected.");
            return;
        }
        
        //Taper le nom du filtre recherché et cliquer sur OK
        Log.Message("Hit the first character of the random filter.");
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Keys(aqString.GetChar(randomFilter, 0));
        
        if (!Get_WinQuickSearch().Exists){
            Log.Error("The Quick Search window was not displayed.");
            return;
        }
        
        Log.Checkpoint("The Quick Search window was displayed.");
        
        Log.Message("Hit all the name of the random filter.");
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(randomFilter);
        
        Get_WinQuickSearch_BtnOK().Click();
        
        //Vérifier que la flèche est positionnée sur le filtre recherché
        var filtersCount = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.get_Count();
        for (var i = 0; i < filtersCount; i++){
            var isCurrentFilterActive = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).get_IsActive();
            if (isCurrentFilterActive){
                var activeFilterName = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
                break;
            }
        }
        
        CheckEquals(activeFilterName, randomFilter, "The active filter");
        
        //Fermer la fenêtre Gestion des filtres
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        for (var i = 0; i < arrayOfFilters.length ; i++) Delete_FilterCriterion(arrayOfFilters[i], vServerRelations);
        Terminate_CroesusProcess();
    }
}