//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1352_0639_Rel_Delete_a_permanent_filter


/**
    Description : Vérifier la gestion d'accès des filtres permanents - Utilisateur
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-655
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0655_Rel_Check_access_management_for_permanent_filters_User()
{
    var expectedIACode = "0AED";
    var filterName = "test0655";
    var userNameROOSEF = "ROOSEF";
    
    try {
    
        //Supprimer par requête le filtre s'il existe
        Delete_FilterCriterion(filterName, vServerRelations);
        
        
        //SE CONNECTER AVEC L'UTILISATEUR COPERN ET CRÉER UN FILTRE D'ACCÈS UTILISATEUR
        
        Login(vServerRelations, userName, psw, language);
        
        
        //Accéder au module Relations et cliquer sur le bouton Filtres Y, cliquer sur "Ajouter un filtre"
        //Créer un filtre avec un accès Utilisateur
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().set_IsDropDownOpen(true);
        Get_WinCRUFilter_CmbAccess_ItemUser().Click();
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
        Get_WinCRUFilter_CmbField_Item("Code de CP", "IA Code").Click();
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
        Get_WinCRUFilter_GrpCondition_TxtValue().Keys(expectedIACode);
        Get_WinCRUFilter_BtnOK().Click();
        
        //Cliquer sur OK si le message "Le filtre que vous avez appliqué ne contient aucune donnée" apparaît
        if (Get_DlgWarning().Exists){
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
        }
        
        //Fermer le filtre
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
        
        
        //Cliquer sur le bouton Filtres Y, cliquer sur "Gérer les filtres"
        //Vérifier que le filtre créé apparaît avec l'utilisateur COPERN
        
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        var filterFound = SearchFilter(filterName);
        if (!filterFound){
            Log.Error(filterName + " filter not found with the user " + userName + " ; this is not expected.");
            return;
        }
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
        
        
        //SE CONNECTER AVEC L'UTILISATEUR ROOSEF ET VÉRIFIER QUE LE FILTRE CRÉÉ AVEC L'UTILISATEUR COPERN N'EST PAS DISPONIBLE
        
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameROOSEF, psw, language);
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        var filterFound = SearchFilter(filterName);
        if (!filterFound){
            Log.Checkpoint(filterName + " filter not found with the user " + userNameROOSEF + " ; this is expected.");
        }
        else {
            Log.Error(filterName + " filter found with the user " + userNameROOSEF + " ; this is not expected.");
        }
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Delete_FilterCriterion(filterName, vServerRelations);
        Terminate_CroesusProcess();
    }
}