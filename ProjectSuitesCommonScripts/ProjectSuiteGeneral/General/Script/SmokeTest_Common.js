//USEUNIT Common_functions
//USEUNIT DBA

////Temporaire pour versions Co (scripté sur : ref90-07-23--V9-Be_1-co6x), pour ne pas impacter le projet AideEnLigne
function Get_HelpWindow_Title(vServer){return Sys.Browser("iexplore").Page(vServer + "crweb/help/croesus*").Panel("body").Panel("contentBody").Panel("contentBodyInner").Frame("topic").Panel(0).Panel(0).Table(0).Cell(0, 1).TextNode(0)}


function DragToModelsByDragAndDrop(fromObject)
{
    Drag(fromObject, Get_ModulesBar_BtnModels());
}



function DragToModelsByShortKeys()
{
    Sys.Keys("^!2");
}



function DragToModelsByMenuBar()
{
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Models().Click();
    
    if (Get_MenuBar_Modules_Models_DragSelection().IsEnabled)
        Get_MenuBar_Modules_Models_DragSelection().Click();
    else {
        Log.Error("Drag Selection to Models menuitem is not enabled.");
        Sys.Keys('[Esc][Esc]');
    }
}



function DragToRelationshipsByDragAndDrop(fromObject)
{
    Drag(fromObject, Get_ModulesBar_BtnRelationships());
}



function DragToRelationshipsByShortKeys()
{
    Sys.Keys("^!3");
}



function DragToRelationshipsByMenuBar()
{
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Relationships().Click();
    
    if (Get_MenuBar_Modules_Relationships_DragSelection().IsEnabled)
        Get_MenuBar_Modules_Relationships_DragSelection().Click();
    else {
        Log.Error("Drag Selection to Relationships menuitem is not enabled.");
        Sys.Keys('[Esc][Esc]');
    }
}



function DragToClientsByDragAndDrop(fromObject)
{
    Drag(fromObject, Get_ModulesBar_BtnClients());
}



function DragToClientsByShortKeys()
{
    Sys.Keys("^!4");
}



function DragToClientsByMenuBar()
{
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Clients().Click();
    
    if (Get_MenuBar_Modules_Clients_DragSelection().IsEnabled)
        Get_MenuBar_Modules_Clients_DragSelection().Click();
    else {
        Log.Error("Drag Selection to Clients menuitem is not enabled.");
        Sys.Keys('[Esc][Esc]');
    }
}



function DragToAccountsByDragAndDrop(fromObject)
{
    Drag(fromObject, Get_ModulesBar_BtnAccounts());
}



function DragToAccountsByShortKeys()
{
    Sys.Keys("^!5");
}



function DragToAccountsByMenuBar()
{
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Accounts().Click();
    
    if (Get_MenuBar_Modules_Accounts_DragSelection().IsEnabled)
        Get_MenuBar_Modules_Accounts_DragSelection().Click();
    else {
        Log.Error("Drag Selection to Accounts menuitem is not enabled.");
        Sys.Keys('[Esc][Esc]');
    }
}



function DragToPortfolioByDragAndDrop(fromObject)
{
    Drag(fromObject, Get_ModulesBar_BtnPortfolio());
}



function DragToPortfolioByShortKeys()
{
    Sys.Keys("^!6");
}



function DragToPortfolioByMenuBar()
{
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    
    if (Get_MenuBar_Modules_Portfolio_DragSelection().IsEnabled)
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    else {
        Log.Error("Drag Selection to Portfolio menuitem is not enabled.");
        Sys.Keys('[Esc][Esc]');
    }
}



function DragToTransactionsByDragAndDrop(fromObject)
{
    Drag(fromObject, Get_ModulesBar_BtnTransactions());
}



function DragToTransactionsByShortKeys()
{
    Sys.Keys("^!7");
}



function DragToTransactionsByMenuBar()
{
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
    
    if (Get_MenuBar_Modules_Transactions_DragSelection().IsEnabled)
        Get_MenuBar_Modules_Transactions_DragSelection().Click();
    else {
        Log.Error("Drag Selection to Transactions menuitem is not enabled.");
        Sys.Keys('[Esc][Esc]');
    }
}



function DragToSecuritiesByDragAndDrop(fromObject)
{
    Drag(fromObject, Get_ModulesBar_BtnSecurities());
}



function DragToSecuritiesByShortKeys()
{
    Sys.Keys("^!8");
}



function DragToSecuritiesByMenuBar()
{
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Securities().Click();
    
    if (Get_MenuBar_Modules_Securities_DragSelection().IsEnabled)
        Get_MenuBar_Modules_Securities_DragSelection().Click();
    else {
        Log.Error("Drag Selection to Securities menuitem is not enabled.");
        Sys.Keys('[Esc][Esc]');
    }
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


function GetRandomNbOfItemsInArray(varArray, maxNbOfItemsToBeSelected, minNbOfItemsToBeSelected)
{
    if (maxNbOfItemsToBeSelected == undefined)
        maxNbOfItemsToBeSelected = varArray.length;
        
    if (minNbOfItemsToBeSelected == undefined)
        minNbOfItemsToBeSelected = 2;
    
    var arrayOfRandomItems = varArray;
        
    if (varArray.length > 2){
        varArray = ShuffleArray(varArray);
        var nbOfRandomItems = 0;
        while (nbOfRandomItems < minNbOfItemsToBeSelected)
            nbOfRandomItems = Math.round(Math.random()*maxNbOfItemsToBeSelected);
        arrayOfRandomItems = varArray.slice(0, nbOfRandomItems);
    }
    
    return arrayOfRandomItems;
}



function DoubleCheckArrayDiff(actualArray, expectedArray)
{
    CheckEquals(actualArray.length, expectedArray.length, "The number of items in the array");
    
    var arrayOfExpectedButNotActual = new Array();
    for (var i = 0; i < expectedArray.length; i ++)
        if (GetIndexOfItemInArray(actualArray, expectedArray[i]) == -1)
            arrayOfExpectedButNotActual.push(expectedArray[i]);
    
    if (arrayOfExpectedButNotActual.length == 0)
        Log.Checkpoint("Tous les éléments attendus sont affichés.");
    else
        Log.Error("Les éléments suivants étaient attendus mais ne sont pas affichés.", arrayOfExpectedButNotActual);
    
    var arrayOfActualButNotExpected = new Array();
    for (var i = 0; i < actualArray.length; i ++)
        if (GetIndexOfItemInArray(expectedArray, actualArray[i]) == -1)
            arrayOfActualButNotExpected.push(actualArray[i]);
        
    if (arrayOfActualButNotExpected.length == 0)
        Log.Checkpoint("Tous les éléments affichés sont attendus.");
    else
        Log.Error("Les élements suivants n'étaient pas attendus mais sont affichés.", arrayOfActualButNotExpected);

    return ((arrayOfExpectedButNotActual.length == 0 && arrayOfActualButNotExpected.length == 0));
}


function RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid()
{
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    //S'assurer qu'il n'y a plus de filtre
    if (Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists)
        return Log.Error("Il y a toujours au moins un filtre après réaffichage.");
}



function ExportGridContentToFile(exportFilePath, timeOut)
{
    Log.Message("Export grid content to file : " + exportFilePath);
    
    if (timeOut == undefined)
        timeOut = 1000000;
    
    //Supprimer le fichier s'il existe
    if (aqFile.Exists(exportFilePath) && !aqFileSystem.DeleteFile(exportFilePath)){
        Log.Error("Unable to delete file : " + exportFilePath);
        return false
    }
    
    Get_MenuBar_Edit().Click();
    Get_MenuBar_Edit_ExportToFile().Click();
    Get_DlgSelectTheFileName().SetFocus();
    Get_DlgSelectTheFileName_CmbFileName_TxtFileName().SetText(exportFilePath);
    Get_DlgSelectTheFileName_BtnSave().Click();
    
    if (Get_DlgProgressCroesus().Exists){
        if (!WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ProgressCroesusWindow_b5e1", timeOut)){
            Log.Error("File export not completed until timeout : " + timeOut + " milliseconds");
            Get_DlgProgressCroesus().Close();
            return false;
        }
    }
    
    return aqFile.Exists(exportFilePath);
}



//Se trouve aussi dans DataHub, voir à mettre dans Common_functions...
function GetDataFromCSVFile(CSVFilePath, arrayOfColumnsNames, delimiterChar, encoding)
{
    if (GetVarType(arrayOfColumnsNames) != varArray && GetVarType(arrayOfColumnsNames) != varDispatch)
        arrayOfColumnsNames = new Array(arrayOfColumnsNames);
        
    var progressDisplayMsgStarting = "GetDataFromCSVFile (started at " + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%H:%M") + ") : ";
    
    var CSVFileName = aqFileSystem.GetFileName(CSVFilePath);
    var ANSIFileName = CSVFileName;
    var ANSIFilePath = CSVFilePath;
    
    if (encoding == undefined)
        var fileObj = aqFile.OpenTextFile(CSVFilePath, aqFile.faRead, aqFile.ctANSI);
    else
        var fileObj = aqFile.OpenTextFile(CSVFilePath, aqFile.faRead, encoding);
    var linesCountInCSVFile = fileObj.LinesCount; //Fonctionne seulement avec les retours de ligne de Windows (\r\n)
    fileObj.Close();
    
    
    if (encoding != undefined && encoding != aqFile.ctANSI){
        ANSIFileName = "ANSIFile.csv";
        ANSIFilePath = CSVFilePath.replace(CSVFileName, ANSIFileName);
        var CSVFileContent = aqFile.ReadWholeTextFile(CSVFilePath, encoding);
        if (!aqFile.WriteToTextFile(ANSIFilePath, CSVFileContent, aqFile.ctANSI, true))
            Log.Error("Failed to create file and write text to it : " + ANSIFilePath);
    }
    
    if (delimiterChar == undefined || delimiterChar.toUpperCase() == "TAB" || delimiterChar == "\t")
        var CSVFormat = "Format=TabDelimited";
    else if (delimiterChar.toUpperCase() == "CSV" || delimiterChar == ",")
        var CSVFormat = "Format=CSVDelimited";
    else
        var CSVFormat = "Format=Delimited(" + delimiterChar + ")";
    
    var schemaFilePath = CSVFilePath.replace(CSVFileName, "schema.ini");
    var schemaFilelines = "[" + ANSIFileName + "]";
    schemaFilelines += "\r\n" + CSVFormat;
    schemaFilelines += "\r\n" + "CharacterSet=ANSI";
    schemaFilelines += "\r\n" + "ColNameHeader=True";
    if (!aqFile.WriteToTextFile(schemaFilePath, schemaFilelines, aqFile.ctANSI, true))
        Log.Error("Failed to create file and write text to it : " + schemaFilePath);
    
    var Driver = DDT.CSVDriver(ANSIFilePath);
    var arrayOfData = new Array();
    var j = 0;
    var progressTotalCount = linesCountInCSVFile;
    var progressPercent;
    var progressDisplayStep = 1;
    var progressDisplayPercent = 0;
    while (! Driver.EOF()){
        var arrayOfCurrentValues = new Array();
        for (var i = 0; i < arrayOfColumnsNames.length; i++)
            arrayOfCurrentValues.push(aqString.Unquote(VarToStr(Driver.Value(aqString.Unquote(arrayOfColumnsNames[i]).replace(".", "#")))));
            
        arrayOfData.push(arrayOfCurrentValues);
        Driver.Next();
        
        j++;
        progressPercent = Math.round(100*j/progressTotalCount);
        if (progressPercent >= progressDisplayPercent){
            progressDisplayPercent = progressPercent + progressDisplayStep;
            Indicator.PushText(progressDisplayMsgStarting + progressPercent + "% completed.");
        }
    }
    Indicator.Clear();
    
    DDT.CloseDriver(Driver.Name);
    aqFileSystem.DeleteFile(schemaFilePath);
    if (encoding != undefined && encoding != aqFile.ctANSI)
        aqFileSystem.DeleteFile(ANSIFilePath);
    
    return arrayOfData;
}


/*
function GetDataFromCSVFile(CSVFilePath, arrayOfColumnsNames, delimiterChar, encoding)
{
    if (GetVarType(arrayOfColumnsNames) != varArray && GetVarType(arrayOfColumnsNames) != varDispatch)
        arrayOfColumnsNames = new Array(arrayOfColumnsNames);
    
    var CSVFileName = aqFileSystem.GetFileName(CSVFilePath);
    var ANSIFileName = CSVFileName;
    var ANSIFilePath = CSVFilePath;
    
    if (encoding != undefined && encoding != aqFile.ctANSI){
        ANSIFileName = "ANSIFile.csv";
        ANSIFilePath = CSVFilePath.replace(CSVFileName, ANSIFileName);
        var CSVFileContent = aqFile.ReadWholeTextFile(CSVFilePath, encoding);
        if (!aqFile.WriteToTextFile(ANSIFilePath, CSVFileContent, aqFile.ctANSI, true))
            Log.Error("Failed to create file and write text to it : " + ANSIFilePath);
    }
    
    if (delimiterChar == undefined || delimiterChar.toUpperCase() == "TAB" || delimiterChar == "\t")
        var CSVFormat = "Format=TabDelimited";
    else if (delimiterChar.toUpperCase() == "CSV" || delimiterChar == ",")
        var CSVFormat = "Format=CSVDelimited";
    else
        var CSVFormat = "Format=Delimited(" + delimiterChar + ")";
    
    var schemaFilePath = CSVFilePath.replace(CSVFileName, "schema.ini");
    var schemaFilelines = "[" + ANSIFileName + "]";
    schemaFilelines += "\r\n" + CSVFormat;
    schemaFilelines += "\r\n" + "CharacterSet=ANSI";
    schemaFilelines += "\r\n" + "ColNameHeader=True";
    if (!aqFile.WriteToTextFile(schemaFilePath, schemaFilelines, aqFile.ctANSI, true))
        Log.Error("Failed to create file and write text to it : " + schemaFilePath);
    
    var Driver = DDT.CSVDriver(ANSIFilePath);
    var arrayOfData = new Array();
    while (! Driver.EOF()){
        var arrayOfCurrentValues = new Array();
        for (var i = 0; i < arrayOfColumnsNames.length; i++)
            arrayOfCurrentValues.push(aqString.Unquote(VarToStr(Driver.Value(aqString.Unquote(arrayOfColumnsNames[i]).replace(".", "#")))));
            
        arrayOfData.push(arrayOfCurrentValues);
        Driver.Next();
    }
    
    DDT.CloseDriver(Driver.Name);
    aqFileSystem.DeleteFile(schemaFilePath);
    if (encoding != undefined && encoding != aqFile.ctANSI)
        aqFileSystem.DeleteFile(ANSIFilePath);
    
    return arrayOfData;
}
*/


function ClickRightAndExpectSubmenus(componentObject, maxNbOfTries)
{
    if (maxNbOfTries == undefined)
        maxNbOfTries = 5;
        
    var nbOfTries = 0;
    componentObject.ClickR();
    Delay(500);
    do {
        componentObject.ClickR();
    } while (!Get_SubMenus().Exists && (++nbOfTries < maxNbOfTries))
}



function SetArrayItemsToString(arr)
{
    var resultArray = new Array();
    for (var i = 0; i < arr.length; i ++)
        resultArray.push(arr[i].toString());
    
    return resultArray;
}


function AddColumnsToGrid(columnHeader, arrayOfColumnsNames)
{
    if (GetVarType(arrayOfColumnsNames) != varArray && GetVarType(arrayOfColumnsNames) != varDispatch)
        arrayOfColumnsNames = new Array(arrayOfColumnsNames);
        
    Log.Message("Add the following columns to grid : " + arrayOfColumnsNames, arrayOfColumnsNames);
    
    //Rétablir la configuration par défaut
    ClickRightAndExpectSubmenus(columnHeader);
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    //Ajouter les colonnes requises
    var j = 0;
    while (j < arrayOfColumnsNames.length){
        ClickRightAndExpectSubmenus(columnHeader);
        
        if (!Get_GridHeader_ContextualMenu().Exists)
            continue;
        
        if (!Get_GridHeader_ContextualMenu_AddColumn().IsEnabled)
            break;
        
        Get_GridHeader_ContextualMenu_AddColumn().Click();
        var columnMenuItem = Get_GridHeader_ContextualMenu_AddColumnOrInsertField_ColumnOrFieldName(arrayOfColumnsNames[j], arrayOfColumnsNames[j]);
        if (columnMenuItem.Exists)
            columnMenuItem.Click();
        else
            Log.Message("Column name '" + arrayOfColumnsNames[j] + "' not found in the Contextual Menu.");
        
        j++;
    }
    
    Sys.Keys('[Esc][Esc]');
}



function ClickAndExpectSubmenus(componentObject, maxNbOfTries)
{
    if (maxNbOfTries == undefined)
        maxNbOfTries = 5;
        
    var nbOfTries = 0;
    do {
        componentObject.Click();
    } while (!Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().Exists && (++nbOfTries < maxNbOfTries))
}



function CheckIfSecuritiesOrdersFilterIsValid(filterName, filterNameValue, filterAccess, conditionField, conditionOperator, conditionValue, valueType)
{
    SetAutoTimeOut();
    Log.Message("Check if filter '" + filterName + "' is valid.");
    var isNoIssueFound = true;
    
    ClickAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders());
    Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_ManageFilters() .Click();
    
    var nbOfFilters = Get_WinQuickFiltersManager_LstFilters().ChildCount;
    Get_WinQuickFiltersManager_LstFilters().Click();
    for(var i = 1; i <= nbOfFilters; i++){
        var filterListBoxItem = Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", filterName], 10);
        if (filterListBoxItem.Exists)
            break;
        Get_WinQuickFiltersManager_LstFilters().Keys("[Down]");
    }
    
    if (!filterListBoxItem.Exists){
        Log.Error("Filter '" + filterName + "' not found.");
        isNoIssueFound = false;
    }
    else {
        filterListBoxItem.Click();
        
        if (Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay().Exists)
            Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay().Click();
        else
            Get_WinQuickFiltersManager_PadHeaderBar_BtnEdit().Click();
        
        isNoIssueFound = CheckWinCRUFilterForSecuritiesOrdersDisplayedValues(filterNameValue, filterAccess, conditionField, conditionOperator, conditionValue, valueType);
        
        Get_WinCRUFilterForSecuritiesOrders_BtnOK().Click();
        
        if (Get_DlgInformation().Exists){
            Log.Error("The Information dialog box was displayed, this is unexpected. Please check the screenshot to see the exact message.");
            isNoIssueFound = false;
            Get_DlgInformation().Click(Get_DlgInformation().Width/2, Get_DlgInformation().Height-45);
        }
        else if (Get_DlgError().Exists){
            Log.Error("The Error dialog box was displayed, this is unexpected. Please check the screenshot to see the exact message.");
            isNoIssueFound = false;
            Get_DlgError().Click(Get_DlgError().Width/2, Get_DlgError().Height - 45);
        }
        else {
            //Cette partie Else a été ajoutée lors de l'adaptation pour versions Co
            var BaseWindow = Get_CroesusApp().FindChildEx(["ClrClassName", "Visible"], ["BaseWindow", true], 10, true, 3000);
            if (BaseWindow.Exists){
                Log.Error(BaseWindow.Title + " dialog box was displayed, this is unexpected. Please check the screenshot to see the exact message.")
                BaseWindow.Close();
            }
        }
        
        if (Get_WinCRUFilterForSecuritiesOrders().Exists)
            Get_WinCRUFilterForSecuritiesOrders().Close();
    }
    
    Get_WinQuickFiltersManager_BtnClose().Click();
    RestoreAutoTimeOut();
    return isNoIssueFound;
}



function CheckWinCRUFilterForSecuritiesOrdersDisplayedValues(filterName, filterAccess, conditionField, conditionOperator, conditionValue, valueType)
{
    var previousLogErrorCount = Log.ErrCount;
    
    CheckEquals(VarToStr(Get_WinCRUFilterForSecuritiesOrders_TxtName().Text), filterName, "Filter displayed Name");
    CheckEquals(Get_WinCRUFilterForSecuritiesOrders_TxtName().IsVisible, true, "Filter displayed Name IsVisible");
    
    CheckEquals(VarToStr(Get_WinCRUFilterForSecuritiesOrders_GrpAccess().FindChild(["ClrClassName", "wChecked"], ["RadioButton", true] ,10).WPFControlText), filterAccess, "Filter Access");
    CheckEquals(Get_WinCRUFilterForSecuritiesOrders_GrpAccess().FindChild(["ClrClassName", "wChecked"], ["RadioButton", true] ,10).IsVisible, true, "Filter Access IsVisible");
    
    CheckEquals(VarToStr(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbField().Text), conditionField, "Filter condition Field");
    CheckEquals(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbField().IsVisible, true, "Filter condition Field IsVisible");
    
    CheckEquals(VarToStr(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbOperator().Text), conditionOperator, "Filter condition Operator");
    CheckEquals(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbOperator().IsVisible, true, "Filter condition Operator IsVisible");
    
    if (conditionValue === null){
        if (Get_WinCRUFilterForSecuritiesOrders_GrpCondition_TxtValue().Exists && Get_WinCRUFilterForSecuritiesOrders_GrpCondition_TxtValue().IsVisible)
            Log.Error("A condition TxtValue component is displayed.");
        
        if (Get_WinCRUFilterForSecuritiesOrders_GrpCondition_TxtValueDouble().Exists && Get_WinCRUFilterForSecuritiesOrders_GrpCondition_TxtValueDouble().IsVisible)
            Log.Error("A condition TxtValueDouble component is displayed.");
        
        if (Get_WinCRUFilterForSecuritiesOrders_GrpCondition_DateValue().Exists && Get_WinCRUFilterForSecuritiesOrders_GrpCondition_DateValue().IsVisible)
            Log.Error("A condition DateValue component is displayed.");
        
        if (Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbValue().Exists && Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbValue().IsVisible)
            Log.Error("A condition CmbValue component is displayed.");
    }
    else {
        switch (valueType){
            case "TxtValue":
                CheckEquals(VarToStr(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_TxtValue().Text), conditionValue, "Filter condition Value");
                CheckEquals(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_TxtValue().IsVisible, true, "Filter condition Value IsVisible");
                break;
            
            case "TxtValueDouble":
                CheckEquals(VarToStr(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_TxtValueDouble().Text), conditionValue, "Filter condition Value");
                CheckEquals(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_TxtValueDouble().IsVisible, true, "Filter condition Value IsVisible");
                break;
            
            case "DateValue":
                CheckEquals(VarToStr(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_DateValue().StringValue), conditionValue, "Filter condition Value");
                CheckEquals(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_DateValue().IsVisible, true, "Filter condition Value IsVisible");
                break;
            
            case "CmbValue":
                CheckEquals(VarToStr(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbValue().Text), conditionValue, "Filter condition Value");
                CheckEquals(Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbValue().IsVisible, true, "Filter condition Value IsVisible");
                break;
            
            default:
                Log.Error("Value type '" + valueType + "' not covered.");
                break;
        }
    }
    
    return (Log.ErrCount == previousLogErrorCount);
}



function GetFilterProperties(stringValuesFromExcel, separatorChar)
{
    if (separatorChar == undefined)
        separatorChar = "|";
    
    //Name|Access|Field|Operator|Value
    //Nom|Accès|Champ|Opérateur|Valeur
    var arrayValuesFromExcel = stringValuesFromExcel.split(separatorChar);
    var arrayValuesFromExcelWithKeys = [];
    arrayValuesFromExcelWithKeys["Name"] = arrayValuesFromExcel[0];
    arrayValuesFromExcelWithKeys["Access"] = arrayValuesFromExcel[1];
    arrayValuesFromExcelWithKeys["Field"] = arrayValuesFromExcel[2];
    arrayValuesFromExcelWithKeys["Operator"] = arrayValuesFromExcel[3];
    arrayValuesFromExcelWithKeys["Value"] = (arrayValuesFromExcel.length > 4)? arrayValuesFromExcel[4]: null;
    return arrayValuesFromExcelWithKeys;
}




function CheckIfRelationshipsClientsAccountsFilterIsValid(filterName, filterNameValue, filterAccess, conditionField, conditionOperator, conditionValue, valueType)
{
    SetAutoTimeOut();
    
    Log.Message("Check if filter '" + filterName + "' is valid.");
    var isNoIssueFound = true;
    
    ClickAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts());
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
    
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Click();
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Keys(filterName.substring(0, 1));
    Sys.Keys(filterName.substring(1));
    Sys.Keys("[Enter]");
    
    var filterListBoxItem = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "Uid", "WPFControlText"], ["CellValuePresenter", "Description", filterName], 10);
    
    if (!filterListBoxItem.Exists){
        Log.Error("Filter '" + filterName + "' not found.");
        isNoIssueFound = false;
    }
    else {
        filterListBoxItem.Click();
        
        if (Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay().Exists && Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay().IsVisible)
            Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay().Click();
        else
            Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit().Click();
        
        isNoIssueFound = CheckWinCRUFilterForRelationshipsClientsAccountsDisplayedValues(filterNameValue, filterAccess, conditionField, conditionOperator, conditionValue, valueType);
        
        if (Get_WinCRUFilter().Exists && Get_WinCRUFilter_BtnOK().Exists && Get_WinCRUFilter_BtnOK().IsVisible)
            Get_WinCRUFilter_BtnOK().Click();
        else
            Get_WinCRUFilter_BtnClose().Click();
        
        if (Get_DlgInformation().Exists){
            Log.Error("The Information dialog box was displayed, this is unexpected. Please check the screenshot to see the exact message.");
            isNoIssueFound = false;
            Get_DlgInformation().Click(Get_DlgInformation().Width/2, Get_DlgInformation().Height-45);
        }
        else if (Get_DlgError().Exists){
            Log.Error("The Error dialog box was displayed, this is unexpected. Please check the screenshot to see the exact message.");
            isNoIssueFound = false;
            Get_DlgError().Click(Get_DlgError().Width/2, Get_DlgError().Height - 45);
        }
        else {
            //Cette partie Else a été ajoutée lors de l'adaptation pour versions Co
            var BaseWindow = Get_CroesusApp().FindChildEx(["ClrClassName", "Visible"], ["BaseWindow", true], 10, true, 3000);
            if (BaseWindow.Exists){
                Log.Error(BaseWindow.Title + " dialog box was displayed, this is unexpected. Please check the screenshot to see the exact message.")
                BaseWindow.Close();
            }
        }
        
        if (Get_WinCRUFilter().Exists)
            Get_WinCRUFilter().Close();
    }
    
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
    RestoreAutoTimeOut();
    return isNoIssueFound;
}



function CheckWinCRUFilterForRelationshipsClientsAccountsDisplayedValues(filterName, filterAccess, conditionField, conditionOperator, conditionValue, valueType)
{
    var previousLogErrorCount = Log.ErrCount;
    
    CheckEquals(VarToStr(Get_WinCRUFilter_GrpDefinition_TxtName().Text), filterName, "Filter displayed Name");
    CheckEquals(Get_WinCRUFilter_GrpDefinition_TxtName().IsVisible, true, "Filter displayed Name IsVisible");
    
    CheckEquals(VarToStr(Get_WinCRUFilter_GrpDefinition_CmbAccess().Text), filterAccess, "Filter Access");
    CheckEquals(Get_WinCRUFilter_GrpDefinition_CmbAccess().IsVisible, true, "Filter Access IsVisible");
    
    CheckEquals(VarToStr(Get_WinCRUFilter_GrpCondition_CmbField().Text), conditionField, "Filter condition Field");
    CheckEquals(Get_WinCRUFilter_GrpCondition_CmbField().IsVisible, true, "Filter condition Field IsVisible");
    
    CheckEquals(VarToStr(Get_WinCRUFilter_GrpCondition_CmbOperator().Text), conditionOperator, "Filter condition Operator");
    CheckEquals(Get_WinCRUFilter_GrpCondition_CmbOperator().IsVisible, true, "Filter condition Operator IsVisible");
    
    if (conditionValue === null){
        if (Get_WinCRUFilter_GrpCondition_DgvValue().Exists && Get_WinCRUFilter_GrpCondition_DgvValue().IsVisible)
            Log.Error("A condition DgvValue component is displayed.");
            
        if (Get_WinCRUFilter_GrpCondition_TxtValue().Exists && Get_WinCRUFilter_GrpCondition_TxtValue().IsVisible)
            Log.Error("A condition TxtValueDouble component is displayed.");
            
        if (Get_WinCRUFilter_GrpCondition_DtpValue().Exists && Get_WinCRUFilter_GrpCondition_DtpValue().IsVisible)
            Log.Error("A condition DateValue component is displayed.");
            
        if (Get_WinCRUFilter_GrpCondition_TxtAnd().Exists && Get_WinCRUFilter_GrpCondition_TxtAnd().IsVisible)
            Log.Error("A condition And Text Value component is displayed.");
            
        if (Get_WinCRUFilter_GrpCondition_DtpAnd().Exists && Get_WinCRUFilter_GrpCondition_DtpAnd().IsVisible)
            Log.Error("A condition And DateValue component is displayed.");
            
        if (Get_WinCRUFilter_GrpCondition_TxtValueDouble().Exists && Get_WinCRUFilter_GrpCondition_TxtValueDouble().IsVisible)
            Log.Error("A condition CmbValue component is displayed.");
            
        if (Get_WinCRUFilter_GrpCondition_TxtAndDouble().Exists && Get_WinCRUFilter_GrpCondition_TxtAndDouble().IsVisible)
            Log.Error("A condition CmbValue component is displayed.");
    }
    else {
        switch (valueType){
            case "DgvValue":
                CheckEquals(Get_WinCRUFilter_GrpCondition_DgvValue().IsVisible, true, "Filter condition Value IsVisible");
                var arrayOfSelectedDgvValues = Get_WinCRUFilter_GrpCondition_DgvValue().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10).FindAllChildren(["ClrClassName", "IsSelected"], ["DataRecordPresenter", true]).toArray();
                var arrayOfSelectedDgvValuesText = [];
                for (var i = 0; i < arrayOfSelectedDgvValues.length; i++)
                    arrayOfSelectedDgvValuesText.push(VarToStr(arrayOfSelectedDgvValues[i].FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFControlText));
    
                if (GetVarType(conditionValue) != varArray && GetVarType(conditionValue) != varDispatch) conditionValue = new Array(conditionValue);
                CheckEquals(arrayOfSelectedDgvValuesText.length, conditionValue.length, "The number of selected Filter condition Values");
                for (var i = 0; i < arrayOfSelectedDgvValuesText.length; i++){
                    if (GetIndexOfItemInArray(conditionValue, arrayOfSelectedDgvValuesText[i]) == -1)
                        Log.Error("The Filter condition selected Value '" + arrayOfSelectedDgvValuesText[i] + "' is not expected.");
                    else
                        Log.Checkpoint("The Filter condition selected Value '" + arrayOfSelectedDgvValuesText[i] + "' is expected.");
                }
                break;
            
            case "TxtValue":
                CheckEquals(VarToStr(Get_WinCRUFilter_GrpCondition_TxtValue().Text), conditionValue, "Filter condition Value");
                CheckEquals(Get_WinCRUFilter_GrpCondition_TxtValue().IsVisible, true, "Filter condition Value IsVisible");
                break;
                
            case "DateValue":
                CheckEquals(VarToStr(Get_WinCRUFilter_GrpCondition_DtpValue().StringValue), conditionValue, "Filter condition Value");
                CheckEquals(Get_WinCRUFilter_GrpCondition_DtpValue().IsVisible, true, "Filter condition Value IsVisible");
                break;
            
            case "TxtValueDouble":
                CheckEquals(VarToStr(Get_WinCRUFilter_GrpCondition_TxtValueDouble().Text), conditionValue, "Filter condition Value");
                CheckEquals(Get_WinCRUFilter_GrpCondition_TxtValueDouble().IsVisible, true, "Filter condition Value IsVisible");
                break;
                
            default:
                Log.Error("Value type '" + valueType + "' not covered.");
                break;
        }
    }
    
    return (Log.ErrCount == previousLogErrorCount);
}
