//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT DBA



/**
    Description : Vérifier dans le module Comptes que lorsqu'on a plusieurs critères
                  de recherche qui donnent les mêmes résultats, la sommation est correcte. 
    Auteur : Christophe Paring
*/
function CR1352_CROES_6004_Acc_Wrong_Sum_when_we_have_search_criteria()
{
    try {
        
        //Nombre de comptes à sélectionner pour la sommation
        nbOfAccountsToBeSelected = 20;    
    
        //Créer un tableau contenant les noms des critères de recherche à créer
        searchCriterionNameSuffix = ".CROES_6004_Acc_";
        nbOfSearchCritera = 3;
        arrayOfSearchCriteraNames = new Array();

        for (i = 1; i <= nbOfSearchCritera; i++)
            arrayOfSearchCriteraNames.push(searchCriterionNameSuffix + IntToStr(i));
        
        Log.Message("Search criteria names :");
        Log.Message(arrayOfSearchCriteraNames);
        
        //Supprimer le cas échéant les critères de recherche s'ils existent
        for (i = 0; i < arrayOfSearchCriteraNames.length; i++)
            Delete_FilterCriterion(arrayOfSearchCriteraNames[i], vServerAccounts);
        
        //Se connecter et aller au module Comptes
        Login(vServerAccounts, userName, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //Fermer les critères de recherche s'il y en a de chargés
        CloseAllFilters();
        
        //Récupérer le résultat attendu
        SelectNbOfAccounts(nbOfAccountsToBeSelected);
        
        Get_Toolbar_BtnSum().Click();
        expectedAccountsTotalCount = VarToInt(Get_WinAccountsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Value.get_CountAcc());
        expectedAccountsTotalValueSum = VarToFloat(Get_WinAccountsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Value.get_CurrSumTotal());
        Log.Message("The Accounts total count is : " + expectedAccountsTotalCount);
        Log.Message("The Accounts total values sum is : " + expectedAccountsTotalValueSum);
        Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
        
        //Créer les critères de recherche
        for (i = 0; i < arrayOfSearchCriteraNames.length; i++)
            AddAllAccountsSearchCriterion(arrayOfSearchCriteraNames[i]);
        
        //Récupérer le résultat du critère de recherche
        SelectNbOfAccounts(nbOfAccountsToBeSelected);
        
        Get_Toolbar_BtnSum().Click();
        searchCriterionAccountsTotalCount = VarToInt(Get_WinAccountsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Value.get_CountAcc());
        searchCriterionAccountsTotalValueSum = VarToFloat(Get_WinAccountsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Value.get_CurrSumTotal());
        Log.Message("The search criterion Accounts total count is : " + searchCriterionAccountsTotalCount);
        Log.Message("The search criterion Accounts total values sum is : " + searchCriterionAccountsTotalValueSum);
        Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
        
        //Comparer les résultats obtenus avec ceux attendus
        CheckEquals(searchCriterionAccountsTotalCount, expectedAccountsTotalCount, "Accounts total count");
        CheckEquals(searchCriterionAccountsTotalValueSum, VarToFloat(expectedAccountsTotalValueSum), "Accounts total values sum");
        
        if (searchCriterionAccountsTotalCount != expectedAccountsTotalCount || searchCriterionAccountsTotalValueSum != expectedAccountsTotalValueSum)
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
            Delete_FilterCriterion(arrayOfSearchCriteraNames[i], vServerAccounts);
    }
}



function AddAllAccountsSearchCriterion(searchCriterionName)
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
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
        WaitUntilObjectDisappears(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["ToggleButton", 1, true], 5000);
    }
}