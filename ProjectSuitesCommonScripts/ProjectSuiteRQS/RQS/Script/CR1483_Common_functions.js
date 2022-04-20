//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT DBA



function GetBasicOverwriteCriteriaDisplayedName(rowIndex)
{
    var basicCriteriaNameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", basicCriteriaNameColumnIndex], 10).WPFControlText;
}



function GetBasicOverwriteCriteriaDisplayedCreatedBy(rowIndex)
{
    var basicCriteriaCreatedByColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChCreatedBy().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", basicCriteriaCreatedByColumnIndex], 10).WPFObject("XamTextEditor", "", 1).DisplayText;
}




function GetBasicOverwriteCriteriaDisplayedModified(rowIndex)
{
    var basicCriteriaModifiedColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChModified().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", basicCriteriaModifiedColumnIndex], 10).WPFObject("XamDateTimeEditor", "", 1).DisplayText;
}



function GetBasicOverwriteCriteriaActiveCheckboxValue(rowIndex)
{
    var activeCheckboxColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChActive().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", activeCheckboxColumnIndex], 10).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1).IsChecked.OleValue;
}



function GetDefaultSubcategoriesDisplayedRating(rowIndex)
{
    var ratingColumnIndex = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChRating().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", ratingColumnIndex], 10).WPFControlText;
}



function GetBasicOverwriteCriteriaDisplayedRating(rowIndex)
{
    var ratingColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChRating().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", ratingColumnIndex], 10).WPFControlText;
}



function GetExternalRiskRatingFeedDisplayedRating(rowIndex)
{
    var ratingColumnIndex = Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChRating().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", ratingColumnIndex], 10).WPFControlText;
}



function GetDefaultSubcategoriesDisplayedSubcategory(rowIndex)
{
    var subcategoryColumnIndex = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChSubcategory().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", subcategoryColumnIndex], 10).WPFControlText;
}



function GetDefaultSubcategoriesDisplayedNbOfCorrespondingSecurities(rowIndex)
{
    var correspondingSecuritiesColumnIndex = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChCorrespondingSecurities().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", correspondingSecuritiesColumnIndex], 10).WPFControlText;
}



function GetDefaultSubcategoriesDisplayedNbOfProductionFinal(rowIndex)
{
    var productionFinalColumnIndex = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChProductionFinal().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", productionFinalColumnIndex], 10).WPFControlText;
}



function GetDefaultSubcategoriesDisplayedNbOfSimulationFinal(rowIndex)
{
    var simulationFinalColumnIndex = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChSimulationFinal().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationFinalColumnIndex], 10).WPFControlText;
}



function GetExternalRiskRatingFeedDisplayedNbOfCorrespondingSecurities(rowIndex)
{
    var correspondingSecuritiesColumnIndex = Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChCorrespondingSecurities().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", correspondingSecuritiesColumnIndex], 10).WPFControlText;
}



function GetExternalRiskRatingFeedDisplayedNbOfProductionFinal(rowIndex)
{
    var productionFinalColumnIndex = Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChProductionFinal().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", productionFinalColumnIndex], 10).WPFControlText;
}



function GetExternalRiskRatingFeedDisplayedNbOfSimulationFinal(rowIndex)
{
    var simulationFinalColumnIndex = Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChSimulationFinal().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationFinalColumnIndex], 10).WPFControlText;
}



function GetBasicOverwriteCriteriaDisplayedNbOfSimulation(rowIndex)
{
    var windowLeft = Get_WinRiskRatingCriteriaManager().get_Left();
    var windowWidth = Get_WinRiskRatingCriteriaManager().get_Width();
    Get_WinRiskRatingCriteriaManager().set_Left(0);
    Get_WinRiskRatingCriteriaManager().set_Width(Sys.Desktop.Width);
    
    var simulationColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulation().WPFControlOrdinalNo;
    var nbOfSimulation = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationColumnIndex], 10).WPFObject("XamNumericEditor", "", 1).DisplayText.OleValue;

    Get_WinRiskRatingCriteriaManager().set_Left(windowLeft);
    Get_WinRiskRatingCriteriaManager().set_Width(windowWidth);
    
    return nbOfSimulation;
}



function GetBasicOverwriteCriteriaDisplayedNbOfProduction(rowIndex)
{
    var productionColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProduction().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", productionColumnIndex], 10).WPFObject("XamNumericEditor", "", 1).DisplayText.OleValue;
}


function GetBasicOverwriteCriteriaDisplayedNbOfProductionFinal(rowIndex)
{
    var productionFinalColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProductionFinal().WPFControlOrdinalNo;
    return Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", productionFinalColumnIndex], 10).WPFObject("XamNumericEditor", "", 1).DisplayText.OleValue;
}



function GetCurrentDateString(){
    var dateFormat = (language == "french")? "%Y/%m/%d": "%m/%d/%Y";
    return aqConvert.DateTimeToFormatStr(aqDateTime.Now(), dateFormat);
}



function ConvertStrToNumberFormat(str)
{
    if (language == "french"){
        str = aqString.Replace(str, ",", ".");
        str = aqString.Replace(str, " ", ",");
    }
    
    return str;
}



function GetRoundedNumberString(decimalNumberStr, nbOfDecimals)
{
    var decimalChar = (language == "french")? ",": ".";
    var decimalPart = decimalNumberStr.substr(decimalNumberStr.indexOf(decimalChar) + 1);
    var decimalRoundPart = StrToFloat("0." + decimalPart).toFixed(nbOfDecimals);
    var roundedDecimalNumberStr = decimalNumberStr.replace(decimalChar + decimalPart, decimalChar + decimalRoundPart.replace("0.", ""));
    return roundedDecimalNumberStr;
}



function CreateRiskRatingCondition_SecuritiesHavingSubcategoryEqualTo(subcategoryName)
{
    CreateRiskRatingCondition_SecuritiesHavingSubcategoriesEqualTo(subcategoryName)
}



function CreateRiskRatingCondition_SecuritiesHavingSubcategoriesEqualTo(arrayOfSubcategoryNames)
{
    if (GetVarType(arrayOfSubcategoryNames) != varArray && GetVarType(arrayOfSubcategoryNames) != varDispatch)
        arrayOfSubcategoryNames = new Array(arrayOfSubcategoryNames);
    
    var PartControlVerb = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client);
    var ItemHaving = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client);
    var PartControlField = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client);
    var ItemInformative = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client);
    var ItemSubcategory = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSubcategory", language + client);
    var PartControlOperator = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client);
    var ItemEqualTo = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client);
    var PartControlValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client);
    var PartControlNext = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client);
    var ItemDot = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client);
    var PartControlDot = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client);
    var ItemOr = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemOr", language + client);
    
    for (var i = 0; i < arrayOfSubcategoryNames.length; i++){
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(PartControlVerb).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ItemHaving).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(PartControlField).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ItemInformative).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ItemSubcategory).HoverMouse();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ItemSubcategory).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(PartControlOperator).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ItemEqualTo).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(PartControlValue).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(arrayOfSubcategoryNames[i]).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(PartControlNext).Click();
        
        if (i < arrayOfSubcategoryNames.length - 1)
            Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ItemOr).Click();
    }
    
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ItemDot).Click();
}


function CreateRiskRatingCondition_SecuritiesHavingSubcategoryNotEqualTo(subcategoryName)
{
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSubcategory", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemNotEqualTo", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(subcategoryName).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
}



function CreateCriterionConditionInSecurities_SecuritiesHavingSubcategoryNotEqualTo(subcategoryName)
{
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSubcategory", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemNotEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(subcategoryName).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
}



function CreateCriterionConditionInSecurities_SecuritiesHavingSubcategoryEqualTo(subcategoryName)
{
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSubcategory", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(subcategoryName).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
}



function CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToUSDorCAD()
{
    CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToUSD();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemOr", language + client)).Click();
    CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToCAD();
}



function CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualTo(priceCurrency)
{
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemPriceCurrency", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(priceCurrency).HoverMouse();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(priceCurrency).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
}



function CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToUSD()
{
    CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualTo(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemUSD", language + client));
}


function CreateRiskRatingCondition_SecuritiesHavingSecurityCurrencyEqualTo(securityCurrency)
{
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSecurityCurrency", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(securityCurrency).HoverMouse();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(securityCurrency).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
}


function CreateRiskRatingCondition_SecuritiesHavingSecurityCurrencyEqualToUSD()
{
    CreateRiskRatingCondition_SecuritiesHavingSecurityCurrencyEqualTo(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemUSD", language + client));
}



function CreateCriterionConditionInSecurities_SecuritiesHavingPriceCurrencyEqualToUSD()
{
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemPriceCurrency", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemUSD", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
}



function CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToCAD()
{
    CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualTo(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCAD", language + client));
}


function CreateRiskRatingCondition_SecuritiesHavingSecurityCurrencyEqualToCAD()
{
    CreateRiskRatingCondition_SecuritiesHavingSecurityCurrencyEqualTo(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCAD", language + client));
}


function CreateCriterionConditionInSecurities_SecuritiesHavingPriceCurrencyEqualToCAD()
{
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemPriceCurrency", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCAD", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
}



function CreateCriterionConditionInSecurities_NotManualSecurities()
{
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemTypeClass", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemNotEqualTo", language + client)).Click();
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).DblClick();    
    Sys.Keys(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemManual", language + client));
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
}


function CreateRiskRatingCondition_SecuritiesHavingSymbolEqualTo(symbol)
{
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSymbol", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).DblClick();    
    Sys.Keys(symbol);
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();

}


function CreateCriterionConditionInSecurities_SecuritiesHavingSymbolEqualTo(symbol)
{
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSymbol", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).DblClick();
    Sys.Keys(symbol);
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();

}



function CreateCriterionInSecurities_SecuritiesHavingSymbolEqualTo(symbol, criterionNameInSecuritiesGrid)
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
    
    CreateCriterionConditionInSecurities_SecuritiesHavingSymbolEqualTo(symbol)
    
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
    //Cliquer sur OK si le message "Les éléments de cette requête sont introuvables ou cette liste est vide." apparaît
    if (Get_DlgCroesus().Exists){
        Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/2, Get_DlgCroesus().get_ActualHeight()-45);
        Get_WinSearchCriteriaManager_BtnClose().Click();
    }
    
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 100000);
}



function GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName)
{
    Log.Message("Get Row Index of the criterion '" + criterionName + "' in the Basic/Overwrite Criteria grid.");
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    //Goto the first row
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[Home]");
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[Home]");
    
    //Navigate through the grid in other to find the needed criterion name
    var isEndOfGridReached = false;
    while (!isEndOfGridReached){
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Refresh();
        var rowCount = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
        for (var i = 1; i <= rowCount; i++){
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentNameValue = GetBasicOverwriteCriteriaDisplayedName(i);
            if (currentNameValue == criterionName){
                Log.Message("'" + criterionName + "' criterion name found in the current page of the Basic/Overwrite Criteria grid at row index : " + i);
                return i;
            }
        }
        
        var previousFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[PageDown]");
        var currentFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
        
        if (previousFirstName == currentFirstName){
            var previousFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
            Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[PageDown]");
            var currentFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
            
            if (previousFirstName == currentFirstName)
                isEndOfGridReached = true;
        }  
    }
    
    Log.Message("'" + criterionName + "' criterion name not found in the Basic/Overwrite Criteria grid.");
    return null;
}



function GetDefaultSubcategoryRowIndex(subcategoryName)
{
    Log.Message("Get Row Index of the subcategory '" + subcategoryName + "' in the 'Default subcategories' grid.");
    
    Log.Message("Select 'Default subcategories'.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories().Click();
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    //Goto the first row
    Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().Keys("[Home] [Home]");
    
    //Navigate through the grid in other to find the needed criterion name
    var isEndOfGridReached = false;
    while (!isEndOfGridReached){
        Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().Refresh();
        var rowCount = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
        for (var i = 1; i <= rowCount; i++){
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentNameValue = GetDefaultSubcategoriesDisplayedSubcategory(i);
            if (currentNameValue == subcategoryName){
                Log.Message("'" + subcategoryName + "' subcategory name found in the current page of 'Default subcategories' grid at row index : " + i);
                return i;
            }
        }
        
        var previousFirstName = GetDefaultSubcategoriesDisplayedSubcategory(1);
        Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().Keys("[PageDown]");
        var currentFirstName = GetDefaultSubcategoriesDisplayedSubcategory(1);
        
        if (previousFirstName == currentFirstName){
            var previousFirstName = GetDefaultSubcategoriesDisplayedSubcategory(1);
            Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().Keys("[PageDown]");
            var currentFirstName = GetDefaultSubcategoriesDisplayedSubcategory(1);
            
            if (previousFirstName == currentFirstName)
                isEndOfGridReached = true;
        }  
    }
    
    Log.Error("'" + subcategoryName + "' subcategory name not found in the 'Default subcategories' grid.");
    return null;
}



function SendToProduction(productionPassword)
{
    Log.Message("Send to Production.");
    
    if (productionPassword == undefined)
        productionPassword = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CroesusEncryptedPassword", language + client);
    
    WaitObject(Get_CroesusApp(), "Uid", "RiskRatingCriteriaManagerWindow_0120", 300000);
    Get_WinRiskRatingCriteriaManager_BtnSendToProduction().Click();
    Get_WinSendCriteriaToProduction_TxtPassword().Keys(productionPassword);
    Get_WinSendCriteriaToProduction_BtnSendToProduction().Click();
}



function CheckIfCriterionIsDisplayedInBasicOverwriteCriteriaGrid(criterionName)
{
    Log.Message("Verify if the criterion '" + criterionName + "' is displayed in the Basic/Overwrite Criteria grid.");
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    //Goto the first row
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[Home]");
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[Home]");
    
    //Navigate through the grid in other to find the needed criterion name
    var isEndOfGridReached = false;
    var isCriterionNameFound = false;
    while (!isEndOfGridReached){
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Refresh();
        var rowCount = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
        for (var i = 1; i <= rowCount; i++){
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentNameValue = GetBasicOverwriteCriteriaDisplayedName(i);
            if (currentNameValue == criterionName){
                isCriterionNameFound = true;
                break;
            }
        }
        
        if (isCriterionNameFound)
            break;
        
        var previousFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[PageDown]");
        var currentFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
        
        if (previousFirstName == currentFirstName){
            var previousFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
            Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[PageDown]");
            var currentFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
            
            if (previousFirstName == currentFirstName)
                isEndOfGridReached = true;
        }  
    }
    
    return isCriterionNameFound;
}



function GetNbOfMatchingItemsForRatingInExternalRiskRatingFeed(column, searchedRating)
{
    Log.Message("Get number of '" + column + "' for '" + searchedRating + "' rating in External Risk Rating Feed grid.");
    
    var expectedColumnValues = ["Corresponding securities", "Production final", "Simulation final"];
    if (GetIndexOfItemInArray(expectedColumnValues, column) == -1){
        Log.Error("'" + column + "' column value is not covered by this function.");
        return null;
    }
    
    var nbOfMatchingItems = null;
    
    Log.Message("Select 'External Risk Rating Feed' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnExternalRiskRatingFeed().Click();
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    //Goto the first row
    Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().Keys("[Home]");
    Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().Keys("[Home]");
    
    //Navigate through the grid in other to find the needed rating
    var isEndOfGridReached = false;
    var isSearchedRatingFound = false;
    while (!isSearchedRatingFound && !isEndOfGridReached){
        var count = Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
        for (var i = 1; i <= count; i++){
            
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentRating = GetExternalRiskRatingFeedDisplayedRating(i);
            if (currentRating == searchedRating){
                if (column == "Corresponding securities")
                    nbOfMatchingItems = GetExternalRiskRatingFeedDisplayedNbOfCorrespondingSecurities(i);
                else if (column == "Production final")
                    nbOfMatchingItems = GetExternalRiskRatingFeedDisplayedNbOfProductionFinal(i);
                else if (column == "Simulation final")
                    nbOfMatchingItems = GetExternalRiskRatingFeedDisplayedNbOfSimulationFinal(i);
                
                isSearchedRatingFound = true;
                break;
            }
        }
        
        if (isSearchedRatingFound)
            break;
        
        var previousFirstRating = GetExternalRiskRatingFeedDisplayedRating(1);
        Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().Keys("[PageDown]");
        var currentFirstRating = GetExternalRiskRatingFeedDisplayedRating(1);
        
        if (previousFirstRating == currentFirstRating){
            var previousFirstRating = GetExternalRiskRatingFeedDisplayedRating(1);
            Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().Keys("[PageDown]");
            var currentFirstRating = GetExternalRiskRatingFeedDisplayedRating(1);
            
            if (previousFirstRating == currentFirstRating)
                isEndOfGridReached = true;
        }  
    }
    
    if (isSearchedRatingFound)
        Log.Message("The number of '" + column + "' for the '" + searchedRating + "' rating is : " + nbOfMatchingItems);
    else
        Log.Error("'" + searchedRating + "' rating not found in the grid.");
    
    //Close Risk Rating Criteria Manager window
    Get_WinRiskRatingCriteriaManager_BtnClose().Click();
    
    return nbOfMatchingItems;
}



function GetAllDisplayedRatingValuesInExternalRiskRatingFeed()
{
    Log.Message("Get all displayed Rating values in External Risk Rating Feed grid.");
    
    var displayedRatingValues = new Array();
    
    Log.Message("Select 'External Risk Rating Feed' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnExternalRiskRatingFeed().Click();
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    //Goto the first row
    Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().Keys("[Home]");
    Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().Keys("[Home]");
    
    //Navigate through the grid in other to find the needed rating
    var isEndOfGridReached = false;
    while (!isEndOfGridReached){
        var count = Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
        for (var i = 1; i <= count; i++){
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentRating = GetExternalRiskRatingFeedDisplayedRating(i);
            displayedRatingValues.push(currentRating);
        }
        
        var previousFirstRating = GetExternalRiskRatingFeedDisplayedRating(1);
        Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().Keys("[PageDown]");
        var currentFirstRating = GetExternalRiskRatingFeedDisplayedRating(1);
        
        if (previousFirstRating == currentFirstRating){
            var previousFirstRating = GetExternalRiskRatingFeedDisplayedRating(1);
            Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed().Keys("[PageDown]");
            var currentFirstRating = GetExternalRiskRatingFeedDisplayedRating(1);
            
            if (previousFirstRating == currentFirstRating)
                isEndOfGridReached = true;
        }  
    }
    
    Log.Message("The displayed Rating values in External Risk Rating Feed grid are : " + displayedRatingValues);
    
    //Close Risk Rating Criteria Manager window
    Get_WinRiskRatingCriteriaManager_BtnClose().Click();
    
    return displayedRatingValues;
}



function CreateSourceExternalRiskRatingFeedRatingMediumCriterion(criterionName)
{
    //Delete the criterion if it exists
    Log.Message("Delete criterion : " + criterionName);
    Delete_FilterCriterion(criterionName, vServerRQS);
    
    //Add the criterion
    Log.Message("Add criterion : " + criterionName);
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnManageSearchCriteria().Click();
    Get_WinSearchCriteriaManager_BtnAdd().Click();
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(criterionName);
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSource", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemExternalFeed", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemRating", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemMedium", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
    
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
    //Cliquer sur OK si le message "Les éléments de cette requête sont introuvables ou cette liste est vide." apparaît
    if (Get_DlgCroesus().Exists){
        Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/2, Get_DlgCroesus().get_ActualHeight()-45);
        Get_WinSearchCriteriaManager_BtnClose().Click();
    }
    
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 100000);
}



function CreateSubcategoryCriterionInSecurities(criterionNameInSecuritiesGrid, criterionDescriptionInSecuritiesGrid, subcategoryName)
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
    Get_WinAddSearchCriterion_TxtDescription().Clear();
    Get_WinAddSearchCriterion_TxtDescription().Keys(criterionDescriptionInSecuritiesGrid);
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSubcategory", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(subcategoryName).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();

    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
    //Cliquer sur OK si le message "Les éléments de cette requête sont introuvables ou cette liste est vide." apparaît
    if (Get_DlgCroesus().Exists){
        Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/2, Get_DlgCroesus().get_ActualHeight()-45);
        Get_WinSearchCriteriaManager_BtnClose().Click();
    }
    
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 100000);
}



function SetIscheckedForCriteriaInBasicCriteriaGrid(isCheckedValue, arrayOfCriteriaNames)
{
    Log.Message("Set criteria in Basic Criteria grid to : " + isCheckedValue);
    
    Log.Message("Select 'Basic criteria' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    
    SetIscheckedForCriteriaInBasicOverwriteCriteriaGrid(isCheckedValue, arrayOfCriteriaNames);
}



function SetIscheckedForCriteriaInOverwriteCriteriaGrid(isCheckedValue, arrayOfCriteriaNames)
{
    Log.Message("Set criteria in Overwrite Criteria grid to : " + isCheckedValue);
    
    Log.Message("Select 'Overwrite criteria' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
    
    SetIscheckedForCriteriaInBasicOverwriteCriteriaGrid(isCheckedValue, arrayOfCriteriaNames);
}



function SetIscheckedForCriteriaInBasicOverwriteCriteriaGrid(isCheckedValue, arrayOfCriteriaNames)
{
    if (arrayOfCriteriaNames != undefined && GetVarType(arrayOfCriteriaNames) != varArray && GetVarType(arrayOfCriteriaNames) != varDispatch)
        arrayOfCriteriaNames = new Array(arrayOfCriteriaNames);
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    var activeCheckboxColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChActive().WPFControlOrdinalNo;
    
    //Goto the first row
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[Home]");
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[Home]");
    
    //Navigate through the grid
    var isEndOfGridReached = false;
    var allCriteriaNamesFound = false;
    var nbOfCriteriaFound = 0;
    var arrayOfDisplayedCriteriaNames = new Array();
    while (!isEndOfGridReached){
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Refresh();
        var rowCount = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
        for (var rowIndex = 1; rowIndex <= rowCount; rowIndex++){
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentNameValue = GetBasicOverwriteCriteriaDisplayedName(rowIndex);
            
            if (arrayOfDisplayedCriteriaNames.indexOf(currentNameValue) != -1)
                continue;
            
            arrayOfDisplayedCriteriaNames.push(currentNameValue);
            
            var activeCheckbox = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", activeCheckboxColumnIndex], 10).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1);
            
            if (arrayOfCriteriaNames == undefined || arrayOfCriteriaNames.indexOf(currentNameValue) != -1){
                if (isCheckedValue != activeCheckbox.IsChecked.OleValue){
                    activeCheckbox.Click();
                    
                    //Verify new active checkbox status
                    aqObject.CompareProperty(activeCheckbox.IsChecked.OleValue, cmpEqual, isCheckedValue, true, lmError);
                }
            }
            
            if (arrayOfCriteriaNames != undefined && arrayOfCriteriaNames.indexOf(currentNameValue) != -1){
                nbOfCriteriaFound ++;
                if (nbOfCriteriaFound == arrayOfCriteriaNames.length){
                    allCriteriaNamesFound = true;
                    break;
                }
            }
        }
        
        if (allCriteriaNamesFound)
            break;
        
        var previousFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[PageDown]");
        var currentFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
        
        if (previousFirstName == currentFirstName){
            var previousFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
            Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[PageDown]");
            var currentFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
            
            if (previousFirstName == currentFirstName)
                isEndOfGridReached = true;
        }
    }
    
    if (arrayOfCriteriaNames != undefined && !allCriteriaNamesFound)
        Log.Warning("Only " + nbOfCriteriaFound + " out of " + arrayOfCriteriaNames.length + " have been found.");
}



function GetCriterionId(criterionName)
{
    //Get the criterion MSG_ID
    var queryString = "SELECT * FROM B_MSG where DESCRIPTION = '" + criterionName + "'";
    var fieldName = "MSG_ID";
    Log.Message(queryString);
    var msg_id = Execute_SQLQuery_GetField(queryString, vServerRQS, fieldName);
    
    //Get the criterion CRIT_ID
    var queryString = "SELECT * FROM B_CRITERIA where MSG_ID = " + msg_id;
    var fieldName = "CRIT_ID";
    Log.Message(queryString);
    return Execute_SQLQuery_GetField(queryString, vServerRQS, fieldName);
}




function DeleteRiskIndexCriterion(criterionName, BasicOrOverwriteCriteria)
{
    if (GetIndexOfItemInArray(["basic", "overwrite"], BasicOrOverwriteCriteria) == -1){
        Log.error(BasicOrOverwriteCriteria + " not expected for the BasicOrOverwriteCriteria parameter.");
        return;
    }
    
    Log.Message("Delete the " + BasicOrOverwriteCriteria + " criterion : " + criterionName);
    
    Log.Message("Click on Simulation tab.");
    Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
    
    //Select the Rating Method.
    if (BasicOrOverwriteCriteria == "overwrite"){
        Log.Message("Select 'Overwrite criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
    }
    else {
        Log.Message("Select 'Basic criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    }
        
    Log.Message("Select the criterion : " + criterionName);
    var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
    
    if (criterionRowIndex == null)
        return;
    
    var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10); 
    criterionRow.Click();
    
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnDelete().Click();
    if (aqObject.CheckProperty(Get_DlgCroesus(), "Exists", cmpEqual, true))
        Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/3, Get_DlgCroesus().get_ActualHeight()-45);
}



function RestoreRQS(arrayOfBasicCriteriaNamesToBeDeleted, arrayOfOverwriteCriteriaNamesToBeDeleted, isSendToProductionToBeExecuted, isSSHCommandsToBeExecuted, isSimulateAllToBeExecuted)
{
    if (GetVarType(arrayOfBasicCriteriaNamesToBeDeleted) != varArray && GetVarType(arrayOfBasicCriteriaNamesToBeDeleted) != varDispatch)
        arrayOfBasicCriteriaNamesToBeDeleted = new Array(arrayOfBasicCriteriaNamesToBeDeleted);
        
    if (GetVarType(arrayOfOverwriteCriteriaNamesToBeDeleted) != varArray && GetVarType(arrayOfOverwriteCriteriaNamesToBeDeleted) != varDispatch)
        arrayOfOverwriteCriteriaNamesToBeDeleted = new Array(arrayOfOverwriteCriteriaNamesToBeDeleted);
     
    //Login
    Login(vServerRQS, userNameRQS, pswRQS, language);
    
    //Go to the securities module,click on "Risk Rating Methods Manager"  button, in Risk Rating Methods Manager window
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    
    //Open the risk rating criteria manager window, click on Simulation Tab
    Log.Message("Open the Risk Rating Criteria Manager window");
    Get_SecuritiesBar_BtnRiskRatingManager().Click();
    
    Log.Message("Go to 'Simulation' tab.");
    Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
    
    for (var i = 0; i < arrayOfBasicCriteriaNamesToBeDeleted.length; i++){
        var criterionNameToBeDeleted = arrayOfBasicCriteriaNamesToBeDeleted[i];
        if (criterionNameToBeDeleted != undefined)
            DeleteRiskIndexCriterion(criterionNameToBeDeleted, "basic");
    }
    
    for (var i = 0; i < arrayOfOverwriteCriteriaNamesToBeDeleted.length; i++){
        var criterionNameToBeDeleted = arrayOfOverwriteCriteriaNamesToBeDeleted[i];
        if (criterionNameToBeDeleted != undefined)
            DeleteRiskIndexCriterion(criterionNameToBeDeleted, "overwrite");
    }
    
    SetIscheckedForCriteriaInBasicCriteriaGrid(true);
    SetIscheckedForCriteriaInOverwriteCriteriaGrid(true);
    
    //Cliquer sur le bouton Simulate All
    if (isSimulateAllToBeExecuted){
        Log.Message("Click on 'Simulate All' button.");
        Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods().Click();
    }

    //Send to Production
    if (isSendToProductionToBeExecuted)
        SendToProduction();
    
    //Execute SSH commands
    if (isSSHCommandsToBeExecuted)
        ExecuteDefaultSSHCommands();
    
    //Close Risk Rating Criteria Manager window
    Get_WinRiskRatingCriteriaManager_BtnClose().Click();
    
    //Close Croesus
    Close_Croesus_X();
    Terminate_CroesusProcess();
}


function ExecuteDefaultSSHCommands()
{
    Log.Message("Execute RiskRating plugin.");
    
    //Create SSH commands file
    var SSHCmdFileName = "CR1483_Default_SSH_commands.txt";
    var SSHCmdLines = "if [ -f '/home/tools/LOG_cfLoader.sh' ]; then sh /home/tools/LOG_cfLoader.sh; fi";
    SSHCmdLines += '\r\ncfLoader -RiskRating " "';
    SSHCmdLines += "\r\ncfLoader -RiskRating \\\"-overwrite\\\"";
    var SSHCmdFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SSH\\" + SSHCmdFileName;
    CreateFileAndWriteText(SSHCmdFilePath, SSHCmdLines);
    
    //Create PLINK batch file
    var hostname = GetVserverHostName(vServerRQS);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m " + SSHCmdFileName + " > CR1483_Default_SSH_output.txt";
    var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SSH\\CR1483_Default_SSH_plink.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
}



function AddARiskRatingCriterion(criterionName, criterionDescription, isActiveStringValue, isOverwriteStringValue, rating, CreateRiskRatingConditionFunction)
{
    Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
    
    //Add the criterion
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
    SetCriterionAttributes(criterionName, criterionDescription, isActiveStringValue, isOverwriteStringValue, rating, CreateRiskRatingConditionFunction);
    var isOverwriteChecked = Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwrite().IsChecked.OleValue;
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
    
    //Check if the criterion is actually added.
    if (isOverwriteChecked)
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
    else
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    
    return CheckIfCriterionIsDisplayedInBasicOverwriteCriteriaGrid(criterionName);
}



function SetCriterionAttributes(criterionName, criterionDescription, isActiveStringValue, isOverwriteStringValue, rating, CreateRiskRatingConditionFunction)
{
    if (criterionName == undefined)
        Log.Message("criterionName not specified, leave the default one.");
    else
        Get_WinRiskRatingCriteriaEditor_TxtName().Keys(criterionName);
    
    if (criterionDescription == undefined)
        Log.Message("criterionDescription not specified, leave the default one.");
    else
        Get_WinRiskRatingCriteriaEditor_TxtDescription().Keys(criterionDescription);
    
    if (isActiveStringValue == undefined || isActiveStringValue == "")
        Log.Message("activeStatus not specified, leave the default one.");
    else
        Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkActive().set_IsChecked(GetBooleanValue(isActiveStringValue));
    
    if (isOverwriteStringValue == undefined || isOverwriteStringValue == "")
        Log.Message("overwriteStatus not specified, leave the default one.");
    else
        Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwrite().set_IsChecked(GetBooleanValue(isOverwriteStringValue));
    
    if (rating == undefined)
        Log.Message("Rating not specified, leave the default one.");
    else
        SelectComboBoxItem(Get_WinRiskRatingCriteriaEditor_GrpRating_CmbRating(), rating);
    
    if (CreateRiskRatingConditionFunction != undefined && CreateRiskRatingConditionFunction != "")
        eval(CreateRiskRatingConditionFunction);
}



function CreateAndRefreshCriterionInSecurities(criterionName, criterionDescription, CriterionDefinitionFunction)
{
    //Delete the criterion if it exists
    Log.Message("Delete criterion : " + criterionName);
    Delete_FilterCriterion(criterionName, vServerRQS);
    
    Log.Message("Add criterion : " + criterionName);
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    
    if (Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().IsChecked.OleValue){
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", false, 100000);
    }
    
    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
    
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(criterionName);
    Get_WinAddSearchCriterion_TxtDescription().Clear();
    Get_WinAddSearchCriterion_TxtDescription().Keys(criterionDescription);
    
    eval(CriterionDefinitionFunction);
    
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
    if (Get_DlgCroesus().Exists){
        Log.Picture(Sys.Desktop, "There was an unexpected issue while creating the criterion '" + criterionName + "'");
        Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/2, Get_DlgCroesus().get_ActualHeight()-45);
        Get_WinAddSearchCriterion_BtnCancel().Click();
        return false;
    }
    
    //Cliquer sur OK si le message "Les éléments de cette requête sont introuvables ou cette liste est vide." apparaît
    if (Get_DlgWarning().Exists){
        Log.Picture(Sys.Desktop, "The Warning dialogbox were displayed upon the creation of criterion '" + criterionName + "'");
        Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
    }
    
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 100000);
    Delay(1000); //For the NbOfcheckedElements to be updated
    
    //Check if criterion is actually created and loaded in Securities
    return (VarToStr(Get_MainWindow_StatusBar_NbOfcheckedElements().ToolTip.OleValue) == criterionName)
}




function RateSecurityManually(securityNumber, rating, checkManualOverwrite)
{
    if (rating != undefined)
        Log.Message("Manually rate Security '" + securityNumber + "' to '" + rating);
        
    if (checkManualOverwrite != undefined)
        Log.Message("For Security '" + securityNumber + "' set Manual overwrite to "+ checkManualOverwrite);
    
    Search_Security(securityNumber);

    var isSecurityFound = false;
    var securitiesRowCount = Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
    for (var i = 1; i <= securitiesRowCount; i++){
        Get_SecurityGrid().Refresh();
        var securityRow = Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
        if (!securityRow.Exists)
            break;
        
        var securityColumnIndex = Get_SecurityGrid_ChSecurity().WPFControlOrdinalNo;
        var securityValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", securityColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", 1], 10).DisplayText);
        if (securityValue == securityNumber){
            isSecurityFound = true;
            Log.Message("'" + securityNumber + "' security found in the current page of 'Securities' grid at row index : " + i);
            securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", securityColumnIndex], 10).Click();
            break;
        }
    }
        
    if (!isSecurityFound){
        Log.Error("'" + securityNumber + "' security not found in the 'Securities' grid.");
        return;
    }
    
    //Open Security Info window
    Get_SecuritiesBar_BtnInfo().Click();
    WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448");
        
    //Change Rating
    if (rating != undefined){
        if (Get_WinInfoSecurity_GrpDescription_CmbRiskRating().Text == rating){
            var lowRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Low", language + client);
            var mediumRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Medium", language + client);
            var highRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_High", language + client);
            SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbRiskRating(), lowRating);
            SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbRiskRating(), mediumRating);
            SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbRiskRating(), highRating);
        }
        
        SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbRiskRating(), rating);
    }
    
    if (checkManualOverwrite != undefined)
        Get_WinInfoSecurity_GrpDescription_ChkManualOverwrite().set_IsChecked(checkManualOverwrite);
    
    Get_WinInfoSecurity_BtnOK().Click();
    if (Get_DlgConfirmAction().Exists){
        Get_DlgConfirmAction_TxtRiskIndexPasswordBox().Keys(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CroesusEncryptedPassword", language + client));
        Get_DlgConfirmAction().Click(Get_DlgConfirmAction().get_ActualWidth()/3, Get_DlgConfirmAction().get_ActualHeight()-45);
    }
}



function GetRatingRowIndexInManualOverwriteGrid(rating)
{
    var ManualOverwriteGrid = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
    if (ManualOverwriteGrid.Items.Count == 0)
        return null;
        
    var RatingColumnIndex = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChRating().WPFControlOrdinalNo;
    
    //Goto the first row
    ManualOverwriteGrid.Keys("[Home][Home]");
    
    //Navigate through the grid
    var isEndOfGridReached = false;
    while (!isEndOfGridReached){
        ManualOverwriteGrid.Refresh();
        var rowCount = ManualOverwriteGrid.ChildCount;
        for (var rowIndex = 1; rowIndex <= rowCount; rowIndex++){
            var currentRow = ManualOverwriteGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10); 
            if (!currentRow.Exists)
                break;
            
            var ratingCell = currentRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10);
            if (!ratingCell.Exists)
                break;
            
            var currentRatingValue = ratingCell.WPFControlText;
            if (currentRatingValue == rating)
                return rowIndex;
        }
        
        if (!ManualOverwriteGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10).Exists)
            break;
        
        var previousFirstRating = ManualOverwriteGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10).WPFControlText;
        ManualOverwriteGrid.Keys("[PageDown]");
        var currentFirstRating = ManualOverwriteGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10).WPFControlText;
        
        if (previousFirstRating == currentFirstRating){
            var previousFirstRating = ManualOverwriteGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10).WPFControlText;
            ManualOverwriteGrid.Keys("[PageDown]");
            var currentFirstRating = ManualOverwriteGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10).WPFControlText;
            
            if (previousFirstRating == currentFirstRating)
                isEndOfGridReached = true;
        }
    }
    
    return null;
}



function GetCriteriaCulturesList(componentObject)
{
    var nbOfCultures = componentObject.CulturesList.Count;
    var arrayOfCultures = new Array();
    for (var i = 0; i < nbOfCultures; i++)
        arrayOfCultures.push(componentObject.CulturesList.Item(i).Culture.NativeName);
    
    return arrayOfCultures;
}



function SelectCriterionCulture(componentObject, cultureName)
{
    Log.Message("Select culture : " + cultureName);
    componentObject.Click(componentObject.Width - 13, componentObject.Height/2);
    Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", VarToStr(cultureName)], 10).Click();
}




/*
    résultat : [nbOfActiveCriteria, nbOfInactiveCriteria]
*/
function GetListOfActiveAndInactiveCriteriaInBasicOverwriteCriteriaGrid()
{
    var arrayOfActiveCriteria = new Array();
    var arrayOfInactiveCriteria = new Array();
    
    var BasicOverwriteCriteriaGrid = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
    if (BasicOverwriteCriteriaGrid.Items.Count == 0)
        return [arrayOfActiveCriteria, arrayOfInactiveCriteria];
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    var activeCheckboxColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChActive().WPFControlOrdinalNo;
    var nameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
    
    //Goto the first row
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[Home] [Home]");
    
    //Navigate through the grid
    var isEndOfGridReached = false;
    var arrayOfDisplayedCriteriaNames = new Array();
    while (!isEndOfGridReached){
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Refresh();
        var rowCount = BasicOverwriteCriteriaGrid.ChildCount;
        for (var rowIndex = 1; rowIndex <= rowCount; rowIndex++){
            var currentRow = BasicOverwriteCriteriaGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentNameValue = currentRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", nameColumnIndex], 10).WPFControlText;
            if (arrayOfDisplayedCriteriaNames.indexOf(currentNameValue) != -1)
                continue;
            
            arrayOfDisplayedCriteriaNames.push(currentNameValue);
            
            var activeCheckbox = currentRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", activeCheckboxColumnIndex], 10).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1);
            if (activeCheckbox.IsChecked.OleValue)
                arrayOfActiveCriteria.push(currentNameValue);
            else
                arrayOfInactiveCriteria.push(currentNameValue);
            
        }
        
        var previousFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[PageDown]");
        var currentFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
        
        if (previousFirstName == currentFirstName){
            var previousFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
            Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[PageDown]");
            var currentFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
            
            if (previousFirstName == currentFirstName)
                isEndOfGridReached = true;
        }
    }
    
    return [arrayOfActiveCriteria, arrayOfInactiveCriteria];
}



function GetBooleanValue(ArrayOrStringValue)
{
    if (GetVarType(ArrayOrStringValue) == varArray || GetVarType(ArrayOrStringValue) == varDispatch){
        var arrayOfBooleanValues = new Array();
        for (var i in ArrayOrStringValue)
            arrayOfBooleanValues.push(GetBooleanValue(ArrayOrStringValue[i]));
        return arrayOfBooleanValues;
    }
    
    ArrayOrStringValue = aqString.ToUpper(Trim(VarToStr(ArrayOrStringValue)));
    
    if (GetIndexOfItemInArray(["VRAI", "OUI", "TRUE", "YES"], ArrayOrStringValue) != -1)
        return true;
    
    if (GetIndexOfItemInArray(["FAUX", "NON", "FALSE", "NO"], ArrayOrStringValue) != -1)
        return false;
    
    return null;
}


// A METTRE DANS LES FONCTIONS GET

// Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwrite() //A mettre à jour pour : Get_WinRiskRatingCriteriaEditor_GrpOption_ChkOverwriteCriteria

function Get_SecurityGrid_AnyDisplayedColumnHeader(){return Get_SecurityGrid().FindChild("ClrClassName", "HeaderLabelArea", 10).FindChild(["ClrClassName", "VisibleOnScreen"], ["LabelPresenter", true], 10)}

function Get_WinRiskRatingCriteriaEditor_GrpRating_CmbRating(){return Get_WinRiskRatingCriteriaEditor_GrpRating().FindChild("Uid", "ComboBox_06da", 10)}