//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Vérifier la présence des filtres inactifs après redémarrage de l'application
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-678
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0678_Rel_Check_the_presence_of_the_inactive_filters_after_restarting_the_application()
{
    var expectedIACode = "0AED";
    var filterNamePrefix = "test0675_";
    var nbOfFilters = 2;
    
    try {
        
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
    
        for (var i=1; i<=nbOfFilters; i++){
        
            var filterName = filterNamePrefix + IntToStr(i);
            
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
            Get_WinCRUFilter_CmbField_Item("Code de CP", "IA Code").Click();
            Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
            Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
            Get_WinCRUFilter_GrpCondition_TxtValue().Keys(expectedIACode);
            Get_WinCRUFilter_BtnOK().Click();
        
            //Cliquer sur OK si le message "Le filtre que vous avez appliqué ne contient aucune donnée" apparaît
        if (Get_DlgWarning().Exists){
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
        }
            
            //Désactiver le filtre
            Get_RelationshipsClientsAccountsGrid_BtnFilter(i).Click(15, 13);
        }
                
        //Vérifier que tous les filtres sont inactifs
        for (var i=1; i<=nbOfFilters; i++){
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(i).DataContext, "IsFilterActivated", cmpEqual, false);
        }
        
        //Redémarrer l'application Croesus et accéder au module Relations
        Close_Croesus_X();
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Vérifier que les filtres affichés avant la fermeture de l'application sont toujours présents et inactifs
        for (var i=1; i<=nbOfFilters; i++){
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(i).DataContext, "IsFilterActivated", cmpEqual, false);
        }
        
        //Fermer les filtres
        for (var i=1; i<=nbOfFilters; i++){
            Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
        }
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