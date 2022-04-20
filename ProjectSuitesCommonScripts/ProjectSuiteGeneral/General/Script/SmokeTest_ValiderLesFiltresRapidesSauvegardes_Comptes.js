//USEUNIT SmokeTest_Common




/*
    Description : Valider les filtres rapides sauvegardés du module Compte
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
        
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderLesFiltresRapidesSauvegardes_Comptes()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderLesFiltresRapidesSauvegardes_Comptes()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        var accountTypeCash = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "AccountTypeCash", language + client);

        var filterCashAccountsName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterCashAccountsName", language + client);
        var filterCashAccountsName_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterCashAccountsName_Properties", language + client));
        
        var filterRealAccountsName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterRealAccountsName", language + client);
        var filterRealAccountsName_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterRealAccountsName_Properties", language + client));
        
        var filterExternalAccountsName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterExternalAccountsName", language + client);
        var filterExternalAccountsName_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterExternalAccountsName_Properties", language + client));
        
        var filterFictitiousAccountsName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterFictitiousAccountsName", language + client);
        var filterFictitiousAccountsName_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterFictitiousAccountsName_Properties", language + client));
        
        var filterUnifiedManagedAccountsName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterUnifiedManagedAccountsName", language + client);
        var filterUnifiedManagedAccountsName_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterUnifiedManagedAccountsName_Properties", language + client));
        
        var AccountsFilterUnifiedManagedAmongValue = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Accounts_FilterUnifiedManaged_Among_Value", language + client);
        
        var filterOpenAccountsName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterOpenAccountsName", language + client);
        var filterOpenAccountsName_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterOpenAccountsName_Properties", language + client));
        
        var realAccountUnexpectedChar = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "RealClientAccountUnexpectedChar", language + client);
        var externalAccountStartChars = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ExternalClientAccountStartChars", language + client);
        var fictitiousAccountStartChars = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FictitiousClientAccountStartChars", language + client);
        
        //Login
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
        
        //Récupérer tous les comptes (sans filtre)
        RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
        var arrayOfAllDisplayedAccountsBeforeFilter = GetAllDisplayedAccounts();
        
        
        //Valider le filtre rapide sauvegardé 'Comptes Comptants'
        Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterCashAccountsName, "", pmNormal, logAttributes);
        var isFilterCashAccountsValid = CheckIfRelationshipsClientsAccountsFilterIsValid(filterCashAccountsName, filterCashAccountsName_Properties["Name"], filterCashAccountsName_Properties["Access"], filterCashAccountsName_Properties["Field"], filterCashAccountsName_Properties["Operator"], filterCashAccountsName_Properties["Value"], "DgvValue");
        CheckEquals(isFilterCashAccountsValid, true, "Is filter '" + filterCashAccountsName + "' valid");
        
        var arrayOfExpectedDisplayedAccountsNumbersAfterFilter = new Array();
        for (var i = 0; i < arrayOfAllDisplayedAccountsBeforeFilter.length; i ++)
            if (arrayOfAllDisplayedAccountsBeforeFilter[i][1] == accountTypeCash)
                arrayOfExpectedDisplayedAccountsNumbersAfterFilter.push(arrayOfAllDisplayedAccountsBeforeFilter[i][0]);
        
        var arrayOfActualDisplayedAccountsNumbersAfterFilter = LoadFilterAndGetDisplayedAccountsNumbers(filterCashAccountsName);
        
        Log.Message("Vérifier que la liste des comptes après le filtre est celle attendue");
        DoubleCheckArrayDiff(arrayOfActualDisplayedAccountsNumbersAfterFilter, arrayOfExpectedDisplayedAccountsNumbersAfterFilter);
        
        
        //Valider le filtre rapide sauvegardé 'Comptes Réels'
        Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterRealAccountsName, "", pmNormal, logAttributes);
        var isFilterRealAccountsValid = CheckIfRelationshipsClientsAccountsFilterIsValid(filterRealAccountsName, filterRealAccountsName_Properties["Name"], filterRealAccountsName_Properties["Access"], filterRealAccountsName_Properties["Field"], filterRealAccountsName_Properties["Operator"], filterRealAccountsName_Properties["Value"], "TxtValue");
        CheckEquals(isFilterRealAccountsValid, true, "Is filter '" + filterRealAccountsName + "' valid");
        
        var arrayOfExpectedDisplayedAccountsNumbersAfterFilter = new Array();
        for (var i = 0; i < arrayOfAllDisplayedAccountsBeforeFilter.length; i ++)
            if (aqString.Find(arrayOfAllDisplayedAccountsBeforeFilter[i][0], realAccountUnexpectedChar) == -1)
                arrayOfExpectedDisplayedAccountsNumbersAfterFilter.push(arrayOfAllDisplayedAccountsBeforeFilter[i][0]);
        
        var arrayOfActualDisplayedAccountsNumbersAfterFilter = LoadFilterAndGetDisplayedAccountsNumbers(filterRealAccountsName);
        
        Log.Message("Vérifier que la liste des comptes après le filtre est celle attendue");
        DoubleCheckArrayDiff(arrayOfActualDisplayedAccountsNumbersAfterFilter, arrayOfExpectedDisplayedAccountsNumbersAfterFilter);
        
        
        //Valider le filtre rapide sauvegardé 'Comptes Externes'
        Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterExternalAccountsName, "", pmNormal, logAttributes);
        var isFilterExternalAccountsValid = CheckIfRelationshipsClientsAccountsFilterIsValid(filterExternalAccountsName, filterExternalAccountsName_Properties["Name"], filterExternalAccountsName_Properties["Access"], filterExternalAccountsName_Properties["Field"], filterExternalAccountsName_Properties["Operator"], filterExternalAccountsName_Properties["Value"], "TxtValue");
        CheckEquals(isFilterExternalAccountsValid, true, "Is filter '" + filterExternalAccountsName + "' valid");
        
        var arrayOfExpectedDisplayedAccountsNumbersAfterFilter = new Array();
        for (var i = 0; i < arrayOfAllDisplayedAccountsBeforeFilter.length; i ++)
            if (aqString.Find(arrayOfAllDisplayedAccountsBeforeFilter[i][0], externalAccountStartChars) == 0)
                arrayOfExpectedDisplayedAccountsNumbersAfterFilter.push(arrayOfAllDisplayedAccountsBeforeFilter[i][0]);
        
        var arrayOfActualDisplayedAccountsNumbersAfterFilter = LoadFilterAndGetDisplayedAccountsNumbers(filterExternalAccountsName);
        
        Log.Message("Vérifier que la liste des comptes après le filtre est celle attendue");
        DoubleCheckArrayDiff(arrayOfActualDisplayedAccountsNumbersAfterFilter, arrayOfExpectedDisplayedAccountsNumbersAfterFilter);
        
        
        //Valider le filtre rapide sauvegardé 'Comptes Fictifs'
        Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterFictitiousAccountsName, "", pmNormal, logAttributes);
        var isFilterFictitiousAccountsValid = CheckIfRelationshipsClientsAccountsFilterIsValid(filterFictitiousAccountsName, filterFictitiousAccountsName_Properties["Name"], filterFictitiousAccountsName_Properties["Access"], filterFictitiousAccountsName_Properties["Field"], filterFictitiousAccountsName_Properties["Operator"], filterFictitiousAccountsName_Properties["Value"], "TxtValue");
        CheckEquals(isFilterFictitiousAccountsValid, true, "Is filter '" + filterFictitiousAccountsName + "' valid");
        
        var arrayOfExpectedDisplayedAccountsNumbersAfterFilter = new Array();
        for (var i = 0; i < arrayOfAllDisplayedAccountsBeforeFilter.length; i ++)
            if (aqString.Find(arrayOfAllDisplayedAccountsBeforeFilter[i][0], fictitiousAccountStartChars) == 0)
                arrayOfExpectedDisplayedAccountsNumbersAfterFilter.push(arrayOfAllDisplayedAccountsBeforeFilter[i][0]);
        
        var arrayOfActualDisplayedAccountsNumbersAfterFilter = LoadFilterAndGetDisplayedAccountsNumbers(filterFictitiousAccountsName);
        
        Log.Message("Vérifier que la liste des comptes après le filtre est celle attendue");
        DoubleCheckArrayDiff(arrayOfActualDisplayedAccountsNumbersAfterFilter, arrayOfExpectedDisplayedAccountsNumbersAfterFilter);
        
        
        //Valider le filtre rapide sauvegardé 'Comptes à gestion unifiée'
        /*
        Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterUnifiedManagedAccountsName, "", pmNormal, logAttributes);
        var isFilterUnifiedManagedAccountsValid = CheckIfRelationshipsClientsAccountsFilterIsValid(filterUnifiedManagedAccountsName, filterUnifiedManagedAccountsName_Properties["Name"], filterUnifiedManagedAccountsName_Properties["Access"], filterUnifiedManagedAccountsName_Properties["Field"], filterUnifiedManagedAccountsName_Properties["Operator"], filterUnifiedManagedAccountsName_Properties["Value"], "DgvValue");
        CheckEquals(isFilterUnifiedManagedAccountsValid, true, "Is filter '" + filterUnifiedManagedAccountsName + "' valid");
        
        var arrayOfExpectedDisplayedAccountsNumbersAfterFilter = new Array();
        
        var hasSleevesCheckValue;
        if (Trim(AccountsFilterUnifiedManagedAmongValue.toUpperCase()) == "OUI" || Trim(AccountsFilterUnifiedManagedAmongValue.toUpperCase()) == "YES")
            hasSleevesCheckValue = true;
        else if (Trim(AccountsFilterUnifiedManagedAmongValue.toUpperCase()) == "NON" || Trim(AccountsFilterUnifiedManagedAmongValue.toUpperCase()) == "NO")
            hasSleevesCheckValue = false;
        else
            hasSleevesCheckValue = null;
        
        for (var i = 0; i < arrayOfAllDisplayedAccountsBeforeFilter.length; i ++)
            if (arrayOfAllDisplayedAccountsBeforeFilter[i][3] === hasSleevesCheckValue)
                arrayOfExpectedDisplayedAccountsNumbersAfterFilter.push(arrayOfAllDisplayedAccountsBeforeFilter[i][0]);
        
        var arrayOfActualDisplayedAccountsNumbersAfterFilter = LoadFilterAndGetDisplayedAccountsNumbers(filterUnifiedManagedAccountsName);
        
        Log.Message("Vérifier que la liste des comptes après le filtre est celle attendue");
        DoubleCheckArrayDiff(arrayOfActualDisplayedAccountsNumbersAfterFilter, arrayOfExpectedDisplayedAccountsNumbersAfterFilter);
        */
        
        //Valider le filtre rapide sauvegardé 'Comptes ouverts'
        Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterOpenAccountsName, "", pmNormal, logAttributes);
        var isFilterOpenAccountsValid = CheckIfRelationshipsClientsAccountsFilterIsValid(filterOpenAccountsName, filterOpenAccountsName_Properties["Name"], filterOpenAccountsName_Properties["Access"], filterOpenAccountsName_Properties["Field"], filterOpenAccountsName_Properties["Operator"], filterOpenAccountsName_Properties["Value"], "TxtValue");
        CheckEquals(isFilterOpenAccountsValid, true, "Is filter '" + filterOpenAccountsName + "' valid");
        
        var arrayOfExpectedDisplayedAccountsNumbersAfterFilter = new Array();
        for (var i = 0; i < arrayOfAllDisplayedAccountsBeforeFilter.length; i ++)
            if (arrayOfAllDisplayedAccountsBeforeFilter[i][2] == "")
                arrayOfExpectedDisplayedAccountsNumbersAfterFilter.push(arrayOfAllDisplayedAccountsBeforeFilter[i][0]);
        
        var arrayOfActualDisplayedAccountsNumbersAfterFilter = LoadFilterAndGetDisplayedAccountsNumbers(filterOpenAccountsName);
        
        Log.Message("Vérifier que la liste des comptes après le filtre est celle attendue");
        DoubleCheckArrayDiff(arrayOfActualDisplayedAccountsNumbersAfterFilter, arrayOfExpectedDisplayedAccountsNumbersAfterFilter);
        
        
        //Fermer Croesus
        RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();

    }
    
}



function LoadFilterAndGetDisplayedAccountsNumbers(filterName)
{
    RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
    
    Log.Message("Charger le filtre : " + filterName);
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_Item(filterName).Click();
    
    //Clic sur l'éventuel message Pas de données
    SetAutoTimeOut();
    if (Get_DlgWarning().Exists)
        Get_DlgWarning().Click(Get_DlgWarning().Width/2, Get_DlgWarning().Height-45);
    
    RestoreAutoTimeOut();
    
    //S'assurer que le filtre a été chargé
    Log.Message("S'assurer que le filtre a été chargé.");
    if (!Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists)
        return Log.Error("Le filtre n'a pas été chargé.");
        
    CheckEquals(VarToStr(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.FilterDescription.OleValue), filterName, "Filter Description");
    CheckEquals(VarToStr(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.FilterTooltip), filterName, "Filter Tooltip");
    
    var arrayOfActualDisplayedAccountsAfterFilter = GetAllDisplayedAccounts();
    var arrayOfActualDisplayedAccountsNumbersAfterFilter = new Array();
    for (var i = 0; i < arrayOfActualDisplayedAccountsAfterFilter.length; i ++)
        arrayOfActualDisplayedAccountsNumbersAfterFilter.push(arrayOfActualDisplayedAccountsAfterFilter[i][0]);
    
    return arrayOfActualDisplayedAccountsNumbersAfterFilter;
}



/*
    Return Array of Array
        AccountNumber Index = 0
        AccountType Index = 1
        AccountClosingDate Index = 2
        AccountHasSleeves Index = 3
*/
function GetAllDisplayedAccounts()
{
    var arrayOfAllDisplayedAccounts = new Array();
    
    if (Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count() < 1)
        return arrayOfAllDisplayedAccounts;
    
    Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
    var isEndOfGriReached = false;
    while (!isEndOfGriReached){
        var accountsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
        for (var i = 0; i < accountsPageCount; i++){
            var currentAccountNumber = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_AccountNumber());
            var currentAccountType = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_TypeDescription());
            var currentAccountClosingDate = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_CloseDate());
            var currentAccountHasSleeves = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_HasSleeve();
            
            var isCurrentAccountNew = true
            for (var j = 0; j < arrayOfAllDisplayedAccounts.length; j++){
                if (arrayOfAllDisplayedAccounts[j][0] == currentAccountNumber){
                    isCurrentAccountNew = false;
                    break;
                }
            }
            
            if (isCurrentAccountNew)
                arrayOfAllDisplayedAccounts.push([currentAccountNumber, currentAccountType, currentAccountClosingDate, currentAccountHasSleeves]);
        }
        
        var firstRowAccountBeforeScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_AccountNumber());
        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
        var firstRowAccountAfterScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_AccountNumber());
        
        if (firstRowAccountBeforeScroll == firstRowAccountAfterScroll){
            Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
            firstRowAccountAfterScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_AccountNumber());
        }
        
        isEndOfGriReached = (firstRowAccountBeforeScroll == firstRowAccountAfterScroll);
    }
    
    return arrayOfAllDisplayedAccounts;
}
