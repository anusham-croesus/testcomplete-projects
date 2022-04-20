//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Supprimer un filtre permanent
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-639
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0639_Rel_Delete_a_permanent_filter()
{
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
      var expectedIACode = "0AED";
    }
    else{//RJ
      var expectedIACode = "BD88";
    }
    var filterName = "test01";
    
    try {
    
        //Supprimer par requête le filtre s'il existe
        Delete_FilterCriterion(filterName, vServerRelations);
        
        Login(vServerRelations, userName, psw, language);
        

        //Accéder au module Relations et cliquer sur le bouton Filtres Y, cliquer sur "Ajouter un filtre"
        //Saisir Nom = test01, Accès = Utilisateur, Champ = Code de CP, Opérateur = égal(e) à, Valeur = 0AED, puis cliquer sur OK
        
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
        SetAutoTimeOut();
        if (Get_DlgWarning().Exists){
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
        }
        RestoreAutoTimeOut();
        //Fermer le filtre
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
        
        
        //Cliquer sur le bouton Filtres Y, cliquer sur "Gérer les filtres"
        //Sélectionner le filtre créé et cliquer sur le bouton "Supprimer"
        
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        var filterFound = SearchFilter(filterName);
        if (!filterFound){
            Log.Error(filterName + " filter not found ; this is not expected.");
            return;
        }
        
        filterIndex = filterFound[1];
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(filterIndex).set_IsSelected(true);
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(filterIndex).set_IsActive(true);
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete().Click();
        SetAutoTimeOut();
        if (!(Get_DlgConfirmation().Exists)){
            Log.Error("Confirmation dialog box not displayed. This is not expected.");
            return;
        }
        RestoreAutoTimeOut();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        
        var filterFound = SearchFilter(filterName);
        if (!filterFound){
            Log.Checkpoint(filterName + " filter not found after deletion ; this is expected.");
        }
        else {
            Log.Error(filterName + " filter found after deletion ; this is not expected.");
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




function SearchFilter(filterName){

    var nbOfFilters = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
    for (var i = 0; i < nbOfFilters; i++){
        var currentFilterName = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
        if (currentFilterName == filterName){
            return new Array(true, i);
        }
    }
        
    return false;
}