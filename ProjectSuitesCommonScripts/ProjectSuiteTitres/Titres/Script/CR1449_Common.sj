//USEUNIT Common_functions
//USEUNIT DBA


function VerifyUserAccessLevel(testUsername, accessLevel)
{
    Log.Message("Valider ACCES = " + accessLevel + " pour l'utilisateur " + testUsername);
    var actualAccessLevel = Execute_SQLQuery_GetField("select ACCES from B_USER where STATION_ID = '" + testUsername + "'", vServerTitre, "ACCES");
    return aqObject.CompareProperty(Trim(actualAccessLevel), cmpEqual, accessLevel, true, lmError);
}



function VerifyPreconditionsOfCR1449(testUsername)
{
    var isAccessLevelTheExpected = VerifyUserAccessLevel(testUsername, "SYSADM");
    
    var prefValue = "YES";
    Log.Message("Valider PREF_EDIT_FIRM_FUNCTIONS = " + prefValue + " pour l'utilisateur " + testUsername);
    var actualPrefValue = GetUserPrefValue(vServerTitre, "PREF_EDIT_FIRM_FUNCTIONS", testUsername);
    var isPrefValueTheExpected = aqObject.CompareProperty(Trim(VarToStr(actualPrefValue)), cmpEqual, prefValue, true, lmWarning);
    
    return (isAccessLevelTheExpected && isPrefValueTheExpected);
}



function OpenSecurityCategorisationWindow(isWinConfigurationsOpened)
{
    Log.Message("Ouvrir la fenêtre 'Catégorisation de titres'");
    if (isWinConfigurationsOpened == undefined)
        isWinConfigurationsOpened = false;
    
    if (!isWinConfigurationsOpened){
        var numTry = 0;
        do {
            Delay(5000);
            Get_MenuBar_Tools().Click();
        } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1000, 3500))
        
        Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 6000);
        Get_WinConfigurations().Parent.Maximize();
    }
    
    Get_WinConfigurations_TvwTreeview_LlbSecurityAndCategorisation().Click();
    Delay(1000);
    Get_WinConfigurations_LvwListView_LlbSecurityAndCategorisation().DblClick();
    Get_WinSecurityCategorisationConfigurations().Parent.Maximize();
    var arrayOfTreeviewItems = Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindAllChildren(["ClrClassName", "IsVisible"], ["TreeViewItem", true]).toArray();
    for (var i in arrayOfTreeviewItems)
        arrayOfTreeviewItems[i].set_IsExpanded(true);
}



function CloseCroesusFromSecurityCategorisationWindow()
{
    Log.Message("Fermer Croesus à partir de la fenêtre 'Catégorisation de titres'");
    Get_WinSecurityCategorisationConfigurationsBtnClose().Click();
    Get_WinConfigurations().Close();
    CloseCroesus();
}



function CloseCroesus()
{
    Close_Croesus_MenuBar();
    var previousAutoTimeout = Options.Run.Timeout;
    SetAutoTimeOut();
    if (Get_DlgConfirmation().Exists)
        Get_DlgConfirmation_BtnYes().Click();
    RestoreAutoTimeOut(previousAutoTimeout);
}



/**
    Description : Trouver l'index d'un élément d'un combobox
*/
function GetComboboxItemIndex(comboboxObject, ItemDisplayedText)
{
    for (var i = 0; i < comboboxObject.Items.Count; i++)
        if (comboboxObject.Items.Item(i).Value.OleValue == ItemDisplayedText)
            return i;
    
    Log.Message("Item '" + ItemDisplayedText + "' not found in the combobox items list.");
    return null;
}



////À déplacer du projet General et à mettre dans Common
function ExecuteActionAndExpectSubmenus(componentObject, action, maxNbOfTries)
{
    try {
        SetAutoTimeOut(500);
        
        if (maxNbOfTries == undefined)
            maxNbOfTries = 5;
            
        var nbOfTries = 0;
        do {
            Sys.Refresh();
            
            if (aqString.ToUpper(action) == "CLICKR" || aqString.ToUpper(action) == "CLICKR()")
                componentObject.ClickR();
            else if (aqString.ToUpper(action) == "CLICK" || aqString.ToUpper(action) == "CLICK()")
                componentObject.Click();
            else
                componentObject.Keys(action);
        
        } while (++nbOfTries < maxNbOfTries && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 3000, 4000))
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        e = null;
    }
    finally {
        if (!Get_SubMenus().Exists || !Get_SubMenus().VisibleOnScreen)
            Log.Error("Submenus was not displayed.");
        RestoreAutoTimeOut();
    }
}



function LoadExistingSecuritiesAndOrdersFilter(filterName)
{
    ExecuteActionAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders(), "Click()");
    if (Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_Item(filterName).Exists)
        Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_Item(filterName).Click();
    else {
        Get_Toolbar_BtnQuickFilters_ContextMenu_MoreFilters().Click();
        var lastItemIndex = Get_WinFilterSelection_LstFilters().Items.Count - 1;
        var lastItemName = Get_WinFilterSelection_LstFilters().Items.Item(lastItemIndex).Text.OleValue
        Get_WinFilterSelection_LstFilters().Keys(filterName[0]);
        while (!Get_WinFilterSelection_LstFilters_Item(filterName).Exists && !Get_WinFilterSelection_LstFilters_Item(lastItemName).Exists)
            Get_WinFilterSelection_LstFilters().Keys("[Down]");
            
        Get_WinFilterSelection_LstFilters_Item(filterName).set_IsSelected(true);
        
        if (Get_WinFilterSelection_LstFilters_Item(filterName).Exists)
            Get_WinFilterSelection_BtnOK().Click();
        else
            Get_WinFilterSelection_BtnCancel().Click();
    }
}



/**
    Description : Trouver l'index de la ligne du titre (dans la grille principale du module Titres)
    Paramètre :
        SecuFirme : Numéro du Titre (Exemple : 987654)
*/
function GetSecurityRowIndex_old(SecuFirme)
{
    Search_Security(SecuFirme);
    var SecuFirmeCell = Get_SecurityGrid_RecordListControl().FindChild(["Uid", "Value"], ["SecuFirm", SecuFirme], 10);
    if (!SecuFirmeCell.Exists)
        Log.Error("Le Titre No '" + SecuFirme + "' n'a pas été trouvé.");
    else {
        var maxNbOfParents = 10;
        var securityParentObject = SecuFirmeCell;
        for (var j = 1 ; j <= maxNbOfParents; j++){
            var securityParentObject = securityParentObject.Parent;
            if (securityParentObject.ClrClassName == "DataRecordPresenter")
                return securityParentObject.WPFControlOrdinalNo;
        }
        
        Log.Error("L'index de la ligne du titre '" + SecuFirme + "' n'a pas été trouvé, ceci est innatendu.");
    }
    
    return null;
}



/**
    Description : Trouver l'index de la ligne du titre (dans la grille principale du module Titres)
    Paramètre :
        SecuFirme : Numéro du Titre (Exemple : 987654)
*/
function GetSecurityRowIndex(SecuFirme)
{
    Search_Security(SecuFirme);
    var SecuFirmeCell = Get_SecurityGrid_RecordListControl().FindChild(["Uid", "Value"], ["SecuFirm", SecuFirme], 10);
    if (!SecuFirmeCell.Exists)
        Log.Message("Le titre '" + SecuFirme + "' n'existe pas.");
    return GetSecurityCellObjectRowIndex(SecuFirmeCell);
}


/**
    Description : Trouver l'index de la ligne du titre (dans la grille principale du module Titres)
    Paramètre :
        SecuFirme : Description du Titre (Exemple : 5N PLUS INC)
*/
function GetSecurityDescriptionRowIndex(SecurityDescription)
{
    Search_SecurityByDescription(SecurityDescription);
    var SecurityDescriptionCell = Get_SecurityGrid_RecordListControl().FindChild(["Uid", "Value"], ["Description", SecurityDescription], 10);
    if (!SecurityDescriptionCell.Exists)
        Log.Message("Le titre '" + SecurityDescription + "' n'existe pas.");
    return GetSecurityCellObjectRowIndex(SecurityDescriptionCell);
}



function Get_SecurityGrid_RecordListControl()
{
    Get_SecurityGrid().Refresh();
    Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).Refresh();
    return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
}



function GetSecurityCellObjectRowIndex(securityCellObject)
{
    if (securityCellObject.Exists){
        var maxNbOfParents = 10;
        var securityParentObject = securityCellObject;
        for (var j = 1 ; j <= maxNbOfParents; j++){
            var securityParentObject = securityParentObject.Parent;
            if (securityParentObject.ClrClassName == "DataRecordPresenter")
                return securityParentObject.WPFControlOrdinalNo;
        }
        
        Log.Error("L'index de la ligne du titre n'a pas été trouvé, ceci est innatendu.");
    }
    
    return null;
}



/**
    Ne fonctionne pas pour les sous-composants PartControl dont la propriété DataContext.PartType = NumericRange
    Paramètre
        conditionListBoxObject : le composant ListBox qui contient la condition, exemple : Get_WinAddSearchCriterion_LvwDefinition()
*/
function GetCriterionConditionDisplayedText_enCours(conditionListBoxObject)
{
    var arrayOfItemsDisplayedText = new Array();
    
    for (var ListBoxItemIndex = 1; ListBoxItemIndex <= conditionListBoxObject.ChildCount; ListBoxItemIndex++){
        var ListBoxItemObject = conditionListBoxObject.WPFObject("ListBoxItem", "", ListBoxItemIndex);
        var arrayOfItemsObjects = ListBoxItemObject.FindAllChildren(["ClrClassName", "VisibleOnScreen"], ["*", true]).toArray();
        var CharRepeaterIndex = 0;
        var PartControlIndex = 0;
        for (var i = arrayOfItemsObjects.length - 1; i >= 0; i--){
            if (arrayOfItemsObjects[i].Find("ClrClassName", "CharRepeater", 0).Exists)
                var itemDisplayedText = VarToStr(ListBoxItemObject.WPFObject("CharRepeater", "", ++CharRepeaterIndex).DataContext.Character.OleValue);
            else {
                if (ListBoxItemObject.WPFObject("PartControl", "", ++PartControlIndex).DataContext.PartType != "NumericRange")
                    var itemDisplayedText = VarToStr(ListBoxItemObject.WPFObject("PartControl", "", PartControlIndex).DataContext.SelectedValue.OleValue);
                else {
                    ListBoxItemObject.WPFObject("PartControl", "", PartControlIndex).Click();
                    ListBoxItemObject.WPFObject("PartControl", "", PartControlIndex).Keys("^a^c");
                    var itemDisplayedText = Sys.Clipboard + ListBoxItemObject.WPFObject("PartControl", "", PartControlIndex).DataContext.Unit.OleValue;
                }
                
                if (Trim(itemDisplayedText) == "")
                    itemDisplayedText = VarToStr(ListBoxItemObject.WPFObject("PartControl", "", ++PartControlIndex).DataContext.SelectedValue.OleValue);
            }
            
            if (Trim(itemDisplayedText) != "")
                arrayOfItemsDisplayedText.push(itemDisplayedText);
        }
    }
    
    return arrayOfItemsDisplayedText.join(" ");
}



/**
    Ne fonctionne pas pour les sous-composants PartControl dont la propriété DataContext.PartType = NumericRange
    Paramètre
        conditionListBoxObject : le composant ListBox qui contient la condition, exemple : Get_WinAddSearchCriterion_LvwDefinition()
*/
function GetCriterionConditionDisplayedText(conditionListBoxObject)
{
    var arrayOfItemsDisplayedText = new Array();
    
    for (var ListBoxItemIndex = 1; ListBoxItemIndex <= conditionListBoxObject.ChildCount; ListBoxItemIndex++){
        var ListBoxItemObject = conditionListBoxObject.WPFObject("ListBoxItem", "", ListBoxItemIndex);
        var arrayOfItemsObjects = ListBoxItemObject.FindAllChildren(["ClrClassName", "VisibleOnScreen"], ["*", true]).toArray();
        var CharRepeaterIndex = 0;
        var PartControlIndex = 0;
        for (var i = arrayOfItemsObjects.length - 1; i >= 0; i--){
            if (arrayOfItemsObjects[i].Find("ClrClassName", "CharRepeater", 0).Exists)
                var itemDisplayedText = VarToStr(ListBoxItemObject.WPFObject("CharRepeater", "", ++CharRepeaterIndex).DataContext.Character.OleValue);
            else {
                var itemDisplayedText = VarToStr(ListBoxItemObject.WPFObject("PartControl", "", ++PartControlIndex).DataContext.SelectedValue.OleValue);
                if (Trim(itemDisplayedText) == "")
                    itemDisplayedText = VarToStr(ListBoxItemObject.WPFObject("PartControl", "", ++PartControlIndex).DataContext.SelectedValue.OleValue);
            }
            
            if (Trim(itemDisplayedText) != "")
                arrayOfItemsDisplayedText.push(itemDisplayedText);
        }
    }
    
    return arrayOfItemsDisplayedText.join(" ");
}

