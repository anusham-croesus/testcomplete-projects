//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Activer/désactiver un filtre
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-666
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0666_Rel_Activate_Deactivate_a_filter()
{
    var expectedIACode = "0AED";
    var filterName = "test0666";
    
    try {
        
        //Supprimer par requête le filtre s'il existe
        Delete_FilterCriterion(filterName, vServerRelations);
        
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
        
        //Vérifier que le filtre est actif
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "IsFilterActivated", cmpEqual, true);
        
        //Cliquer sur le filtre pour le désactiver
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(15, 13);
        
        //Vérifier que le filtre est inactif
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "IsFilterActivated", cmpEqual, false);
        
        //Fermer le filtre
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Delete_FilterCriterion(filterName, vServerRelations);
        Terminate_CroesusProcess();
    }
}