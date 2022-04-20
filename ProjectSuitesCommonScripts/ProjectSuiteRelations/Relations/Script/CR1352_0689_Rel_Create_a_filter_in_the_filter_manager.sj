//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Créer un filtre dans le gestionnaire des filtres
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-689
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0689_Rel_Create_a_filter_in_the_filter_manager()
{
    var filterName = "test0689";
    
    try {
        
        //Supprimer par requête le filtre s'il existe
        Delete_FilterCriterion(filterName, vServerRelations);
        
        Login(vServerRelations, userName, psw, language);
        
        //Accéder au module Relations et cliquer sur le bouton Filtres Y, cliquer sur "Gérer les filtres"
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        if (!Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Exists){
            Log.Error("The Filter Manager window not displayed ; this is not expected.");
            return;
        }
        
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 119, language));
        
        //Cliquer sur le bouton "Ajouter"
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click();
        
        if (!Get_WinCRUFilter().Exists){
            Log.Error("The WinCRUFilter window not displayed ; this is not expected.");
            return;
        }
        
        aqObject.CheckProperty(Get_WinCRUFilter(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 120, language));
        
        //Saisir un nom, accès, opérateur, un champ et valeur puis cliquer sur OK
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().set_IsDropDownOpen(true);
        Get_WinCRUFilter_CmbAccess_ItemUser().Click();
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
        Get_WinCRUFilter_CmbField_Item("Code de CP", "IA Code").Click();
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
        Get_WinCRUFilter_GrpCondition_TxtValue().Keys("0AED");
        Get_WinCRUFilter_BtnOK().Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
        
        //Cliquer sur OK si le message "Le filtre que vous avez appliqué ne contient aucune donnée" apparaît
        if (Get_DlgWarning().Exists){
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
        }
        
        //Vérifier que le filtre est affiché dans la barre
        if (!Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists){
            Log.Error("The filter is not displayed ; this is not expected.");
            return;
        }
        
        //Vérifier le nom du filtre
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filterName);
        
        //Fermer le filtre
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
        
        //Vérifier que le filtre est enregistré sur la liste des filtres prédéfinis
        Get_ModulesBar_BtnRelationships().Click();
        
        
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
  
 var numberOftries=0;  
  while ( numberOftries < 5 && !Get_SubMenus().Exists){
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    numberOftries++;
  } 

        
        
        if (!Get_Toolbar_BtnQuickFilters_ContextMenu_Item(filterName).Exists){
            Log.Error(filterName + " filter is not displayed in the filters contextual menu ; this is not expected.");
            return;
        }
        
        var PredefinedFiltersSeparatorPosition = Get_Toolbar_BtnQuickFilters_ContextMenu_PredefinedFiltersSeparator().WPFControlOrdinalNo;
        var FilterFieldsSeparatorPosition = Get_Toolbar_BtnQuickFilters_ContextMenu_FilterFieldsSeparator().WPFControlOrdinalNo;
        var FilterPosition = Get_Toolbar_BtnQuickFilters_ContextMenu_Item(filterName).WPFControlOrdinalNo;
        
        Log.Message("The Predefined Filters Separator position in the filters contextual menu was : " + IntToStr(PredefinedFiltersSeparatorPosition));
        Log.Message("The Filter Fields Separator position in the filters contextual menu was : " + IntToStr(FilterFieldsSeparatorPosition));
        Log.Message(filterName + " filter position in the filters contextual menu was : " + IntToStr(FilterPosition));
        
        if (PredefinedFiltersSeparatorPosition < FilterPosition < FilterFieldsSeparatorPosition){
            Log.Checkpoint(filterName + " filter was saved in the Predefined Filters section.");
        }
        else {
            Log.Error(filterName + " filter was not saved in the Predefined Filters section.");
        }
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Delete_FilterCriterion(filterName, vServerRelations);
        Terminate_CroesusProcess();
    }
}

