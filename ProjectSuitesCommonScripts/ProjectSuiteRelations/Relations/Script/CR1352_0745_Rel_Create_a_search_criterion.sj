//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Créer un critère de recherche
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-745
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0745_Rel_Create_a_search_criterion()
{
    var searchCriterionName = "test_CR1352_0745";
    
    try {
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        
        //Mettre le résultat attendu dans un tableau
        
        var expectedRelationships = new Array();
        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for (var i = 0; i < count; i++){
            var displayedRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
            expectedRelationships.push(displayedRelationshipName);
        }
        
        
        //Ajouter un critère de recherche
        
        Log.Message("Add the '" + searchCriterionName + "' search criterion.");
        Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
        Get_WinAddSearchCriterion_TxtName().set_Text(searchCriterionName);
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
        Delay(2000);
        
        
        //Vérifier que le critère est présent dans la barre
        
        if (!(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists)){
            Log.Error("Criterion button not displayed in the bar. This is not expected.");
            return;
        }
        
        Log.Checkpoint("Criterion button displayed in the bar.");
        
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual, searchCriterionName);
        
        
        //Mettre le résultat obtenu dans un tableau
        
        var searchCriterionRelationships = new Array();
        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for (var i = 0; i < count; i++){
            var displayedRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
            searchCriterionRelationships.push(displayedRelationshipName);
        }
        
        
        //Fermer le critère de recherche
        
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13); //Fermer le filtre
        
        
        //Comparer le résultat obtenu avec celui attendu
        
        CheckEquals(searchCriterionRelationships.length, expectedRelationships.length, "The number of relationships");
        if (searchCriterionRelationships.length == expectedRelationships.length){
            for (var i = 0 ; i < expectedRelationships.length; i++){
                CheckEquals(VarToStr(searchCriterionRelationships[i]), VarToStr(expectedRelationships[i]), "The element at the position " + i);
            }   
        }
        
        
        //Vérifier que le critère de recherche est présent dans la liste des critères de recherche
        
        Log.Message("Verify that the '" + searchCriterionName + "' search criterion is present in the criteria list.");
        Get_Toolbar_BtnManageSearchCriteria().Click();
        Get_WinSearchCriteriaManager().Parent.Maximize();
        var rowCount = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.get_Count();
        var found = false;
        for (var i = 0; i < rowCount; i++){
            displayedCriterionName = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
            if (displayedCriterionName == searchCriterionName){
                found = true;
                break;
            }
        }
        
        if (!found){
            Log.Error("'" + searchCriterionName + "' search criterion was not present. This is not expected.");
            return
        }
        
        Log.Checkpoint("'" + searchCriterionName + "' search criterion was present.");
        
        Get_WinSearchCriteriaManager().Parent.Restore();
        Get_WinSearchCriteriaManager_BtnClose().Click();
    }
    catch (e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Delete_FilterCriterion(searchCriterionName, vServerRelations);
        Terminate_CroesusProcess();
    }
}