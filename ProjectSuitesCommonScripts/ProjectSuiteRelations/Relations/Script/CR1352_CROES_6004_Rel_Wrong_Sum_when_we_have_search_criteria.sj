//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
    Description : Vérifier dans le module Relations que lorsqu'on a plusieurs critères
                  de recherche qui donnent les mêmes résultats, la sommation est correcte. 
    Auteur : Christophe Paring
*/
function CR1352_CROES_6004_Rel_Wrong_Sum_when_we_have_search_criteria()
{
    try {
        
        //Créer un tableau contenant les noms des critères de recherche à créer
        searchCriterionNameSuffix = ".CROES_6004_Rel_";
        nbOfSearchCritera = 3;
        arrayOfSearchCriteraNames = new Array();

        for (i = 1; i <= nbOfSearchCritera; i++)
            arrayOfSearchCriteraNames.push(searchCriterionNameSuffix + IntToStr(i));
        
        Log.Message("Search criteria names :");
        Log.Message(arrayOfSearchCriteraNames);
        
        
        //Se connecter et aller au module Relations
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Fermer les critères de recherche s'il y en a de chargés
        CloseAllFilters();
        
        //Récupérer le résultat attendu
        Get_RelationshipsClientsAccountsGrid().Click();
        Get_RelationshipsClientsAccountsGrid().Keys("^a");
        
        Get_Toolbar_BtnSum().Click();
        expectedRelationshipsTotalCount = VarToInt(Get_WinRelationshipsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Value.get_CountLink());
        expectedRelationshipsTotalValueSum = VarToFloat(Get_WinRelationshipsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Value.get_SumTotalValue());
        Log.Message("The Relationships total count is : " + expectedRelationshipsTotalCount);
        Log.Message("The Relationships total values sum is : " + expectedRelationshipsTotalValueSum);
        Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
        
        
        //Créer les critères de recherche
        for (i = 0; i < arrayOfSearchCriteraNames.length; i++)
            AddAllRelationshipsSearchCriterion(arrayOfSearchCriteraNames[i]);
        
        //Récupérer le résultat du critère de recherche
        Get_RelationshipsClientsAccountsGrid().Click();
        Get_RelationshipsClientsAccountsGrid().Keys("^a");
        
        Get_Toolbar_BtnSum().Click();
        searchCriterionRelationshipsTotalCount = VarToInt(Get_WinRelationshipsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Value.get_CountLink());
        searchCriterionRelationshipsTotalValueSum = VarToFloat(Get_WinRelationshipsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Value.get_SumTotalValue());
        Log.Message("The search criterion Relationships total count is : " + searchCriterionRelationshipsTotalCount);
        Log.Message("The search criterion Relationships total values sum is : " + searchCriterionRelationshipsTotalValueSum);
        Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
        
        //Comparer les résultats obtenus avec ceux attendus
        CheckEquals(searchCriterionRelationshipsTotalCount, expectedRelationshipsTotalCount, "Relationships total count");
        CheckEquals(searchCriterionRelationshipsTotalValueSum, VarToFloat(expectedRelationshipsTotalValueSum), "Relationships total values sum");
        
        if (searchCriterionRelationshipsTotalCount != expectedRelationshipsTotalCount || searchCriterionRelationshipsTotalValueSum != expectedRelationshipsTotalValueSum)
            Log.Error("Bug CROES-6004");
        
        //Fermer le critère de recherche
        CloseAllFilters();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        //Supprimer le cas échéant les critères de recherche créés
        for (i = 0; i < arrayOfSearchCriteraNames.length; i++)
            Delete_FilterCriterion(arrayOfSearchCriteraNames[i], vServerRelations);
    }
}



function AddAllRelationshipsSearchCriterion(searchCriterionName)
{
    Log.Message("Add the '" + searchCriterionName + "' search criterion.");
    
    Get_Toolbar_BtnManageSearchCriteria().Click();
    Get_WinSearchCriteriaManager_BtnAdd().Click();
    
    Get_WinAddSearchCriterion_TxtName().set_Text(searchCriterionName);
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
}



function CloseAllFilters()
{
    Log.Message("Close all filters and search criteria.");
    
    while (Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists){
        var previousNbOfFilters = Get_RelationshipsClientsAccountsGrid().FindAllChildren(["ClrClassName", "IsVisible"], ["ToggleButton", true], 10).toArray().length;
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
        WaitUntilFilterIsClosed(previousNbOfFilters);
    }
}



function WaitUntilFilterIsClosed(previousNbOfFilters, timeOut)
{
    if (timeOut == undefined) timeOut = 30000;
    
    var waitTime = 0;
    do {
        var newNbOfFilters = Get_RelationshipsClientsAccountsGrid().FindAllChildren(["ClrClassName", "IsVisible"], ["ToggleButton", true], 10).toArray().length;
        waitTime += 1;
        Delay(1);
    } while (waitTime < timeOut && newNbOfFilters >= previousNbOfFilters)
    
    if (waitTime >= timeOut)
        Log.Message("Filter not closed until timeout : " + waitTime);
}