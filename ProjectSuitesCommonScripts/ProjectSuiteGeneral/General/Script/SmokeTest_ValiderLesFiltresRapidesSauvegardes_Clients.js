//USEUNIT SmokeTest_Common




/*
    Description : Valider les filtres rapides sauvegardés du module Clients
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
        
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderLesFiltresRapidesSauvegardes_Clients()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderLesFiltresRapidesSauvegardes_Clients()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        var filterRealClientsName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterRealClientsName", language + client);
        var filterRealClientsName_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterRealClientsName_Properties", language + client));
        
        var filterExternalClientsName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterExternalClientsName", language + client);
        var filterExternalClientsName_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterExternalClientsName_Properties", language + client));
        
        var filterFictitiousClientsName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterFictitiousClientsName", language + client);
        var filterFictitiousClientsName_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterFictitiousClientsName_Properties", language + client));
        
        var filterVieuxName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterVieuxName", language + client);
        var filterVieuxName_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FilterVieuxName_Properties", language + client));
        
        var vieuxMaxDate = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "VieuxMaxDate", language + client);
        
        var realClientUnexpectedChar = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "RealClientAccountUnexpectedChar", language + client);
        var externalClientStartChars = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ExternalClientAccountStartChars", language + client);
        var fictitiousClientStartChars = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "FictitiousClientAccountStartChars", language + client);
        
        //Login
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 100000);
        
        //Récupérer tous les clients (sans filtre)
        RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
        var arrayOfAllDisplayedClientsBeforeFilter = GetAllDisplayedClients();
        
        
        //Valider le filtre rapide sauvegardé 'Clients Réels'
        Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterRealClientsName, "", pmNormal, logAttributes);
        var isFilterRealClientsValid = CheckIfRelationshipsClientsAccountsFilterIsValid(filterRealClientsName, filterRealClientsName_Properties["Name"], filterRealClientsName_Properties["Access"], filterRealClientsName_Properties["Field"], filterRealClientsName_Properties["Operator"], filterRealClientsName_Properties["Value"], "TxtValue");
        CheckEquals(isFilterRealClientsValid, true, "Is filter '" + filterRealClientsName + "' valid");
        
        var arrayOfExpectedDisplayedClientsNumbersAfterFilter = new Array();
        for (var i = 0; i < arrayOfAllDisplayedClientsBeforeFilter.length; i ++)
            if (aqString.Find(arrayOfAllDisplayedClientsBeforeFilter[i][0], realClientUnexpectedChar) == -1)
                arrayOfExpectedDisplayedClientsNumbersAfterFilter.push(arrayOfAllDisplayedClientsBeforeFilter[i][0]);
        
        var arrayOfActualDisplayedClientsNumbersAfterFilter = LoadFilterAndGetDisplayedClientsNumbers(filterRealClientsName);
        
        Log.Message("Vérifier que la liste des comptes après le filtre est celle attendue");
        DoubleCheckArrayDiff(arrayOfActualDisplayedClientsNumbersAfterFilter, arrayOfExpectedDisplayedClientsNumbersAfterFilter);
        
        
        //Valider le filtre rapide sauvegardé 'Clients Externes'
        Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterExternalClientsName, "", pmNormal, logAttributes);
        var isFilterExternalClientsValid = CheckIfRelationshipsClientsAccountsFilterIsValid(filterExternalClientsName, filterExternalClientsName_Properties["Name"], filterExternalClientsName_Properties["Access"], filterExternalClientsName_Properties["Field"], filterExternalClientsName_Properties["Operator"], filterExternalClientsName_Properties["Value"], "TxtValue");
        CheckEquals(isFilterExternalClientsValid, true, "Is filter '" + filterExternalClientsName + "' valid");
        
        var arrayOfExpectedDisplayedClientsNumbersAfterFilter = new Array();
        for (var i = 0; i < arrayOfAllDisplayedClientsBeforeFilter.length; i ++)
            if (aqString.Find(arrayOfAllDisplayedClientsBeforeFilter[i][0], externalClientStartChars) == 0)
                arrayOfExpectedDisplayedClientsNumbersAfterFilter.push(arrayOfAllDisplayedClientsBeforeFilter[i][0]);
        
        var arrayOfActualDisplayedClientsNumbersAfterFilter = LoadFilterAndGetDisplayedClientsNumbers(filterExternalClientsName);
        
        Log.Message("Vérifier que la liste des comptes après le filtre est celle attendue");
        DoubleCheckArrayDiff(arrayOfActualDisplayedClientsNumbersAfterFilter, arrayOfExpectedDisplayedClientsNumbersAfterFilter);
        
        
        //Valider le filtre rapide sauvegardé 'Clients Fictifs'
        Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterFictitiousClientsName, "", pmNormal, logAttributes);
        var isFilterFictitiousClientsValid = CheckIfRelationshipsClientsAccountsFilterIsValid(filterFictitiousClientsName, filterFictitiousClientsName_Properties["Name"], filterFictitiousClientsName_Properties["Access"], filterFictitiousClientsName_Properties["Field"], filterFictitiousClientsName_Properties["Operator"], filterFictitiousClientsName_Properties["Value"], "TxtValue");
        CheckEquals(isFilterFictitiousClientsValid, true, "Is filter '" + filterFictitiousClientsName + "' valid");
        
        var arrayOfExpectedDisplayedClientsNumbersAfterFilter = new Array();
        for (var i = 0; i < arrayOfAllDisplayedClientsBeforeFilter.length; i ++)
            if (aqString.Find(arrayOfAllDisplayedClientsBeforeFilter[i][0], fictitiousClientStartChars) == 0)
                arrayOfExpectedDisplayedClientsNumbersAfterFilter.push(arrayOfAllDisplayedClientsBeforeFilter[i][0]);
        
        var arrayOfActualDisplayedClientsNumbersAfterFilter = LoadFilterAndGetDisplayedClientsNumbers(filterFictitiousClientsName);
        
        Log.Message("Vérifier que la liste des comptes après le filtre est celle attendue");
        DoubleCheckArrayDiff(arrayOfActualDisplayedClientsNumbersAfterFilter, arrayOfExpectedDisplayedClientsNumbersAfterFilter);
        
        
        //Valider le filtre rapide sauvegardé 'Vieux'
        Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterVieuxName, "", pmNormal, logAttributes);
        var isFilterVieuxValid = CheckIfRelationshipsClientsAccountsFilterIsValid(filterVieuxName, filterVieuxName_Properties["Name"], filterVieuxName_Properties["Access"], filterVieuxName_Properties["Field"], filterVieuxName_Properties["Operator"], filterVieuxName_Properties["Value"], "DateValue");
        CheckEquals(isFilterVieuxValid, true, "Is filter '" + filterVieuxName + "' valid");
        
        var arrayOfExpectedDisplayedClientsNumbersAfterFilter = new Array();
        for (var i = 0; i < arrayOfAllDisplayedClientsBeforeFilter.length; i ++)
            if (Trim(arrayOfAllDisplayedClientsBeforeFilter[i][1]) != "" && aqDateTime.Compare(aqConvert.StrToDate(arrayOfAllDisplayedClientsBeforeFilter[i][1]), aqConvert.StrToDate(vieuxMaxDate)) == -1)
                arrayOfExpectedDisplayedClientsNumbersAfterFilter.push(arrayOfAllDisplayedClientsBeforeFilter[i][0]);
        
        var arrayOfActualDisplayedClientsNumbersAfterFilter = LoadFilterAndGetDisplayedClientsNumbers(filterVieuxName);
        
        Log.Message("Vérifier que la liste des comptes après le filtre est celle attendue");
        DoubleCheckArrayDiff(arrayOfActualDisplayedClientsNumbersAfterFilter, arrayOfExpectedDisplayedClientsNumbersAfterFilter);
        
        
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



function LoadFilterAndGetDisplayedClientsNumbers(filterName)
{
    RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
    
    Log.Message("Charger le filtre : " + filterName);
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_Item(filterName).Click();
        
    //Clic sur l'éventuel message Pas de données
    SetAutoTimeOut();
    if (Get_DlgWarning().Exists)
        Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
    RestoreAutoTimeOut();
        
    //S'assurer que le filtre a été chargé
    Log.Message("S'assurer que le filtre a été chargé.");
    if (!Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists)
        return Log.Error("Le filtre n'a pas été chargé.");
        
    CheckEquals(VarToStr(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.FilterDescription.OleValue), filterName, "Filter Description");
    CheckEquals(VarToStr(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.FilterTooltip), filterName, "Filter Tooltip");
    
    var arrayOfActualDisplayedClientsAfterFilter = GetAllDisplayedClients();
    var arrayOfActualDisplayedClientsNumbersAfterFilter = new Array();
    for (var i = 0; i < arrayOfActualDisplayedClientsAfterFilter.length; i ++)
        arrayOfActualDisplayedClientsNumbersAfterFilter.push(arrayOfActualDisplayedClientsAfterFilter[i][0]);
    
    return arrayOfActualDisplayedClientsNumbersAfterFilter;
}



/*
    Return Array of Array
        ClientNumber Index = 0
        ClientBirthDay Index = 1
*/
function GetAllDisplayedClients()
{
    var arrayOfAllDisplayedClients = new Array();
    
    if (Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count() < 1)
        return arrayOfAllDisplayedClients;
    
    Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
    var isEndOfGriReached = false;
    while (!isEndOfGriReached){
        var clientsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
        for (var i = 0; i < clientsPageCount; i++){
            var currentClientNumber = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_ClientNumber());
            var currentClientBirthDate = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_BirthDate());
            
            var isCurrentClientNew = true
            for (var j = 0; j < arrayOfAllDisplayedClients.length; j++){
                if (arrayOfAllDisplayedClients[j][0] == currentClientNumber){
                    isCurrentClientNew = false;
                    break;
                }
            }
            
            if (isCurrentClientNew)
                arrayOfAllDisplayedClients.push([currentClientNumber, currentClientBirthDate]);
        }
        
        var firstRowClientBeforeScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_ClientNumber());
        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
        var firstRowClientAfterScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_ClientNumber());
        
        if (firstRowClientBeforeScroll == firstRowClientAfterScroll){
            Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
            firstRowClientAfterScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_ClientNumber());
        }
        
        isEndOfGriReached = (firstRowClientBeforeScroll == firstRowClientAfterScroll);
    }
    
    return arrayOfAllDisplayedClients;
}
