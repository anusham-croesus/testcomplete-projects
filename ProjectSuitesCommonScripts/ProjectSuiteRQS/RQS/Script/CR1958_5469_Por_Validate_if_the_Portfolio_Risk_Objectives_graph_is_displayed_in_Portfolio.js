//USEUNIT CR1958_Helper




/**
    Description : Validate if the Portfolio Risk Objectives graph is displayed in Portfolio 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5469
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5469_Por_Validate_if_the_Portfolio_Risk_Objectives_graph_is_displayed_in_Portfolio()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5469", "CR1958_5469_Por_Validate_if_the_Portfolio_Risk_Objectives_graph_is_displayed_in_Portfolio()");
    Log.Message("Bug JIRA CROES-11292 : On ne doit pas avoir les  triangles  sur le graphe de répartition de risque si on maille plusieurs clients ou comptes qui ont des objectifs de risque différents.");
    Log.Message("Bug JIRA CROES-11351 : L'application crash si la  PREF_ENABLE_RISK_SCORE_GRAPH est disactivée");
    Log.Message("Bug JIRA CROES-11340 : RQS - Sur le graphe de répartition de risque, les tooltips sont incomplets");
    
    try {
        //Client Number
        var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5469_ClientNumber", language + client);
        var expectedClientPortfolioName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5469_PortFolio_DisplayedName", language + client);
        
        var expectedRiskObjectivesGraphTitle = (client == "CIBC")? CR1958_GRAPH_TITLE_RISKOBJECTIVES: CR1958_GRAPH_TITLE_RISKALLOCATION;
        var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5469_CheckTrianglesDisplayInGraph", language + client));
        
        //Needed columns names
        var columnName_MarketValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "ColumnName_MarketValue", language + client);
        
        //User DARWIC
        var userDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var pswdDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
        //Prealables
        var firm_code = GetUserFirmCode(userDARWIC, vServerRQS);
        var arrayOfPrefsValues = CR1958_GetArrayOfPrefsValues();
        
        var arrayOfPrefsPreviousValues = new Array();
        for (var prefKey in arrayOfPrefsValues)
            arrayOfPrefsPreviousValues[prefKey] = GetFirmPrefValue(vServerRQS, prefKey, firm_code);
        
        UpdateFirmArrayOfPrefs(vServerRQS, firm_code, arrayOfPrefsValues, arrayOfPrefsPreviousValues);
        SetRiskAllocationLevelsWeightsAndClientProfileNames(CR1958_SECURITY_RISK_RATINGS_WEIGHTS, CR1958_RISK_ALLOCATION_CLIENT_PROFILE_NAMES, true);
        
        //Login
        Login(vServerRQS, userDARWIC, pswdDARWIC, language);
        
        //Go to the Client module and Drag the Client to the Portfolio
        Log.Message("1. Open the client module and then drag and drop the client '" + clientNumber + "' to Portfolio module.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
        Search_Client(clientNumber);
        var clientNumberCell = Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "Uid", "Value"], ["CellValuePresenter", "ClientNumber", clientNumber], 10);
        if (!clientNumberCell.Exists){
            Log.Error("Client Number '" + clientNumber + "' not found.");
            return CloseCroesus();
        }
        
        Drag(clientNumberCell, Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
        aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_TxtPortfolioName(), "WPFControlText", cmpEqual, expectedClientPortfolioName);
        CheckIfRiskAllocationGraphIsDisplayedAtTheBottomRightSideOfTheScreen();
        CheckRiskObjectivesGraphDisplayInPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
        
        Log.Message("2. Validate the results in the Graph of risk Allocation.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        //Expected Risk Objectives and Current Market Values
        var arrayOfArrayOfColumnsData = GetColumnsDataFromDataGrid([columnName_MarketValue], Get_Portfolio_AssetClassesGrid());
        var arrayOfArrayOfMarketValuesGroupedByRating = GroupColumnsDataByRiskRating(arrayOfArrayOfColumnsData);
        var portfolioMarketValuesGroupByRating = arrayOfArrayOfMarketValuesGroupedByRating[columnName_MarketValue];
        
        var expected_arrayOfCurrentMarketValuesPercents = [];
        var expected_arrayOfClientRiskObjectivePercents = [];
        for (var key in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[key];
            expected_arrayOfCurrentMarketValuesPercents[riskAllocationLevel] = CalculateAllocationLevelPercent_ClientToPortfolio(portfolioMarketValuesGroupByRating, CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel]);
            expected_arrayOfClientRiskObjectivePercents[riskAllocationLevel] = GetTargetPercentValueFromDataBase(clientNumber, CR1958_RISK_ALLOCATION_CLIENT_PROFILE_CODES[riskAllocationLevel]);
        }
        
        //Validate Allocation levels percent labels in the portfolio
        Get_PortfolioGrid_GrpSummary().set_IsExpanded(true);
        Get_PortfolioGrid_GrpSummary().Click(Get_PortfolioGrid_GrpSummary().Width - 40, Get_PortfolioGrid_GrpSummary().Height - 8);
        var actual_portfolio_arrayOfRiskAllocationGraphInfos = [];
        for (var k in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[k];
            Log.Message("Validations for Risk allocation level '" + riskAllocationLevel + "'.");
            
            var portfolio_RiskAllocationLevelPercentsObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskAllocationLevel);
            actual_portfolio_arrayOfRiskAllocationGraphInfos[riskAllocationLevel] = {};
            actual_portfolio_arrayOfRiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel = GetRectangleDisplayedPercentLabel(portfolio_RiskAllocationLevelPercentsObject.WPFControlText);
            actual_portfolio_arrayOfRiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel = GetTriangleDisplayedPercentLabel(portfolio_RiskAllocationLevelPercentsObject.WPFControlText);
            
            var actual_portfolio_currentMarketPercentLabel = actual_portfolio_arrayOfRiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel;
            var expected_portfolio_currentMarketPercentLabel = GetRiskRatingExpectedPercentageLabel(expected_arrayOfCurrentMarketValuesPercents[riskAllocationLevel]);
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Current Market Percent Label is : " + expected_portfolio_currentMarketPercentLabel);
            CheckEqualsForFormattedNumberWithSuffix(actual_portfolio_currentMarketPercentLabel, expected_portfolio_currentMarketPercentLabel, "Risk allocation level '" + riskAllocationLevel + "' Current Market Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
            
            var actual_portfolio_targetMarketPercentLabel = actual_portfolio_arrayOfRiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel;
            var expected_portfolio_clientRiskObjectivePercentLabel= GetRiskRatingExpectedPercentageLabel(expected_arrayOfClientRiskObjectivePercents[riskAllocationLevel]);
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Client Risk Objective Percent Label is : " + expected_portfolio_clientRiskObjectivePercentLabel);
            CheckEqualsForFormattedNumberWithSuffix(actual_portfolio_targetMarketPercentLabel, expected_portfolio_clientRiskObjectivePercentLabel, "Risk allocation level '" + riskAllocationLevel + "' Client Risk Objective Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
        }
        
        //Close Croesus
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        //Restore prefs
        UpdateFirmArrayOfPrefs(vServerRQS, firm_code, arrayOfPrefsPreviousValues, arrayOfPrefsValues);
        
        //Terminate Croesus process
        Terminate_CroesusProcess();
    }
}

