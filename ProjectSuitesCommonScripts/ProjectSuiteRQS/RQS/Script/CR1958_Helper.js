//USEUNIT Common_functions
//USEUNIT DBA
//USEUNIT ExcelUtils

NameMapping.TimeOutWarning = false;
var CR1958_LOG_ATTRIBUTES_BOLD = Log.CreateNewAttributes();
CR1958_LOG_ATTRIBUTES_BOLD.Bold = true;

var CR1958_GRAPH_TITLE_RISKSCORE = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Title_RiskScore", language + client);
var CR1958_GRAPH_TITLE_RISKOBJECTIVES = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Title_RiskObjectives", language + client);
var CR1958_GRAPH_TITLE_RISKALLOCATION = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Title_RiskAllocation", language + client);

var CR1958_PERCENT_VALUES_TOLERANCE = ConvertStrToNumberFormat(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_PercentsValues_Tolerance", language + client));
var CR1958_GRAPH_TOOLTIP_MARKET_VALUES_TOLERANCE = ConvertStrToNumberFormat(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_CurrentMarketValue_FloatValuesTolerance", language + client));
var CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_GraphAndToolTip_PercentSymbol", language + client);
var CR1958_GRAPH_MARKET_VALUES_NB_DECIMALS = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_NumberOfDecimals_ForMarketValues", language + client));
var CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_NumberOfDecimals_ForPercentsValues", language + client));
var CR1958_GRAPH_PERCENTS_LABEL_SPLITTER = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_PercentsLabel_Splitter", language + client);

var CR1958_GRAPH_FLOAT_VALUES_CHECKPOINT_TOLERANCE_PERCENT = ConvertStrToNumberFormat(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_FloatValuesCheckpointTolerance_Percent", language + client));
var CR1958_GRAPH_MIN_PIXELS_BETWEEN_IDENTIFICATION_LABELS_AND_TRIANGLES = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_MinPixelsNb_Between_IdentificationLabels_Triangles", language + client));
var CR1958_GRAPH_MIN_PIXELS_BETWEEN_LEVELS_IDENTIFICATION_LABELS_AND_RECTANGLES = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_MinPixelsNb_Between_IdentificationLabels_Rectangles", language + client));
var CR1958_GRAPH_MIN_PIXELS_BETWEEN_RECTANGLES_TRIANGLES_AND_PERCENTS_LABELS = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_MinPixelsNb_Between_RectanglesTriangles_PercentsLabels", language + client));
var CR1958_GRAPH_MIN_PIXELS_BETWEEN_ADJACENT_LEVELS_COMPONENTS = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_MinPixelsNb_Between_Adjacent_LevelsComponents", language + client));
var CR1958_GRAPH_MAX_PIXELS_BETWEEN_LEVEL_RECTANGLE_AND_TRIANGLE = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_MaxPixelsNb_Between_Rectangle_Triangle", language + client));
var CR1958_GRAPH_MAX_PIXELS_LEFT_DEVIATION_TOLERANCE_FOR_VERTICALLY_ALIGNED_ITEMS = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_MaxPixelsNb_LeftDeviation_ForVertically_Aligned_Items", language + client));
var CR1958_GRAPH_MAX_PIXELS_NB_TOLERANCE_FOR_HORIZONTAL_AXIS_PERCENTS_LABELS_POSITIONS = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_MaxPixelsNb_Tolerance_For_HorizontalAxis_PercentsLabels_Positions", language + client));

InitializeConfigurationInformation();



//*************** Initialisation Config

function InitializeConfigurationInformation()
{
    CR1958_SECURITY_RISK_RATINGS = CR1958_Get_arrayOfSecurityRiskRatingsLabels(); //Rows
    CR1958_RISK_ALLOCATION_LEVELS = CR1958_Get_arrayOfRiskAllocationLevelsLabels(); //Columns
    CR1958_SECURITY_RISK_RATINGS_WEIGHTS = CR1958_Get_ArrayOfArrayOfSecurityRiskRatingsWeights(); //Rows
    CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS = CR1958_Get_ArrayOfArrayOfRiskAllocationLevelsWeights(); //Columns
    CR1958_RISK_ALLOCATION_LEVELS_COLORS = CR1958_Get_ArrayOfAllocationColors(client);
    CR1958_RISK_ALLOCATION_CLIENT_PROFILE_NAMES = CR1958_Get_ArrayOfClientProfileNames();
    CR1958_RISK_ALLOCATION_CLIENT_PROFILE_CODES = CR1958_Get_ArrayOfClientProfileCodes();
}


function IsThereClientProfilesForRiskObjectives()
{
    for (var key in CR1958_RISK_ALLOCATION_CLIENT_PROFILE_NAMES)
        if (VarToStr(CR1958_RISK_ALLOCATION_CLIENT_PROFILE_NAMES[key]) != "")
            return true;
    return false;
}


function GetTransposedArray2D(array2D)
{
    var columnKeys = GetArrayKeys(array2D);
    if (columnKeys.length == 0) return array2D;
    var rowsKeys = GetArrayKeys(array2D[columnKeys[0]]);
    var transposedArray2D = [];
    for (var i in rowsKeys) transposedArray2D[rowsKeys[i]] = [];
    for (var column in array2D)
        for (var row in array2D[column])
            transposedArray2D[row][column] = array2D[column][row];
    return transposedArray2D;
}



//Récupérer la liste des de toutes les répartitions du Client
function CR1958_Get_arrayOfSecurityRiskRatingsLabels()
{
    var dataSeparatorChar       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_RiskRating_Labels_And_Levels_SeparatorChar", language + client);
    var allRatingLabels         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_RiskRating_AllLabels_FromTheMostRisky_ToTheLeastRisky", language + client);
    var arrayOfAllRatingLabels  = (Trim(allRatingLabels) == "")? []: allRatingLabels.split(dataSeparatorChar);
    return arrayOfAllRatingLabels;
}


//Récupérer la liste des niveaux de risque du Client
function CR1958_Get_arrayOfRiskAllocationLevelsLabels()
{
    var dataSeparatorChar       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_RiskRating_Labels_And_Levels_SeparatorChar", language + client);
    var riskRatingLevels        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_RiskRating_Levels_Labels", language + client);
    var arrayOfRiskRatingLevels = (Trim(riskRatingLevels) == "")? []: riskRatingLevels.split(dataSeparatorChar);
    return arrayOfRiskRatingLevels;
}



function CR1958_Get_ArrayOfArrayOfSecurityRiskRatingsWeights()
{
    //Risk Rating levels labels and levels
    var arrayOfSecurityRiskRatings  = CR1958_Get_arrayOfSecurityRiskRatingsLabels();
    var arrayOfRiskAllocationLevels = CR1958_Get_arrayOfRiskAllocationLevelsLabels();
    
    //Whole allocation weights table
    var arrayOfArrayOfSecurityRiskRatingsWeights = [];
    for (var i in arrayOfSecurityRiskRatings){
        var ratingRow = arrayOfSecurityRiskRatings[i];
        arrayOfArrayOfSecurityRiskRatingsWeights[ratingRow] = [];
        for (var j in arrayOfRiskAllocationLevels){
            var levelColumn = arrayOfRiskAllocationLevels[j];
            var weight = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958_Config_" + language + client, ratingRow, levelColumn);
            arrayOfArrayOfSecurityRiskRatingsWeights[ratingRow][levelColumn] = ConvertStrToNumberFormat(weight);
        }
    }
    
    return arrayOfArrayOfSecurityRiskRatingsWeights;
}



function CR1958_Get_ArrayOfArrayOfRiskAllocationLevelsWeights()
{
    //Risk Rating levels labels and levels
    var arrayOfSecurityRiskRatings  = CR1958_Get_arrayOfSecurityRiskRatingsLabels();
    var arrayOfRiskAllocationLevels = CR1958_Get_arrayOfRiskAllocationLevelsLabels();
    
    //Whole allocation weights table
    var arrayOfArrayOfRiskAllocationLevelsWeights = [];
    for (var i in arrayOfRiskAllocationLevels){
        var levelColumn = arrayOfRiskAllocationLevels[i];
        arrayOfArrayOfRiskAllocationLevelsWeights[levelColumn] = [];
        for (var j in arrayOfSecurityRiskRatings){
            var ratingRow = arrayOfSecurityRiskRatings[j];
            var weight = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958_Config_" + language + client, ratingRow, levelColumn);
            arrayOfArrayOfRiskAllocationLevelsWeights[levelColumn][ratingRow] = ConvertStrToNumberFormat(weight);
        }
    }
    
    return arrayOfArrayOfRiskAllocationLevelsWeights;
}


function CR1958_Get_ArrayOfAllocationColors(client)
{
    var arrayOfRiskRatingLevels = CR1958_Get_arrayOfRiskAllocationLevelsLabels();
    
    var arrayOfAllocationColors = [];
    for (var k in arrayOfRiskRatingLevels){
        var riskRatingLevel = arrayOfRiskRatingLevels[k];
        arrayOfAllocationColors[riskRatingLevel] = {};
        arrayOfAllocationColors[riskRatingLevel].R = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958_Config_" + language + client, "Color-R", riskRatingLevel);
        arrayOfAllocationColors[riskRatingLevel].G = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958_Config_" + language + client, "Color-G", riskRatingLevel);
        arrayOfAllocationColors[riskRatingLevel].B = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958_Config_" + language + client, "Color-B", riskRatingLevel);
        arrayOfAllocationColors[riskRatingLevel].Hex = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958_Config_" + language + client, "Color-RGBHex", riskRatingLevel);
    }
    
    return arrayOfAllocationColors;
}

function CR1958_Get_ArrayOfClientProfileNames()
{
    var arrayOfRiskRatingLevels = CR1958_Get_arrayOfRiskAllocationLevelsLabels();
    
    var arrayOfClientProfileNames = [];
    for (var k in arrayOfRiskRatingLevels){
        var riskRatingLevel = arrayOfRiskRatingLevels[k];
        arrayOfClientProfileNames[riskRatingLevel] = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958_Config_" + language + client, "Mnemonic-Code", riskRatingLevel);
    }
    
    return arrayOfClientProfileNames;
}


function CR1958_Get_ArrayOfClientProfileCodes()
{
    var arrayOfRiskRatingLevels = CR1958_Get_arrayOfRiskAllocationLevelsLabels();
    
    var arrayOfClientProfileCodes = [];
    for (var k in arrayOfRiskRatingLevels){
        var riskRatingLevel = arrayOfRiskRatingLevels[k];
        arrayOfClientProfileCodes[riskRatingLevel] = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958_Config_" + language + client, "Profile-Code", riskRatingLevel);
    }
    
    return arrayOfClientProfileCodes;
}



//*************************** CONFIGURATION *************************************

function SetRiskAllocationLevelsWeightsAndClientProfileNames(arrayOfArrayOfSecurityRiskRatingsWeights, arrayOfRiskAllocationLevelsClientProfileNames, rememberResult)
{
    if (rememberResult == undefined)
        rememberResult = false;
    
    Log.AppendFolder("CR1958 Configuration", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5468", "SetRiskAllocationLevelsWeightsAndClientProfileNames()");
    
    if (typeof IS_CR1958_CONFIGURATION_PREVIOUSLY_EXECUTED != "undefined" && IS_CR1958_CONFIGURATION_PREVIOUSLY_EXECUTED === true && typeof IS_CR1958_CONFIGURATION_PREVIOUSLY_EXECUTED_WITHOUT_ISSUE != "undefined" && IS_CR1958_CONFIGURATION_PREVIOUSLY_EXECUTED_WITHOUT_ISSUE === true){
        var isAllocationWeightsTableToBeUpdated = false;
        if (arrayOfArrayOfSecurityRiskRatingsWeights != undefined){
            for (securityRiskRatingRow in CR1958_SECURITY_RISK_RATINGS_WEIGHTS){
                for (riskAllocationLevelColumn in CR1958_SECURITY_RISK_RATINGS_WEIGHTS[securityRiskRatingRow]){
                    if (CR1958_SECURITY_RISK_RATINGS_WEIGHTS[securityRiskRatingRow][riskAllocationLevelColumn] != arrayOfArrayOfSecurityRiskRatingsWeights[securityRiskRatingRow][riskAllocationLevelColumn]){
                        isAllocationWeightsTableToBeUpdated = true;
                        break;
                    }
                }
                if (isAllocationWeightsTableToBeUpdated)
                    break;
            }
        
            if (!isAllocationWeightsTableToBeUpdated)
                arrayOfArrayOfSecurityRiskRatingsWeights = null;
        }
    
        var isAllocationClientProfileNameTableToBeUpdated = false;
        if (arrayOfRiskAllocationLevelsClientProfileNames != undefined){
            for (riskAllocationLevel in CR1958_RISK_ALLOCATION_CLIENT_PROFILE_NAMES)
                if (CR1958_RISK_ALLOCATION_CLIENT_PROFILE_NAMES[riskAllocationLevel] != arrayOfRiskAllocationLevelsClientProfileNames[riskAllocationLevel]){
                    isAllocationClientProfileNameTableToBeUpdated = true;
                    break;
                }
        
            if (!isAllocationClientProfileNameTableToBeUpdated)
                arrayOfRiskAllocationLevelsClientProfileNames = null;
        }
        
        if (isAllocationWeightsTableToBeUpdated === false && isAllocationClientProfileNameTableToBeUpdated === false){        
                Log.Message("No need to update Risk Allocation configuration.");
                Log.PopLogFolder();
                return;
        }
        else
            Log.Message("Update Risk Allocation configuration.");
    }
    
    try {
        IS_CR1958_CONFIGURATION_PREVIOUSLY_EXECUTED = null;
        IS_CR1958_CONFIGURATION_PREVIOUSLY_EXECUTED_WITHOUT_ISSUE = null;
        var previousErrorCount_CR1958_Config = Log.ErrCount;
        var previousWarningCount_CR1958_Config = Log.WrnCount;
        var productionPassword = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "PREF_SECURITY_RATING_PASSWORD", language + client);
        
        //Connect to croesus (user = KEYNEJ, Firm Administrator)
        var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Prefs
//        var firm_code = GetUserFirmCode(userKEYNEJ, vServerRQS);
//        var arrayOfPrefsValues = CR1958_GetArrayOfPrefsValues();
//        UpdateFirmArrayOfPrefs(vServerRQS, firm_code, arrayOfPrefsValues);
        
        //Login
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        Get_MainWindow().Maximize();
        
        //Open the Risk Allocation Configuration Tool window
        var numTry = 0;
        do {
            Delay(5000);
            Get_MenuBar_Tools().Click();
        } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1000, 3500))
        
        Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 6000);
        Get_WinConfigurations().Parent.Maximize();
        
        WaitObject(Get_WinConfigurations(), ["Uid"], ["TreeView_f006"]);
        var nbTries = 0;
        while (++nbTries < 20 && !Get_WinConfigurations_TvwTreeview_LlbRiskComplianceManager().Exists)
            Delay(1000);
        Get_WinConfigurations_TvwTreeview_LlbRiskComplianceManager().Click();
        
        WaitObject(Get_WinConfigurations(), ["ClrClassName", "WPFControlOrdinalNo"], ["ListViewItem", 1]);
        var nbTries = 0;
        while (++nbTries < 20 && !Get_WinConfigurations_LvwListView_LlbRiskRatingAllocation().Exists)
            Delay(1000);
        Get_WinConfigurations_LvwListView_LlbRiskRatingAllocation().DblClick();
        
        //Input Risk Rating Weights for all ratings
        Get_WinRiskAllocationConfigurationTool().Parent.Position(0, 0, Get_MainWindow().Width, Get_MainWindow().Height);
        if (arrayOfArrayOfSecurityRiskRatingsWeights != undefined){
            for (var securityRiskRatingRow in arrayOfArrayOfSecurityRiskRatingsWeights)
                for (var riskAllocationLevelColumn in arrayOfArrayOfSecurityRiskRatingsWeights[securityRiskRatingRow])
                    InputSecurityRiskRatingWeightForRiskAllocationLevelInRiskAllocationConfigurationTool(securityRiskRatingRow, riskAllocationLevelColumn, arrayOfArrayOfSecurityRiskRatingsWeights[securityRiskRatingRow][riskAllocationLevelColumn]);
        }
        
        //Risk Rating Profiles Mnemonic codes
        if (arrayOfRiskAllocationLevelsClientProfileNames != undefined){
            for (var riskAllocationLevel in arrayOfRiskAllocationLevelsClientProfileNames)
                InputClientProfileNameForRiskAllocationLevelInRiskAllocationConfigurationTool(riskAllocationLevel, arrayOfRiskAllocationLevelsClientProfileNames[riskAllocationLevel]);
        }
        
        //Save
        Get_WinRiskAllocationConfigurationTool_BtnSave().Click();
        Get_DlgConfirmation_TxtRiskIndexPasswordBox().Keys(productionPassword);
        Get_DlgConfirmation_BtnConfirm().Click();
        Get_WinConfigurations().WaitProperty("Focused", true, PROJECT_AUTO_WAIT_TIMEOUT);
        Get_WinConfigurations().Close();
        Get_MainWindow().WaitProperty("Focused", true, PROJECT_AUTO_WAIT_TIMEOUT);
        
        //Excute Risk Rating plugin
        ExecuteCfLoaderRiskRatingPlugin();
        if (rememberResult === true)
            IS_CR1958_CONFIGURATION_PREVIOUSLY_EXECUTED = true;
        
        //Close Croesus
        CloseCroesus();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        RestartServices(vServerRQS);
        if (rememberResult === true)
            IS_CR1958_CONFIGURATION_PREVIOUSLY_EXECUTED_WITHOUT_ISSUE = (0 == (Log.ErrCount - previousErrorCount_CR1958_Config) && (0 == (Log.WrnCount - previousWarningCount_CR1958_Config)));
        Terminate_CroesusProcess();
        Delay(PROJECT_AUTO_WAIT_TIMEOUT/2);
    }
    
     Log.PopLogFolder();
}



function InputSecurityRiskRatingWeightForRiskAllocationLevelInRiskAllocationConfigurationTool(securityRiskRatingName, riskAllocationLevelName, ratingLevelWeightValue)
{
    //Input weight
    Log.Message("Input weight '" + ratingLevelWeightValue + "' for securityRiskRating row '" + securityRiskRatingName + "' and riskAllocationLevel column '" + riskAllocationLevelName + "'");
    var ratingLevelWeightCell = Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation_TxtRatingLevelWeightCell(securityRiskRatingName, riskAllocationLevelName);
    if (!ratingLevelWeightCell.Exists){
        Log.Error("securityRiskRating row '" + securityRiskRatingName + "' and riskAllocationLevel column '" + riskAllocationLevelName + "' cell not found.");
        return false;
    }
    
    if (VarToStr(ratingLevelWeightCell.DisplayText) == VarToStr(ratingLevelWeightValue))
        Log.Message("The existing weight '" + ratingLevelWeightValue + "' matches the new one, no need to input it (for securityRiskRating row '" + securityRiskRatingName + "' and riskAllocationLevel column '" + riskAllocationLevelName + "')");
    else {
        ratingLevelWeightCell.Click();
        ratingLevelWeightCell.Keys(ratingLevelWeightValue + "[Tab]");
        Delay(500);
        if (!WaitObject(ratingLevelWeightCell.Parent, ["ClrClassName", "DisplayText"], ["XamNumericEditor", ratingLevelWeightValue], 10000, false))
            Log.Error("Input was not successfull by timeout : weight '" + ratingLevelWeightValue + "' for securityRiskRating row '" + securityRiskRatingName + "' and riskAllocationLevel column '" + riskAllocationLevelName + "'");
    }
    
    //Verify the values in Total column and then Check Save button Enable state
    var isTotalEqualToHundredEverywhere = true;
    var dgvRecordListControl = Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
    dgvRecordListControl.Refresh();
    var allSecurityRiskRatingRows = dgvRecordListControl.FindAllChildren(["ClrClassName", "Visible"], ["DataRecordPresenter", true], 10).toArray();
    for (var allSecurityRiskRatingRowsIndex = 0; allSecurityRiskRatingRowsIndex < allSecurityRiskRatingRows.length; allSecurityRiskRatingRowsIndex++){
        var DataRecordCellArea = allSecurityRiskRatingRows[allSecurityRiskRatingRowsIndex].FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordCellArea", 1], 10);
        if (!DataRecordCellArea.Exists)
            continue;
            
        var rowTotalValue = DataRecordCellArea.FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "Total"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", 1], 10).DisplayText.OleValue;
        if (VarToStr(rowTotalValue) != '100'){
            isTotalEqualToHundredEverywhere = false;
            break;
        }
    }
    
    return CompareProperty(Get_WinRiskAllocationConfigurationTool_BtnSave().IsEnabled, cmpEqual, isTotalEqualToHundredEverywhere, true, lmError);
}



function InputClientProfileNameForRiskAllocationLevelInRiskAllocationConfigurationTool(riskAllocationLevelName, riskAllocationLevelMnemonicCode)
{
    //Input Risk Allocation Level Mnemonic Code
    Log.Message("Input Mnemonic Code '" + riskAllocationLevelMnemonicCode + "' for Risk Allocation Level row '" + riskAllocationLevelName + "'");
    var mnemonicCodeCell = Get_WinRiskAllocationConfigurationTool_DgvClientRiskObjectives_TxtRatingLevelMnemonicCodeCell(riskAllocationLevelName);
    if (!mnemonicCodeCell.Exists){
        Log.Error("Risk Allocation Level row '" + riskAllocationLevelName + "' cell not found.");
        return false;
    }
    
    if (VarToStr(mnemonicCodeCell.DisplayText) == VarToStr(riskAllocationLevelMnemonicCode)){
        Log.Message("The existing Mnemonic Code '" + riskAllocationLevelMnemonicCode + "' matches the new one, no need to input it (for Risk Allocation Level row '" + riskAllocationLevelName + "')");
        return true;
    }
    else {
        mnemonicCodeCell.Click();
        mnemonicCodeCell.Keys("[BS]" + riskAllocationLevelMnemonicCode + "[Tab]");
        Delay(500);
        if (WaitObject(mnemonicCodeCell.Parent, ["ClrClassName", "DisplayText"], ["XamTextEditor", riskAllocationLevelMnemonicCode], 2000, false) || (riskAllocationLevelMnemonicCode == "" && mnemonicCodeCell.DisplayText == null))
            return true;
        else {
            Log.Error("Input was not successfull by timeout : Mnemonic Code '" + riskAllocationLevelMnemonicCode + "' for Risk Allocation Level row '" + riskAllocationLevelName + "'");
            return false;
        }
    }
}




//************************ CALCULATIONS *****************************************

function CalculateAllocationLevelPercent_ModelToPortfolio_PositiveBalance(positionsOrTargetsArray, arrayOfWeights)
{
    Log.Message("CalculateAllocationLevelPercent_ModelToPortfolio_PositiveBalance()");
    
    if (!CheckArraysKeysMatch(positionsOrTargetsArray, arrayOfWeights))
        return null;
    
    var ratingValueDotProduct = 0;
    for (var key in arrayOfWeights)
        ratingValueDotProduct += positionsOrTargetsArray[key] * arrayOfWeights[key];
    
    return (ratingValueDotProduct / 100);
}



function CalculateAllocationLevelPercent_ModelToPortfolio_NegativeBalance(arrayOfMarketOrTargetPercentValues, arrayOfWeights)
{
    Log.Message("CalculateAllocationLevelPercent_ModelToPortfolio_NegativeBalance()");
    
    if (!CheckArraysKeysMatch(arrayOfMarketOrTargetPercentValues, arrayOfWeights))
        return null;
    
    var allocationValueDotProduct = 0;
    var totalPercents = 0;
    for (var key in arrayOfWeights){
        allocationValueDotProduct += Math.abs(arrayOfMarketOrTargetPercentValues[key]) * arrayOfWeights[key];
        totalPercents += Math.abs(arrayOfMarketOrTargetPercentValues[key]);
    }
    
    return (allocationValueDotProduct / totalPercents);
}



function CalculateCurrentMarketValuePercentForSecurityRating_Portfolio(arrayOfMarketValues, marketValuesTotal)
{
    Log.Message("CalculateCurrentMarketValuePercentForSecurityRating_Portfolio()");
    
    var totalValueForAllRatings = 0;
    for (var key in arrayOfMarketValues)
        totalValueForAllRatings += Math.abs(arrayOfMarketValues[key]);
    
    return (100 * marketValuesTotal / totalValueForAllRatings);
}



function CalculateAllocationLevelPercent_ClientToPortfolio(arrayOfPositions, arrayOfWeights)
{
    Log.Message("CalculateAllocationLevelPercent_ClientToPortfolio()");
    
    if (!CheckArraysKeysMatch(arrayOfPositions, arrayOfWeights))
        return null;
    
    var valuesDotProduct = 0;
    var valuesSum = 0;
    for (var key in arrayOfWeights){
        valuesDotProduct += Math.abs(arrayOfPositions[key]) * arrayOfWeights[key];
        valuesSum += Math.abs(arrayOfPositions[key]);
    }
    
    return (valuesDotProduct / valuesSum);
}





//************************ TOOLTIPS*****************************************

function HoverMouseOnComponentInProjectedPortfolioGraph(componentObject)
{
    return HoverMouseOnComponent(componentObject, "PROJECTED PORTFOLIO");
}



function HoverMouseOnComponentInPortfolioGraph(componentObject)
{
    return HoverMouseOnComponent(componentObject, "PORTFOLIO");
}


//graphLocation : PORTFOLIO or PROJECTED PORTFOLIO
function HoverMouseOnComponent(componentObject, graphLocation)
{
    if (aqString.ToUpper(VarToStr(graphLocation)) == "PORTFOLIO")
        var scrollViewerObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts();
    else
        var scrollViewerObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts();
    
    var isPopupRootFound = false;
    
    if (componentObject == null || !componentObject.Exists)
        Log.Error("Component not found.");
    else {
        var maxNbOfTries = 3;
        var nbOfTries = 1;
        do {
            scrollViewerObject.HoverMouse(5, 5);
            Delay(nbOfTries * nbOfTries * 500);
            componentObject.HoverMouse();
            isPopupRootFound = WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 30000, false);
        } while (!isPopupRootFound && ++nbOfTries <= maxNbOfTries)
        
        if (!isPopupRootFound)
            Log.Error("Upon the HoverMouse action, no popup (tooltip) was found by timeout.");
    }
    
    return isPopupRootFound;
}



function GetRiskAllocationTooltipDataGridContent(componentObject, graphLocation)
{
    if (graphLocation == undefined)
        graphLocation = null;
    
    Log.Message("GetRiskAllocationTooltipDataGridContent()");
    var nbOfTriesLeft = 3;
    Log.LockEvents(3);
    
    while (nbOfTriesLeft > 0){
        try {
            nbOfTriesLeft --;
            var exceptionRaised = false;
            var arrayOfArrayOfTooltipGridContent = new Array();
    
            if (componentObject != undefined && componentObject.Exists)
                HoverMouseOnComponent(componentObject, graphLocation);
    
            var riskAllocationTooltipDataGrid = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_DgvAllocations();
        
            if (riskAllocationTooltipDataGrid == null || !riskAllocationTooltipDataGrid.Exists)
                Log.Error("The Risk Allocation Tooltip DataGrid does not exist");
            else {
                //Grid headers indexes
                var column_SecuritiesRiskRating_Index   = 1;
                var column_Allocation_Index = 2;
                var column_CurrentMarketValue_Index = 3;
        
                //Get Grid columns Headers
                var arrayOfGridContentHeaders = [];
        
                if (componentObject != undefined && componentObject.Exists){
                    HoverMouseOnComponent(componentObject, graphLocation);
                    var riskAllocationTooltipDataGrid = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_DgvAllocations();
                }
                var column_SecuritiesRiskRating_Header = riskAllocationTooltipDataGrid.FindChild(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["DataGridColumnHeader", true, column_SecuritiesRiskRating_Index], 10);
                arrayOfGridContentHeaders[arrayOfGridContentHeaders.length] = (column_SecuritiesRiskRating_Header.Exists)? VarToStr(column_SecuritiesRiskRating_Header.WPFControlText): null;
            
                if (componentObject != undefined && componentObject.Exists){
                    HoverMouseOnComponent(componentObject, graphLocation);
                    var riskAllocationTooltipDataGrid = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_DgvAllocations();
                }
                var column_Allocation_Header = riskAllocationTooltipDataGrid.FindChild(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["DataGridColumnHeader", true, column_Allocation_Index], 10);
                arrayOfGridContentHeaders[arrayOfGridContentHeaders.length] = (column_Allocation_Header.Exists)? VarToStr(column_Allocation_Header.WPFControlText): null;
        
                if (componentObject != undefined && componentObject.Exists){
                    HoverMouseOnComponent(componentObject, graphLocation);
                    var riskAllocationTooltipDataGrid = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_DgvAllocations();
                }
                var column_CurrentMarketValue_Header    = riskAllocationTooltipDataGrid.FindChild(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["DataGridColumnHeader", true, column_CurrentMarketValue_Index], 10);
                arrayOfGridContentHeaders[arrayOfGridContentHeaders.length] = (column_CurrentMarketValue_Header.Exists)? VarToStr(column_CurrentMarketValue_Header.WPFControlText): null;
            
                arrayOfArrayOfTooltipGridContent.push(arrayOfGridContentHeaders);
            
                //Get Grid rows content
                if (componentObject != undefined && componentObject.Exists){
                    HoverMouseOnComponent(componentObject, graphLocation);
                    var riskAllocationTooltipDataGrid = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_DgvAllocations();
                }
                var gridRowCount = riskAllocationTooltipDataGrid.FindAllChildren(["ClrClassName", "Visible"], ["DataGridRow", true]).toArray().length;
        
                for (var gridRowIndex = 1; gridRowIndex <= gridRowCount; gridRowIndex++){
                    var gridCurrentRowValues = [];
                
                    if (componentObject != undefined && componentObject.Exists){
                        HoverMouseOnComponent(componentObject, graphLocation);
                        var riskAllocationTooltipDataGrid = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_DgvAllocations();
                    }
                    var gridRow = riskAllocationTooltipDataGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataGridRow", gridRowIndex]);
            
                    if (componentObject != undefined && componentObject.Exists){
                        HoverMouseOnComponent(componentObject, graphLocation);
                        var riskAllocationTooltipDataGrid = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_DgvAllocations();
                        var gridRow = riskAllocationTooltipDataGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataGridRow", gridRowIndex]);
                    }
                    var riskRatingLevel = gridRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataGridCell", column_SecuritiesRiskRating_Index], 10);
                    gridCurrentRowValues[gridCurrentRowValues.length] = (riskRatingLevel.Exists)? VarToStr(riskRatingLevel.WPFControlText): null;
                
                    if (componentObject != undefined && componentObject.Exists){
                        HoverMouseOnComponent(componentObject, graphLocation);
                        var riskAllocationTooltipDataGrid = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_DgvAllocations();
                        var gridRow = riskAllocationTooltipDataGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataGridRow", gridRowIndex]);
                    }
                    var riskRatingAllocation = gridRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataGridCell", column_Allocation_Index], 10);
                    gridCurrentRowValues[gridCurrentRowValues.length] = (riskRatingAllocation.Exists)? VarToStr(riskRatingAllocation.WPFControlText): null;
                
                    if (componentObject != undefined && componentObject.Exists){
                        HoverMouseOnComponent(componentObject, graphLocation);
                        var riskAllocationTooltipDataGrid = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_DgvAllocations();
                        var gridRow = riskAllocationTooltipDataGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataGridRow", gridRowIndex]);
                    }
                    var riskRatingCurrentMarketValue = gridRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataGridCell", column_CurrentMarketValue_Index], 10);
                    gridCurrentRowValues[gridCurrentRowValues.length] = (riskRatingCurrentMarketValue.Exists)? VarToStr(riskRatingCurrentMarketValue.WPFControlText): null;
                
                    arrayOfArrayOfTooltipGridContent.push(gridCurrentRowValues);
                }
            }
        }
        catch (e_GetRiskAllocationTooltipDataGridContent){
            exceptionRaised = true;
            if (nbOfTriesLeft > 0)
                Log.Message("Try GetRiskAllocationTooltipDataGridContent() " + nbOfTriesLeft + " more time(s), there was Exception. " + e_GetRiskAllocationTooltipDataGridContent.message, VarToStr(e_GetRiskAllocationTooltipDataGridContent.stack));
            else
                Log.Error("Exception : " + e_GetRiskAllocationTooltipDataGridContent.message, VarToStr(e_GetRiskAllocationTooltipDataGridContent.stack));
            e_GetRiskAllocationTooltipDataGridContent = null;
            
        }
        finally {
            if (!exceptionRaised)
                nbOfTriesLeft = 0;
        }
    }
    
    var isNullValueFound = false;
    for (var rowIndex = 0; rowIndex < arrayOfArrayOfTooltipGridContent.length; rowIndex++){
        var arrayOfTooltipGridContent = arrayOfArrayOfTooltipGridContent[rowIndex];
        for (var columnIndex = 0; columnIndex < arrayOfTooltipGridContent.length; columnIndex++){
            if (arrayOfTooltipGridContent[columnIndex] === null){
                Log.Message("GetRiskAllocationTooltipDataGridContent() : Some grid value(s) of the tooltip were empty.");///
                isNullValueFound = true;
                break;
            }
        }
        if (isNullValueFound)
            break;
    }
    
    Log.UnlockEvents();
    return arrayOfArrayOfTooltipGridContent;
}



function CheckEqualsForTooltipDataGridContent(arrayOfArrayOfDisplayedValues, arrayOfArrayOfExpectedValues, description, floatValuesCheckpointTolerance, picture)
{
    try {
        if (floatValuesCheckpointTolerance == undefined)
            floatValuesCheckpointTolerance = 0;
            
        if (picture == undefined)
            picture = null;
        
        var riskRatingCurrentMarketValueIndex = 2;
        var isQuickSuccess = false;
        var arrayOfErrorMessages = [];
        var arrayOfWarningMessages = [];
        
        var stringOfDisplayedValues = GetStringOfArray2D(arrayOfArrayOfDisplayedValues);
        var stringOfExpectedValues = GetStringOfArray2D(arrayOfArrayOfExpectedValues);
        if (stringOfDisplayedValues == stringOfExpectedValues){
            isQuickSuccess = true;
            return;
        }
    
        if (arrayOfArrayOfDisplayedValues.length != arrayOfArrayOfExpectedValues.length){
            arrayOfErrorMessages.push("The number of displayed grid rows (" + arrayOfArrayOfDisplayedValues.length + ") does not match the expected (" + arrayOfArrayOfExpectedValues.length + ") rows.");
            return false;
        }
    
        var columnsCount = 0
        var isDimensionsCheckOK = null; 
        for (var rowIndex = 0; rowIndex < arrayOfArrayOfDisplayedValues.length; rowIndex++){
            var arrayOfDisplayedValues = arrayOfArrayOfDisplayedValues[rowIndex];
            var arrayOfExpectedValues = arrayOfArrayOfExpectedValues[rowIndex];
            if (arrayOfDisplayedValues.length == arrayOfExpectedValues.length){
                if (isDimensionsCheckOK === null)
                    isDimensionsCheckOK = true;
            }
            else {
                arrayOfErrorMessages.push("Tooltip datagrid Displayed grid columns at Row " + (rowIndex + 1) + " (" + arrayOfDisplayedValues.length + ") does not match the expected (" + arrayOfExpectedValues.length + ") columns.");
                isDimensionsCheckOK = false;
            }
            
            columnsCount = arrayOfExpectedValues.length;
        }
        
        if (isDimensionsCheckOK === false)
            return;
        
        var expectedNumberOfSuccess = columnsCount * arrayOfArrayOfExpectedValues.length;
        var actualNumberOfSuccess = 0;
        for (var rowIndex = 0; rowIndex < arrayOfArrayOfDisplayedValues.length; rowIndex++){
            var arrayOfDisplayedValues = arrayOfArrayOfDisplayedValues[rowIndex];
            var arrayOfExpectedValues = arrayOfArrayOfExpectedValues[rowIndex];
            
            for (var columnIndex = 0; columnIndex < arrayOfDisplayedValues.length; columnIndex++){
                var cellIdentifier = (rowIndex == 0)? "'" + arrayOfArrayOfExpectedValues[0][columnIndex] + "' colummn header": "'" + arrayOfArrayOfExpectedValues[rowIndex][0] + " " + arrayOfArrayOfExpectedValues[0][columnIndex] + "'";
                var displayedValue = arrayOfDisplayedValues[columnIndex];
                var expectedValue = arrayOfExpectedValues[columnIndex];
                if (displayedValue === null)
                    arrayOfErrorMessages.push("Tooltip datagrid Displayed value for " + cellIdentifier + " at Row " + (rowIndex + 1) + ", Column " + (columnIndex + 1) + " was not successfully retrieved. Expecting it to be '" + expectedValue + "'.");
                else {
                    if (displayedValue == expectedValue){
                        actualNumberOfSuccess ++;
                        continue;
                    }
                    else if (columnIndex != riskRatingCurrentMarketValueIndex)
                        arrayOfErrorMessages.push("Tooltip datagrid Displayed value for " + cellIdentifier + " at Row " + (rowIndex + 1) + ", Column " + (columnIndex + 1) + " ('" + displayedValue + "') does not match the expected value ('" + expectedValue + "').");
                    else {
                        /*
                        if (!aqString.StrMatches("^\\(\\d?\\d?\\d( |\\,\\d\\d\\d)*(\\,|\\.\\d\\d+)?\\)$", displayedValue))
                            arrayOfErrorMessages.push("Tooltip datagrid Displayed value at Row " + (rowIndex + 1) + ", Column " + (columnIndex + 1) + " ('" + displayedValue + "') display format is not the expected one.");
                        */
                        
                        if (expectedValue[expectedValue.length - 1] == CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL){
                            if (displayedValue[displayedValue.length - 1] != CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL)
                                arrayOfErrorMessages.push("Tooltip datagrid Displayed value for " + cellIdentifier + " at Row " + (rowIndex + 1) + ", Column " + (columnIndex + 1) + " ('" + displayedValue + "') does not have percent symbol (" + CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL + ") at it most right as the expected value ('" + expectedValue + "').");
                                
                            var displayedValueNumberFormat = ConvertStrToNumberFormat(displayedValue.split(CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL)[0]);
                            var expectedValueNumberFormat = ConvertStrToNumberFormat(expectedValue.split(CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL)[0]);
                        }
                        else {
                            var displayedValueNumberFormat = ConvertStrToNumberFormat(displayedValue);
                            var expectedValueNumberFormat = ConvertStrToNumberFormat(expectedValue);
                        }
                        
                        var floatValuePrecision = Math.min((VarToStr(displayedValueNumberFormat).substr(GetIndexOfItemInArray(VarToStr(displayedValueNumberFormat).split(""), ".") + 1)).length,
                                                           (VarToStr(expectedValueNumberFormat).substr(GetIndexOfItemInArray(VarToStr(expectedValueNumberFormat).split(""), ".") + 1)).length);
                        
                        if (floatValuesCheckpointTolerance >= Math.abs(VarToFloat(displayedValueNumberFormat) - VarToFloat(expectedValueNumberFormat)).toFixed(floatValuePrecision)){
                            arrayOfWarningMessages.push("Tooltip datagrid Displayed value for " + cellIdentifier + " at Row " + (rowIndex + 1) + ", Column " + (columnIndex + 1) + " ('" + displayedValue + "') matches the expected value ('" + expectedValue + "') according to the tolerance of " + floatValuesCheckpointTolerance + ".");
                            actualNumberOfSuccess ++;
                        }
                        else
                            arrayOfErrorMessages.push("Tooltip datagrid Displayed value for " + cellIdentifier + " at Row " + (rowIndex + 1) + ", Column " + (columnIndex + 1) + " ('" + displayedValue + "') does not match the expected value ('" + expectedValue + "') according to the tolerance of " + floatValuesCheckpointTolerance + ".");
                    }
                }
            }
        
        }
    }
    catch (e_validateTooltipDataGrid){
        Log.Error("Exception : " + e_validateTooltipDataGrid.message, VarToStr(e_validateTooltipDataGrid.stack));
        e_validateTooltipDataGrid = null;
    }
    finally {
        if (arrayOfWarningMessages.length != 0){
            Log.CallStackSettings.EnableStackOnWarning = true;
            Log.Warning(arrayOfWarningMessages.join("\r\n"), arrayOfWarningMessages.join("\r\n"), pmHigher, null, picture);
            Log.CallStackSettings.EnableStackOnWarning = false;
        }
        
        if (isQuickSuccess || (actualNumberOfSuccess == expectedNumberOfSuccess && arrayOfErrorMessages.length == 0)){
            var logSuccessMessageBrief = description + " is the expected : '" + stringOfDisplayedValues + "'";
            var logSuccessMessageDetailed = "Displayed value :\r\n\r\n" + stringOfDisplayedValues + "\r\n\r\nmatches Expected value :\r\n\r\n" + stringOfExpectedValues + "\r\n";
            Log.CallStackSettings.EnableStackOnCheckpoint = true;
            Log.Checkpoint(logSuccessMessageBrief, logSuccessMessageDetailed);
            Log.CallStackSettings.EnableStackOnCheckpoint = false;
            return true;
        }
        else {
            var logFailMessageBrief = description + " is not the expected. Expecting '" + stringOfExpectedValues + "', got '" + stringOfDisplayedValues + "'";
            var logFailMessageDetailed = (arrayOfErrorMessages.length != 0)? arrayOfErrorMessages.join("\r\n") : "Displayed value :\r\n\r\n" + stringOfDisplayedValues + "\r\n\r\ndoes not match Expected value :\r\n\r\n" + stringOfExpectedValues + "\r\n";
            Log.Error(logFailMessageBrief, logFailMessageDetailed, pmNormal, null, picture);
            return false;
        }
    }
}

function GetStringOfArray2D(array2D, columnSeparator)
{
    if (columnSeparator == undefined)
        columnSeparator = "|"
    var arrayOfStringValues = [];
    for (var i in array2D)
        arrayOfStringValues.push(array2D[i].join(columnSeparator));
    return arrayOfStringValues.join("\n");
}


//******************************

//Get CR1958 prefs
function CR1958_GetArrayOfPrefsValues()
{
    var arrayOfPrefsValues = new Array();
    arrayOfPrefsValues["PREF_SECURITY_RATING_PASSWORD"] = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "PREF_SECURITY_RATING_PASSWORD", language + client);
    arrayOfPrefsValues["PREF_ENABLE_RISK_OBJECTIVES_GRAPH"] = "YES";
    arrayOfPrefsValues["PREF_ENABLE_COMPLIANCE_MANAGER"] = "YES";
    arrayOfPrefsValues["PREF_ENABLE_RISK_RATING"] = "2";
    arrayOfPrefsValues["PREF_ALLOW_RISK_RATING"] = "YES";
    
    return arrayOfPrefsValues;
}



/**
    Fonction générique pour mettre à jour toute une liste de prefs d'une firme.
    arrayOfPrefsPreviousValues : paramètre facultatif
*/
function UpdateFirmArrayOfPrefs(vServerURL, firm_code, arrayOfPrefsNewValues, arrayOfPrefsPreviousValues)
{
    if (vServerURL == undefined || firm_code == undefined || arrayOfPrefsNewValues == undefined)
        return Log.Error("vServerURL, firm_code and arrayOfPrefsNewValues parameters are required.");
    
    var isVserverPrefUpdated = false;
    for (prefKey in arrayOfPrefsNewValues){
        if (arrayOfPrefsPreviousValues == undefined || arrayOfPrefsPreviousValues[prefKey] != arrayOfPrefsNewValues[prefKey]){
            Activate_Inactivate_PrefFirm(firm_code, prefKey, arrayOfPrefsNewValues[prefKey], vServerURL);
            isVserverPrefUpdated = true;
        }
    }
    
    //if (isVserverPrefUpdated)
        RestartServices(vServerURL);
}


/**
    Fonction générique pour récupérer le FIRM_CODE d'un utilisateur
*/
function GetUserFirmCode(user, vServerURL)
{
    var no_succ = Execute_SQLQuery_GetField("select NO_SUCC from B_USER where STATION_ID = '" + user + "'", vServerURL, "NO_SUCC");
    var firm_id = Execute_SQLQuery_GetField("select FIRM_ID from B_SUCC where NO_SUCC = '" + no_succ + "'", vServerURL, "FIRM_ID");
    var firm_code = Execute_SQLQuery_GetField("select FIRM_CODE from B_FIRM where FIRM_ID = " + firm_id, vServerURL, "FIRM_CODE");
    return firm_code;
}


function ExecuteCfLoaderRiskRatingPlugin()
{
    Log.Message("Execute RiskRating plugin.");
    
    //Create SSH commands file
    var SSHCmdFileName = "CfLoaderRiskRatingPlugin.sh";
    var SSHCmdLines = "if [ -f '/home/tools/LOG_cfLoader.sh' ]; then sh /home/tools/LOG_cfLoader.sh; fi";
    SSHCmdLines += '\r\ncfLoader -RiskRating " "';
    SSHCmdLines += "\r\ncfLoader -RiskRating \\\"-overwrite\\\"";
    SSHCmdLines += '\r\nsleep 15';
    var SSHCmdFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SSH\\" + SSHCmdFileName;
    CreateFileAndWriteText(SSHCmdFilePath, SSHCmdLines);
    
    //Create PLINK batch file
    var hostname = GetVserverHostName(vServerRQS);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m " + SSHCmdFileName + " > CfLoaderRiskRatingPlugin_output.txt";
    var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SSH\\CfLoaderRiskRatingPlugin_plink.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
}



function UpdateIACodeForClient(clientNumber, IACode, vServerURL)
{
    if (clientNumber != undefined && IACode != undefined){
        var REP_ID = Execute_SQLQuery_GetField("select REP_ID from B_REP where NO_REP = '" + IACode + "'", vServerURL, "REP_ID");
        var updateClientIACodeSQLQuery  = "update B_CLIENT set NO_REP = '" + IACode + "', REP_ID = " + REP_ID + " where NO_CLIENT = '" + clientNumber + "'\r\n";
            updateClientIACodeSQLQuery += "update B_COMPTE set NO_REP = '" + IACode + "', REP_ID = " + REP_ID + " where NO_CLIENT = '" + clientNumber + "'\r\n";
        Log.Message("Update Client Number '" + clientNumber + "' IACode to : " + IACode, updateClientIACodeSQLQuery);
        Execute_SQLQuery(updateClientIACodeSQLQuery, vServerURL);
    }
}



function UpdateIACodeForAccount(accountNumber, IACode, vServerURL)
{
    if (accountNumber != undefined && IACode != undefined){
        var NO_CLIENT = Trim(Execute_SQLQuery_GetField("select NO_CLIENT from B_COMPTE where NO_COMPTE = '" + accountNumber + "'", vServerURL, "NO_CLIENT"));
        var REP_ID = Execute_SQLQuery_GetField("select REP_ID from B_REP where NO_REP = '" + IACode + "'", vServerURL, "REP_ID");
        var updateAccountIACodeSQLQuery  = "update B_CLIENT set NO_REP = '" + IACode + "', REP_ID = " + REP_ID + " where NO_CLIENT = '" + NO_CLIENT + "'\r\n";
            updateAccountIACodeSQLQuery += "update B_COMPTE set NO_REP = '" + IACode + "', REP_ID = " + REP_ID + " where NO_CLIENT = '" + NO_CLIENT + "'\r\n";
        Log.Message("Update Account Number '" + accountNumber + "' IACode to : " + IACode, updateAccountIACodeSQLQuery);
        Execute_SQLQuery(updateAccountIACodeSQLQuery, vServerURL);
    }
}


function GetArrayKeys(varArray)
{
    var arrayOfKeys = [];
    for (var key in varArray)
        arrayOfKeys.push(key);
    return arrayOfKeys;
}



function CheckArraysKeysMatch(array1, array2)
{
    var isArraysKeysCheckOK = true;
        
    var keysOfArray1 = GetArrayKeys(array1);
    var keysOfArray2 = GetArrayKeys(array2);
    
    for (var i in keysOfArray1)
        if (GetIndexOfItemInArray(keysOfArray2, keysOfArray1[i]) == -1){
            isArraysKeysCheckOK = false;
            Log.Error("Key '" + keysOfArray1[i] + "' found in array1 but not in array2 this is unexpected.");
        }
    
    for (var i in keysOfArray2)
        if (GetIndexOfItemInArray(keysOfArray1, keysOfArray2[i]) == -1){
            isArraysKeysCheckOK = false;
            Log.Error("Key '" + keysOfArray2[i] + "' found in array2 but not in array1 this is unexpected.");
        }
    
    return isArraysKeysCheckOK;
}



function CloseCroesus()
{
    Close_Croesus_MenuBar();
    SetAutoTimeOut();
    if (Get_DlgConfirmation().Exists)
        Get_DlgConfirmation_BtnYes().Click();
    RestoreAutoTimeOut();
}



function AddPositionBySecuritySymbol(securitySymbol, targetValuePercentage, marketValuePercentage)
{
    Get_Toolbar_BtnAdd().Click();
    SetAutoTimeOut(3000);
    if (Get_DlgConfirmation().Exists) Get_DlgConfirmation_BtnNo().Click();
    RestoreAutoTimeOut();
    
    
    Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(".[BS]" + securitySymbol + "[Tab]");
    SetAutoTimeOut(3000);
    if (Get_SubMenus().Exists)
        Get_SubMenus().FindChild(["Uid", "Value"], ["Symbol", securitySymbol], 10).DblClick();
    RestoreAutoTimeOut();
    
    if (targetValuePercentage != undefined)
        Get_WinAddPositionSubmodel_TxtValuePercent().Keys(targetValuePercentage);
    
    if (marketValuePercentage != undefined)
        Get_WinAddPositionSubmodel_TxtMarketValue().Keys(marketValuePercentage);
    
    Get_WinAddPositionSubmodel_BtnOK().Click();
}



function AddPositionBySecurityDescription(securityDescription, targetValuePercentage, marketValuePercentage)
{
    Get_Toolbar_BtnAdd().Click();
    SetAutoTimeOut(3000);
    if (Get_DlgConfirmation().Exists) Get_DlgConfirmation_BtnNo().Click();
    RestoreAutoTimeOut();
    
    Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(",[BS]" + securityDescription + "[Tab]");
    SetAutoTimeOut(3000);
    if (Get_SubMenus().Exists)
        Get_SubMenus().FindChild(["Uid", "Value"], ["Description", securityDescription], 10).DblClick();
    RestoreAutoTimeOut();
    
    if (targetValuePercentage != undefined)
        Get_WinAddPositionSubmodel_TxtValuePercent().Keys(targetValuePercentage);
    
    if (marketValuePercentage != undefined)
        Get_WinAddPositionSubmodel_TxtMarketValue().Keys(marketValuePercentage);
    
    Get_WinAddPositionSubmodel_BtnOK().Click();
}



function CleanupModelsByName(modelName, vServerURL)
{
    Log.Message("Cleanup Models having Name = '" + modelName + "'.");
    Get_ModulesBar_BtnModels().Click();
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    SearchModelByName(modelName);
    Get_ModelsGrid().Refresh();
    var arrayOfModelsCells = Get_ModelsGrid().FindAllChildren(["ClrClassName", "Uid", "Value"], ["CellValuePresenter", "Name", modelName], 10).toArray();
    for (var m in arrayOfModelsCells)
        CleanupModel(arrayOfModelsCells[m].DataContext.DataItem.AccountNumber.OleValue, vServerURL);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
}



function CleanupModel(modelNumber, vServerURL)
{
    if (modelNumber != undefined){
        var cleanupModelSQLQuery = "update B_COMPTE set LOCK_ID = null\r\n";
        cleanupModelSQLQuery += "delete from B_MODEL_POSITIONS where NO_COMPTE = '" + modelNumber + "'\r\n";
        cleanupModelSQLQuery += "delete from B_PORTEF where NO_COMPTE = '" + modelNumber + "'\r\n";
        cleanupModelSQLQuery += "delete from B_MODEL_ASSIGNED_CLIENT where MODEL_ID = (select ACCOUNT_ID from B_COMPTE where NO_COMPTE = '" + modelNumber + "')\r\n";
        cleanupModelSQLQuery += "delete from B_COMPTE where NO_COMPTE = '" + modelNumber + "'\r\n";
        Log.Message("Cleanup Model, Number = '" + modelNumber + "'.", cleanupModelSQLQuery);
        Execute_SQLQuery(cleanupModelSQLQuery, vServerURL);
    }
}



function CleanupRelationship(relationshipShortName, vServerURL)
{
    if (relationshipShortName != undefined){
        var cleanupSQLQuery = "delete from B_LINKACCOUNT where LINK_ID = (select LINK_ID from B_LINK where SHORTNAME = '" + relationshipShortName + "')\r\n";
        cleanupSQLQuery += "delete from B_LINK where SHORTNAME = '" + relationshipShortName + "'\r\n";
        Log.Message("Cleanup relationship,  SHORTNAME = '" + relationshipShortName + "'", cleanupSQLQuery);
        Execute_SQLQuery(cleanupSQLQuery, vServerURL);
    }
}



function GetTargetPercentValueFromDataBase(clientNumber, B_PROFIL_CODE)
{
    if (Trim(VarToStr(B_PROFIL_CODE)) == "")
        return null;
    else
        return VarToStr(Execute_SQLQuery_GetField("select VALEUR from B_PROFIL where NO_CLIENT = '" + clientNumber + "' and CODE = " + B_PROFIL_CODE, vServerRQS, "VALEUR"));
}



//Save and Reinitialize and Save Portfolio
function SaveReinitializeSavePortfolio()
{
    Get_PortfolioBar_BtnSave().Click();
    Get_WinWhatIfSave_BtnOK().Click();
    Get_PortfolioBar_BtnReinitializeMV().Click();
    Get_DlgConfirmation_BtnReinitialize().Click();
    Get_PortfolioBar_BtnSave().Click();
    Get_WinWhatIfSave_BtnOK().Click();
}


//Perform a Rebalancing till the step 4
function RebalanceTillProjectedPortfolio()
{
    Get_Toolbar_BtnRebalance().Click();
    Get_WinRebalance().Parent.Maximize();
    Get_WinRebalance_BtnNext().Click(); //Rebalancing step 1
    Get_WinRebalance_BtnNext().Click(); //Rebalancing step 2
    Get_WinRebalance_BtnNext().Click(); //Rebalancing step 3
    SetAutoTimeOut(10000);
    if (Get_WinWarningDeleteGeneratedOrders().Exists) Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
    RestoreAutoTimeOut();
    WaitObject(Get_WinRebalance(),"Uid", "TabControl_1a23", 120000);
    SetAutoTimeOut(10000);
    if (Get_WinWarningDeleteGeneratedOrders().Exists) Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
    RestoreAutoTimeOut();
    Get_CroesusApp().WaitProperty("CPUUsage", 0, 100000);
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsSelected", true, 60000);
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().set_IsExpanded(true);
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().Click(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().Width - 40, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().Height - 8);
}



function CheckEqualsForFormattedNumberWithSuffix(displayedValue, expectedValue, valueDescription, floatValuesCheckpointTolerance, suffix, picture)
{
    try {
        if (floatValuesCheckpointTolerance == undefined)
            floatValuesCheckpointTolerance = 0;
        
        if (suffix == undefined)
            suffix = "";
            
        if (picture == undefined)
            picture = null;
            
        var isSuffixPartOK = false;
        var isNumberPartOK = false;
        
        var isQuickSuccess = (displayedValue == expectedValue);
        if (isQuickSuccess)
            return;
        
        if (aqString.SubString(expectedValue, expectedValue.length - suffix.length, suffix.length) == suffix){
            if (aqString.SubString(displayedValue, displayedValue.length - suffix.length, suffix.length) == suffix)
                isSuffixPartOK = true
            else
                arrayOfErrorMessages.push("Displayed value ('" + displayedValue + "') does not contain expected suffix (" + suffix + ") at its most right as the expected value ('" + expectedValue + "').");
                                
            var displayedValueNumberFormat = ConvertStrToNumberFormat(aqString.SubString(displayedValue, 0, displayedValue.length - suffix.length));
            var expectedValueNumberFormat = ConvertStrToNumberFormat(aqString.SubString(expectedValue, 0, expectedValue.length - suffix.length));
        }
        else {
            var displayedValueNumberFormat = ConvertStrToNumberFormat(displayedValue);
            var expectedValueNumberFormat = ConvertStrToNumberFormat(expectedValue);
        }
        
        var floatValuePrecision = Math.min((VarToStr(displayedValueNumberFormat).substr(GetIndexOfItemInArray(VarToStr(displayedValueNumberFormat).split(""), ".") + 1)).length,
                                           (VarToStr(expectedValueNumberFormat).substr(GetIndexOfItemInArray(VarToStr(expectedValueNumberFormat).split(""), ".") + 1)).length);

        if (floatValuesCheckpointTolerance >= Math.abs(VarToFloat(displayedValueNumberFormat) - VarToFloat(expectedValueNumberFormat)).toFixed(floatValuePrecision))
            isNumberPartOK = true;
    }
    catch (e_CheckEqualsForFormattedNumberWithSuffix){
        Log.Error("Exception : " + e_CheckEqualsForFormattedNumberWithSuffix.message, VarToStr(e_CheckEqualsForFormattedNumberWithSuffix.stack));
        e_CheckEqualsForFormattedNumberWithSuffix = null;
    }
    finally {        
        if (isQuickSuccess){
            var logSuccessMessageBrief = valueDescription + " is the expected : '" + displayedValue + "'";
            var logSuccessMessageDetailed = "Displayed value :\r\n\r\n" + displayedValue + "\r\n\r\nmatches Expected value :\r\n\r\n" + expectedValue + "\r\n";
            Log.CallStackSettings.EnableStackOnCheckpoint = true;
            Log.Checkpoint(logSuccessMessageBrief, logSuccessMessageDetailed);
            Log.CallStackSettings.EnableStackOnCheckpoint = false;
            return true;
        }
        else if (isNumberPartOK && isSuffixPartOK){
            Log.CallStackSettings.EnableStackOnWarning = true;
            var logWarningMessage = valueDescription + " displayed value '" + displayedValue + "' matches the expected value '" + expectedValue + "' according to the tolerance of " + floatValuesCheckpointTolerance + ".";
            Log.Warning(logWarningMessage, logWarningMessage, pmHigher, null, picture);
            Log.CallStackSettings.EnableStackOnWarning = false;
            return true;
        }        
        else {
            var logFailMessageBrief = valueDescription + " is not the expected. Expecting '" + expectedValue + "', got '" + displayedValue + "'";
            var logFailMessageDetailed = "Displayed value :\r\n\r\n" + displayedValue + "\r\n\r\ndoes not match Expected value :\r\n\r\n" + expectedValue + "\r\n";
            Log.Error(logFailMessageBrief, logFailMessageDetailed, pmNormal, null, picture);
            return false;
        }
    }
}



function CheckEqualsForFloatValue(actualValue, expectedValue, valueDescription, floatValuesCheckpointTolerance, messageType)
{   
    if (floatValuesCheckpointTolerance == undefined)
        floatValuesCheckpointTolerance = 0;
    
    if (messageType == undefined)
        messageType = lmError;
    
    var floatValuePrecision = Math.min((VarToStr(actualValue).substr(GetIndexOfItemInArray(VarToStr(actualValue).split(""), ".") + 1)).length,
                                       (VarToStr(expectedValue).substr(GetIndexOfItemInArray(VarToStr(expectedValue).split(""), ".") + 1)).length);
    
    if (floatValuesCheckpointTolerance >= Math.abs(VarToFloat(actualValue) - VarToFloat(expectedValue)).toFixed(floatValuePrecision)){
        Log.CallStackSettings.EnableStackOnCheckpoint = true;
        Log.Checkpoint(valueDescription + " actual value '" + actualValue + "' matches the expected value '" + expectedValue + "' in regard to the tolerance of '" + floatValuesCheckpointTolerance + "'.",
        "Actual value :\r\n\r\n" + actualValue + "\r\n\r\n matches Expected value :\r\n\r\n" + expectedValue + "\r\n");
        Log.CallStackSettings.EnableStackOnCheckpoint = false;
        return true;
    }
    else {
        Log.CallStackSettings.EnableStackOnWarning = true;
        if (messageType == lmWarning)
            Log.Warning(valueDescription + " actual value '" + actualValue + "' does not match the expected value '" + expectedValue + "' in regard to the tolerance of '" + floatValuesCheckpointTolerance + "'.",
            "Actual value :\r\n\r\n" + actualValue + "\r\n\r\n does not match Expected value :\r\n\r\n" + expectedValue + "\r\n", pmHigher, null, Sys.Desktop.Picture());
        else
            Log.Error(valueDescription + " actual value '" + actualValue + "' does not match the expected value '" + expectedValue + "' in regard to the tolerance of '" + floatValuesCheckpointTolerance + "'.",
            "Actual value :\r\n\r\n" + actualValue + "\r\n\r\n does not match Expected value :\r\n\r\n" + expectedValue + "\r\n");
        
        Log.CallStackSettings.EnableStackOnWarning = false;
        return false;
    }
}



function GetColumnsDataFromDataGrid(arrayOfValuesColumnsNames, dgvDataGrid)
{
    Log.Message("GetColumnsDataFromDataGrid()");
    
    if (GetIndexOfItemInArray([varArray, varDispatch], GetVarType(arrayOfValuesColumnsNames)) == -1)
        arrayOfValuesColumnsNames = new Array(arrayOfValuesColumnsNames);
    
    var riskRatingColumnName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "ColumnName_RiskRating", language + client);
    var nonDeterminedValueDisplayString = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_DataGrid_NonDeterminedValue_DisplayString", language + client);
    
    //Init Results Array
    var arrayOfArrayOfColumnsData = [];
    arrayOfArrayOfColumnsData[riskRatingColumnName] = [];
    for (var i in arrayOfValuesColumnsNames)
        arrayOfArrayOfColumnsData[arrayOfValuesColumnsNames[i]] = [];
    
    if (dgvDataGrid == null || !dgvDataGrid.Exists)
        Log.Error("The data grid provided does not exist.");
    else {
        //Display the needed columns
        var anyDisplayedColumn = dgvDataGrid.Find(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10).FindChild("ClrClassName", "HeaderLabelArea", 10).FindChild(["ClrClassName", "VisibleOnScreen"], ["LabelPresenter", true], 10);
        Add_ColumnByLabel(anyDisplayedColumn, riskRatingColumnName);
        for (var i in arrayOfValuesColumnsNames)
            Add_ColumnByLabel(anyDisplayedColumn, arrayOfValuesColumnsNames[i]);
        
        //Copy the grid content to clipboard
        Sys.Clipboard = null;
        dgvDataGrid.Keys("^a^C");
        var nbOfTries = 0;
        do {Delay(2000);}while (GetVarType(Sys.Clipboard) != varOleStr && ++nbOfTries < 20)
        if (GetVarType(Sys.Clipboard) != varOleStr)
            Log.Warning("The datagrid content copy actions (CTRL+A and CTRL+MAJ+C) may have failed.");
        
        //Put the grid content to Array
        var allDataGridContent = Sys.Clipboard;
        var lineSeparator = (aqString.Find(allDataGridContent, "\r\n") == -1)? "\n": "\r\n";
        var arrayOfAllDataGridContent = allDataGridContent.split(lineSeparator);
        for (var i in arrayOfAllDataGridContent){
            var arrayOfLineContent = arrayOfAllDataGridContent[i].split("\t");
            for (var j in arrayOfLineContent)
                arrayOfLineContent[j] = aqString.Unquote(arrayOfLineContent[j]);
            arrayOfAllDataGridContent[i] = arrayOfLineContent;
        }
        
        //Get Column Indexes from the grid content Array
        var riskRatingColumnIndex = GetIndexOfItemInArray(arrayOfAllDataGridContent[0], riskRatingColumnName);
        var arrayOfValuesColumnsIndexes = [];
        for (var i in arrayOfValuesColumnsNames){
            var valuesColumnName = arrayOfValuesColumnsNames[i];
            arrayOfValuesColumnsIndexes[valuesColumnName] = GetIndexOfItemInArray(arrayOfAllDataGridContent[0], arrayOfValuesColumnsNames[i]);
        }
        
        //Get and set the values
        var isNonDeterminedValueFound = false;
        var arrayOfColumNameWhereNonDeterminedValueIsFound = []
        for (var i = 1; i < arrayOfAllDataGridContent.length; i++){
            var currentRiskRating = arrayOfAllDataGridContent[i][riskRatingColumnIndex];
            arrayOfArrayOfColumnsData[riskRatingColumnName].push(currentRiskRating);
            for (var j in arrayOfValuesColumnsNames){
                var valuesColumnName = arrayOfValuesColumnsNames[j];
                var valuesColumnIndex = arrayOfValuesColumnsIndexes[valuesColumnName];
                var currentValue = GetFloatValueFromGridData(arrayOfAllDataGridContent[i][valuesColumnIndex]);
                arrayOfArrayOfColumnsData[valuesColumnName].push(currentValue);
            }
        }
    }
    
    if (isNonDeterminedValueFound)
        Log.Warning("Non determined value '" + nonDeterminedValueDisplayString + "' found in '" + arrayOfColumNameWhereNonDeterminedValueIsFound + "' column(s).", allDataGridContent, pmHigher, null, Sys.Desktop.Picture());
    
    return arrayOfArrayOfColumnsData;
    
    function GetFloatValueFromGridData(str)
    {
        str = Trim(str);
        
        if (str == nonDeterminedValueDisplayString){
            str = '0';
            isNonDeterminedValueFound = true;
            if (GetIndexOfItemInArray(arrayOfColumNameWhereNonDeterminedValueIsFound, valuesColumnName) == -1)
                arrayOfColumNameWhereNonDeterminedValueIsFound.push(valuesColumnName);
        }
        
        str = aqString.Replace(str, "(", "-");
        str = aqString.Replace(str, ")", "");
        
        if (language == "french"){
            str = aqString.Replace(str, ",", ".");
            str = aqString.Replace(str, " ", ",");
        }
        
        return aqConvert.StrToFloat(str);
    }
}



function GroupColumnsDataByRiskRating(arrayOfArrayOfColumnsData)
{
    Log.Message("GroupColumnsDataByRiskRating()");
    
    var riskRatingColumnName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "ColumnName_RiskRating", language + client);
    if (arrayOfArrayOfColumnsData[riskRatingColumnName] == undefined){
        Log.Error(riskRatingColumnName + " data not found in the provided array.");
        return null;
    }
    
    //Get Values Column Names and Init Results Array
    var arrayOfValuesColumnsNames = [];
    var arrayOfArrayOfValuesGroupedByRating = [];
    for (var columnName in arrayOfArrayOfColumnsData){
        if (columnName != riskRatingColumnName){
            arrayOfValuesColumnsNames.push(columnName);
            arrayOfArrayOfValuesGroupedByRating[columnName] = [];
            for (var i in CR1958_SECURITY_RISK_RATINGS)
                arrayOfArrayOfValuesGroupedByRating[columnName][CR1958_SECURITY_RISK_RATINGS[i]] = 0;
        }
    }

    
    //Group values by Risk Rating
    var arrayOfRiskRatings = arrayOfArrayOfColumnsData[riskRatingColumnName];
    for (var i = 0; i < arrayOfRiskRatings.length; i++){
        var currentRiskRating = arrayOfRiskRatings[i];
        if (GetIndexOfItemInArray(CR1958_SECURITY_RISK_RATINGS, currentRiskRating) == -1){
            Log.Error("Row num " + (i+1) + " : Unexpected value '" + currentRiskRating + "' for Risk Rating");
            continue;
        }
        
        for (var j = 0; j < arrayOfValuesColumnsNames.length; j++){
            var valuesColumnName = arrayOfValuesColumnsNames[j];
            arrayOfArrayOfValuesGroupedByRating[valuesColumnName][currentRiskRating] += Math.abs(arrayOfArrayOfColumnsData[valuesColumnName][i]);
        }
    }
    
    return arrayOfArrayOfValuesGroupedByRating;
}



function GetRiskRatingExpectedPercentageLabel(percentValue, nbDecimals)
{
    if (nbDecimals == undefined)
        nbDecimals = CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS;
    
    var formattedNumber = GetDisplayedNumber(percentValue, nbDecimals);
    var percentageLabel = "";
    switch (formattedNumber){
        case "":
            percentageLabel = "";
            break;
            
        default:
            percentageLabel = formattedNumber + CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL;
            break;
    }
    
    return percentageLabel;
}




function ConvertStrToNumberFormat(str)
{
    str = Trim(str);
    
    if (str == "NaN")
        return NaN; //A valider
    else if (str == "∞")
        return Infinity; //A confirmer et à valider
    else if (str == "")
        return null;
    else {
        str = aqString.Replace(str, "(", "-");
        str = aqString.Replace(str, ")", "");
    
        if (language == "french"){
            str = aqString.Replace(str, ",", ".");
            str = aqString.Replace(str, " ", ",");
        }
    
        return aqConvert.StrToFloat(str);
    }
}



function GetDisplayedNumber(numberValue, nbDecimals)
{
    if (nbDecimals == undefined)
        nbDecimals = 1;
    
    if (isNaN(numberValue))
        return "NaN"; //A valider
    else if (!isFinite(numberValue))
        return "∞";//A confirmer et à valider
    else if (Trim(VarToStr(numberValue)) == "")
        return "";
    else {
        var decimalSymbol = (language == "french")? ",": ".";
        var digitGroupingSymbol = (language == "french")? " ": ",";
        var numberParts = StrToFloat(numberValue).toFixed(nbDecimals).toString().split(".");
        var formattedNumber = numberParts[0].replace(/\B(?=(\d{3})+(?!\d))/g, digitGroupingSymbol) + (numberParts[1] ? decimalSymbol + numberParts[1] : "");
        return formattedNumber;
    }
}



function GetTooltipDisplayedNumber(numberValue, nbDecimals)
{
    if (nbDecimals == undefined)
        nbDecimals = 1;
    
    var formattedNumber = GetDisplayedNumber(numberValue, nbDecimals);
    if (formattedNumber[0] == "-")
        formattedNumber = "(" + formattedNumber.split("-")[1] + ")";
    return formattedNumber;
}



function GetRectangleDisplayedPercentLabel(percentsLabelText)
{
    return VarToStr(VarToStr(percentsLabelText).split(CR1958_GRAPH_PERCENTS_LABEL_SPLITTER)[0]);
}



function GetTriangleDisplayedPercentLabel(percentsLabelText)
{
    return VarToStr(VarToStr(percentsLabelText).split(CR1958_GRAPH_PERCENTS_LABEL_SPLITTER)[1]);
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



//***************** CHECKPOINTS *****************


function CheckIfRiskAllocationGraphIsDisplayedAtTheBottomRightSideOfTheScreen()
{
    Log.Message("Check if the Graph is displayed at the bottom-right side of the screen.");
    
    if (aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_PnlRQSCharts(), "IsVisible", cmpEqual, true)){
        //Check if the graph is located at the Most bottom
        var statusBarTop = Get_MainWindow_StatusBar().Top;
        var summaryExpanderBottom = Get_PortfolioGrid_GrpSummary_ScrollViewer().Top + Get_PortfolioGrid_GrpSummary_ScrollViewer().Height;
        var graphBottom = Get_PortfolioGrid_GrpSummary_PnlRQSCharts().Top + Get_PortfolioGrid_GrpSummary_PnlRQSCharts().Height;
        var HScrollBar = Get_PortfolioGrid_GrpSummary_ScrollViewer().FindChild(["ClrClassName", "Orientation", "IsVisible"], ["ScrollBar", "Horizontal", true]);
        var HScrollBarHeight = (Get_PortfolioGrid_GrpSummary_ScrollViewer().HScroll.Max == 0)? 0: ((HScrollBar.Exists)? HScrollBar.Height: 18);
        var isGraphMostBottom = (((statusBarTop - summaryExpanderBottom) <= 2) && ((summaryExpanderBottom - graphBottom) <= 2 + HScrollBarHeight));
        
        //Check if the graph is located at the Most right
        var portfolioPluginRight = Get_PortfolioPlugin().Left + Get_PortfolioPlugin().Width;
        var summaryExpanderRight = Get_PortfolioGrid_GrpSummary().Left + Get_PortfolioGrid_GrpSummary().Width;
        var isSummaryExpanderMostRight = (portfolioPluginRight == (summaryExpanderRight + 1));
        
        var isGraphMostRightInSummaryExpander = true;
        var isGraphObjectFoundInImmediateChildren = false;
        var graphUid = Get_PortfolioGrid_GrpSummary_PnlRQSCharts().Uid;
        var graphLeft = Get_PortfolioGrid_GrpSummary_PnlRQSCharts().Left;
        var allScrollViewerImmediateChildren = Get_PortfolioGrid_GrpSummary_ScrollViewer().FindAllchildren("IsVisible", true).toArray();
        for (var i in allScrollViewerImmediateChildren){
            if (VarToStr(allScrollViewerImmediateChildren[i].Uid) == VarToStr(graphUid))
                isGraphObjectFoundInImmediateChildren = true;
            
            if (allScrollViewerImmediateChildren[i].Width > 1 && allScrollViewerImmediateChildren[i].Left > graphLeft)
                isGraphMostRightInSummaryExpander = false;
        }
        
        var isGraphMostRight = (isGraphMostRightInSummaryExpander && isSummaryExpanderMostRight);
        
        //Check if the graph is located at the bottom-right
        if (!isGraphObjectFoundInImmediateChildren)
            Log.Error("The graph objet was not found in the Scroll Viewer Immediate Children ; this is unexpected.");
        else if (isGraphMostBottom && isGraphMostRight)
            Log.Checkpoint("The Graph is displayed at the bottom-right side of the screen.");
        else
            Log.Error("The Graph is not displayed at the bottom-right side of the screen. (Please, read the Details section for more information).", "A noter que la vérification est faite relativement à la distance séparant les composants en termes de nombre de pixels ; il se peut qu'il y ait eu une évolution de l'application qui fait qu'il y a désormais quelque nouveau composant (possiblement englobant), peut-être aussi invisible à l'oeil ; advenant cette situation, voir s'il faut mettre à jour les variables suivantes : \nisGraphMostBottom\nisSummaryExpanderMostRight");
    }
}



function CheckRiskScoreGraphDisplayInPortfolio(checkObjectiveTriangleDisplay)
{
    var expectedGraphTitle = CR1958_GRAPH_TITLE_RISKSCORE;
    var expectedActualLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_HorizontalAxis_Label_Actual", language + client);
    var expectedObjectiveLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_HorizontalAxis_Label_Objective", language + client);
    
    try {
        SetAutoTimeOut(3000);
        var graphName = (Trim(expectedGraphTitle) != "")? expectedGraphTitle: "Risk Score";
    
        Log.AppendFolder("Check " + graphName + " graph display in Portfolio.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
    
        //Title label validation
        Log.Message("Check " + graphName + " graph Title.");
        var riskScoreGraphTitle = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_LblTitle();
        CheckProperty(riskScoreGraphTitle, "IsVisible", cmpEqual, true);
        CheckProperty(riskScoreGraphTitle, "WPFControlText", cmpEqual, expectedGraphTitle);
        Log.Link("https://jira.croesus.com/browse/RISK-1268", "JIRA 'RISK-1268' (Fix versions : 90.12.Hf-77, 90.13.In-59, 90.14-63) relativement au nom affiché du graphique de RQS ('Cote de risque' | 'Risk score').", "JIRA 'RISK-1268' (Fix versions : 90.12.Hf-77, 90.13.In-59, 90.14-63) relativement au nom affiché du graphique de RQS ('Cote de risque' | 'Risk score').");
        
        Log.Message("Check " + graphName + " graph Actual label.");
        var riskScoreLabelActual = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_HorizontalAxis_LblActual();
        CheckProperty(riskScoreLabelActual, "IsVisible", cmpEqual, true);
        CheckProperty(riskScoreLabelActual, "WPFControlText", cmpEqual, expectedActualLabel);
    
        Log.Message("Check " + graphName + " graph Objective label.");
        var riskScoreLabelObjective = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_HorizontalAxis_LblObjective();
        CheckProperty(riskScoreLabelObjective, "IsVisible", cmpEqual, true);
        CheckProperty(riskScoreLabelObjective, "WPFControlText", cmpEqual, expectedObjectiveLabel);
    
        Log.Message("Check " + graphName + " graph General Rectangle.");
        var riskScoreGeneralRectangle = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_GeneralRectangle();
        CheckProperty(riskScoreGeneralRectangle, "IsVisible", cmpEqual, true);
    
        Log.Message("Check " + graphName + " graph Actual Rectangle.");
        var riskScoreActualRectangle = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_ActualRectangle();
        CheckProperty(riskScoreActualRectangle, "IsVisible", cmpEqual, true);
        
        Log.Message("Check " + graphName + " graph Actual Percent label.");
        var riskScoreActualPercentLabel = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_LblActualPercent();
        CheckProperty(riskScoreActualPercentLabel, "IsVisible", cmpEqual, true);
        CheckProperty(riskScoreActualPercentLabel, "WPFControlText", cmpNotEqual, "");
        
        Log.Message("Check " + graphName + " graph Objective Triangle.");
        var riskScoreObjectiveTriangle = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_ObjectiveTriangle();
        if (checkObjectiveTriangleDisplay === true){
            CheckProperty(riskScoreObjectiveTriangle, "IsVisible", cmpEqual, true);
            Log.Message("Check " + graphName + " graph Objective Percent label.");
            var riskScoreObjectivePercentLabel = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_LblObjectivePercent();
            CheckProperty(riskScoreObjectivePercentLabel, "IsVisible", cmpEqual, true);
            CheckProperty(riskScoreObjectivePercentLabel, "WPFControlText", cmpNotEqual, "");
        }
        else if (!CheckProperty(riskScoreObjectiveTriangle, "Exists", cmpEqual, false))
            CheckProperty(riskScoreObjectiveTriangle, "IsVisible", cmpEqual, false);
        
        Log.Message("Check " + graphName + " graph background color.");
        var backgroundActualColor = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_ScrollViewer().Background.Color;
        var backgroundActualColorHexValue = aqString.Format("%02x%02x%02x", backgroundActualColor.R, backgroundActualColor.G, backgroundActualColor.B);
        var backgroundExpectedColor = {};
        backgroundExpectedColor.Hex = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Background_Color-RGBHex", language + client);
        if (!CheckEquals(backgroundActualColorHexValue, backgroundExpectedColor.Hex, "Graph background color #")){
            backgroundExpectedColor.R = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Background_Color-R", language + client);
            backgroundExpectedColor.G = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Background_Color-G", language + client);
            backgroundExpectedColor.B = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Background_Color-B", language + client);
            CheckEquals(backgroundActualColor.R, backgroundExpectedColor.R, "Graph background color R component");
            CheckEquals(backgroundActualColor.G, backgroundExpectedColor.G, "Graph background color G component");
            CheckEquals(backgroundActualColor.B, backgroundExpectedColor.B, "Graph background color B component");
        }
        
        //LAYOUT VERIFICATION
        Log.Message(aqString.ToUpper("Check " + graphName + " graph components layout."), "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        CheckRiskScoreGraphLayout(graphName, checkObjectiveTriangleDisplay);
    }
    catch (checkDisplayException){
        Log.Error("Exception : " + checkDisplayException.message, VarToStr(checkDisplayException.stack));
        checkDisplayException = null;
    }
    finally {
        RestoreAutoTimeOut();
        Log.PopLogFolder();
    }
}



function CheckRiskScoreGraphLayout(graphName, checkObjectiveTrianglesDisplay)
{
        var graphName = (graphName != undefined)? graphName: "Risk Score";
        
        //Title label validation
        Log.Message("Check " + graphName + " graph Title.");
        var riskScoreGraphTitle = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_LblTitle();
        var riskScoreLabelActual = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_HorizontalAxis_LblActual();
        var riskScoreLabelObjective = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_HorizontalAxis_LblObjective();
        var riskScoreGeneralRectangle = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_GeneralRectangle();
        var riskScoreActualPercentLabel = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_LblActualPercent();
        var riskScoreActualRectangle = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_ActualRectangle();
        var riskScoreObjectiveTriangle = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_ObjectiveTriangle();
        var riskScoreObjectivePercentLabel = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_LblObjectivePercent();
        
        Log.Message("Check if " + graphName + " graph General Rectangle and Actual Rectangle are symetric.");
        var GeneralRectangleMiddle = riskScoreGeneralRectangle.Left + 0.5*(riskScoreGeneralRectangle.Width);
        var ActualRectangleMiddle = riskScoreActualRectangle.Left + 0.5*(riskScoreActualRectangle.Width);
        CheckEqualsForFloatValue(ActualRectangleMiddle, GeneralRectangleMiddle, graphName + " graph General Rectangle and Actual Rectangle vertical axis.", CR1958_GRAPH_MAX_PIXELS_NB_TOLERANCE_FOR_HORIZONTAL_AXIS_PERCENTS_LABELS_POSITIONS, lmWarning);
        
        Log.Message("Check if " + graphName + " graph Labels, General Rectangle, Actual Rectangle and Objective triangle are well spaced.");
        var graphComponentsLeftSide = [];
        graphComponentsLeftSide.push(riskScoreActualPercentLabel);
        graphComponentsLeftSide.push(riskScoreActualRectangle);
        graphComponentsLeftSide.push(riskScoreGeneralRectangle);
        
        var graphComponentsRightSide = [];
        graphComponentsRightSide.push(riskScoreGeneralRectangle);
        graphComponentsRightSide.push(riskScoreActualRectangle);
        graphComponentsRightSide.push(riskScoreObjectiveTriangle);
        graphComponentsRightSide.push(riskScoreObjectivePercentLabel);
        
        var graphComponents = graphComponentsLeftSide.concat(graphComponentsRightSide);
        
        var arrayOfSpaces = [];
        for (var i = 1; i < graphComponentsLeftSide.length; i++)
            arrayOfSpaces.push(graphComponentsLeftSide[i].Left - (graphComponentsLeftSide[i-1].Left + graphComponentsLeftSide[i-1].Width))
        
        for (var i = 1; i < graphComponentsRightSide.length; i++)
            if (graphComponentsRightSide[i].Exists)
                arrayOfSpaces.push(graphComponentsRightSide[i].Left - (graphComponentsRightSide[i-1].Left + graphComponentsRightSide[i-1].Width))
        
        var spacesDeviation = GetArrayMax(arrayOfSpaces) - GetArrayMin(arrayOfSpaces);
        CheckEqualsForFloatValue(spacesDeviation, 0, graphName + " graph area components horizontal inter-spaces deviation.", CR1958_GRAPH_MAX_PIXELS_NB_TOLERANCE_FOR_HORIZONTAL_AXIS_PERCENTS_LABELS_POSITIONS, lmWarning);
        
        Log.Message("Check if " + graphName + " graph Labels, General Rectangle, Actual Rectangle and Objective triangle are located between Title and labels.");
        var graphComponentsTop = GetComponentsTop(graphComponents);
        var graphTitleBottom = GetComponentsBottom([riskScoreGraphTitle]);
        CompareProperty(graphComponentsTop, cmpGreaterOrEqual, graphTitleBottom, true, lmWarning);
        var graphComponentsBottom = GetComponentsBottom(graphComponents);
        var labelsTop = GetComponentsTop([riskScoreLabelActual, riskScoreLabelObjective]);
        CompareProperty(graphComponentsBottom, cmpLessOrEqual, labelsTop, true, lmWarning);
        
        Log.Message("Check if " + graphName + " graph Labels, General Rectangle, Actual Rectangle and Objective triangle are horizontally between labels.");
        var graphComponentsMostLeft = GetComponentsLeftMax(graphComponents);
        CompareProperty(graphComponentsMostLeft, cmpGreaterOrEqual, riskScoreLabelActual.Left + riskScoreLabelActual.Width, true, lmWarning);
        var graphComponentsMostRight = GetComponentsRightMax(graphComponents);
        CompareProperty(graphComponentsMostRight, cmpLessOrEqual, riskScoreLabelObjective.Left, true, lmWarning);
        
        Log.Message("Check if " + graphName + " graph Actual Rectangle location on General Rectangle reflects the actual percent label information.");
        var maxNbOfLevels = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_RiskScore_MaxLevel", language + client));
        var RectanglePercentDisplayedValue = ConvertStrToNumberFormat(riskScoreActualPercentLabel.WPFControlText);
        if (RectanglePercentDisplayedValue == null)
            Log.Error("The Actual Rectangle percent displayed value is empty.");
        else {
            var relativeLength = (riskScoreGeneralRectangle.ActualHeight)*((RectanglePercentDisplayedValue-1)/(maxNbOfLevels-1));
            var expectedRectanglePosition = riskScoreGeneralRectangle.Top + riskScoreGeneralRectangle.ActualHeight - relativeLength;
            var actualRectanglePosition = riskScoreActualRectangle.Top + riskScoreActualRectangle.ActualHeight/2;
            CheckEqualsForFloatValue(actualRectanglePosition.toFixed(CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS), expectedRectanglePosition.toFixed(CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS), graphName + " graph Actual Rectangle position on the General Rectangle.", CR1958_GRAPH_MAX_PIXELS_NB_TOLERANCE_FOR_HORIZONTAL_AXIS_PERCENTS_LABELS_POSITIONS, lmWarning);
        }
        
        if (checkObjectiveTrianglesDisplay == true){
            Log.Message("Check if " + graphName + " graph Objective Triangle location on General Rectangle reflects the actual percent label information.");
            var TrianglePercentDisplayedValue = ConvertStrToNumberFormat(riskScoreObjectivePercentLabel.WPFControlText);
            if (TrianglePercentDisplayedValue == null)
                Log.Error("The Objective Triangle percent displayed value is empty.");
            else {
                var relativePosition = (riskScoreGeneralRectangle.ActualHeight)*((TrianglePercentDisplayedValue-1)/(maxNbOfLevels-1));
                var expectedTrianglePosition = riskScoreGeneralRectangle.Top + riskScoreGeneralRectangle.ActualHeight - relativePosition;
                var actualTrianglePosition = riskScoreObjectiveTriangle.Top + riskScoreObjectiveTriangle.ActualHeight/2;
                CheckEqualsForFloatValue(actualTrianglePosition.toFixed(CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS), expectedTrianglePosition.toFixed(CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS), graphName + " graph Objective Triangle position on the General Rectangle.", CR1958_GRAPH_MAX_PIXELS_NB_TOLERANCE_FOR_HORIZONTAL_AXIS_PERCENTS_LABELS_POSITIONS, lmWarning);
            }
        }
}



function CheckRiskObjectivesGraphDisplayInPortfolio(arrayOfRiskAllocationLevels, expectedGraphTitle, checkObjectiveTrianglesDisplay)
{
    var graphName = (Trim(expectedGraphTitle) != "")? expectedGraphTitle: "Risk Objectives";
    
    try {
        SetAutoTimeOut(3000);
        Log.AppendFolder("Check " + graphName + " graph display in Portfolio.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        
        //Title label validation
        Log.Message("Check " + graphName + " graph Title.");
        var riskObjectivesGraphTitle = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblTitle();
        CheckProperty(riskObjectivesGraphTitle, "IsVisible", cmpEqual, true);
        CheckProperty(riskObjectivesGraphTitle, "WPFControlText", cmpEqual, expectedGraphTitle);
        Log.Link("https://jira.croesus.com/browse/RISK-1268", "JIRA 'RISK-1268' (Fix versions : 90.12.Hf-77, 90.13.In-59, 90.14-63) relativement au nom affiché du graphique de RQS ('Risk Allocation' vs 'Risk Objectives' |  'Répartition du risque' vs 'Objectifs de risque').", "JIRA 'RISK-1268' (Fix versions : 90.12.Hf-77, 90.13.In-59, 90.14-63) relativement au nom affiché du graphique de RQS ('Risk Allocation' vs 'Risk Objectives' |  'Répartition du risque' vs 'Objectifs de risque').");
        
        //Horizontal Axis labels validation
        Log.Message("Check " + graphName + " graph Horizontal Axis label 0%.");
        var riskObjectivesGraphLabelPercent0 = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent0();
        var expected_HorizontalAxis_LblPercent0 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_HorizontalAxis_Label_Percent_0", language + client);
        CheckProperty(riskObjectivesGraphLabelPercent0, "IsVisible", cmpEqual, true);
        CheckProperty(riskObjectivesGraphLabelPercent0, "WPFControlText", cmpEqual, expected_HorizontalAxis_LblPercent0);
        
        Log.Message("Check " + graphName + " graph Horizontal Axis label 25%.");
        var riskObjectivesGraphLabelPercent25 = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent25();
        var expected_HorizontalAxis_LblPercent25 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_HorizontalAxis_Label_Percent_25", language + client);
        CheckProperty(riskObjectivesGraphLabelPercent25, "IsVisible", cmpEqual, true);
        CheckProperty(riskObjectivesGraphLabelPercent25, "WPFControlText", cmpEqual, expected_HorizontalAxis_LblPercent25);
        
        Log.Message("Check " + graphName + " graph Horizontal Axis label 50%.");
        var riskObjectivesGraphLabelPercent50 = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent50();
        var expected_HorizontalAxis_LblPercent50 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_HorizontalAxis_Label_Percent_50", language + client);
        CheckProperty(riskObjectivesGraphLabelPercent50, "IsVisible", cmpEqual, true);
        CheckProperty(riskObjectivesGraphLabelPercent50, "WPFControlText", cmpEqual, expected_HorizontalAxis_LblPercent50);
    
        Log.Message("Check " + graphName + " graph Horizontal Axis label 75%.");
        var riskObjectivesGraphLabelPercent75 = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent75();
        var expected_HorizontalAxis_LblPercent75 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_HorizontalAxis_Label_Percent_75", language + client);
        CheckProperty(riskObjectivesGraphLabelPercent75, "IsVisible", cmpEqual, true);
        CheckProperty(riskObjectivesGraphLabelPercent75, "WPFControlText", cmpEqual, expected_HorizontalAxis_LblPercent75);
        
        Log.Message("Check " + graphName + " graph Horizontal Axis label 100%.");
        var riskObjectivesGraphLabelPercent100 = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent100();
        var expected_HorizontalAxis_LblPercent100 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_HorizontalAxis_Label_Percent_100", language + client);
        CheckProperty(riskObjectivesGraphLabelPercent100, "IsVisible", cmpEqual, true);
        CheckProperty(riskObjectivesGraphLabelPercent100, "WPFControlText", cmpEqual, expected_HorizontalAxis_LblPercent100);
        
        Log.Message("Check " + graphName + " graph background color.");
        var backgroundActualColor = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_ScrollViewer().Background.Color;
        var backgroundActualColorHexValue = aqString.Format("%02x%02x%02x", backgroundActualColor.R, backgroundActualColor.G, backgroundActualColor.B);
        var backgroundExpectedColor = {};
        backgroundExpectedColor.Hex = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Background_Color-RGBHex", language + client);
        if (!CheckEquals(backgroundActualColorHexValue, backgroundExpectedColor.Hex, "Graph background color #")){
            backgroundExpectedColor.R = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Background_Color-R", language + client);
            backgroundExpectedColor.G = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Background_Color-G", language + client);
            backgroundExpectedColor.B = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Background_Color-B", language + client);
            CheckEquals(backgroundActualColor.R, backgroundExpectedColor.R, "Graph background color R component");
            CheckEquals(backgroundActualColor.G, backgroundExpectedColor.G, "Graph background color G component");
            CheckEquals(backgroundActualColor.B, backgroundExpectedColor.B, "Graph background color B component");
        }
        
        //Risk allocation levels component validation
        var labels = [];
        var rectangles = [];
        var triangles = [];
        var percents = [];
        for (var i in arrayOfRiskAllocationLevels){
            var riskAllocationLevel = arrayOfRiskAllocationLevels[i];
            
            Log.Message("Check " + graphName + " graph Risk Allocation level '" + riskAllocationLevel + "' identification label.");
            var riskAllocationLevelLabelObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblLabelForLevel(riskAllocationLevel);
            CheckProperty(riskAllocationLevelLabelObject, "IsVisible", cmpEqual, true);
            CheckProperty(riskAllocationLevelLabelObject, "WPFControlText", cmpEqual, riskAllocationLevel);
            
            Log.Message("Check " + graphName + " graph Risk Allocation level '" + riskAllocationLevel + "' percents label.");
            var riskAllocationLevelPercentsObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskAllocationLevel);
            CheckProperty(riskAllocationLevelPercentsObject, "IsVisible", cmpEqual, true);
            CheckProperty(riskAllocationLevelPercentsObject, "WPFControlText", cmpNotEqual, "");
            
            Log.Message("Check " + graphName + " graph Risk Allocation level '" + riskAllocationLevel + "' rectangle.");
            var riskAllocationLevelRectangleObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(riskAllocationLevel);
            CheckProperty(riskAllocationLevelRectangleObject, "IsVisible", cmpEqual, true);
            
            Log.Message("Check " + graphName + " graph Risk Allocation level '" + riskAllocationLevel + "' rectangle color.");
            var rectangleActualColor = riskAllocationLevelRectangleObject.Fill.Color;
            var rectangleActualColorHexValue = aqString.Format("%02x%02x%02x", rectangleActualColor.R, rectangleActualColor.G, rectangleActualColor.B);
            var rectangleExpectedColor = CR1958_RISK_ALLOCATION_LEVELS_COLORS[riskAllocationLevel];
            if (!CheckEquals(rectangleActualColorHexValue, rectangleExpectedColor.Hex, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color #")){
                CheckEquals(rectangleActualColor.R, rectangleExpectedColor.R, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component");
                CheckEquals(rectangleActualColor.G, rectangleExpectedColor.G, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component");
                CheckEquals(rectangleActualColor.B, rectangleExpectedColor.B, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component");
            }
            
            Log.Message("Check " + graphName + " graph Risk Allocation level '" + riskAllocationLevel + "' triangle.");
            var riskAllocationLevelTriangleObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_TriangleForLevel(riskAllocationLevel);
            if (checkObjectiveTrianglesDisplay === true){
                CheckProperty(riskAllocationLevelTriangleObject, "IsVisible", cmpEqual, true);
                
                Log.Message("Check " + graphName + " graph Risk Allocation level '" + riskAllocationLevel + "' triangle color.");
                var tiangleActualColor = riskAllocationLevelTriangleObject.Fill.Color;
                var tiangleActualColorHexValue = aqString.Format("%02x%02x%02x", tiangleActualColor.R, tiangleActualColor.G, tiangleActualColor.B);
                var tiangleExpectedColor = CR1958_RISK_ALLOCATION_LEVELS_COLORS[riskAllocationLevel];
                if (!CheckEquals(tiangleActualColorHexValue, tiangleExpectedColor.Hex, "Risk allocation level '" + riskAllocationLevel + "' Triangle color #")){
                    CheckEquals(tiangleActualColor.R, tiangleExpectedColor.R, "Risk allocation level '" + riskAllocationLevel + "' Triangle color R component");
                    CheckEquals(tiangleActualColor.G, tiangleExpectedColor.G, "Risk allocation level '" + riskAllocationLevel + "' Triangle color G component");
                    CheckEquals(tiangleActualColor.B, tiangleExpectedColor.B, "Risk allocation level '" + riskAllocationLevel + "' Triangle color B component");
                }
            }
            else if (riskAllocationLevelTriangleObject.Exists)
                CheckProperty(riskAllocationLevelTriangleObject, "IsVisible", cmpEqual, false);
            
            labels[riskAllocationLevel] = riskAllocationLevelLabelObject;
            rectangles[riskAllocationLevel] = riskAllocationLevelRectangleObject;
            triangles[riskAllocationLevel] = riskAllocationLevelTriangleObject;
            percents[riskAllocationLevel] = riskAllocationLevelPercentsObject;
        }
        
        //LAYOUT VERIFICATION
        Log.Message(aqString.ToUpper("Check " + graphName + " graph components layout."), "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        var levelComponents = [];
        for (var i in arrayOfRiskAllocationLevels){
            var riskAllocationLevel = arrayOfRiskAllocationLevels[i];
            levelComponents[riskAllocationLevel] = [];
            levelComponents[riskAllocationLevel].push(labels[riskAllocationLevel]);
            levelComponents[riskAllocationLevel].push(rectangles[riskAllocationLevel]);
            levelComponents[riskAllocationLevel].push(triangles[riskAllocationLevel]);
            levelComponents[riskAllocationLevel].push(percents[riskAllocationLevel]);
        }
        
        var horizontalAxisComponents = [];
        horizontalAxisComponents.push(riskObjectivesGraphLabelPercent0);
        horizontalAxisComponents.push(riskObjectivesGraphLabelPercent25);
        horizontalAxisComponents.push(riskObjectivesGraphLabelPercent50);
        horizontalAxisComponents.push(riskObjectivesGraphLabelPercent75);
        horizontalAxisComponents.push(riskObjectivesGraphLabelPercent100);
        
        CheckRiskObjectivesGraphLayout(arrayOfRiskAllocationLevels, labels, rectangles, triangles, percents, levelComponents, riskObjectivesGraphTitle, horizontalAxisComponents, checkObjectiveTrianglesDisplay);
    }
    catch (checkDisplayException){
        Log.Error("Exception : " + checkDisplayException.message, VarToStr(checkDisplayException.stack));
        checkDisplayException = null;
    }
    finally {
        RestoreAutoTimeOut();
        Log.PopLogFolder();
    }
}



function CheckRiskObjectivesGraphDisplayInProjectedPortfolio(arrayOfRiskAllocationLevels, expectedGraphTitle, checkObjectiveTrianglesDisplay)
{
    var graphName = (Trim(expectedGraphTitle) != "")? expectedGraphTitle: "Risk Objectives";
    
    try {
        SetAutoTimeOut(3000);
        Log.AppendFolder("Check " + graphName + " graph display in the Projected Portfolio.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        
        //Title label validation
        Log.Message("Check " + graphName + " graph Title.");
        var riskObjectivesGraphTitle = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblTitle();
        CheckProperty(riskObjectivesGraphTitle, "IsVisible", cmpEqual, true);
        CheckProperty(riskObjectivesGraphTitle, "WPFControlText", cmpEqual, expectedGraphTitle);
        Log.Link("https://jira.croesus.com/browse/RISK-1268", "JIRA 'RISK-1268' (Fix versions : 90.12.Hf-77, 90.13.In-59, 90.14-63) relativement au nom affiché du graphique de RQS ('Risk Allocation' vs 'Risk Objectives' |  'Répartition du risque' vs 'Objectifs de risque').", "JIRA 'RISK-1268' (Fix versions : 90.12.Hf-77, 90.13.In-59, 90.14-63) relativement au nom affiché du graphique de RQS ('Risk Allocation' vs 'Risk Objectives' |  'Répartition du risque' vs 'Objectifs de risque').");
        
        //Horizontal Axis labels validation
        Log.Message("Check " + graphName + " graph Horizontal Axis label 0%.");
        var riskObjectivesGraphLabelPercent0 = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent0();
        var expected_HorizontalAxis_LblPercent0 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_HorizontalAxis_Label_Percent_0", language + client);
        CheckProperty(riskObjectivesGraphLabelPercent0, "IsVisible", cmpEqual, true);
        CheckProperty(riskObjectivesGraphLabelPercent0, "WPFControlText", cmpEqual, expected_HorizontalAxis_LblPercent0);
        
        Log.Message("Check " + graphName + " graph Horizontal Axis label 25%.");
        var riskObjectivesGraphLabelPercent25 = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent25();
        var expected_HorizontalAxis_LblPercent25 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_HorizontalAxis_Label_Percent_25", language + client);
        CheckProperty(riskObjectivesGraphLabelPercent25, "IsVisible", cmpEqual, true);
        CheckProperty(riskObjectivesGraphLabelPercent25, "WPFControlText", cmpEqual, expected_HorizontalAxis_LblPercent25);
        
        Log.Message("Check " + graphName + " graph Horizontal Axis label 50%.");
        var riskObjectivesGraphLabelPercent50 = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent50();
        var expected_HorizontalAxis_LblPercent50 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_HorizontalAxis_Label_Percent_50", language + client);
        CheckProperty(riskObjectivesGraphLabelPercent50, "IsVisible", cmpEqual, true);
        CheckProperty(riskObjectivesGraphLabelPercent50, "WPFControlText", cmpEqual, expected_HorizontalAxis_LblPercent50);
    
        Log.Message("Check " + graphName + " graph Horizontal Axis label 75%.");
        var riskObjectivesGraphLabelPercent75 = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent75();
        var expected_HorizontalAxis_LblPercent75 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_HorizontalAxis_Label_Percent_75", language + client);
        CheckProperty(riskObjectivesGraphLabelPercent75, "IsVisible", cmpEqual, true);
        CheckProperty(riskObjectivesGraphLabelPercent75, "WPFControlText", cmpEqual, expected_HorizontalAxis_LblPercent75);
        
        Log.Message("Check " + graphName + " graph Horizontal Axis label 100%.");
        var riskObjectivesGraphLabelPercent100 = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_HorizontalAxis_LblPercent100();
        var expected_HorizontalAxis_LblPercent100 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_HorizontalAxis_Label_Percent_100", language + client);
        CheckProperty(riskObjectivesGraphLabelPercent100, "IsVisible", cmpEqual, true);
        CheckProperty(riskObjectivesGraphLabelPercent100, "WPFControlText", cmpEqual, expected_HorizontalAxis_LblPercent100);
    
        Log.Message("Check " + graphName + " graph background color.");
        var backgroundActualColor = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_ScrollViewer().Background.Color;
        var backgroundActualColorHexValue = aqString.Format("%02x%02x%02x", backgroundActualColor.R, backgroundActualColor.G, backgroundActualColor.B);
        var backgroundExpectedColor = {};
        backgroundExpectedColor.Hex = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Background_Color-RGBHex", language + client);
        if (!CheckEquals(backgroundActualColorHexValue, backgroundExpectedColor.Hex, "Graph background color #")){
            backgroundExpectedColor.R = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Background_Color-R", language + client);
            backgroundExpectedColor.G = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Background_Color-G", language + client);
            backgroundExpectedColor.B = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Background_Color-B", language + client);
            CheckEquals(backgroundActualColor.R, backgroundExpectedColor.R, "Graph background color R component");
            CheckEquals(backgroundActualColor.G, backgroundExpectedColor.G, "Graph background color G component");
            CheckEquals(backgroundActualColor.B, backgroundExpectedColor.B, "Graph background color B component");
        }
        
        //Risk allocation levels component validation
        var labels = [];
        var rectangles = [];
        var triangles = [];
        var percents = [];
        for (var i in arrayOfRiskAllocationLevels){
            var riskAllocationLevel = arrayOfRiskAllocationLevels[i];
            
            Log.Message("Check " + graphName + " graph Risk Allocation level '" + riskAllocationLevel + "' identification label.");
            var riskAllocationLevelLabelObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblLabelForLevel(riskAllocationLevel);
            CheckProperty(riskAllocationLevelLabelObject, "IsVisible", cmpEqual, true);
            CheckProperty(riskAllocationLevelLabelObject, "WPFControlText", cmpEqual, riskAllocationLevel);
            
            Log.Message("Check " + graphName + " graph Risk Allocation level '" + riskAllocationLevel + "' percents label.");
            var riskAllocationLevelPercentsObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskAllocationLevel);
            CheckProperty(riskAllocationLevelPercentsObject, "IsVisible", cmpEqual, true);
            CheckProperty(riskAllocationLevelPercentsObject, "WPFControlText", cmpNotEqual, "");
            
            Log.Message("Check " + graphName + " graph Risk Allocation level '" + riskAllocationLevel + "' rectangle.");
            var riskAllocationLevelRectangleObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(riskAllocationLevel);
            CheckProperty(riskAllocationLevelRectangleObject, "IsVisible", cmpEqual, true);
            
            Log.Message("Check " + graphName + " graph Risk Allocation level '" + riskAllocationLevel + "' rectangle color.");
            var rectangleActualColor = riskAllocationLevelRectangleObject.Fill.Color;
            var rectangleActualColorHexValue = aqString.Format("%02x%02x%02x", rectangleActualColor.R, rectangleActualColor.G, rectangleActualColor.B);
            var rectangleExpectedColor = CR1958_RISK_ALLOCATION_LEVELS_COLORS[riskAllocationLevel];
            if (!CheckEquals(rectangleActualColorHexValue, rectangleExpectedColor.Hex, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color #")){
                CheckEquals(rectangleActualColor.R, rectangleExpectedColor.R, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component");
                CheckEquals(rectangleActualColor.G, rectangleExpectedColor.G, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component");
                CheckEquals(rectangleActualColor.B, rectangleExpectedColor.B, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component");
            }
            
            Log.Message("Check " + graphName + " graph Risk Allocation level '" + riskAllocationLevel + "' triangle.");
            var riskAllocationLevelTriangleObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_TriangleForLevel(riskAllocationLevel);
            if (checkObjectiveTrianglesDisplay === true){
                CheckProperty(riskAllocationLevelTriangleObject, "IsVisible", cmpEqual, true);
                
                Log.Message("Check " + graphName + " graph Risk Allocation level '" + riskAllocationLevel + "' triangle color.");
                var tiangleActualColor = riskAllocationLevelTriangleObject.Fill.Color;
                var tiangleActualColorHexValue = aqString.Format("%02x%02x%02x", tiangleActualColor.R, tiangleActualColor.G, tiangleActualColor.B);
                var tiangleExpectedColor = CR1958_RISK_ALLOCATION_LEVELS_COLORS[riskAllocationLevel];
                if (!CheckEquals(tiangleActualColorHexValue, tiangleExpectedColor.Hex, "Risk allocation level '" + riskAllocationLevel + "' Triangle color #")){
                    CheckEquals(tiangleActualColor.R, tiangleExpectedColor.R, "Risk allocation level '" + riskAllocationLevel + "' Triangle color R component");
                    CheckEquals(tiangleActualColor.G, tiangleExpectedColor.G, "Risk allocation level '" + riskAllocationLevel + "' Triangle color G component");
                    CheckEquals(tiangleActualColor.B, tiangleExpectedColor.B, "Risk allocation level '" + riskAllocationLevel + "' Triangle color B component");
                }
            }
            else if (riskAllocationLevelTriangleObject.Exists)
                CheckProperty(riskAllocationLevelTriangleObject, "IsVisible", cmpEqual, false);
            
            labels[riskAllocationLevel] = riskAllocationLevelLabelObject;
            rectangles[riskAllocationLevel] = riskAllocationLevelRectangleObject;
            triangles[riskAllocationLevel] = riskAllocationLevelTriangleObject;
            percents[riskAllocationLevel] = riskAllocationLevelPercentsObject;
        }
        
        //LAYOUT VERIFICATION
        Log.Message(aqString.ToUpper("Check " + graphName + " graph components layout."), "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        var levelComponents = [];
        for (var i in arrayOfRiskAllocationLevels){
            var riskAllocationLevel = arrayOfRiskAllocationLevels[i];
            levelComponents[riskAllocationLevel] = [];
            levelComponents[riskAllocationLevel].push(labels[riskAllocationLevel]);
            levelComponents[riskAllocationLevel].push(rectangles[riskAllocationLevel]);
            levelComponents[riskAllocationLevel].push(triangles[riskAllocationLevel]);
            levelComponents[riskAllocationLevel].push(percents[riskAllocationLevel]);
        }
        
        var horizontalAxisComponents = [];
        horizontalAxisComponents.push(riskObjectivesGraphLabelPercent0);
        horizontalAxisComponents.push(riskObjectivesGraphLabelPercent25);
        horizontalAxisComponents.push(riskObjectivesGraphLabelPercent50);
        horizontalAxisComponents.push(riskObjectivesGraphLabelPercent75);
        horizontalAxisComponents.push(riskObjectivesGraphLabelPercent100);
        
        CheckRiskObjectivesGraphLayout(arrayOfRiskAllocationLevels, labels, rectangles, triangles, percents, levelComponents, riskObjectivesGraphTitle, horizontalAxisComponents, checkObjectiveTrianglesDisplay);
    }
    catch (checkDisplayException){
        Log.Error("Exception : " + checkDisplayException.message, VarToStr(checkDisplayException.stack));
        checkDisplayException = null;
    }
    finally {
        RestoreAutoTimeOut();
        Log.PopLogFolder();
    }
}



function CheckRiskObjectivesGraphLayout(arrayOfRiskAllocationLevels, labels, rectangles, triangles, percents, levelComponents, title, horizontalAxisComponents, checkObjectiveTrianglesDisplay)
{
    //Horizontal axis labels positions
    var arrayOfSpaces = [];
    for (var i = 1; i < horizontalAxisComponents.length; i++)
        arrayOfSpaces.push(horizontalAxisComponents[i].Left + 0.5*(horizontalAxisComponents[i].Width) - horizontalAxisComponents[i-1].Left - 0.5*(horizontalAxisComponents[i-1].Width));
    var horizontalAxisSpacesDeviation = GetArrayMax(arrayOfSpaces) - GetArrayMin(arrayOfSpaces);
    Log.Message("Check if Horizontal axis percents Labels are well spaced, actual spaces deviation max - min = " + horizontalAxisSpacesDeviation + ".");
    CompareProperty(horizontalAxisSpacesDeviation, cmpLessOrEqual, CR1958_GRAPH_MAX_PIXELS_NB_TOLERANCE_FOR_HORIZONTAL_AXIS_PERCENTS_LABELS_POSITIONS, true, lmWarning);
    
    var rectanglesZeroPosition = (GetComponentsLeftMax(rectangles) + GetComponentsLeftMin(rectangles))/2;
    var horizontalAxisFirstLabelMiddle = horizontalAxisComponents[0].Left + 0.5*(horizontalAxisComponents[0].Width);
    Log.Message("Check if Horizontal axis first Label (" + horizontalAxisComponents[0].WPFControlText + ") is well located at the beginning of the graph = " + horizontalAxisFirstLabelMiddle + " versus " + rectanglesZeroPosition);
    CompareProperty(Math.abs(horizontalAxisFirstLabelMiddle - rectanglesZeroPosition), cmpLessOrEqual, CR1958_GRAPH_MAX_PIXELS_NB_TOLERANCE_FOR_HORIZONTAL_AXIS_PERCENTS_LABELS_POSITIONS, true, lmWarning);
    
    var graphRectanglesLengthSum  = 0;
    for (var key in rectangles){
        var rectangleWidth = (rectangles[key].ActualWidth == 0)? 0: rectangles[key].Width;
        graphRectanglesLengthSum  += rectangleWidth;
    }
    var expectedHorizontalAxisLastLabelMiddle = (rectanglesZeroPosition + graphRectanglesLengthSum).toFixed(0);
    var actualHorizontalAxisLastLabelMiddle = horizontalAxisComponents[horizontalAxisComponents.length-1].Left + 0.5*(horizontalAxisComponents[horizontalAxisComponents.length-1].Width);
    Log.Message("Check if Horizontal axis last Label (" + horizontalAxisComponents[horizontalAxisComponents.length-1].WPFControlText+ ") is well located at the end of the graph = " + expectedHorizontalAxisLastLabelMiddle + " versus " + actualHorizontalAxisLastLabelMiddle);
    CompareProperty(Math.abs(actualHorizontalAxisLastLabelMiddle - expectedHorizontalAxisLastLabelMiddle), cmpLessOrEqual, CR1958_GRAPH_MAX_PIXELS_NB_TOLERANCE_FOR_HORIZONTAL_AXIS_PERCENTS_LABELS_POSITIONS, true, lmWarning);
    
    //Labels vertical alignment
    var labelsLeftDeviationMaxMin = GetComponentsLeftMax(labels) - GetComponentsLeftMin(labels);
    Log.Message("Check if Risk Allocation Levels Labels are well left aligned, actual deviation max - min = " + labelsLeftDeviationMaxMin + ".");
    CompareProperty(labelsLeftDeviationMaxMin, cmpLessOrEqual, CR1958_GRAPH_MAX_PIXELS_LEFT_DEVIATION_TOLERANCE_FOR_VERTICALLY_ALIGNED_ITEMS, true, lmWarning);
    
    //Percents vertical alignment
    var percentsLeftDeviationMaxMin = GetComponentsLeftMax(percents) - GetComponentsLeftMin(percents);
    Log.Message("Check if Risk Allocation Levels Percents are well left aligned, actual deviation max - min = " + percentsLeftDeviationMaxMin + ".");
    CompareProperty(percentsLeftDeviationMaxMin, cmpLessOrEqual, CR1958_GRAPH_MAX_PIXELS_LEFT_DEVIATION_TOLERANCE_FOR_VERTICALLY_ALIGNED_ITEMS, true, lmWarning);
    
    //Rectangles vertical alignment
    var rectangleLeftDeviationMaxMin = GetComponentsLeftMax(rectangles) - GetComponentsLeftMin(rectangles);
    Log.Message("Check if Risk Allocation Levels Rectangles are well left aligned, actual deviation max - min = " + rectangleLeftDeviationMaxMin + ".");
    CompareProperty(rectangleLeftDeviationMaxMin, cmpLessOrEqual, CR1958_GRAPH_MAX_PIXELS_LEFT_DEVIATION_TOLERANCE_FOR_VERTICALLY_ALIGNED_ITEMS, true, lmWarning);
    
    //Rectangles area
    Log.Message("Check if Risk Allocation Levels Rectangle are located in the expected area, within labels and percents.");
    Log.Message("Rectangles Most Left position check.");
    var labelsRight = GetComponentsRightMax(labels);
    var rectanglesLeft = GetComponentsLeftMin(rectangles);
    CompareProperty(rectanglesLeft, cmpGreaterOrEqual, labelsRight + CR1958_GRAPH_MIN_PIXELS_BETWEEN_LEVELS_IDENTIFICATION_LABELS_AND_RECTANGLES, true, lmWarning);
    Log.Message("Rectangles Most Right position check.");
    var percentsLeft = GetComponentsLeftMin(percents);
    var rectanglesRight = GetComponentsRightMax(rectangles);
    CompareProperty(rectanglesRight, cmpLessOrEqual, percentsLeft - CR1958_GRAPH_MIN_PIXELS_BETWEEN_RECTANGLES_TRIANGLES_AND_PERCENTS_LABELS, true, lmWarning);
    
    //Triangles area
    if (checkObjectiveTrianglesDisplay === true){
        Log.Message("Check if Risk Allocation Levels Triangles are located in the expected area, within labels and percents.");
        Log.Message("Triangles Most Left position check.");
        var labelsRight = GetComponentsRightMax(labels);
        var trianglesLeft = GetComponentsLeftMin(triangles);
        CompareProperty(trianglesLeft, cmpGreaterOrEqual, labelsRight + CR1958_GRAPH_MIN_PIXELS_BETWEEN_IDENTIFICATION_LABELS_AND_TRIANGLES, true, lmWarning);
        Log.Message("Triangles Most Right position check.");
        var percentsLeft = GetComponentsLeftMin(percents);
        var trianglesRight = GetComponentsRightMax(triangles);
        CompareProperty(trianglesRight, cmpLessOrEqual, percentsLeft - CR1958_GRAPH_MIN_PIXELS_BETWEEN_RECTANGLES_TRIANGLES_AND_PERCENTS_LABELS, true, lmWarning);
    }
    
    //CHECK IF THE VERTICAL POSITION IS ACCORDING THE MOST RISKY TO THE LEAST RISKY ORDER
    Log.Message("Check if Risk Allocation levels components are actually vertically ordered according to the most risky to the least risky order (and if applicable if each level Triangle is adjacent to the Rectangle).", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
    for (var i = 0; i < arrayOfRiskAllocationLevels.length; i++){
        var riskAllocationLevel = arrayOfRiskAllocationLevels[i];
        
        //Triangle againt rectangle
        if (checkObjectiveTrianglesDisplay === true){
            Log.Message("Check if Risk Allocation level '" + riskAllocationLevel + "' Triangle is adjacent to the bar, just under it.");
            var rectangleBottom = rectangles[riskAllocationLevel].Top + rectangles[riskAllocationLevel].Height;
            var triangleTop = triangles[riskAllocationLevel].Top;
            CompareProperty(triangleTop, cmpLessOrEqual, rectangleBottom, true, lmWarning);
            CompareProperty(Math.abs(triangleTop - rectangleBottom), cmpLessOrEqual, CR1958_GRAPH_MAX_PIXELS_BETWEEN_LEVEL_RECTANGLE_AND_TRIANGLE, true, lmWarning);
        }
        
        //All level components against immediate most risky
        var currentLevelComponentsTop = GetComponentsTop(levelComponents[riskAllocationLevel]);
        if (i == 0){
            Log.Message("Check Risk Allocation level '" + riskAllocationLevel + "' components vertical position against 'Title' one.");
            CompareProperty(currentLevelComponentsTop, cmpGreaterOrEqual, title.Top + title.Height, true, lmWarning);
        }
        else {
            Log.Message("Check Risk Allocation level '" + riskAllocationLevel + "' components vertical position against '" + arrayOfRiskAllocationLevels[i-1] + "' one.");
            CompareProperty(currentLevelComponentsTop, cmpGreaterOrEqual, previousMostRiskyLevelComponentsBottom + CR1958_GRAPH_MIN_PIXELS_BETWEEN_ADJACENT_LEVELS_COMPONENTS, true, lmWarning);
        }
        
        var previousMostRiskyLevelComponentsBottom = GetComponentsBottom(levelComponents[riskAllocationLevel]);
        if (i == (arrayOfRiskAllocationLevels.length - 1)){
            Log.Message("Check Risk Allocation level '" + riskAllocationLevel + "' components vertical position against 'Horizontal axis' one.");
            var horizontalAxisComponentsTop = GetComponentsTop(horizontalAxisComponents);
            CompareProperty(previousMostRiskyLevelComponentsBottom, cmpLessOrEqual, horizontalAxisComponentsTop, true, lmWarning);
        }
    }
    
    //CHECK GRAPH RECTANGLE LENGTH AND TRIANGLE POSITION REFLECTS THE PERCENTS LABELS INFORMATION
    Log.Message("Check if Graph Rectangles length reflect the displayed percents labels information.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
    var graphRectanglesLengthPercents = GetGraphRectanglesLengthPercents(rectangles);
    var labelsRectanglesLengthPercents = GetLabelRectanglesLengthPercents(percents);
    for (var i = 0; i < arrayOfRiskAllocationLevels.length; i++){
        var riskAllocationLevel = arrayOfRiskAllocationLevels[i];
        CheckEqualsForFloatValue(graphRectanglesLengthPercents[riskAllocationLevel], labelsRectanglesLengthPercents[riskAllocationLevel], "Risk Allocation level '" + riskAllocationLevel + "' graph bar length compared to the percent label information", CR1958_GRAPH_FLOAT_VALUES_CHECKPOINT_TOLERANCE_PERCENT, lmWarning);
    }
    
    if (checkObjectiveTrianglesDisplay === true){
        Log.Message("Check if Graph Triangles positions reflect the displayed percents labels information.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        var graphTrianglesPositionsPercents = GetGraphTrianglesPositionPercents(triangles, rectangles)
        var labelsTrianglesPositionPercents = GetLabelTrianglesPositionPercents(percents);
        for (var i = 0; i < arrayOfRiskAllocationLevels.length; i++){
            var riskAllocationLevel = arrayOfRiskAllocationLevels[i];
            CheckEqualsForFloatValue(graphTrianglesPositionsPercents[riskAllocationLevel], labelsTrianglesPositionPercents[riskAllocationLevel], "Risk Allocation level '" + riskAllocationLevel + "' graph triangle position compared to the percent label information", CR1958_GRAPH_FLOAT_VALUES_CHECKPOINT_TOLERANCE_PERCENT, lmWarning);
        }
    }
}



function GetLabelRectanglesLengthPercents(percentsLabelsObjects)
{
    var labelsRectanglesLengthPercents = [];
    for (var key in percentsLabelsObjects){
        var labelRectangleLengthPercentDisplayed = GetRectangleDisplayedPercentLabel(percentsLabelsObjects[key].WPFControlText);
        if (labelRectangleLengthPercentDisplayed[labelRectangleLengthPercentDisplayed.length - 1] == CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL)
            labelRectangleLengthPercentDisplayed = aqString.SubString(labelRectangleLengthPercentDisplayed, 0, labelRectangleLengthPercentDisplayed.length - 1);
        
        var labelRectangleLengthPercentValue = ConvertStrToNumberFormat(labelRectangleLengthPercentDisplayed);
        labelsRectanglesLengthPercents[key] = labelRectangleLengthPercentValue;
    }
    
    return labelsRectanglesLengthPercents;
}


function GetLabelTrianglesPositionPercents(percentsLabelsObjects)
{
    var labelsTrianglesPositionPercents = [];
    for (var key in percentsLabelsObjects){
        var labelTrianglePositionPercentDisplayed = GetTriangleDisplayedPercentLabel(percentsLabelsObjects[key].WPFControlText);
        if (labelTrianglePositionPercentDisplayed[labelTrianglePositionPercentDisplayed.length - 1] == CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL)
            labelTrianglePositionPercentDisplayed = aqString.SubString(labelTrianglePositionPercentDisplayed, 0, labelTrianglePositionPercentDisplayed.length - 1);
        
        var labelTrianglePositionPercentValue = ConvertStrToNumberFormat(labelTrianglePositionPercentDisplayed);
        labelsTrianglesPositionPercents[key] = labelTrianglePositionPercentValue;
    }
    
    return labelsTrianglesPositionPercents;
}


function GetGraphRectanglesLengthPercents(rectangles)
{
    var graphRectanglesLengthSum  = 0;
    var graphRectanglesLengthPercents = [];
    var graphRectanglesLengths = [];
    for (var key in rectangles){
        var graphRectangleLength = (rectangles[key].ActualWidth == 0)? 0: rectangles[key].Width;
        graphRectanglesLengths[key] = graphRectangleLength;
        graphRectanglesLengthSum  += graphRectangleLength;
    }
    
    for (var key in graphRectanglesLengths)
        graphRectanglesLengthPercents[key] = (100 * (graphRectanglesLengths[key] / graphRectanglesLengthSum)).toFixed(CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS);
    
    return graphRectanglesLengthPercents;
}



function GetGraphTrianglesPositionPercents(triangles, rectangles)
{
    var graphRectanglesLengthSum  = 0;
    for (var key in rectangles){
        var graphRectangleLength = (rectangles[key].ActualWidth == 0)? 0: rectangles[key].Width;
        graphRectanglesLengthSum  += graphRectangleLength;
    }
    
    var trianglesZeroPosition = (GetComponentsLeftMax(rectangles) + GetComponentsLeftMin(rectangles))/2;
    var graphTrianglesPositionsPercents = [];
    var graphTrianglesPositions = [];
    for (var key in triangles){
        var graphTrianglePosition = triangles[key].Left + (triangles[key].ActualWidth / 2) - trianglesZeroPosition;
        graphTrianglesPositions[key] = graphTrianglePosition;
    }
    
    for (var key in graphTrianglesPositions)
        graphTrianglesPositionsPercents[key] = (100 * (graphTrianglesPositions[key] / graphRectanglesLengthSum)).toFixed(CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS);
       
    return graphTrianglesPositionsPercents;
}



function GetComponentsTop(arrObj)
{
    var arrayOfTop = [];
    for (var key in arrObj)
        if (arrObj[key].Exists && arrObj[key].IsVisible)
            arrayOfTop[key] = arrObj[key].Top;
    return GetArrayMin(arrayOfTop);
}


function GetComponentsBottom(arrObj)
{
    var arrayOfBottom = [];
    for (var key in arrObj)
        if (arrObj[key].Exists && arrObj[key].IsVisible)
            arrayOfBottom[key] = arrObj[key].Top + arrObj[key].Height;
    return GetArrayMax(arrayOfBottom);
}



function GetComponentsLeftMin(arrObj)
{
    var arrayOfLeft = [];
    for (var key in arrObj)
        if (arrObj[key].Exists && arrObj[key].IsVisible)
            arrayOfLeft[key] = arrObj[key].Left;
    return GetArrayMin(arrayOfLeft);
}

function GetComponentsLeftMax(arrObj)
{
    var arrayOfLeft = [];
    for (var key in arrObj)
        if (arrObj[key].Exists && arrObj[key].IsVisible)
            arrayOfLeft[key] = arrObj[key].Left;
    return GetArrayMax(arrayOfLeft);
}

function GetComponentsRightMax(arrObj)
{
    var arrayOfRight = [];
    for (var key in arrObj)
        if (arrObj[key].Exists && arrObj[key].IsVisible)
            arrayOfRight[key] = arrObj[key].Left + arrObj[key].Width;
    return GetArrayMax(arrayOfRight);
}

function GetArrayMin(arr)
{
    var tempArr = [];
    for (var key in arr)
        tempArr.push(arr[key]);
    tempArr.sort();
    return tempArr[0];
}

function GetArrayMax(arr)
{
    var tempArr = [];
    for (var key in arr)
        tempArr.push(arr[key]);
    tempArr.sort().reverse();
    return tempArr[0];
}



/**

//************************************************ GENERIC GRAPH INFOS RETRIEVE ********************************

function GetRiskAllocationGraphInfosFromProjectedPortfolioForAllLevelsWithRelativeInfos(arrayOfRiskRatingLevels)
{
    //Retrieve objects information from the Projected Portfolio Risk Allocation Graph
    var projectedPortfolio_RiskAllocationGraphInfos = new Array();
    for (var k in arrayOfRiskRatingLevels)
        projectedPortfolio_RiskAllocationGraphInfos[arrayOfRiskRatingLevels[k]] = GetRiskAllocationGraphInfosFromProjectedPortfolioForLevel(arrayOfRiskRatingLevels[k]);
            
    //Complete retrieved objects information by adding relative information
    return GetRiskAllocationGraphAddRelativeInfos(projectedPortfolio_RiskAllocationGraphInfos);
}



function GetRiskAllocationGraphInfosFromPortfolioForAllLevelsWithRelativeInfos(arrayOfRiskRatingLevels)
{
    //Retrieve objects information from the Portfolio Risk Allocation Graph
    var portfolio_RiskAllocationGraphInfos = new Array();
    for (var k in arrayOfRiskRatingLevels)
        portfolio_RiskAllocationGraphInfos[arrayOfRiskRatingLevels[k]] = GetRiskAllocationGraphInfosFromPortfolioForLevel(arrayOfRiskRatingLevels[k]);
            
    //Complete retrieved objects information by adding relative information
    return GetRiskAllocationGraphAddRelativeInfos(portfolio_RiskAllocationGraphInfos);
}


function GetRiskAllocationGraphInfosFromProjectedPortfolioForLevel(ratingLevel, pixelsTolerance)
{
    if (pixelsTolerance == undefined)
        pixelsTolerance = 10;
    
    var ratingLabelObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblLabelForLevel(ratingLevel);
    var ratingRectangleObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(ratingLevel);
    var ratingTriangleObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_TriangleForLevel(ratingLevel);
    var ratingPercentsObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(ratingLevel);
    
    return GetRiskAllocationGraphInfosFromObjects(ratingLabelObject, ratingRectangleObject, ratingTriangleObject, ratingPercentsObject, pixelsTolerance);
}



function GetRiskAllocationGraphInfosFromPortfolioForLevel(ratingLevel, pixelsTolerance)
{
    if (pixelsTolerance == undefined)
        pixelsTolerance = 10;
    
    var ratingLabelObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblLabelForLevel(ratingLevel);
    var ratingRectangleObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(ratingLevel);
    var ratingTriangleObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_TriangleForLevel(ratingLevel);
    var ratingPercentsObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(ratingLevel);
    
    return GetRiskAllocationGraphInfosFromObjects(ratingLabelObject, ratingRectangleObject, ratingTriangleObject, ratingPercentsObject, pixelsTolerance);
}



function GetRiskAllocationGraphInfosFromObjects(ratingLabelObject, ratingRectangleObject, ratingTriangleObject, ratingPercentsObject, pixelsTolerance)
{
    if (pixelsTolerance == undefined)
        pixelsTolerance = 10;
    
    var riskAllocationGraphInfos = {ratingLabel: null,
                                    marketPercentLabel: null,
                                    marketBarLength: null,
                                    marketBarLengthPercent: null,
                                    marketBarColorRGBA: null,
                                    targetPercentLabel: null,
                                    targetTrianglePosition: null,
                                    targetTrianglePositionPercent: null,
                                    targetTriangleColorRGBA: null,
                                    isTargetTriangleDisplayed: null,
                                    isLabelsAndBarVerticalAlignmentCorrect: null,
                                    isTriangleVerticalPositionCorrect: null,
                                    allObjectsTopMost: null,
                                    allObjectsBottomMost: null
                                    };
    
    var ratingLabelObject_Middle_Y = ratingLabelObject.Top + (ratingLabelObject.ActualHeight / 2);
    var ratingRectangleObject_Middle_Y = ratingRectangleObject.Top + (ratingRectangleObject.ActualHeight / 2);
    var ratingPercentsObject_Middle_Y = ratingPercentsObject.Top + (ratingPercentsObject.ActualHeight / 2);
    var isLabelsAndBarVerticalAlignmentCorrect = (pixelsTolerance >= Math.max(Math.abs(ratingLabelObject_Middle_Y - ratingRectangleObject_Middle_Y),
                                                                      Math.abs(ratingLabelObject_Middle_Y - ratingPercentsObject_Middle_Y),
                                                                      Math.abs(ratingRectangleObject_Middle_Y - ratingPercentsObject_Middle_Y)));
    

    
    var marketBarColorRGBA = [IntToStr(ratingRectangleObject.Fill.Color.R), IntToStr(ratingRectangleObject.Fill.Color.G), IntToStr(ratingRectangleObject.Fill.Color.B), IntToStr(ratingRectangleObject.Fill.Color.A)];
    
    if (ratingTriangleObject.Exists){
        var targetTriangleColorRGBA = [IntToStr(ratingTriangleObject.Fill.Color.R), IntToStr(ratingTriangleObject.Fill.Color.G), IntToStr(ratingTriangleObject.Fill.Color.B), IntToStr(ratingTriangleObject.Fill.Color.A)];
        var isTriangleVerticalPositionCorrect = (pixelsTolerance >= (ratingTriangleObject.Top - (ratingRectangleObject.Top + ratingRectangleObject.ActualHeight)));
        var displayedMarketValue = GetRectangleDisplayedPercentLabel(ratingPercentsObject.WPFControlText);
        var displayedTargetValue = GetTriangleDisplayedPercentLabel(ratingPercentsObject.WPFControlText);
        var ratingTriangleObject_Position = ratingTriangleObject.Left + (ratingTriangleObject.ActualWidth / 2) - ratingRectangleObject.Left;
        var allObjectsTopMost_Y = Math.min(ratingLabelObject.Top, ratingTriangleObject.Top, ratingRectangleObject.Top, ratingPercentsObject.Top);
        var allObjectsBottomMost_Y = Math.max(ratingLabelObject.Top + ratingLabelObject.ActualHeight,
                                           ratingTriangleObject.Top + ratingTriangleObject.ActualHeight,
                                          ratingRectangleObject.Top + ratingRectangleObject.ActualHeight,
                                           ratingPercentsObject.Top + ratingPercentsObject.ActualHeight);
    }
    else {
        var targetTriangleColorRGBA = null;
        var isTriangleVerticalPositionCorrect = null;
        var displayedMarketValue = Trim(ratingPercentsObject.WPFControlText);
        var displayedTargetValue = null;
        var ratingTriangleObject_Position = null;
        var allObjectsTopMost_Y = Math.min(ratingLabelObject.Top, ratingRectangleObject.Top, ratingPercentsObject.Top);
        var allObjectsBottomMost_Y = Math.max(ratingLabelObject.Top + ratingLabelObject.ActualHeight,
                                          ratingRectangleObject.Top + ratingRectangleObject.ActualHeight,
                                           ratingPercentsObject.Top + ratingPercentsObject.ActualHeight);
    }
    
    riskAllocationGraphInfos.ratingLabel = ratingLabelObject.Text.OleValue;
    riskAllocationGraphInfos.marketPercentLabel = displayedMarketValue;
    riskAllocationGraphInfos.marketBarLength = (ratingRectangleObject.ActualWidth == 0)? 0: ratingRectangleObject.Width;
    riskAllocationGraphInfos.marketBarColorRGBA = marketBarColorRGBA;
    riskAllocationGraphInfos.targetPercentLabel = displayedTargetValue;
    riskAllocationGraphInfos.targetTrianglePosition = ratingTriangleObject_Position;
    riskAllocationGraphInfos.targetTriangleColorRGBA = targetTriangleColorRGBA
    riskAllocationGraphInfos.isTargetTriangleDisplayed = (ratingTriangleObject.Exists && ratingTriangleObject.IsVisible);
    riskAllocationGraphInfos.isLabelsAndBarVerticalAlignmentCorrect = isLabelsAndBarVerticalAlignmentCorrect;
    riskAllocationGraphInfos.isTriangleVerticalPositionCorrect = isTriangleVerticalPositionCorrect;
    riskAllocationGraphInfos.allObjectsTopMost = allObjectsTopMost_Y;
    riskAllocationGraphInfos.allObjectsBottomMost = allObjectsBottomMost_Y;
    
    return riskAllocationGraphInfos;
}



function GetRiskAllocationGraphAddRelativeInfos(riskAllocationGraphInfosArray)
{
    var rectanglesLengthSum  = 0;
    var trianglesPositionSum = 0;
    
    var arrayOfKeys = GetArrayKeys(riskAllocationGraphInfosArray);
    for (var i in arrayOfKeys){
        rectanglesLengthSum  += riskAllocationGraphInfosArray[arrayOfKeys[i]].marketBarLength;
        if (riskAllocationGraphInfosArray[arrayOfKeys[i]].isTargetTriangleDisplayed)
            trianglesPositionSum += riskAllocationGraphInfosArray[arrayOfKeys[i]].targetTrianglePosition;
    }
    
    for (var i in arrayOfKeys){
        var currentRiskAllocationGraphInfos = riskAllocationGraphInfosArray[arrayOfKeys[i]];
        var barLengthPercent = 100 * ((currentRiskAllocationGraphInfos.marketBarLength) / rectanglesLengthSum);
        currentRiskAllocationGraphInfos.marketBarLengthPercent = barLengthPercent.toFixed(2);
        var trianglePositionPercent = (!(currentRiskAllocationGraphInfos.isTargetTriangleDisplayed))? null: 100 * ((currentRiskAllocationGraphInfos.targetTrianglePosition) / trianglesPositionSum);
        currentRiskAllocationGraphInfos.targetTrianglePositionPercent = trianglePositionPercent.toFixed(2);
        riskAllocationGraphInfosArray[arrayOfKeys[i]] = currentRiskAllocationGraphInfos;
    }
    
    return riskAllocationGraphInfosArray;
}

*/
