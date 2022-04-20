//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Sauvegarder l'affichage d'un critère par défaut
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-749
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0749_Rel_Save_the_display_of_a_default_criterion()
{
    var searchCriterionName = "test_CR1352_0749";
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
        
        
        //Ajouter un critère de recherche
        
        Log.Message("Add the '" + searchCriterionName + "' search criterion.");
        Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
        Get_WinAddSearchCriterion_TxtName().Clear();
        Get_WinAddSearchCriterion_TxtName().Keys(searchCriterionName);
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemTotalValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterThan().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
        Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Keys(minValue);
        
        Get_WinAddSearchCriterion_BtnSave().Click();
        Delay(2000);
        
        
        //Cliquer sur le bouton Gérer les critères de recherche, puis sélectionner et appliquer un filtre
        
        Get_Toolbar_BtnManageSearchCriteria().Click();
        
        var rowCount = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.get_Count();
        for (var i = 0; i < rowCount; i++){
            displayedCriterionName = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
            if (displayedCriterionName == searchCriterionName){
                Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
                Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
                break;
            }
        }
        
        Get_WinSearchCriteriaManager_BtnRefresh().Click();
        
        
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
                
        
        //Comparer le résultat obtenu avec celui attendu
        
        CheckEquals(searchCriterionRelationships.length, expectedRelationships.length, "The number of relationships that match the criterion");
        if (searchCriterionRelationships.length == expectedRelationships.length){
            for (var i = 0 ; i < expectedRelationships.length; i++){
                CheckEquals(searchCriterionRelationships[i], expectedRelationships[i], "The element at position " + i);
            }   
        }
        
        
        //Redémarrer l'application et se connecter avec le même utilisateur
        
        Log.Message("Restart the application and connect with the same user.");
        Close_Croesus_MenuBar();
        
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        
        //Vérifier que le filtre est présent main inactif 
        
        Log.message("Verify that the filter is present but inactive.");
        if (!(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists)){
            Log.Error("Criterion button not displayed in the bar. This is not expected.");
            return;
        }
        
        Log.Checkpoint("Criterion button displayed in the bar.");
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual, searchCriterionName);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsChecked", cmpEqual, false);
        
        
        //Vérifier que des crochets rouges sont présents pour indiquer le résultat précédent du filtre
        
        Log.Message("Verify that red crochets are displayed to indicate the previous result of the filter.");
        
        //Mettre dans un tableau les relations qui présentent un crochet rouge 
        
        var matchesCriterionRelationships = new Array();
        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for (var i = 0; i < count; i++){
            var isRedCrochetPresent = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_MatchesCriterion();
            if (isRedCrochetPresent){
                var currentRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
                matchesCriterionRelationships.push(VarToStr(currentRelationshipName));
            }
        }
        
        //Fermer le critère de recherche
        
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13); //Fermer le filtre
        
        
        //Comparer le tableau des relations qui présentent un crochet rouge avec celui attendu
        
        CheckEquals(matchesCriterionRelationships.length, expectedRelationships.length, "The number of relationships that match the criterion");
        if (matchesCriterionRelationships.length == expectedRelationships.length){
            for (var i = 0 ; i < expectedRelationships.length; i++){
                CheckEquals(matchesCriterionRelationships[i], expectedRelationships[i], "The element at position " + i);
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