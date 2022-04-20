//USEUNIT CR1483_Common_functions
//USEUNIT CR1806_Helper
//USEUNIT SmokeTest_Common




/**
    Vérifier que tous les titre US et Canadien ont une valeur de risque,
    aller dans le module titre ajouter la colonne Risk Rating
    et verifier qu'elle prend les valeurs  Medium, High et Low.
 */
function CR1958_8_PreparationBD_RiskRatingVerification()
{
    Log.Message("");
    Log.Message("************* CR1958_8_PreparationBD_RiskRatingVerification() *************");
    
    //Aller au module Titres
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 100000);
    Delay(PROJECT_AUTO_WAIT_TIMEOUT/2);//Provisoire
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Delay(PROJECT_AUTO_WAIT_TIMEOUT/2);//Provisoire
    
    //Valeurs de Risk Rating attendues
    var lowRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Low", language + client);
    var mediumRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Medium", language + client);
    var highRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_High", language + client);
    var arrayOfExpectedRiskRatingValues = [lowRating, mediumRating, highRating];
    
    //Valeurs de Security Currency (CAD/USD)
    var currencyCAD = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCAD", language + client);
    var currencyUSD = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemUSD", language + client);
    var arrayOfCurrencies = [currencyCAD, currencyUSD];
    
    //Colonnes nécessaires et suffisantes pour la validation
    var columnName_Description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "SecurityColumnName_Description", language + client);
    var columnName_RiskRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "SecurityColumnName_RiskRating", language + client);
    //var columnName_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "SecurityColumnName_Symbol", language + client);
    //var columnName_Security = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "SecurityColumnName_Security", language + client);
    var columnName_CurrencyPrice = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "SecurityColumnName_CurrencyPrice", language + client);
    var arrayOfNecessaryColumnsNames = [columnName_CurrencyPrice, columnName_RiskRating, columnName_Description];
    
    //Afficher seulement les colonnes nécessaires
    AddColumnsToGrid(Get_SecurityGrid_AnyDisplayedColumnHeader(), arrayOfNecessaryColumnsNames);
    var arrayOfAllColumnNames = Get_ColumnList(Get_SecurityGrid_AnyDisplayedColumnHeader());
    for (var i in arrayOfAllColumnNames)
        if (GetIndexOfItemInArray(arrayOfNecessaryColumnsNames, arrayOfAllColumnNames[i]) == -1)
            DeleteColumn(Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", arrayOfAllColumnNames[i]], 10));
    
    //Récupérer toutes les valeurs de Risk Rating via un export vers Fichier Excel
    var exportFilePath = Project.Path + "CR1958_8_Ratings.xlsx";
    CloseExcelProcess();
    if (Sys.WaitProcess("excel", 1000).Exists)
        Log.Error("CloseExcelProcess was not successfull");
    
    if (aqFileSystem.Exists(exportFilePath) && !aqFileSystem.DeleteFile(exportFilePath))
        return Log.Error("File deletion was not successfull : " + exportFilePath);
    
    //Exporter ver MsExcel
    var numTry = 0;
    do {Get_MenuBar_Edit().OpenMenu();} while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 3000, 4000))
    Get_MenuBar_Edit_ExportToMsExcel().Click();
    WaitForDataExportCompletion(3600000);
    var excelProcess = Sys.WaitProcess("excel", 100000);
    if (!excelProcess.Exists)
        return Log.Error("Export to MSExcel was not successfull");
    
    //Ouvrir la boîte de dialogue Enregistrer sous
    var excelMainWindow = excelProcess.FindChildEx(["WndClass"], ["XLMAIN"], 10, true, -1);
    excelMainWindow.Keys("[F12]");
    var excelSaveAsDlg = excelProcess.FindChildEx(["WndClass"], ["#32770"], 10, true, -1);
    
    //Choisir le type de fichier, le premier type de la liste
    excelSaveAsDlg.Keys("~t");
    Sys.Keys("[Down][Home][Enter]");
    
    //Récupérer le nom du fichier pour avoir le nom de la feuille
    Sys.Clipboard = null;
    excelSaveAsDlg.Keys("~n");
    Sys.Keys("^c");
    var nbOfTries = 0;
    do {Delay(200);}while (GetVarType(Sys.Clipboard) != varOleStr && ++nbOfTries < 20)
    var excelFileName = Sys.Clipboard;
    var excelSheetName = aqString.SubString(excelFileName, 0, aqString.FindLast(excelFileName, "."));
    
    //Saisir le nom du fichier et valider
    excelSaveAsDlg.Keys("~n");
    Sys.Keys(exportFilePath + "[Enter]");
    
    //Attendre que le fichier soit effectivement enregistré puis fermer Excel
    var nbOfChecks = 0;
    do {Delay(1000);} while (!aqFileSystem.Exists(exportFilePath) && ++nbOfChecks < 20)
    if (!aqFileSystem.Exists(exportFilePath))
        return Log.Error("Save As was not successfull to : " + exportFilePath);
    CloseExcelProcess();
    
    //Vérifier les données exportées vers Excel
    var arrayOfRiskRatingValues = GetAllDataFromExcelSheet(exportFilePath, excelSheetName, arrayOfNecessaryColumnsNames);
    var arrayOfSecuritiesRecordsWithUnexpectedRiskRatingValue = new Array();
    var currencyIndex = GetIndexOfItemInArray(arrayOfNecessaryColumnsNames, columnName_CurrencyPrice);
    var riskRatingIndex = GetIndexOfItemInArray(arrayOfNecessaryColumnsNames, columnName_RiskRating);
    var progressTotalCount = arrayOfRiskRatingValues.length;
    var progressDisplayStep = 1;
    var progressDisplayPercent = 0;
    var progressDisplayMsgStarting = "Current processing (started at " + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%H:%M") + ") : ";
    for (var j in arrayOfRiskRatingValues){
        var currentSecurityRecord = arrayOfRiskRatingValues[j];
        if (GetIndexOfItemInArray(arrayOfCurrencies, currentSecurityRecord[currencyIndex]) != -1)
            if (GetIndexOfItemInArray(arrayOfExpectedRiskRatingValues, currentSecurityRecord[riskRatingIndex]) == -1)
                arrayOfSecuritiesRecordsWithUnexpectedRiskRatingValue.push(currentSecurityRecord);
            
        var progressPercent = Math.round(100*j/progressTotalCount);
        if (progressPercent >= progressDisplayPercent){
            progressDisplayPercent = progressPercent + progressDisplayStep;
            Indicator.PushText(progressDisplayMsgStarting + progressPercent + "% completed.");
        }
    }
    Indicator.Clear();
        
    if (arrayOfSecuritiesRecordsWithUnexpectedRiskRatingValue.length == 0)
        Log.Checkpoint("Les valeurs affichées de Risk Rating sont celles attendues (" + arrayOfExpectedRiskRatingValues + ") pour les titres : " + arrayOfCurrencies);
    else {
        var arrayOfSecuritiesRecordsWithUnexpectedRiskRatingValueForDisplay = arrayOfSecuritiesRecordsWithUnexpectedRiskRatingValue.map(x => aqString.Quote(x.join("\"\t\"")));
        arrayOfSecuritiesRecordsWithUnexpectedRiskRatingValueForDisplay.unshift(aqString.Quote(arrayOfNecessaryColumnsNames.join("\"\t\"")));
        Log.Error(arrayOfSecuritiesRecordsWithUnexpectedRiskRatingValue.length + " titres n'ont pas la valeur attendue (" + arrayOfExpectedRiskRatingValues + ') pour le Risk Rating (voir la partie Details du log, et le fichier "' + exportFilePath + '") :', arrayOfSecuritiesRecordsWithUnexpectedRiskRatingValueForDisplay.join("\r\n"));            
    }
    
    //Réinitialiser l'affichage
    SetDefaultConfiguration(Get_SecurityGrid_AnyDisplayedColumnHeader());
}



//Mettre dans Common_function et utiliser ailleurs si tests concluants
function WaitObjectWithPersistenceCheck(parentObject, properties, propertiesValues, maxWaitTimeForWaitObject, maxWaitTimeForWaitUntilObjectDisappears)
{
    return (WaitObject(parentObject, properties, propertiesValues, maxWaitTimeForWaitObject) && !WaitUntilObjectDisappears(parentObject, properties, propertiesValues, maxWaitTimeForWaitUntilObjectDisappears));
}


function GetAllDataFromExcelSheet(ExcelFilePath, ExcelSheetName, arrayOfColumnsNames)
{
    if (GetVarType(arrayOfColumnsNames) != varArray && GetVarType(arrayOfColumnsNames) != varDispatch)
        arrayOfColumnsNames = new Array(arrayOfColumnsNames);
    
    var progressDisplayMsgStarting = "GetAllDataFromExcelSheet (started at " + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%H:%M") + ") : ";    
    var excelObject = Sys.OleObject("Excel.Application");  
    Sys.WaitProcess("EXCEL", 100000);
    excelObject.Workbooks.Open(ExcelFilePath).Sheets.Item(ExcelSheetName).Activate();
    var linesCountInExcelFile = excelObject.ActiveSheet.UsedRange.Rows.Count;
    excelObject.Quit();
    TerminateExcelProcess();
    
    var Driver = DDT.ExcelDriver(ExcelFilePath, ExcelSheetName, true);
    
    var arrayOfData = new Array();
    var j = 0;
    var progressTotalCount = linesCountInExcelFile;
    var progressPercent;
    var progressDisplayStep = 1;
    var progressDisplayPercent = 0;
    while (! Driver.EOF()){
        var arrayOfCurrentValues = new Array();
        for (var i = 0; i < arrayOfColumnsNames.length; i++)
            arrayOfCurrentValues.push(Driver.Value(arrayOfColumnsNames[i].replace(".", "#")));
            
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
    
    return arrayOfData;
}



/**
    Vérifier que tous les titre US et Canadien ont une valeur de risque,
    aller dans le module titre ajouter la colonne Risk Rating
    et verifier qu'elle prend les valeurs  Medium, High et Low.
 */
function CR1958_8_PreparationBD_RiskRatingVerification_old()
{
    Log.Message("");
    Log.Message("************* CR1958_8_PreparationBD_RiskRatingVerification() *************");
    
    //Aller au module Titres
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    
    //Valeurs de Risk Rating attendues
    var lowRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Low", language + client);
    var mediumRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Medium", language + client);
    var highRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_High", language + client);
    var arrayOfExpectedRiskRatingValues = [lowRating, mediumRating, highRating];
    
    //Valeurs de Security Currency (CAD/USD)
    var securityCurrencyCAD = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCAD", language + client);
    var securityCurrencyUSD = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemUSD", language + client);
    var filterName_SecurityCurrencyCAD = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_FilterName_SecurityCurrencyCAD", language + client);
    var filterName_SecurityCurrencyUSD = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_FilterName_SecurityCurrencyUSD", language + client);
    
    //Colonnes nécessaires et suffisantes pour la validation
    var columnName_Description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "SecurityColumnName_Description", language + client);
    var columnName_Security = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "SecurityColumnName_Security", language + client);
    var columnName_RiskRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "SecurityColumnName_RiskRating", language + client);
    var arrayOfNecessaryColumnsNames = [columnName_Description, columnName_Security, columnName_RiskRating];
    
    //Supprimer les filtres et les critères existants de mêmes noms
    Delete_FilterCriterion(filterName_SecurityCurrencyCAD, vServerRQS);
    Delete_FilterCriterion(filterName_SecurityCurrencyUSD, vServerRQS);
    
    //Afficher seulement les colonnes nécessaires
    AddColumnsToGrid(Get_SecurityGrid_AnyDisplayedColumnHeader(), arrayOfNecessaryColumnsNames);
    var arrayOfAllColumnNames = Get_ColumnList(Get_SecurityGrid_AnyDisplayedColumnHeader());
    for (var i in arrayOfAllColumnNames)
        if (GetIndexOfItemInArray(arrayOfNecessaryColumnsNames, arrayOfAllColumnNames[i]) == -1)
            DeleteColumn(Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", arrayOfAllColumnNames[i]], 10));
    
    //Comparer toutes les valeurs de Risk Rating affichées avec celles attendues (pour Security Currency = CAD ou USD)
    var arrayOfDisplayedRiskRatingValuesForSecurityCurrencyCAD = GetDisplayedRiskRatingValuesForSecurityCurrency(securityCurrencyCAD, filterName_SecurityCurrencyCAD);
    var arrayOfDisplayedRiskRatingValuesForSecurityCurrencyUSD = GetDisplayedRiskRatingValuesForSecurityCurrency(securityCurrencyUSD, filterName_SecurityCurrencyUSD);
    var arrayOfDisplayedRiskRatingValuesForSecurityCurrenciesCADandUSD = GetArrayUniqueValues(arrayOfDisplayedRiskRatingValuesForSecurityCurrencyCAD.concat(arrayOfDisplayedRiskRatingValuesForSecurityCurrencyUSD));
    if (DoubleCheckArrayDiff(arrayOfDisplayedRiskRatingValuesForSecurityCurrenciesCADandUSD, arrayOfExpectedRiskRatingValues))
        Log.Checkpoint("Les valeurs affichées de Risk Rating sont celles attendues pour Security Currency = " + [securityCurrencyCAD, securityCurrencyUSD]);
    else
        Log.Error("Toutes les valeurs affichées de Risk Rating ne sont pas celles attendues pour Security Currency = " + [securityCurrencyCAD, securityCurrencyUSD]);
    
    //Réinitialiser l'affichage
    SetDefaultConfiguration(Get_SecurityGrid_AnyDisplayedColumnHeader());
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    //Supprimer les filtres créés pour la vérification
    Delete_FilterCriterion(filterName_SecurityCurrencyCAD, vServerRQS);
    Delete_FilterCriterion(filterName_SecurityCurrencyUSD, vServerRQS);
}



function GetDisplayedRiskRatingValuesForSecurityCurrency(securityCurrency, filterName)
{
    var arrayOfRiskRatingValues = new Array();
    
    //Créer et charger un filtre rapide
    var filterConditionField = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_FilterConditionField", language + client);
    var filterConditionOperator = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_FilterConditionOperator", language + client);
    
    if (!CreateSecuritiesAndOrdersQuickFilterWithComboboxValueCondition(filterName, filterConditionField, filterConditionOperator, securityCurrency))
        Log.Error("La création/chargement du filtre rapide n'a pas réussi.");
    else {
        //Récupérer toutes les valeurs de Risk Rating via un export vers Fichier CSV
        var columnName_RiskRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "SecurityColumnName_RiskRating", language + client);
        var exportFilePath = Project.Path + filterName +".txt";
        if (!ExportGridContentToFile(exportFilePath, false, null, 3600000))
            Log.Error("Failed to export Grid content to : " + exportFilePath);
        else
            arrayOfRiskRatingValues = SetArrayItemsToString(GetDataFromCSVFile(exportFilePath, columnName_RiskRating));
    }
    
    //Supprimer les doublons dans les valeurs de Risk Rating récupérées
    return GetArrayUniqueValues(arrayOfRiskRatingValues);
}




function CreateSecuritiesAndOrdersQuickFilterWithComboboxValueCondition(filterName, conditionField, conditionOperator, conditionValue)
{    
    //Créer le filtre rapide
    Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 5000))
        Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
    Get_WinAddFilter_TxtName().Keys(filterName);
    SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbField(), conditionField);
    SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbOperator(), conditionOperator);
    SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbValue(), conditionValue);
    Get_WinAddFilter_BtnOK().Click();
    
    //S'assurer que le filtre a été chargé
    if (!Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().WaitProperty("IsChecked.OleValue", true, 30000))
        Log.Error("Filter '" + filterName + "' is not loaded.");
    
    return (VarToStr(Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().WPFControlText) == filterName);
}





function CreateCriterionInSecurities_ForRiskRatingVerification(securityCurrency, criterionNameInSecuritiesGrid)
{
    //Delete the criterion if it exists
    Log.Message("Delete criterion : " + criterionNameInSecuritiesGrid);
    Delete_FilterCriterion(criterionNameInSecuritiesGrid, vServerRQS);
    
    //Add the criterion
    Log.Message("Add criterion : " + criterionNameInSecuritiesGrid);
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnManageSearchCriteria().Click();
    Get_WinSearchCriteriaManager_BtnAdd().Click();
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(criterionNameInSecuritiesGrid);
    
    //Subcategories to discard
    if (language == "french"){
        var arrayOfSubcategoryNamesToDicard = Execute_SQLQuery_GetFieldAllValues("select DESC_L1C from B_ASSET where CATEGO <= 60", vServerRQS, "DESC_L1C");
    }
    else {
        var arrayOfSubcategoryNamesToDicard = Execute_SQLQuery_GetFieldAllValues("select DESC_L2C from B_ASSET where CATEGO <= 60", vServerRQS, "DESC_L2C");
    }
    
    CreateCriterionConditionInSecurities_SecuritiesHavingSecurityCurrencyEqualTo(securityCurrency);
    CreateCriterionConditionInSecurities_AndJoinToExistingCriterion();
    CreateCriterionConditionInSecurities_NotManualSecurities();
    CreateCriterionConditionInSecurities_AndJoinToExistingCriterion()
    CreateCriterionConditionInSecurities_SecuritiesHavingSubcategoriesNotEqualTo(arrayOfSubcategoryNamesToDicard.map(x => Trim(x)))
    
    //Sauvergarder et rafraîchir
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
    //Cliquer sur OK si le message "Les éléments de cette requête sont introuvables ou cette liste est vide." apparaît
    SetAutoTimeOut();
    if (Get_DlgWarning().Exists){
        Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
        Get_WinSearchCriteriaManager_BtnClose().Click();
    }
    RestoreAutoTimeOut();
    
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 100000);
}



function CreateCriterionConditionInSecurities_OrJoinToExistingCriterion()
{
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemOr", language + client)).Click();
}


function CreateCriterionConditionInSecurities_AndJoinToExistingCriterion()
{
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
}



function CreateCriterionConditionInSecurities_SecuritiesHavingSecurityCurrencyEqualTo(securityCurrency)
{
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSecurityCurrency", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(securityCurrency).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
}



function CreateCriterionConditionInSecurities_SecuritiesHavingSubcategoriesNotEqualTo(arrayOfSubcategoryNames)
{
    Log.Message(arrayOfSubcategoryNames, arrayOfSubcategoryNames);
    
    var PartControlVerb = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client);
    var ItemHaving = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client);
    var PartControlField = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)
    var ItemInformative = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)
    var ItemSubcategory = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSubcategory", language + client);
    var PartControlOperator = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)
    var ItemNotEqualTo = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemNotEqualTo", language + client);
    var PartControlValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client);
    var PartControlNext = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client);
    var ItemAnd = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client);
    var ItemDot = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client);
    
    for (var i = 0; i < arrayOfSubcategoryNames.length; i++){
        Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(PartControlVerb).Click();
        Get_WinAddSearchCriterion_LvwDefinition_Item(ItemHaving).Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(PartControlField).Click();
        Get_WinAddSearchCriterion_LvwDefinition_Item(ItemInformative).Click();
        Get_WinAddSearchCriterion_LvwDefinition_Item(ItemSubcategory).HoverMouse();
        Get_WinAddSearchCriterion_LvwDefinition_Item(ItemSubcategory).Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(PartControlOperator).Click();
        Get_WinAddSearchCriterion_LvwDefinition_Item(ItemNotEqualTo).Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(PartControlValue).Click();
        
        while (i < arrayOfSubcategoryNames.length && !Get_WinAddSearchCriterion_LvwDefinition_Item(arrayOfSubcategoryNames[i]).Exists){i++;}
        if (Get_WinAddSearchCriterion_LvwDefinition_Item(arrayOfSubcategoryNames[i]).Exists){
            Get_WinAddSearchCriterion_LvwDefinition_Item(arrayOfSubcategoryNames[i]).HoverMouse();
            Get_WinAddSearchCriterion_LvwDefinition_Item(arrayOfSubcategoryNames[i]).Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(PartControlNext).Click();
            if (i < arrayOfSubcategoryNames.length - 1)
                Get_WinAddSearchCriterion_LvwDefinition_Item(ItemAnd).Click();
        }
        else if (i == arrayOfSubcategoryNames.length - 1)
            Get_WinAddSearchCriterion_LvwDefinition_Item(ItemAnd).Click();
    }
    
    Get_WinAddSearchCriterion_LvwDefinition_Item(ItemDot).Click();

}
