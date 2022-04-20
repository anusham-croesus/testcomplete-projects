//USEUNIT CR1958_Helper



/**
    Description : Validate In profolio Intraday 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6144
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_6144_Por_Validate_In_profolio_Intraday()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6144", "CR1958_6144_Por_Validate_In_profolio_Intraday()");
    Log.Message("Bug JIRA CROES-11351 : L'application crash si la  PREF_ENABLE_RISK_SCORE_GRAPH est disactivée");
    
    try {
        var formerOrdersLastID = null;
        formerOrdersLastID = Execute_SQLQuery_GetField("select top 1 GDODER_ID from B_GDO_ORDER order by GDODER_ID desc", vServerRQS, "GDODER_ID");
        var accountNumber = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_6144_AccountNumber", language + client);
        var security1_Description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_6144_Security1_Description", language + client);
        var security1_Quantity = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_6144_Security1_Quantity", language + client);
        var security2_Description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_6144_Security2_Description", language + client);
        var security2_Quantity = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_6144_Security2_Quantity", language + client);
        
        var expectedRiskObjectivesGraphTitle = (client == "CIBC")? CR1958_GRAPH_TITLE_RISKOBJECTIVES: CR1958_GRAPH_TITLE_RISKALLOCATION;
        var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_6144_CheckTrianglesDisplayInGraph", language + client));
        
        //User DARWIC
        var userDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var pswdDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
        //Prealables
        var firm_code = GetUserFirmCode(userDARWIC, vServerRQS);
        var arrayOfPrefsValues = CR1958_GetArrayOfPrefsValues();
        
        //Add GDO prefs
        arrayOfPrefsValues["PREF_INTRADAY_ENABLED"] = "2";
        arrayOfPrefsValues["PREF_INTRADAY_STATUS"] = "10,40,50,70,130";
        arrayOfPrefsValues["PREF_INTRADAY_TOGGLE_ON_OFF"] = "YES";
        //arrayOfPrefsValues["PREF_ENABLE_RISK_SCORE_GRAPH"] = "YES";
        
        var arrayOfPrefsPreviousValues = new Array();
        for (var prefKey in arrayOfPrefsValues)
            arrayOfPrefsPreviousValues[prefKey] = GetFirmPrefValue(vServerRQS, prefKey, firm_code);
        
        UpdateFirmArrayOfPrefs(vServerRQS, firm_code, arrayOfPrefsValues, arrayOfPrefsPreviousValues);
        SetRiskAllocationLevelsWeightsAndClientProfileNames(CR1958_SECURITY_RISK_RATINGS_WEIGHTS, CR1958_RISK_ALLOCATION_CLIENT_PROFILE_NAMES, true);
        
        //Login
        Login(vServerRQS, userDARWIC, pswdDARWIC, language);
        
        if (!Get_ModulesBar_BtnOrders().Exists){
            Log.Error("Orders module not found in the modules bar");
            return CloseCroesus();
        }
        
        //Selected an account add an ordre sell or buy and Drag the Account in the portfolio module
        var randomBuyOrSell = ShuffleArray(["buy", "sell"])[0];
        Log.Message("1. Select account '" + accountNumber + "' add a " + randomBuyOrSell + " order (randomly chosen between sell or buy) and Drag the Account in the portfolio module.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        var nbOfAccountNewOrders_1 = CreateStocksOrder(accountNumber, security1_Description, security1_Quantity, randomBuyOrSell);
        Log.Message("Check if the number of added orders for account '" + accountNumber + "' is : 1");
        CheckEquals(nbOfAccountNewOrders_1, 1, "The number of added orders for account '" + accountNumber + "'");
        
        //Drag the Account in the portfolio module
        if (!SelectAccounts(accountNumber)){
            Log.Error("Unable to select Account Number '" + accountNumber + "'.");
            return CloseCroesus();
        }
        
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_PortfolioGrid_GrpSummary().set_IsExpanded(true);
        Get_PortfolioGrid_GrpSummary().Click(Get_PortfolioGrid_GrpSummary().Width - 40, Get_PortfolioGrid_GrpSummary().Height - 8);
        
        //Check if Risk Score graph and Risk Allocation graph are displayed
        CheckRiskScoreGraphDisplayInPortfolio(checkObjectiveTriangleDisplay);
        CheckRiskObjectivesGraphDisplayInPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
        
        Log.Message("2. Select account '" + accountNumber + "' add a sell order. Drag the Account in the portfolio module and click in Intrady bouton.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        var nbOfAccountNewOrders_2 = CreateStocksOrder(accountNumber, security2_Description, security2_Quantity, "sell");
        Log.Message("Check if the number of added orders for account '" + accountNumber + "' is : 1");
        CheckEquals(nbOfAccountNewOrders_2, 1, "The number of added orders for account '" + accountNumber + "'");
        
        //Drag the Account in the portfolio module
        if (!SelectAccounts(accountNumber)){
            Log.Error("Unable to select Account Number '" + accountNumber + "'.");
            return CloseCroesus();
        }
        
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_PortfolioGrid_GrpSummary().set_IsExpanded(true);
        Get_PortfolioGrid_GrpSummary().Click(Get_PortfolioGrid_GrpSummary().Width - 40, Get_PortfolioGrid_GrpSummary().Height - 8);
        
        var arrayOfRiskScoreDisplayedValues_BeforeIntradayClick = GetRiskScoreDisplayedValues();
        var arrayOfRiskAllocationDisplayedValues_BeforeIntradayClick = GetRiskAllocationDisplayedValues(CR1958_RISK_ALLOCATION_LEVELS);
        
        Log.Message("Click in Intraday button.");
        Get_PortfolioBar_BtnIntraday().Click();
        Get_PortfolioBar_BtnIntraday().WaitProperty("wState", 0, 30000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 10000);
        var arrayOfRiskScoreDisplayedValues_AfterIntradayClick = GetRiskScoreDisplayedValues();
        var arrayOfRiskAllocationDisplayedValues_AfterIntradayClick = GetRiskAllocationDisplayedValues(CR1958_RISK_ALLOCATION_LEVELS);
        
        //Compare AfterIntradayClick values against BeforeIntradayClick values : Risk Score
        Log.Message("Check if the Risk Score graph values changed.")
        var haveRiskScoreDisplayedValuesChanged = false;
        for (var key in arrayOfRiskScoreDisplayedValues_AfterIntradayClick){
            Log.Message("The Risk Score graph " + key + " values : previous value = " + arrayOfRiskScoreDisplayedValues_BeforeIntradayClick[key] + ", new value = " + arrayOfRiskScoreDisplayedValues_AfterIntradayClick[key]);
            if (arrayOfRiskScoreDisplayedValues_AfterIntradayClick[key] != arrayOfRiskScoreDisplayedValues_BeforeIntradayClick[key]){
                Log.Checkpoint("The Risk Score graph " + key + " values changed. Previous value = " + arrayOfRiskScoreDisplayedValues_BeforeIntradayClick[key] + ", new value = " + arrayOfRiskScoreDisplayedValues_AfterIntradayClick[key]);
                haveRiskScoreDisplayedValuesChanged = true;
                break;
            }
        }
        
        if (haveRiskScoreDisplayedValuesChanged === false)
            Log.Error("The Risk Score graph values did not change.");
        
        //Compare AfterIntradayClick values against BeforeIntradayClick values : Risk Allocation
        Log.Message("Check if the Risk Allocation graph values changed.")
        var haveRiskAllocationDisplayedValuesChanged = false;
        for (var key in arrayOfRiskAllocationDisplayedValues_AfterIntradayClick){
            Log.Message("The Risk Allocation graph " + key + " values : previous value = " + arrayOfRiskAllocationDisplayedValues_BeforeIntradayClick[key] + ", new value = " + arrayOfRiskAllocationDisplayedValues_AfterIntradayClick[key]);
            if (arrayOfRiskAllocationDisplayedValues_AfterIntradayClick[key] != arrayOfRiskAllocationDisplayedValues_BeforeIntradayClick[key]){
                Log.Checkpoint("The Risk Allocation graph " + key + " values changed. Previous value = " + arrayOfRiskAllocationDisplayedValues_BeforeIntradayClick[key] + ", new value = " + arrayOfRiskAllocationDisplayedValues_AfterIntradayClick[key]);
                haveRiskAllocationDisplayedValuesChanged = true;
                break;
            }
        }
        
        if (haveRiskAllocationDisplayedValuesChanged === false)
            Log.Error("The Risk Allocation graph values did not change.");
        
        
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        //Deleted Added Orders
        if (formerOrdersLastID != null)
            Execute_SQLQuery("delete from B_GDO_ORDER where GDODER_ID > " + formerOrdersLastID, vServerRQS);
        
        //Restore prefs
        UpdateFirmArrayOfPrefs(vServerRQS, firm_code, arrayOfPrefsPreviousValues, arrayOfPrefsValues);
        
        //Terminate Croesus process
        Terminate_CroesusProcess();
    }
}



function GetRiskScoreDisplayedValues()
{
    var arrayOfRiskScoreDisplayedValues = [];
    
    arrayOfRiskScoreDisplayedValues["ActualPercent"] = null;
    var actualPercentValueObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_LblActualPercent();
    if (actualPercentValueObject.Exists && actualPercentValueObject.IsVisible && Trim(VarToStr(actualPercentValueObject.WPFControlText)) != "")
        arrayOfRiskScoreDisplayedValues["ActualPercent"] = Trim(VarToStr(actualPercentValueObject.WPFControlText));
    
    arrayOfRiskScoreDisplayedValues["ObjectivePercent"] = null;
    var objectivePercentValueObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskScore_LblObjectivePercent();
    if (objectivePercentValueObject.Exists && objectivePercentValueObject.IsVisible && Trim(VarToStr(objectivePercentValueObject.WPFControlText)) != "")
        arrayOfRiskScoreDisplayedValues["ObjectivePercent"] = Trim(VarToStr(objectivePercentValueObject.WPFControlText));
        
    return arrayOfRiskScoreDisplayedValues;
}



function GetRiskAllocationDisplayedValues(arrayOfRiskAllocationLevels)
{
    var arrayOfRiskAllocationDisplayedValues = [];
    
    for (var i in arrayOfRiskAllocationLevels){
        var riskAllocationLevel = arrayOfRiskAllocationLevels[i];
        arrayOfRiskAllocationDisplayedValues[riskAllocationLevel] = null;
        var displayed_levelPercentValueObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskAllocationLevel);
        if (displayed_levelPercentValueObject.Exists && displayed_levelPercentValueObject.IsVisible && Trim(VarToStr(displayed_levelPercentValueObject.WPFControlText)) != "")
            arrayOfRiskAllocationDisplayedValues[riskAllocationLevel] = Trim(VarToStr(displayed_levelPercentValueObject.WPFControlText));
    }
    
    return arrayOfRiskAllocationDisplayedValues;
}
        
        

function CreateStocksOrder(accountNumber, securityDescription, securityQuantity, buyOrSell)
{    
    //Get Previous OrderID
    var arrayOfFormerOrderIDs = GetAccountNumberOrdersIDs(accountNumber);

    //Selected the  account add an ordre sell or bay
    if (!SelectAccounts(accountNumber)){
        Log.Error("Unable to select Account Number '" + accountNumber + "'. The " + buyOrSell + " Order is not added.");
        return 0;
    }
    
    if (aqString.ToUpper(buyOrSell) == "BUY")
        Get_Toolbar_BtnCreateABuyOrder().Click();
    else if (aqString.ToUpper(buyOrSell) == "SELL")
        Get_Toolbar_BtnCreateASellOrder().Click();
    
    Get_WinFinancialInstrumentSelector_RdoStocks().Click();
    Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled", true, 10000);
    Get_WinFinancialInstrumentSelector_BtnOK().Click();
    
    Get_WinStocksOrderDetail_TxtQuantity().Clear();
    Get_WinStocksOrderDetail_TxtQuantity().Keys(securityQuantity);
    
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(",[BS]" + securityDescription + "[Tab]");
    SetAutoTimeOut(3000);
    if (Get_SubMenus().Exists)
        Get_SubMenus().FindChild(["Uid", "Value"], ["Description", securityDescription], 10).DblClick();
    RestoreAutoTimeOut();
    
    Get_WinOrderDetail_BtnSave().Click();
    
    //Get New OrderID
    var arrayOfUpdatedOrderIDs = GetAccountNumberOrdersIDs(accountNumber);
    var accountNewOrdersCount = arrayOfUpdatedOrderIDs.length - arrayOfFormerOrderIDs.length;
    return accountNewOrdersCount;     
    
    function GetAccountNumberOrdersIDs(accountNo)
    {
        var arrayOfOrderIds = [];
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, 30000);
        //Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, 1], 10).Click();
        var accumulatorCount = Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).Items.Count;
        for (var j = 0; j < accumulatorCount; j++){
            var currentAccumulatorItem = Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).Items.Item(j);    
            if (VarToStr(currentAccumulatorItem.DataItem.AccountNumber) == accountNo)
                arrayOfOrderIds.push(VarToStr(currentAccumulatorItem.DataItem.OrderId))
        }
        return arrayOfOrderIds
    }

}
        