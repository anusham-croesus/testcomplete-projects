//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1352_0639_Rel_Delete_a_permanent_filter


/**
    Description : Modifier un filtre
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-669
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0669_Rel_Edit_a_filter()
{
    var expectedIACode = "0AED";
    var filterName = "test0669";
    var filterNewName = "test0669_edited";
    
    try {
        
        //Supprimer par requête le filtre s'il existe
        Delete_FilterCriterion(filterName, vServerRelations);
        Delete_FilterCriterion(filterNewName, vServerRelations);
        
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
        
        //Vérifier que le filtre "test0669" existe et que le filtre "test0669_edited" n'existe pas
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        var filterFound = SearchFilter(filterName);
        if (!filterFound){
            Log.Error(filterName + " filter not found ; this is not expected.");
            return;
        }
        else {
            Log.Checkpoint(filterName + " filter found ; this is expected.");
        }
        
        filterFound = SearchFilter(filterNewName);
        if (!filterFound){
            Log.Checkpoint(filterNewName + " filter not found ; this is expected.");
        }
        else {
            Log.Error(filterNewName + " filter found ; this is not expected.");
            return;
        }
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
        
        
        //Cliquer sur l'icône du crayon dans le filtre sur la barre en haut
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 40, 10);
        
        //Vérifier que la fenêtre "Modifier un filtre" est ouverte
        if (!(Get_WinCRUFilter().Exists)){
            Log.Error("WinCRUFilter window not displayed ; this is not expected.");
            return;
        }
        
        aqObject.CheckProperty(Get_WinCRUFilter(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 113, language));
        
        
        //Changer le nom du filtre et valider avec le bouton OK
        Get_WinCRUFilter_GrpDefinition_TxtName().Clear();
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterNewName);
        Get_WinCRUFilter_BtnOK().Click();
        
        //Cliquer sur OK si le message "Le filtre que vous avez appliqué ne contient aucune donnée" apparaît
        if (Get_DlgWarning().Exists){
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
        }
        
        
        //Vérifier que le filtre "test0669" n'existe plus et que le filtre "test0669_edited" existe
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        filterFound = SearchFilter(filterName);
        if (!filterFound){
            Log.Checkpoint(filterName + " filter not found ; this is expected.");
        }
        else {
            Log.Error(filterName + " filter found ; this is not expected.");
        }
        
        var filterFound = SearchFilter(filterNewName);
        if (!filterFound){
            Log.Error(filterNewName + " filter not found ; this is not expected.");
        }
        else {
            Log.Checkpoint(filterNewName + " filter found ; this is expected.");
        }
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
        
        
        //Fermer le filtre
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Delete_FilterCriterion(filterName, vServerRelations);
        Delete_FilterCriterion(filterNewName, vServerRelations);
        Terminate_CroesusProcess();
    }
}