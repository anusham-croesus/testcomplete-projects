//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Créer un critère de recherche à partir d'un gabarit
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-748
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0748_Rel_Create_a_search_criterion_from_a_template()
{
    var searchCriterionName = "test_CR1352_0748";
    var minValue = 3000000;
    
    try {
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        
        //Mettre le résultat attendu dans un tableau
        
        var expectedRelationships = new Array();
        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for (var i = 0; i < count; i++){
            var currentRelationshipTotalValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_TotalValue();
            if (currentRelationshipTotalValue > minValue){
                var currentRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
                expectedRelationships.push(VarToStr(currentRelationshipName));
            }
        }
        
        
        //Ajouter un critère de recherche à partir du gabarit 
        
        var searchCriterionTemplateName = GetData(filePath_Relations, "CR1352", 131, language);
        
        Get_Toolbar_BtnManageSearchCriteria().Click();
        
        var isSearchCriterionTemplateFound = false; 
        var rowCount = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.get_Count();
        for (var i = 0; i < rowCount; i++){
            displayedCriterionName = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
            if (displayedCriterionName == searchCriterionTemplateName){
                Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
                Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
                isSearchCriterionTemplateFound = true;
                break;
            }
        }
        
        if (!isSearchCriterionTemplateFound){
            Log.Error("'" + searchCriterionTemplateName + "' template not found in the search criteria list ; this is not expected." );
            return;
        }
        
        Get_WinSearchCriteriaManager_BtnCreateFromTemplate().Click();
        
        if (!Get_WinAddSearchCriterion().Exists){
            Log.Error("The Edit Template window was not displayed. This is not expected.");
            return;
        }
        
        aqObject.CheckProperty(Get_WinAddSearchCriterion(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 132, language));
        
        Log.Message("Add the '" + searchCriterionName + "' search criterion.");
        Get_WinAddSearchCriterion_TxtName().set_Text(searchCriterionName);
        Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Keys(minValue);
        
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
            searchCriterionRelationships.push(VarToStr(displayedRelationshipName));
        }
        
        
        //Fermer le critère de recherche
        
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13); //Fermer le filtre
        
        
        //Comparer le résultat obtenu avec celui attendu
        
        CheckEquals(searchCriterionRelationships.length, expectedRelationships.length, "The number of relationships that match the criterion");
        if (searchCriterionRelationships.length == expectedRelationships.length){
            for (var i = 0 ; i < expectedRelationships.length; i++){
                CheckEquals(searchCriterionRelationships[i], expectedRelationships[i], "The element at position " + i);
            }   
        }
    }
    catch (e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Delete_FilterCriterion(searchCriterionName, vServerRelations);
        Terminate_CroesusProcess();
    }
}