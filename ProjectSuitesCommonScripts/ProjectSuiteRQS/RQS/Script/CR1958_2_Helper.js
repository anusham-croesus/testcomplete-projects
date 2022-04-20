//USEUNIT Common_functions
//USEUNIT DBA


NameMapping.TimeOutWarning = false;
var CR1958_2_LOG_ATTRIBUTES_BOLD = Log.CreateNewAttributes();
CR1958_2_LOG_ATTRIBUTES_BOLD.Bold = true;

var CR1958_2_REPOSITORY_SQL = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SQL\\";
var CR1958_2_REPOSITORY_SSH = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SSH\\";
var CR1958_2_SSH_USERNAME   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_SSH_UserName", language + client);
var CR1958_2_SSH_FOLDERNAME = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_SSH_FolderName", language + client) + "_" + Sys.HostName;



function AddAndCheckNewColumns(gridRecordListControl, fromHeaderLabel)
{
    var Label_ColumnHeader_ManagementLevel              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ManagementLevel", language + client);
    var Label_ColumnHeader_ClientRelationshipName       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ClientRelationshipName", language + client);
    var Label_ColumnHeader_ClientRelationshipNumber     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ColumnHeader_ClientRelationshipNumber", language + client);
    var arrayOfNewColumnsHeaders = [Label_ColumnHeader_ManagementLevel, Label_ColumnHeader_ClientRelationshipName, Label_ColumnHeader_ClientRelationshipNumber];
    
    Log.Message("AddAndCheckNewColumns() : Right click on a column header --> Default Configuration ; Right click on a column header --> Add following columns : " + arrayOfNewColumnsHeaders, arrayOfNewColumnsHeaders.join("\r\n"), pmNormal, CR1958_2_LOG_ATTRIBUTES_BOLD);
    SetDefaultConfigurationForGrid(gridRecordListControl);
    
    var arrayOfSuccessfullyFoundColumnsHeaders = [];
    var arrayOfNotSuccessfullyFoundColumnsHeaders = []
    
    for (var k = 0; k < arrayOfNewColumnsHeaders.length; k++){
        var newColumnHeader = arrayOfNewColumnsHeaders[k];
        if (AddColumnInGrid(gridRecordListControl, newColumnHeader, fromHeaderLabel))
            arrayOfSuccessfullyFoundColumnsHeaders.push(newColumnHeader);
        else
            arrayOfNotSuccessfullyFoundColumnsHeaders.push(newColumnHeader);
    }
    
    if (arrayOfSuccessfullyFoundColumnsHeaders.length != 0)
        Log.Checkpoint("The following columns headers were successfully found in Add Column menu list : " + arrayOfSuccessfullyFoundColumnsHeaders, arrayOfSuccessfullyFoundColumnsHeaders);
    
    if (arrayOfNotSuccessfullyFoundColumnsHeaders.length != 0)
        Log.Error("The following columns headers were not successfully found in Add Column menu list  : " + arrayOfNotSuccessfullyFoundColumnsHeaders, arrayOfNotSuccessfullyFoundColumnsHeaders);
    
    //Valider que les colonnes ont été efectivement ajoutées
    CheckIfColumnsHeadersAreDisplayedInGrid(gridRecordListControl, arrayOfNewColumnsHeaders);
}



//Check if the displayed value does not match any of the unexpected values
function CheckNotEqualsToAnyArrayItem(displayedValue, arrayOfUnexpectedValues, valueDescription)
{
    if (GetVarType(arrayOfUnexpectedValues) != varArray && GetVarType(arrayOfUnexpectedValues) != varDispatch)
        arrayOfUnexpectedValues = [arrayOfUnexpectedValues];
    
    var checkResult = true;
    for (var i = 0; i < arrayOfUnexpectedValues.length; i++){
        var unexpectedValue = arrayOfUnexpectedValues[i];
        if (unexpectedValue == displayedValue){
            Log.Error("'" + unexpectedValue + "' is unexpected for " + valueDescription + ".");
            checkResult = false;
        }
        else if (aqString.ToLower(Trim(aqString.Replace(displayedValue, " " , ""))) == aqString.ToLower(Trim(aqString.Replace(unexpectedValue, " " , "")))){
            Log.CallStackSettings.EnableStackOnWarning = true;
            Log.Warning("'" + unexpectedValue + "' is unexpected, '" + displayedValue + "' was found for " + valueDescription + ".", "", pmNormal, null, Sys.Desktop.Picture());
            Log.CallStackSettings.EnableStackOnWarning = false;
            if (checkResult !== false)
                checkResult = undefined;
        }
    }
    
    return checkResult;
}



function OpenAndCheckRiskAndComplianceWindow()
{
    Get_Toolbar_BtnRQS().WaitProperty("IsEnabled", true, 30000);
    Get_Toolbar_BtnRQS().Click();
    
    var nbTries = 0; //Réessayer  au cas où le clic n'aurait pas réussi à faire afficher la fenêtre de RQS
    while (!Get_WinRQS().Exists && ++nbTries < 5)
        Get_Toolbar_BtnRQS().Click();
    
    Get_WinRQS().Parent.Maximize();
    
    var label_windowTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_WinRiskAndComplianceManager_Title", language + client);
    var label_TabAlerts = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_WinRiskAndComplianceManager_TabAlerts", language + client);
    var label_TabTransactionBlotter = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_WinRiskAndComplianceManager_TabTransactionBlotter", language + client);
    var label_TabSecurityAlerts = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_WinRiskAndComplianceManager_TabSecurityAlerts", language + client);
    var label_TabReports = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_WinRiskAndComplianceManager_TabReports", language + client);
    //var count_NumberOfMainTabs = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Count_WinRiskAndComplianceManager_NumberOfMainTabs", language + client);
    
    aqObject.CheckProperty(Get_WinRQS().Parent, "WndCaption", cmpEqual, label_windowTitle, true);
    aqObject.CheckProperty(Get_WinRQS_TabAlerts(), "WPFControlText", cmpEqual, label_TabAlerts, true);
    aqObject.CheckProperty(Get_WinRQS_TabTransactionBlotter(), "WPFControlText", cmpEqual, label_TabTransactionBlotter, true);
    aqObject.CheckProperty(Get_WinRQS_TabSecurityAlerts(), "WPFControlText", cmpEqual, label_TabSecurityAlerts, true);
    aqObject.CheckProperty(Get_WinRQS_TabReports(), "WPFControlText", cmpEqual, label_TabReports, true);
    aqObject.CheckProperty(Get_WinRQS_TabTransactionBlotter(), "IsSelected", cmpEqual, true, true);
    //Log.Message("Verify if the number of tabs is " + count_NumberOfMainTabs + ".");
    //aqObject.CompareProperty(Get_WinRQS_TabsControl().wTabCount, cmpEqual, count_NumberOfMainTabs, true, lmWarning);
}



function SetDefaultConfigurationForGrid(gridRecordListControl)
{
    gridRecordListControl.Refresh();
    ClickRightOnGridHeader(gridRecordListControl);
    Get_GridHeader_ContextualMenu_DefaultConfiguration().HoverMouse();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
}




function CheckUnexpectedLabelsInSubMenusContextMenu(arrayOfUnexpectedLabels)
{
    var arrayOfAllMenuItems = Get_SubMenus().FindChild(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["ContextMenu", true, 1], 10).FindAllChildren(["ClrClassName", "IsVisible"], ["MenuItem", true], 10).toArray();
    
    var arrayOfUnexpectedFieldsFound = [];
    for (var j = arrayOfAllMenuItems.length - 1; j >= 0; j--){
        var currentMenuItem = arrayOfAllMenuItems[j];
        if (false === CheckNotEqualsToAnyArrayItem(VarToStr(currentMenuItem.WPFControlText), arrayOfUnexpectedLabels, "Contextual Menu item"))
            arrayOfUnexpectedFieldsFound.push(VarToStr(currentMenuItem.WPFControlText));
        
        if (currentMenuItem.HasItems){
            currentMenuItem.HoverMouse();
            currentMenuItem.WaitProperty("IsSelected", true, 10000);
            Delay(1000);
            var arrayOfSubMenuItems = Get_CroesusApp().FindChildEx(["ClrClassName", "IsMouseOver", "WPFControlOrdinalNo"], ["PopupRoot", false, 1], 10, true, 10000).FindAllChildren(["ClrClassName", "IsVisible"], ["MenuItem", true], 10).toArray();
            
            for (var k = arrayOfSubMenuItems.length - 1; k >= 0; k--){
                var currentSubMenuItem = arrayOfSubMenuItems[k];
                var currentSubMenuItemLabel = VarToStr(currentSubMenuItem.WPFControlText);
                if (false === CheckNotEqualsToAnyArrayItem(currentSubMenuItemLabel, arrayOfUnexpectedLabels, "Contextual Menu item"))
                    arrayOfUnexpectedFieldsFound.push(currentSubMenuItemLabel);
                
                if (currentSubMenuItem.HasItems){
                    currentSubMenuItem.HoverMouse();
                    Delay(1000);
                    Log.Error("Submenu item '" + currentSubMenuItemLabel + "' item leads to a SubMenu. This script stops at depth level 2. Validate if script should be updated accordingly.");
                    currentMenuItem.HoverMouse();
                    currentMenuItem.WaitProperty("IsSelected", true, 10000);                
                }
            }
        }
    }
    
    if (arrayOfUnexpectedFieldsFound.length == 0)
        Log.Checkpoint("None of the following unexpected fields was found : " + arrayOfUnexpectedLabels, "None of the following unexpected fields was found : \r\n" + arrayOfUnexpectedLabels.join("\r\n"));
    else
        Log.Error("The following unexpected fields were found : " + arrayOfUnexpectedFieldsFound, "The following unexpected fields were found : \r\n" + arrayOfUnexpectedFieldsFound.join("\r\n") + "\r\n\r\nUnexpected fields are : \r\n" + arrayOfUnexpectedLabels.join("\r\n"));

}



function CheckIfColumnsHeadersAreDisplayedInGrid(gridRecordListControl, arrayOfExpectedHeadersLabels)
{
    if (GetVarType(arrayOfExpectedHeadersLabels) != varArray && GetVarType(arrayOfExpectedHeadersLabels) != varDispatch)
        arrayOfExpectedHeadersLabels = [arrayOfExpectedHeadersLabels];
    
    Log.LockEvents(3);
    
    var arrayOfSuccessfullyFoundHeadersLabels = [];
    
    //Lookup expected headers labels
    gridRecordListControl.Refresh();
    for (var k = arrayOfExpectedHeadersLabels.length - 1; k >= 0; k--){
        var expectedColumnHeader = GetGridDisplayedColumnHeader(gridRecordListControl, arrayOfExpectedHeadersLabels[k]);
        if (expectedColumnHeader.Exists)
            arrayOfSuccessfullyFoundHeadersLabels.push(VarToStr(arrayOfExpectedHeadersLabels.splice(k, 1)));
    }
    
    if (arrayOfExpectedHeadersLabels.length > 0){
        //VERIFY GRID MOBILE COLUMN HEADERS
        //Go to the most left of grid using Left key
        var maxKeyboardHits = 1000;
        var keyboardHits = 0;
        var staticMaxChecks = 6;
        var staticTrueChecks = 0;
        var isGridHeadersAreaStatic = false;
        var isMaxKeyboardHitsReached = false;
    
        var previousMostRightHeaderLabel = null;
        var previousMostRightHeaderLeft = -1;
        while (!isMaxKeyboardHitsReached && !isGridHeadersAreaStatic){
            gridRecordListControl.Keys("[Left]");
            keyboardHits++;
        
            gridRecordListControl.Refresh();
            var currentMostRightHeader = GetMostRightDisplayedGridMobileHeader(gridRecordListControl);
            if (!currentMostRightHeader.Exists)
                break;
        
            var currentMostRightHeaderLabel = VarToStr(currentMostRightHeader.WPFControlText);
            var currentMostRightHeaderLeft = currentMostRightHeader.Left;
            if (currentMostRightHeaderLeft == previousMostRightHeaderLeft && currentMostRightHeaderLabel == previousMostRightHeaderLabel)
                staticTrueChecks++;
        
            previousMostRightHeaderLabel = currentMostRightHeaderLabel;
            previousMostRightHeaderLeft = currentMostRightHeaderLeft;
        
            isGridHeadersAreaStatic = (staticTrueChecks >= staticMaxChecks);
            isMaxKeyboardHitsReached = (keyboardHits >= maxKeyboardHits);
        }
    
        if (isMaxKeyboardHitsReached)
            Log.Error("While moving to the grid most left, maximum number of Left keyboard hits was reached : " + keyboardHits);
    
        //Lookup expected headers labels
        gridRecordListControl.Refresh();
        for (var k = arrayOfExpectedHeadersLabels.length - 1; k >= 0; k--){
            var expectedColumnHeader = GetGridDisplayedColumnHeader(gridRecordListControl, arrayOfExpectedHeadersLabels[k]);
            if (expectedColumnHeader.Exists)
                arrayOfSuccessfullyFoundHeadersLabels.push(VarToStr(arrayOfExpectedHeadersLabels.splice(k, 1)));
        }
    
        //Navigate throughout whole grid using Right key
        var maxKeyboardHits = 2000;
        var keyboardHits = 0;
        var staticMaxChecks = 6;
        var staticTrueChecks = 0;
        var isGridHeadersAreaStatic = false;
        var isMaxKeyboardHitsReached = false;
    
        //Move to the next screen on right
        while (!isMaxKeyboardHitsReached && !isGridHeadersAreaStatic && arrayOfExpectedHeadersLabels.length > 0){
            var currentMostRightHeader = GetMostRightDisplayedGridMobileHeader(gridRecordListControl);
            var waitedToBeHiddenHeaderLabel = VarToStr(currentMostRightHeader.WPFControlText);
            var previousWaitedToBeHiddenHeaderLeft = -1;
            while (!isMaxKeyboardHitsReached && !isGridHeadersAreaStatic){
                gridRecordListControl.Keys("[Right]");
                keyboardHits++;
                gridRecordListControl.Refresh();
                var waitedToBeHiddenHeader = GetGridDisplayedColumnHeader(gridRecordListControl, waitedToBeHiddenHeaderLabel);
                if (!waitedToBeHiddenHeader.Exists)
                    break;
            
                var currentWaitedToBeHiddenHeaderLeft = waitedToBeHiddenHeader.Left;
                if (currentWaitedToBeHiddenHeaderLeft == previousWaitedToBeHiddenHeaderLeft)
                    staticTrueChecks++;
            
                previousWaitedToBeHiddenHeaderLeft = currentWaitedToBeHiddenHeaderLeft;
                isGridHeadersAreaStatic = (staticTrueChecks >= staticMaxChecks);
                isMaxKeyboardHitsReached = (keyboardHits >= maxKeyboardHits);
            }
        
            if (!isGridHeadersAreaStatic)
                gridRecordListControl.Keys("[Left]");
        
            if (isMaxKeyboardHitsReached)
                Log.Error("While moving to the grid most right, maximum number of Right keyboard hits was reached : " + keyboardHits);
        
            //Lookup expected headers labels
            gridRecordListControl.Refresh();
            for (var k = arrayOfExpectedHeadersLabels.length - 1; k >= 0; k--){
                var expectedColumnHeader = GetGridDisplayedColumnHeader(gridRecordListControl, arrayOfExpectedHeadersLabels[k]);
                if (expectedColumnHeader.Exists)
                    arrayOfSuccessfullyFoundHeadersLabels.push(VarToStr(arrayOfExpectedHeadersLabels.splice(k, 1)));
            }
        }
    }
    
    if (arrayOfExpectedHeadersLabels.length != 0)
        Log.Error("The following Columns Headers were not successfully found in the grid : " + arrayOfExpectedHeadersLabels, arrayOfExpectedHeadersLabels);
    
    if (arrayOfSuccessfullyFoundHeadersLabels.length != 0)
        Log.Checkpoint("The following Columns Headers were successfully found in the grid : " + arrayOfSuccessfullyFoundHeadersLabels, arrayOfSuccessfullyFoundHeadersLabels);
    
    return (arrayOfExpectedHeadersLabels.length == 0)
}




function CheckIfColumnsHeadersAreNotAvailableForGrid(gridRecordListControl, arrayOfUnexpectedHeadersLabels)
{
    if (GetVarType(arrayOfUnexpectedHeadersLabels) != varArray && GetVarType(arrayOfUnexpectedHeadersLabels) != varDispatch)
        arrayOfUnexpectedHeadersLabels = [arrayOfUnexpectedHeadersLabels];
    
    Log.LockEvents(3);
    var arrayOfUnexpectedFieldsFound = [];
    
    //VERIFY GRID FIXED COLUMN HEADERS
    gridRecordListControl.Refresh();
    var gridHeaderLabelArea = gridRecordListControl.FindChild(["ClrClassName", "IsHeaderRecord", "IsVisible"], ["DataRecordPresenter", true, true], 10).FindChild(["ClrClassName", "IsVisible"], ["HeaderLabelArea", true], 10);
    var arrayOfFixedColumnHeaders = gridHeaderLabelArea.FindAllChildren(["ClrClassName", "VisibleOnScreen", "IsFixed"], ["LabelPresenter", true, true], 10).toArray();
    for (var k = arrayOfFixedColumnHeaders.length - 1; k >= 0; k--)
        if (false === CheckNotEqualsToAnyArrayItem(VarToStr(arrayOfFixedColumnHeaders[k].WPFControlText), arrayOfUnexpectedHeadersLabels, "Grid column header"))
            arrayOfUnexpectedFieldsFound.push(VarToStr(arrayOfFixedColumnHeaders[k].WPFControlText));
    
    //VERIFY GRID MOBILE COLUMN HEADERS
    //Go to the most left of grid using Left key
    var maxKeyboardHits = 1000;
    var keyboardHits = 0;
    var staticMaxChecks = 6;
    var staticTrueChecks = 0;
    var isGridHeadersAreaStatic = false;
    var isMaxKeyboardHitsReached = false;
    
    var previousMostRightHeaderLabel = null;
    var previousMostRightHeaderLeft = -1;
    while (!isMaxKeyboardHitsReached && !isGridHeadersAreaStatic){
        gridRecordListControl.Keys("[Left]");
        keyboardHits++;
        
        gridRecordListControl.Refresh();
        var currentMostRightHeader = GetMostRightDisplayedGridMobileHeader(gridRecordListControl);
        if (!currentMostRightHeader.Exists)
            break;
        
        var currentMostRightHeaderLabel = VarToStr(currentMostRightHeader.WPFControlText);
        var currentMostRightHeaderLeft = currentMostRightHeader.Left;
        if (currentMostRightHeaderLeft == previousMostRightHeaderLeft && currentMostRightHeaderLabel == previousMostRightHeaderLabel)
            staticTrueChecks++;
        
        previousMostRightHeaderLabel = currentMostRightHeaderLabel;
        previousMostRightHeaderLeft = currentMostRightHeaderLeft;
        
        isGridHeadersAreaStatic = (staticTrueChecks >= staticMaxChecks);
        isMaxKeyboardHitsReached = (keyboardHits >= maxKeyboardHits);
    }
    
    if (isMaxKeyboardHitsReached)
        Log.Error("While moving to the grid most left, maximum number of Left keyboard hits was reached : " + keyboardHits);
    
    
    //Navigate throughout whole grid using Right key
    var maxKeyboardHits = 2000;
    var keyboardHits = 0;
    var staticMaxChecks = 6;
    var staticTrueChecks = 0;
    var isGridHeadersAreaStatic = false;
    var isMaxKeyboardHitsReached = false;
    
    //Check displayed grid column mobile headers labels
    gridRecordListControl.Refresh();
    var gridHeaderLabelArea = gridRecordListControl.FindChild(["ClrClassName", "IsHeaderRecord", "IsVisible"], ["DataRecordPresenter", true, true], 10).FindChild(["ClrClassName", "IsVisible"], ["HeaderLabelArea", true], 10);
    var arrayOfMobileColumnHeaders = gridHeaderLabelArea.FindAllChildren(["ClrClassName", "VisibleOnScreen", "IsFixed"], ["LabelPresenter", true, false], 10).toArray();
    
    if (arrayOfMobileColumnHeaders.length == 0)
        Log.Warning("No mobile column header label found in the grid Headers.", "", pmHigher, null, Sys.Desktop.Picture());
    
    for (var k = arrayOfMobileColumnHeaders.length - 1; k >= 0; k--)
        if (false === CheckNotEqualsToAnyArrayItem(VarToStr(arrayOfMobileColumnHeaders[k].WPFControlText), arrayOfUnexpectedHeadersLabels, "Grid column header"))
            arrayOfUnexpectedFieldsFound.push(VarToStr(arrayOfMobileColumnHeaders[k].WPFControlText));
    
    //Move to the next screen on right
    while (!isMaxKeyboardHitsReached && !isGridHeadersAreaStatic){
        var currentMostRightHeader = GetMostRightDisplayedGridMobileHeader(gridRecordListControl);
        var waitedToBeHiddenHeaderLabel = VarToStr(currentMostRightHeader.WPFControlText);
        var previousWaitedToBeHiddenHeaderLeft = -1;
        while (!isMaxKeyboardHitsReached && !isGridHeadersAreaStatic){
            gridRecordListControl.Keys("[Right]");
            keyboardHits++;
            gridRecordListControl.Refresh();
            var waitedToBeHiddenHeader = GetGridDisplayedColumnHeader(gridRecordListControl, waitedToBeHiddenHeaderLabel);
            if (!waitedToBeHiddenHeader.Exists)
                break;
            
            var currentWaitedToBeHiddenHeaderLeft = waitedToBeHiddenHeader.Left;
            if (currentWaitedToBeHiddenHeaderLeft == previousWaitedToBeHiddenHeaderLeft)
                staticTrueChecks++;
            
            previousWaitedToBeHiddenHeaderLeft = currentWaitedToBeHiddenHeaderLeft;
            isGridHeadersAreaStatic = (staticTrueChecks >= staticMaxChecks);
            isMaxKeyboardHitsReached = (keyboardHits >= maxKeyboardHits);
        }
        
        if (!isGridHeadersAreaStatic)
            gridRecordListControl.Keys("[Left]");
        
        if (isMaxKeyboardHitsReached)
            Log.Error("While moving to the grid most right, maximum number of Right keyboard hits was reached : " + keyboardHits);
    
        //Check displayed grid mobile columns headers labels
        gridRecordListControl.Refresh();
        var gridHeaderLabelArea = gridRecordListControl.FindChild(["ClrClassName", "IsHeaderRecord", "IsVisible"], ["DataRecordPresenter", true, true], 10).FindChild(["ClrClassName", "IsVisible"], ["HeaderLabelArea", true], 10);
        var arrayOfMobileColumnHeaders = gridHeaderLabelArea.FindAllChildren(["ClrClassName", "VisibleOnScreen", "IsFixed"], ["LabelPresenter", true, false], 10).toArray();
        
        if (arrayOfMobileColumnHeaders.length == 0)
            Log.Warning("No mobile column header label found in the grid Headers.", "", pmHigher, null, Sys.Desktop.Picture());
    
        for (var k = arrayOfMobileColumnHeaders.length - 1; k >= 0; k--){
            if (!isGridHeadersAreaStatic || (isGridHeadersAreaStatic && arrayOfMobileColumnHeaders[k].Left > currentWaitedToBeHiddenHeaderLeft)){
                if (false === CheckNotEqualsToAnyArrayItem(VarToStr(arrayOfMobileColumnHeaders[k].WPFControlText), arrayOfUnexpectedHeadersLabels, "Grid column header"))
                    arrayOfUnexpectedFieldsFound.push(VarToStr(arrayOfMobileColumnHeaders[k].WPFControlText));
            }
        }
    }
    
    
    //SUBMENUS
    ClickRightOnGridHeader(gridRecordListControl);
    if (!Get_GridHeader_ContextualMenu_AddColumn().WaitProperty("IsEnabled", true, 5000))
        Log.Message("The contextual menu Add Column item was disabled.", "", pmNormal, null, Sys.Desktop.Picture());
    else {
        Get_GridHeader_ContextualMenu_AddColumn().HoverMouse();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "IsMouseOver", "WPFControlOrdinalNo"], ["PopupRoot", false, 1], 2000);
        Delay(1000);
        var arrayOfSubMenuItems = Get_CroesusApp().FindChild(["ClrClassName", "IsMouseOver", "WPFControlOrdinalNo"], ["PopupRoot", false, 1], 10).FindAllChildren(["ClrClassName", "IsVisible"], ["MenuItem", true], 10).toArray();
        if (arrayOfSubMenuItems.length == 0)
            Log.Warning("No column header label found in the Add Columns submenus list.", "", pmHigher, null, Sys.Desktop.Picture());
        
        for (var k = arrayOfSubMenuItems.length - 1; k >= 0; k--){
            var subMenuItem = arrayOfSubMenuItems[k];
            var subMenuItemLabel = VarToStr(subMenuItem.FindChild(["ClrClassName", "IsVisible"], ["TextBlock", true], 10).WPFControlText);
            if (false === CheckNotEqualsToAnyArrayItem(subMenuItemLabel, arrayOfUnexpectedHeadersLabels, "Add Column submenu item"))
                arrayOfUnexpectedFieldsFound.push(subMenuItemLabel);
            
            if (subMenuItem.HasItems){
                subMenuItem.HoverMouse();
                subMenuItem.WaitProperty("IsSelected", true, 5000);
                Delay(1000);
                Log.Error("Submenu item '" + subMenuItemLabel + "' item leads to a SubMenu. This script stops at depth level 2. Please, validate if script should be updated accordingly.");            
            }
        }
    }
    
    if (arrayOfUnexpectedFieldsFound.length == 0)
        Log.Checkpoint("None of the following unexpected columns headers was found : " + arrayOfUnexpectedHeadersLabels, "None of the following unexpected columns headers was found : \r\n" + arrayOfUnexpectedHeadersLabels.join("\r\n"));
    else
        Log.Error("The following unexpected columns headers were found : " + arrayOfUnexpectedFieldsFound, "The following unexpected columns headers were found : \r\n" + arrayOfUnexpectedFieldsFound.join("\r\n") + "\r\n\r\nUnexpected columns headers are : \r\n" + arrayOfUnexpectedHeadersLabels.join("\r\n"));

}



function ClickRightOnGridHeader(gridRecordListControl, fromHeaderLabel)
{
    gridRecordListControl.Refresh();
    
    var aColumnHeader = Utils.CreateStubObject();
    if (fromHeaderLabel != undefined)
        aColumnHeader = GetGridDisplayedColumnHeader(gridRecordListControl, fromHeaderLabel)
    
    if (!aColumnHeader.Exists){
        var gridHeaderLabelArea = gridRecordListControl.FindChild(["ClrClassName", "IsHeaderRecord", "IsVisible"], ["DataRecordPresenter", true, true], 10).FindChild(["ClrClassName", "IsVisible"], ["HeaderLabelArea", true], 10);
        var allDisplayedColumnsHeaders = gridHeaderLabelArea.FindAllChildren(["ClrClassName", "VisibleOnScreen"], ["LabelPresenter", true], 10).toArray();
        aColumnHeader = ShuffleArray(allDisplayedColumnsHeaders)[0];
    }
    
    var numTry = 0;
    do {
        aColumnHeader.ClickR();
    } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 2000, 2500))
}



function GetMostRightDisplayedGridMobileHeader(gridRecordListControl)
{   
    gridRecordListControl.Refresh();
    var gridHeaderLabelArea = gridRecordListControl.FindChild(["ClrClassName", "IsHeaderRecord", "IsVisible"], ["DataRecordPresenter", true, true], 10).FindChild(["ClrClassName", "IsVisible"], ["HeaderLabelArea", true], 10);
    var arrayOfColumnHeaders = gridHeaderLabelArea.FindAllChildren(["ClrClassName", "VisibleOnScreen", "IsFixed"], ["LabelPresenter", true, false], 10).toArray();
    if (arrayOfColumnHeaders.length == 0){
        Log.Warning("GetMostRightDisplayedGridMobileHeader(gridRecordListControl) : no column header found.", "", pmHigher, null, Sys.Desktop.Picture());
        return Utils.CreateStubObject();
    }
    
    var mostRightDisplayedGridHeader = arrayOfColumnHeaders[0];
    for (var i = 0; i < arrayOfColumnHeaders.length; i++)
        if (arrayOfColumnHeaders[i].Left > mostRightDisplayedGridHeader.Left)
            mostRightDisplayedGridHeader = arrayOfColumnHeaders[i];
    
    return mostRightDisplayedGridHeader;
}



function AddColumnInGrid(gridRecordListControl, columnHeaderLabel, fromHeaderLabel, logCheckPointIfErrorIfHeaderLabelFound)
{
    ClickRightOnGridHeader(gridRecordListControl, fromHeaderLabel);
    Get_GridHeader_ContextualMenu_AddColumn().HoverMouse();
    WaitObject(Get_CroesusApp(), ["ClrClassName", "IsMouseOver", "WPFControlOrdinalNo"], ["PopupRoot", false, 1], 2000);
    Delay(1000);
    var arrayOfSubMenuItems = Get_CroesusApp().FindChild(["ClrClassName", "IsMouseOver", "WPFControlOrdinalNo"], ["PopupRoot", false, 1], 10).FindAllChildren(["ClrClassName", "IsVisible"], ["MenuItem", true], 10).toArray();
    
    var isColumnHeaderFound = false;
    for (var j = arrayOfSubMenuItems.length - 1; j >= 0; j--){
        var subMenuItem = arrayOfSubMenuItems[j];
        if (columnHeaderLabel == VarToStr(subMenuItem.FindChild(["ClrClassName", "IsVisible"], ["TextBlock", true], 10).WPFControlText)){                  
            isColumnHeaderFound = true;
            subMenuItem.HoverMouse();
            subMenuItem.Click();
            break;
        }
    }
    
    if (logCheckPointIfErrorIfHeaderLabelFound != undefined && logCheckPointIfErrorIfHeaderLabelFound == true){
        if (isColumnHeaderFound)
            Log.Checkpoint("Column '" + columnHeaderLabel + "' was available in the Add Column submenu list.");  
        else
            Log.Error("Column '" + columnHeaderLabel + "' was not available in the Add Column submenu list.");
    }
    
    return isColumnHeaderFound;
}



function DisplayRiskAndComplianceReportType(reportType)
{
    Log.Message("Ouvrir la fenêtre RCM --> Onglet Reports --> Reports Type choisir '" + reportType + "' --> Display Report.");
    Get_Toolbar_BtnRQS().Click();
    var nbOfTries = 0;
    do {
        Get_WinRQS_TabReports().Click();
    } while (++nbOfTries < 3 && !Get_WinRQS_TabReports().WaitProperty("IsSelected", true, 40000))
    
    SelectComboBoxItem(Get_WinRQS_TabReports_CmbReportType(), reportType);
    
    var nbOfTries = 0;
    do {
        Delay(1000);
        Get_WinRQS_TabReports_BtnDisplayReport().Click();
        
        SetAutoTimeOut(3000);
        if (Get_DlgWarning().Exists){
            if (!Get_DlgWarning_LblTheFilterYouHaveAppliedContainsNoData().Exists)
                Log.Error("There was an unexpected Warning dialog box.");
            
            Get_DlgWarning_BtnOK().Click();
        }
        RestoreAutoTimeOut();
        
        WaitObject(Get_WinRQS(), ["Uid", "IsVisible"], ["ReportsControl_2034", true]);
        Get_WinRQS_TabReports_ReportsControl().Refresh();
        var gridRecordListControl = Get_WinRQS_TabReports_ReportsControl().FindChildEx(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["RecordListControl", 1, true], 10, true, 10000);
    } while (++nbOfTries < 5 && !gridRecordListControl.Exists)
    
}


function GetGridVisibleRowsCount(gridRecordListControl)
{
    gridRecordListControl.Refresh();
    return gridRecordListControl.FindAllChildren(["ClrClassName", "IsVisible", "IsHeaderRecord"], ["DataRecordPresenter", true, false], 10).toArray().length;
}





//Testée pour filterOperator = "equal to" ou "égal(e) à"
function ApplyFilterForRiskAndComplianceReportType(reportType, filterField, filterOperator, filterValue)
{   
    DisplayRiskAndComplianceReportType(reportType);
    var actualNumberOfPriorDisplayedFilters = Get_WinRQS_TabReports_ScrollViewer().FindAllChildren(["ClrClassName", "IsVisible"], ["ToggleButton", true], 10).toArray().length;
    Get_WinRQS_TabReports_BtnFilter().Click();
    var nbTries = 0; //Réessayer  au cas où le clic n'aurait pas réussi
    while (!Get_SubMenus().Exists && ++nbTries < 5)
        Get_WinRQS_TabReports_BtnFilter().Click();
    
    ApplyFilter(filterField, filterOperator, filterValue);
    CompareProperty(Get_WinRQS_TabReports_ScrollViewer().FindAllChildren(["ClrClassName", "IsVisible"], ["ToggleButton", true], 10).toArray().length, cmpEqual, actualNumberOfPriorDisplayedFilters + 1, true, lmError);
}



//Testée pour filterOperator = "equal to" ou "égal(e) à"
function ApplyFilter(filterField, filterOperator, filterValue)
{
    Log.Message("Apply Filter : " + filterField + " '" + filterOperator + "' " + filterValue);
    Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", filterField], 10).Click();
    CompareProperty(Get_WinCreateFilter_TxtField().WPFControlText, cmpEqual, filterField, true, lmError);
    SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), filterOperator);
    Get_WinCreateFilter_TxtValue().Clear();
    Get_WinCreateFilter_TxtValue().Keys(filterValue);
    Get_WinCreateFilter_BtnApply().Click();
    
    var previousAutoTimeOut = Options.Run.Timeout;
    SetAutoTimeOut();
    if (Get_DlgWarning().Exists){
        if (!Get_DlgWarning_LblTheFilterYouHaveAppliedContainsNoData().Exists)
            Log.Error("There was an unexpected Warning dialog box.");
        
        Get_DlgWarning_BtnOK().Click();
    }
    SetAutoTimeOut(previousAutoTimeOut);
}



function ShuffleArray(varArray)
{
    var i = 0, j = 0, temp = null;

    for (i = varArray.length - 1; i > 0; i -= 1){
        j = Math.floor(Math.random() * (i + 1));
        temp = varArray[i];
        varArray[i] = varArray[j];
        varArray[j] = temp;
    }
    
    return varArray;
}



function CloseCroesus()
{
    Close_Croesus_MenuBar();
    SetAutoTimeOut();
    if (Get_DlgConfirmation().Exists)
        Get_DlgConfirmation_BtnYes().Click();
    RestoreAutoTimeOut();
}



function GetGridDisplayedColumnHeader(gridRecordListControl, label)
{
    return gridRecordListControl.FindChild(["ClrClassName", "IsHeaderRecord", "IsVisible"], ["DataRecordPresenter", true, true], 10).FindChild(["ClrClassName", "IsVisible"], ["HeaderLabelArea", true], 10).FindChild(["ClrClassName", "VisibleOnScreen", "WPFControlText"], ["LabelPresenter", true, label], 10);
}
