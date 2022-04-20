//USEUNIT SmokeTest_Common



/*
    Description : Valider les filtres rapides sauvegardés du module Relations
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
        
    Analyste d'automatisation : Christophe Paring
*/
function SmokeTest_ValiderLesFiltresRapidesSauvegardes_Relations()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderLesFiltresRapidesSauvegardes_Relations()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        var profilePanierLongNumerique = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "RelationshipsProfilName_PanierLongNumerique", language + client);
        var profilePanier = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "RelationshipsProfilName_Panier", language + client);
        var profileDate = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "RelationshipsProfilName_Date", language + client);
        var linkNumberColumn = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "RelationshipsProfilName_LinkNumber", language + client);
        
        var arrayOfProfilesColumnsNames = [profilePanier, profileDate];
        var arrayOfProfilesNames = [profilePanierLongNumerique, profileDate];
        var arrayOfColumnsNames = [linkNumberColumn].concat(arrayOfProfilesColumnsNames);
        
        var filterName_relation = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Relationships_ValidateCriteria_FilterName_relation", language + client);
        var filterName_relation_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Relationships_ValidateCriteria_FilterName_relation_Properties", language + client));
        var filterRelationValue_Date = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Relationships_ValidateCriteria_FilterRelationValue_Date", language + client);
        
        var filterName_profil = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Relationships_ValidateCriteria_FilterName_profil", language + client);
        var filterName_profil_Properties = GetFilterProperties(ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Relationships_ValidateCriteria_FilterName_profil_Properties", language + client));
        var filterProfilValue_Panier = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Relationships_ValidateCriteria_FilterProfilValue_Panier", language + client);
        
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        //Cocher les profils nécessaires
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
        
        Get_RelationshipsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabProfile().Click();
        Get_WinInfo_TabProfile_BtnSetup().Click();
        
        var arrayOfProfileCheckboxPreviousState = new Array();
        for (var i = 0; i < arrayOfProfilesNames.length; i++){
            var profileCheckbox = Get_WinVisibleProfilesConfiguration_ChkProfile(arrayOfProfilesNames[i]);
            if (!profileCheckbox.Exists)
                return Log.Error("Profile '" + arrayOfProfilesNames[i] + "' was not found, this is unexpected.");
            else {
                var previousState = profileCheckbox.IsChecked.OleValue;
                arrayOfProfileCheckboxPreviousState.push(previousState);
                if (previousState != true)
                    profileCheckbox.Click();
            }

        }
        
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        Get_WinDetailedInfo_BtnOK().Click();
        
        //Ajouter les colonnes des profils
        ClickRightAndExpectSubmenus(Get_RelationshipsGrid_ChName());
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        for (var j = 0; j < arrayOfProfilesColumnsNames.length; j++){
            ClickRightAndExpectSubmenus(Get_RelationshipsGrid_ChName());
            Get_GridHeader_ContextualMenu_AddColumn().Click();
            Get_GridHeader_ContextualMenu_AddColumn_Profiles().Click();
            var columnMenuItem = Get_GridHeader_ContextualMenu_AddColumnOrInsertField_Profiles_ProfileName(arrayOfProfilesColumnsNames[j], arrayOfProfilesColumnsNames[j]);
            if (columnMenuItem.Exists)
                columnMenuItem.Click();
        }
        
        //Récupérer toutes les relations (sans filtre)
        RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
        var arrayOfAllDisplayedRelationshipsBeforeFilter = GetAllDisplayedRelationships();
        
        //Filtre profil
        Log.Message("******** CAS DU FILTRE : '" + filterName_profil + "' ********", "", pmNormal, logAttributes);
        var isFilterProfilValid = CheckIfRelationshipsClientsAccountsFilterIsValid(filterName_profil, filterName_profil_Properties["Name"], filterName_profil_Properties["Access"], filterName_profil_Properties["Field"], filterName_profil_Properties["Operator"], filterName_profil_Properties["Value"], "TxtValueDouble");
        CheckEquals(isFilterProfilValid, true, "Is filter '" + filterName_profil + "' valid");
        
        CheckFilter(filterName_profil, cmpEqual, filterProfilValue_Panier, arrayOfAllDisplayedRelationshipsBeforeFilter, arrayOfColumnsNames, profilePanier);
        
        //Filtre relation
        Log.Message("******** CAS DU FILTRE : '" + filterName_relation + "' ********", "", pmNormal, logAttributes);
        var isFilterRelationValid = CheckIfRelationshipsClientsAccountsFilterIsValid(filterName_relation, filterName_relation_Properties["Name"], filterName_relation_Properties["Access"], filterName_relation_Properties["Field"], filterName_relation_Properties["Operator"], filterName_relation_Properties["Value"], "DateValue");
        CheckEquals(isFilterRelationValid, true, "Is filter '" + filterName_relation + "' valid");
        
        CheckDateFilter(filterName_relation, cmpEqual, filterRelationValue_Date, arrayOfAllDisplayedRelationshipsBeforeFilter, arrayOfColumnsNames, profileDate);
 
        //Fermer Croesus
        RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        if (arrayOfProfileCheckboxPreviousState == undefined)
            return;
            
        //Restore Profiles previous state
        Log.Message("Restore Profiles previous state", "", pmNormal, logAttributes);
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
        Get_RelationshipsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabProfile().Click();
        Get_WinInfo_TabProfile_BtnSetup().Click();
        
        for (var i = 0; i < arrayOfProfilesNames.length; i++){
            var profileCheckbox = Get_WinVisibleProfilesConfiguration_ChkProfile(arrayOfProfilesNames[i]);
            if (!profileCheckbox.Exists)
                Log.Error("Profile '" + arrayOfProfilesNames[i] + "' was not found, this is unexpected.");
            else if (profileCheckbox.IsChecked.OleValue != arrayOfProfileCheckboxPreviousState[i])
                    profileCheckbox.Click();
        }
        
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        Get_WinDetailedInfo_BtnOK().Click();
        
        //Rétablir la configuration par défaut des colonnes
        ClickRightAndExpectSubmenus(Get_RelationshipsGrid_ChName());
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        //Fermer Croesus
        Close_Croesus_MenuBar();
        Terminate_CroesusProcess();
    }
    
}



/*
    Return Array of Array
        RelationshipNumber Index = 0
        currentRelationshipProfilePanier Index = 1
        currentRelationshipProfileDate Index = 2
*/
function GetAllDisplayedRelationships()
{
    Log.Message("Get all displayed Relationships.");
    
    var arrayOfAllDisplayedRelationships = new Array();
    
    if (Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count() < 1)
        return arrayOfAllDisplayedRelationships;
    
    Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
    var isEndOfGriReached = false;
    while (!isEndOfGriReached){
        Get_RelationshipsClientsAccountsGrid().Refresh();
        var relatonshipsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
        for (var i = 0; i < relatonshipsPageCount; i++){
            var currentRelationshipNumber = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_LinkNumber());
            var objProfilePanier = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Profiles.Item(0);
            var objProfileDate = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Profiles.Item(1);
            var currentRelationshipProfilePanier = (objProfilePanier == null)? "": VarToStr(objProfilePanier.get_ValueForDisplay());
            var currentRelationshipProfileDate = (objProfileDate == null)? "": VarToStr(objProfileDate.get_ValueForDisplay());
            
            var isCurrentRelationshipNew = true;
            for (var j = 0; j < arrayOfAllDisplayedRelationships.length; j++){
                if (arrayOfAllDisplayedRelationships[j][0] == currentRelationshipNumber){
                    isCurrentRelationshipNew = false;
                    break;
                }
            }
            
            if (isCurrentRelationshipNew)
                arrayOfAllDisplayedRelationships.push([currentRelationshipNumber, currentRelationshipProfilePanier, currentRelationshipProfileDate]);
        }
        
        var firstRowRelatonshipBeforeScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_LinkNumber());
        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
        var firstRowRelatonshipAfterScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_LinkNumber());
        
        if (firstRowRelatonshipBeforeScroll == firstRowRelatonshipAfterScroll){
            Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
            firstRowRelatonshipAfterScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_LinkNumber());
        }
        
        isEndOfGriReached = (firstRowRelatonshipBeforeScroll == firstRowRelatonshipAfterScroll);
    }
    
    return arrayOfAllDisplayedRelationships;
}


/**
    Description : Vérifie le bon fonctionnement d'un filtre date.
    
    Paramètres :
		- filterName (nom du filtre)
		- conditionAgainstValueToCompareWith (la condition que la valeur doit respecter - voir les valeurs possibles dans la documentation de la fonction CompareProperty : https://support.smartbear.com/testcomplete/docs/reference/program-objects/aqobject/compareproperty.html)
		- valueToCompareWith (valeur avec laquelle faire la comparaison)
		- arrayOfAllDisplayedRelationshipsBeforeFilter (tableau contenant la liste de tous les titres - sans filtre)
		- arrayOfColumnsNames (tableau contenant les noms des colonnes)
		- recordColumnName (nom de la colonne contenant la valeur à comparer)
		
    Auteur : Christophe Paring
*/
function CheckDateFilter(filterName, conditionAgainstValueToCompareWith, valueToCompareWith, arrayOfAllDisplayedRelationshipsBeforeFilter, arrayOfColumnsNames, recordColumnName)
{
    Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterName);
    var recordColumnIndex = arrayOfColumnsNames.indexOf(recordColumnName);
    
    var arrayOfExpectedDisplayedRelationshipsAfterFilter = new Array();
    for (var i = 0; i < arrayOfAllDisplayedRelationshipsBeforeFilter.length; i++){
        var actualValue = arrayOfAllDisplayedRelationshipsBeforeFilter[i][recordColumnIndex];
        if (conditionAgainstValueToCompareWith == cmpEqual){
            if (Trim(actualValue) != "" && aqDateTime.Compare(aqConvert.StrToDate(actualValue), aqConvert.StrToDate(valueToCompareWith)) == 0)
            arrayOfExpectedDisplayedRelationshipsAfterFilter.push(arrayOfAllDisplayedRelationshipsBeforeFilter[i]);
        }
        else
         return Log.Error("Condition '" + conditionAgainstValueToCompareWith + "' not supported.");
    }
    
    if (LoadRelationshipsClientsAccountsFilter(filterName)){
        var arrayOfActualDisplayedRelationshipsAfterFilter = GetAllDisplayedRelationships();
        Log.Message("Vérifier que la liste des relations après le filtre est celle attendue");
        DoubleCheckArrayDiff(SetArrayItemsToString(arrayOfActualDisplayedRelationshipsAfterFilter), SetArrayItemsToString(arrayOfExpectedDisplayedRelationshipsAfterFilter));
    }
}


/**
    Description : Vérifie le bon fonctionnement d'un filtre.
    
    Paramètres :
		- filterName (nom du filtre)
		- conditionAgainstValueToCompareWith (la condition que la valeur doit respecter - voir les valeurs possibles dans la documentation de la fonction CompareProperty : https://support.smartbear.com/testcomplete/docs/reference/program-objects/aqobject/compareproperty.html)
		- valueToCompareWith (valeur avec laquelle faire la comparaison)
		- arrayOfAllDisplayedRelationshipsBeforeFilter (tableau contenant la liste de tous les titres - sans filtre)
		- arrayOfColumnsNames (tableau contenant les noms des colonnes)
		- recordColumnName (nom de la colonne contenant la valeur à comparer)
		
    Auteur : Christophe Paring
*/
function CheckFilter(filterName, conditionAgainstValueToCompareWith, valueToCompareWith, arrayOfAllDisplayedRelationshipsBeforeFilter, arrayOfColumnsNames, recordColumnName)
{
    Log.Message("VALIDER LE FILTRE RAPIDE SAUVEGARDÉ : " + filterName);
    var recordColumnIndex = arrayOfColumnsNames.indexOf(recordColumnName);
    
    var arrayOfExpectedDisplayedRelationshipsAfterFilter = new Array();
    for (var i = 0; i < arrayOfAllDisplayedRelationshipsBeforeFilter.length; i++){
        var actualValue = arrayOfAllDisplayedRelationshipsBeforeFilter[i][recordColumnIndex];
        if (CompareProperty(valueToCompareWith, conditionAgainstValueToCompareWith, actualValue, true, lmNone))
            arrayOfExpectedDisplayedRelationshipsAfterFilter.push(arrayOfAllDisplayedRelationshipsBeforeFilter[i]);
    }
    
    if (LoadRelationshipsClientsAccountsFilter(filterName)){
        var arrayOfActualDisplayedRelationshipsAfterFilter = GetAllDisplayedRelationships();
        Log.Message("Vérifier que la liste des titres après le filtre est celle attendue");
        DoubleCheckArrayDiff(SetArrayItemsToString(arrayOfActualDisplayedRelationshipsAfterFilter), SetArrayItemsToString(arrayOfExpectedDisplayedRelationshipsAfterFilter));
    }
}



function LoadRelationshipsClientsAccountsFilter(filterName)
{
    try {
        SetAutoTimeOut();
        
        var isFilterLoaded = false;
        
        Log.Message("Load filter '" + filterName + "'.");
        RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Item(filterName).Click();
        
        //Gérer l'affichage d'un éventuel message d'erreur
        if (Get_DlgError().Exists)
            throw new Error("There was an unexpected error upon filter '" + filterName + "' loading.");
        
        //Clic sur l'éventuel message Pas de données
        if (Get_DlgWarning().Exists)
            Get_DlgWarning().Click(Get_DlgWarning().Width/2, Get_DlgWarning().Height-45);
        
        //S'assurer que le filtre a été chargé
        Log.Message("Make sure filter '" + filterName + "' is loaded.");
        if (!Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists)
            Log.Error("Filter '" + filterName + "' is not loaded.");
        else {
            CheckEquals(VarToStr(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.FilterDescription.OleValue), filterName, "Filter Description");
            CheckEquals(VarToStr(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.FilterTooltip), filterName, "Filter Tooltip");

            isFilterLoaded = (VarToStr(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.FilterDescription.OleValue) == filterName);
        }
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
        e = null;
        
        if (Get_DlgError().Exists)
            Get_DlgError().Click(Get_DlgError().Width/2, Get_DlgError().Height - 45);
        
        //Re-Login
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
    }
    finally {
        RestoreAutoTimeOut();
        return isFilterLoaded;
    }
}
