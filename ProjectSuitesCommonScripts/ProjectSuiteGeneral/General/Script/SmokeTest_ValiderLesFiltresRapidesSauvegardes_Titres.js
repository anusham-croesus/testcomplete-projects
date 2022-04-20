//USEUNIT SmokeTest_Common



/*
    Description : Valider les filtres rapides sauvegardés du module Titres
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
        
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderLesFiltresRapidesSauvegardes_Titres()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderLesFiltresRapidesSauvegardes_Titres()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        var columnName_Description = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "SecurityColumnName_Description", language + client);
        var columnName_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "SecurityColumnName_Symbol", language + client);
        var columnName_Security = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "SecurityColumnName_Security", language + client);
        var columnName_Subcategory = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "SecurityColumnName_Subcategory", language + client);
        var columnName_Type = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "SecurityColumnName_Type", language + client);
        var columnName_FinancialInstrument = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "SecurityColumnName_FinancialInstrument", language + client);
        var columnName_DiscretionaryManagement = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "SecurityColumnName_DiscretionaryManagement", language + client);
        var columnName_Manager = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "SecurityColumnName_Manager", language + client);
        
        var arrayOfColumnsNames = [columnName_Description, columnName_Symbol, columnName_Security, columnName_Subcategory, columnName_Type, columnName_FinancialInstrument, columnName_DiscretionaryManagement, columnName_Manager];
        
        var financialInstrumentValue_Index = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FinancialInstrumentValue_Index", language + client);
        var financialInstrumentValue_Currency = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FinancialInstrumentValue_Currency", language + client);
        var financialInstrumentValue_Bond = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FinancialInstrumentValue_Bond", language + client);
        var financialInstrumentValue_AssetBackedSecurities = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FinancialInstrumentValue_AssetBackedSecurities", language + client);
        var financialInstrumentValue_Equity = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FinancialInstrumentValue_Equity", language + client);
        var subcategoryValue_CommonStock = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_SubcategoryValue_CommonStock", language + client);
        var value_Blank = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_Value_Blank", language + client);
        
        var filterName_Indices = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Indices", language + client);
        var filterName_Indices_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Indices_Properties", language + client));
        
        var filterName_Currencies = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Currencies", language + client);
        var filterName_Currencies_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Currencies_Properties", language + client));
        
        var filterName_Obligations = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Obligations", language + client);
        var filterName_Obligations_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Obligations_Properties", language + client));
        
        var filterName_Baskets = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Baskets", language + client);
        var filterName_Baskets_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Baskets_Properties", language + client));
        
        var filterName_Panier = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Panier", language + client);
        var filterName_Panier_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Panier_Properties", language + client));
        var filterName_Baskets_Panier_ExcludedSubCategories = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Baskets_Panier_ExcludedSubCategories", language + client).split("|");
        
        var filterName_CommonStocks = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_CommonStocks", language + client);
        var filterName_CommonStocks_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_CommonStocks_Properties", language + client));
        
        var filterName_MutualFunds = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_MutualFunds", language + client);
        var filterName_MutualFunds_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_MutualFunds_Properties", language + client));
        var filter_MutualFunds_StartWith_Value = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_MutualFunds_StartWith_Value", language + client);
        
        var filterName_GestDiscr = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_GestDiscr", language + client);
        var filterName_GestDiscr_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_GestDiscr_Properties", language + client));
        
        //var filterName_Gestionnaire = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Gestionnaire", language + client);
        //var filterName_Gestionnaire_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Security_ValidateCriteria_FilterName_Gestionnaire_Properties", language + client));
        
        
        //Login
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Récupérer tous les titres (sans filtre)
        RedisplayAndRemoveCheckmarksOfSecuritiesAndOrdersGrid();
        var arrayOfAllDisplayedSecuritiesBeforeFilter = GetAllDisplayedSecurities(arrayOfColumnsNames);
        
        //Pour les filtres Baskets et Panier
        var arrayOfAllDisplayedSecuritiesBeforeFilterWithoutExcludedSubcategories = GetFilteredSecurities(cmpNotEqual, filterName_Baskets_Panier_ExcludedSubCategories, arrayOfAllDisplayedSecuritiesBeforeFilter, arrayOfColumnsNames, columnName_Subcategory);
        
        //Filtre Indices
        Log.Message("******** CAS DU FILTRE : '" + filterName_Indices + "' ********", "", pmNormal, logAttributes);
        var isFilterIndicesValid = CheckIfSecuritiesOrdersFilterIsValid(filterName_Indices, filterName_Indices_Properties["Name"], filterName_Indices_Properties["Access"], filterName_Indices_Properties["Field"], filterName_Indices_Properties["Operator"], filterName_Indices_Properties["Value"], "CmbValue");
        CheckEquals(isFilterIndicesValid, true, "Is filter '" + filterName_Indices + "' valid");
        CheckSecurityFilter(filterName_Indices, cmpEqual, financialInstrumentValue_Index, arrayOfAllDisplayedSecuritiesBeforeFilter, arrayOfColumnsNames, columnName_FinancialInstrument);
        
        //Filtre Devises
        Log.Message("******** CAS DU FILTRE : '" + filterName_Currencies + "' ********", "", pmNormal, logAttributes);
        var isFilterCurrenciesValid = CheckIfSecuritiesOrdersFilterIsValid(filterName_Currencies, filterName_Currencies_Properties["Name"], filterName_Currencies_Properties["Access"], filterName_Currencies_Properties["Field"], filterName_Currencies_Properties["Operator"], filterName_Currencies_Properties["Value"], "CmbValue");
        CheckEquals(isFilterCurrenciesValid, true, "Is filter '" + filterName_Currencies + "' valid");
        CheckSecurityFilter(filterName_Currencies, cmpEqual, financialInstrumentValue_Currency, arrayOfAllDisplayedSecuritiesBeforeFilter, arrayOfColumnsNames, columnName_FinancialInstrument);
        
        //Filtre Obligations
        Log.Message("******** CAS DU FILTRE : '" + filterName_Obligations + "' ********", "", pmNormal, logAttributes);
        var isFilterObligationsValid = CheckIfSecuritiesOrdersFilterIsValid(filterName_Obligations, filterName_Obligations_Properties["Name"], filterName_Obligations_Properties["Access"], filterName_Obligations_Properties["Field"], filterName_Obligations_Properties["Operator"], filterName_Obligations_Properties["Value"], "CmbValue");
        CheckEquals(isFilterObligationsValid, true, "Is filter '" + filterName_Obligations + "' valid");
        CheckSecurityFilter(filterName_Obligations, cmpEqual, financialInstrumentValue_Bond, arrayOfAllDisplayedSecuritiesBeforeFilter, arrayOfColumnsNames, columnName_FinancialInstrument);
        
        //Filtre Baskets
        Log.Message("******** CAS DU FILTRE : '" + filterName_Baskets + "' ********", "", pmNormal, logAttributes);
        var isFilterBasketsValid = CheckIfSecuritiesOrdersFilterIsValid(filterName_Baskets, filterName_Baskets_Properties["Name"], filterName_Baskets_Properties["Access"], filterName_Baskets_Properties["Field"], filterName_Baskets_Properties["Operator"], filterName_Baskets_Properties["Value"], "CmbValue");
        CheckEquals(isFilterBasketsValid, true, "Is filter '" + filterName_Baskets + "' valid");
        var financialInstrumentForFilterBaskets = (language == "french")? financialInstrumentValue_Equity: financialInstrumentValue_AssetBackedSecurities;
        //var financialInstrumentForFilterBaskets = financialInstrumentValue_Equity;
        if (financialInstrumentForFilterBaskets == financialInstrumentValue_Equity)
            CheckSecurityFilter(filterName_Baskets, cmpEqual, financialInstrumentForFilterBaskets, arrayOfAllDisplayedSecuritiesBeforeFilterWithoutExcludedSubcategories, arrayOfColumnsNames, columnName_FinancialInstrument);
        else
            CheckSecurityFilter(filterName_Baskets, cmpEqual, financialInstrumentForFilterBaskets, arrayOfAllDisplayedSecuritiesBeforeFilter, arrayOfColumnsNames, columnName_FinancialInstrument);
        
        //Filtre Panier
        Log.Message("******** CAS DU FILTRE : '" + filterName_Panier + "' ********", "", pmNormal, logAttributes);
        var isFilterPanierValid = CheckIfSecuritiesOrdersFilterIsValid(filterName_Panier, filterName_Panier_Properties["Name"], filterName_Panier_Properties["Access"], filterName_Panier_Properties["Field"], filterName_Panier_Properties["Operator"], filterName_Panier_Properties["Value"], "CmbValue");
        CheckEquals(isFilterPanierValid, true, "Is filter '" + filterName_Panier + "' valid");
        var financialInstrumentForFilterPanier = (language == "french")? financialInstrumentValue_Equity: financialInstrumentValue_AssetBackedSecurities;
        //var financialInstrumentForFilterPanier = financialInstrumentValue_Equity;
        if (financialInstrumentForFilterPanier == financialInstrumentValue_Equity)
            CheckSecurityFilter(filterName_Panier, cmpEqual, financialInstrumentForFilterPanier, arrayOfAllDisplayedSecuritiesBeforeFilterWithoutExcludedSubcategories, arrayOfColumnsNames, columnName_FinancialInstrument);
        else
            CheckSecurityFilter(filterName_Panier, cmpEqual, financialInstrumentForFilterPanier, arrayOfAllDisplayedSecuritiesBeforeFilter, arrayOfColumnsNames, columnName_FinancialInstrument);
        
        //Filtre Actions ordinaires
        Log.Message("******** CAS DU FILTRE : '" + filterName_CommonStocks + "' ********", "", pmNormal, logAttributes);
        var isFilterCommonStocksValid = CheckIfSecuritiesOrdersFilterIsValid(filterName_CommonStocks, filterName_CommonStocks_Properties["Name"], filterName_CommonStocks_Properties["Access"], filterName_CommonStocks_Properties["Field"], filterName_CommonStocks_Properties["Operator"], filterName_CommonStocks_Properties["Value"], "CmbValue");
        CheckEquals(isFilterCommonStocksValid, true, "Is filter '" + filterName_CommonStocks + "' valid");
        CheckSecurityFilter(filterName_CommonStocks, cmpEqual, subcategoryValue_CommonStock, arrayOfAllDisplayedSecuritiesBeforeFilter, arrayOfColumnsNames, columnName_Subcategory);
        
        //Filtre Fonds d'investissement
        Log.Message("******** CAS DU FILTRE : '" + filterName_MutualFunds + "' ********", "", pmNormal, logAttributes);
        var isFilterMutualFundsValid = CheckIfSecuritiesOrdersFilterIsValid(filterName_MutualFunds, filterName_MutualFunds_Properties["Name"], filterName_MutualFunds_Properties["Access"], filterName_MutualFunds_Properties["Field"], filterName_MutualFunds_Properties["Operator"], filterName_MutualFunds_Properties["Value"], "TxtValue");
        CheckEquals(isFilterMutualFundsValid, true, "Is filter '" + filterName_MutualFunds + "' valid");
        CheckSecurityFilter(filterName_MutualFunds, cmpStartsWith, filter_MutualFunds_StartWith_Value, arrayOfAllDisplayedSecuritiesBeforeFilter, arrayOfColumnsNames, columnName_Type);
        
        //Filtre Gest. discr
        Log.Message("******** CAS DU FILTRE : '" + filterName_GestDiscr + "' ********", "", pmNormal, logAttributes);
        var isFilterGestDiscrValid = CheckIfSecuritiesOrdersFilterIsValid(filterName_GestDiscr, filterName_GestDiscr_Properties["Name"], filterName_GestDiscr_Properties["Access"], filterName_GestDiscr_Properties["Field"], filterName_GestDiscr_Properties["Operator"], filterName_GestDiscr_Properties["Value"], "CmbValue");
        CheckEquals(isFilterGestDiscrValid, true, "Is filter '" + filterName_GestDiscr + "' valid");
        CheckSecurityFilter(filterName_GestDiscr, cmpNotEqual, value_Blank, arrayOfAllDisplayedSecuritiesBeforeFilter, arrayOfColumnsNames, columnName_DiscretionaryManagement);
        
        //Filtre Gestionnaire
        //Log.Message("******** CAS DU FILTRE : '" + filterName_Gestionnaire + "' ********", "", pmNormal, logAttributes);
        //var isFilterGestionnaireValid = CheckIfSecuritiesOrdersFilterIsValid(filterName_Gestionnaire, filterName_Gestionnaire_Properties["Name"], filterName_Gestionnaire_Properties["Access"], filterName_Gestionnaire_Properties["Field"], filterName_Gestionnaire_Properties["Operator"], filterName_Gestionnaire_Properties["Value"]);
        //CheckEquals(isFilterGestionnaireValid, true, "Is filter '" + filterName_Gestionnaire + "' valid");
        //CheckSecurityFilter(filterName_Gestionnaire, cmpNotEqual, value_Blank, arrayOfAllDisplayedSecuritiesBeforeFilter, arrayOfColumnsNames, columnName_Manager);
        
        //Fermer Croesus
        RedisplayAndRemoveCheckmarksOfSecuritiesAndOrdersGrid();
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}


function GetAllDisplayedSecurities(arrayOfColumnsNames)
{
    AddColumnsToGrid(Get_SecurityGrid_ChDescription(), arrayOfColumnsNames);
    
    var exportFilePath = Project.Path + "AllDisplayedSecurities.txt";
    if (!ExportGridContentToFile(exportFilePath)){
        Log.Error("Failed to export Grid content to : " + exportFilePath);
        return new Array();
    }
    
    return GetDataFromCSVFile(exportFilePath, arrayOfColumnsNames);
}


function RedisplayAndRemoveCheckmarksOfSecuritiesAndOrdersGrid()
{
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    //S'assurer qu'il n'y a plus de filtre actif
    if (Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().IsChecked.OleValue)
        return Log.Error("Il y a toujours au un filtre actif après réaffichage.");
}



function LoadSecuritiesAndOrdersFilter(filterName)
{
    try {
        SetAutoTimeOut();
        var isFilterLoaded = false;
        
        Log.Message("Load filter '" + filterName + "'.");
        ClickAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders());
        Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_Item(filterName).Click();
        
        //Gérer l'affichage d'un éventuel message d'erreur
        if (Get_DlgError().Exists)
            throw new Error("There was an unexpected error upon filter '" + filterName + "' loading.");
        
        //Clic sur l'éventuel message Pas de données
        if (Get_DlgWarning().Exists)
            Get_DlgWarning().Click(Get_DlgWarning().Width/2, Get_DlgWarning().Height-45);
        
        //S'assurer que le filtre a été chargé
        Log.Message("Make sure filter '" + filterName + "' is loaded.");
        if (!Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().WaitProperty("IsChecked.OleValue", true, 30000))
            Log.Error("Filter '" + filterName + "' is not loaded.");
        else {
            CheckEquals(VarToStr(Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().WPFControlText), filterName, "Filter displayed Description");
            isFilterLoaded = (VarToStr(Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().WPFControlText) == filterName);
        }
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
        e = null;
        
        if (Get_DlgError().Exists)
            Get_DlgError().Click(Get_DlgError().Width/2, Get_DlgError().Height - 45);
        
        //Re-Login
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    }
    finally {
        RestoreAutoTimeOut();
        return isFilterLoaded;
    }
}



/**
    Description : Vérifie le bon fonctionnement d'un filtre du module Titres.
    
    Paramètres :
		- filterName (nom du filtre)
		- conditionAgainstValueToCompareWith (la condition que la valeur doit respecter - voir les valeurs possibles dans la documentation de la fonction CompareProperty : https://support.smartbear.com/testcomplete/docs/reference/program-objects/aqobject/compareproperty.html)
		- valueToCompareWith (valeur avec laquelle faire la comparaison)
		- arrayOfAllDisplayedSecuritiesBeforeFilter (tableau contenant la liste de tous les titres - sans filtre)
		- arrayOfColumnsNames (tableau contenant les noms des colonnes)
		- recordColumnName (nom de la colonne contenant la valeur à comparer)
		
    Auteur : Christophe Paring
*/
function CheckSecurityFilter(filterName, conditionAgainstValueToCompareWith, valueToCompareWith, arrayOfAllDisplayedSecuritiesBeforeFilter, arrayOfColumnsNames, recordColumnName)
{
    Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterName);
    var recordColumnIndex = arrayOfColumnsNames.indexOf(recordColumnName);
    
    var arrayOfExpectedDisplayedSecuritiesAfterFilter = new Array();
    for (var i = 0; i < arrayOfAllDisplayedSecuritiesBeforeFilter.length; i++){
        var actualValue = arrayOfAllDisplayedSecuritiesBeforeFilter[i][recordColumnIndex];
        if (CompareProperty(actualValue, conditionAgainstValueToCompareWith, valueToCompareWith, true, lmNone))
            arrayOfExpectedDisplayedSecuritiesAfterFilter.push(arrayOfAllDisplayedSecuritiesBeforeFilter[i]);
    }
    
    if (LoadSecuritiesAndOrdersFilter(filterName)){
        var arrayOfActualDisplayedSecuritiesAfterFilter = GetAllDisplayedSecurities(arrayOfColumnsNames);
        Log.Message("Vérifier que la liste des titres après le filtre est celle attendue");
        DoubleCheckArrayDiff(SetArrayItemsToString(arrayOfActualDisplayedSecuritiesAfterFilter), SetArrayItemsToString(arrayOfExpectedDisplayedSecuritiesAfterFilter));
    }
}



/**
    Description : Filtre une liste de titre selon une condition.
    
    Paramètres :
		- conditionAgainstValueToCompareWith (la condition que la valeur doit respecter - voir les valeurs possibles dans la documentation de la fonction CompareProperty : https://support.smartbear.com/testcomplete/docs/reference/program-objects/aqobject/compareproperty.html)
		- valueToCompareWith (valeur avec laquelle faire la comparaison)
		- arrayOfAllDisplayedSecuritiesBeforeFilter (tableau contenant la liste de tous les titres - sans filtre)
		- arrayOfColumnsNames (tableau contenant les noms des colonnes)
		- recordColumnName (nom de la colonne contenant la valeur à comparer)
		
    Auteur : Christophe Paring
*/
function GetFilteredSecurities(conditionAgainstValueToCompareWith, valuesToCompareWith, arrayOfAllDisplayedSecuritiesBeforeFilter, arrayOfColumnsNames, recordColumnName)
{
    if (GetVarType(valuesToCompareWith) != varArray && GetVarType(valuesToCompareWith) != varDispatch)
        valuesToCompareWith = new Array(valuesToCompareWith);
    
    var recordColumnIndex = arrayOfColumnsNames.indexOf(recordColumnName);
    
    var arrayOfExpectedDisplayedSecuritiesAfterFilter = new Array();
    for (var i = 0; i < arrayOfAllDisplayedSecuritiesBeforeFilter.length; i++){
        var actualValue = arrayOfAllDisplayedSecuritiesBeforeFilter[i][recordColumnIndex];
        var isActualValueMatched = true;
        for (var j = 0; j < valuesToCompareWith.length; j++){
            if (!CompareProperty(actualValue, conditionAgainstValueToCompareWith, valuesToCompareWith[j], true, lmNone)){
                isActualValueMatched = false;
                break;
            }
        }
        if (isActualValueMatched)
            arrayOfExpectedDisplayedSecuritiesAfterFilter.push(arrayOfAllDisplayedSecuritiesBeforeFilter[i]);
    }
    
    return arrayOfExpectedDisplayedSecuritiesAfterFilter;
}
