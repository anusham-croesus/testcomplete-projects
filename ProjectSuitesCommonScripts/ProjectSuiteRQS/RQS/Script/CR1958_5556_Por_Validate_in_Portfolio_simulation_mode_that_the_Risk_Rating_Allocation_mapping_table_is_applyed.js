//USEUNIT CR1958_Helper




/**
    Description : Validate in Portfolio simulation mode that the Risk Rating Allocation mapping table is applyed 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5556
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5556_Por_Validate_in_Portfolio_simulation_mode_that_the_Risk_Rating_Allocation_mapping_table_is_applyed()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5556", "CR1958_5556_Por_Validate_in_Portfolio_simulation_mode_that_the_Risk_Rating_Allocation_mapping_table_is_applyed()");
    Log.Message("Bug JIRA CROES-11292 : On ne doit pas avoir les  triangles  sur le graphe de répartition de risque si on maille plusieurs clients ou comptes qui ont des objectifs de risque différents.");
    Log.Message("Bug JIRA CROES-11351 : L'application crash si la  PREF_ENABLE_RISK_SCORE_GRAPH est disactivée");
    Log.Message("Bug JIRA CROES-11340 : RQS - Sur le graphe de répartition de risque, les tooltips sont incomplets");
    Log.Message("Bug JIRA CROES-11340 : RQS - Sur le graphe de répartition de risque, les tooltips sont incomplets");
    
    try {
        //Client Number
        var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5556_ClientNumber", language + client);
        var expectedClientPortfolioName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5556_PortFolio_DisplayedName", language + client);
        var expectedClientPortfolioWhatIfName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5556_PortFolioWhatIf_DisplayedName", language + client);
        var security1_Description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5556_Security1_Description", language + client);
        var security1_WhatIf_Quantity = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5556_Security1_WhatIf_Quantity", language + client);
        var security2_Description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5556_Security2_Description", language + client);
        var security2_WhatIf_Quantity = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5556_Security2_WhatIf_Quantity", language + client);
        
        var expectedRiskObjectivesGraphTitle = (client == "CIBC")? CR1958_GRAPH_TITLE_RISKOBJECTIVES: CR1958_GRAPH_TITLE_RISKALLOCATION;
        var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5556_CheckTrianglesDisplayInGraph", language + client));
        
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
        
        Log.Message("Validate the results in the Portfolio Risk Objectives Graph.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        Get_PortfolioGrid_GrpSummary().set_IsExpanded(true);
        Get_PortfolioGrid_GrpSummary().Click(Get_PortfolioGrid_GrpSummary().Width - 40, Get_PortfolioGrid_GrpSummary().Height - 8);
        CheckRiskObjectivesGraphDisplayInPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
        
        //Expected values
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
        
        //Validate KYC risk levels percent labels in the portfolio
        Log.Message("Validate KYC risk levels percent in the portfolio.");
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
        
        Log.Message("2. Clic in What-If button, change the quantity and Validate the results of the Portfolio Risk Objectives applying the mapping table (and formula).", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        Get_PortfolioBar_BtnWhatIf().Click();
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 100000);
        aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_TxtPortfolioName(), "WPFControlText", cmpEqual, expectedClientPortfolioWhatIfName);
        Get_PortfolioGrid_GrpSummary().set_IsExpanded(true);
        Get_PortfolioGrid_GrpSummary().Click(Get_PortfolioGrid_GrpSummary().Width - 40, Get_PortfolioGrid_GrpSummary().Height - 8);
        
        //Change security 1 position quantity
        Search_PositionByDescription(security1_Description);
        Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "Uid", "Value"], ["CellValuePresenter", "SecurityDescription", security1_Description], 10).Click();
        Get_PortfolioBar_BtnInfo().Click();
        var security1_Quantity = Get_WinPositionInfo_GrpPositionInformation_TxtQuantity().Value;
        Get_WinPositionInfo_GrpPositionInformation_TxtQuantity().Clear();
        Get_WinPositionInfo_GrpPositionInformation_TxtQuantity().Keys(security1_WhatIf_Quantity + "[Tab]");
        var security1_WhatIf_Validate_Quantity = Get_WinPositionInfo_GrpPositionInformation_TxtQuantity().Value;
        CompareProperty(security1_WhatIf_Validate_Quantity, cmpEqual, ConvertStrToNumberFormat(security1_WhatIf_Quantity), true, lmError);
        Get_WinPositionInfo_BtnOK().Click();
        
        //Change security 2 position quantity
        Search_PositionByDescription(security2_Description);
        Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "Uid", "Value"], ["CellValuePresenter", "SecurityDescription", security2_Description], 10).Click();
        Get_PortfolioBar_BtnInfo().Click();
        var security2_Quantity = Get_WinPositionInfo_GrpPositionInformation_TxtQuantity().Value;
        Get_WinPositionInfo_GrpPositionInformation_TxtQuantity().Clear();
        Get_WinPositionInfo_GrpPositionInformation_TxtQuantity().Keys(security2_WhatIf_Quantity + "[Tab]");
        var security2_WhatIf_Validate_Quantity = Get_WinPositionInfo_GrpPositionInformation_TxtQuantity().Value;
        CompareProperty(security2_WhatIf_Validate_Quantity, cmpEqual, ConvertStrToNumberFormat(security2_WhatIf_Quantity), true, lmError);
        Get_WinPositionInfo_BtnOK().Click();
        
        if (security1_Quantity == security1_WhatIf_Validate_Quantity && security2_Quantity == security2_WhatIf_Validate_Quantity)
            Log.Warning("All the portfolio simulation quantities are the same as the portfolio quantities.", security1_Description + " : " + security1_WhatIf_Validate_Quantity + "\n" + security2_Description + " : " + security2_WhatIf_Validate_Quantity, pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        
        Log.Message("Validate the results in the simulated Portfolio Risk Objectives Graph.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        
        //Expected values
        var arrayOfArrayOfColumnsData_WhatIf = GetColumnsDataFromDataGrid([columnName_MarketValue], Get_Portfolio_AssetClassesGrid());
        var arrayOfArrayOfMarketValuesGroupedByRating_WhatIf = GroupColumnsDataByRiskRating(arrayOfArrayOfColumnsData_WhatIf);
        var portfolioWhatIf_MarketValuesGroupByRating = arrayOfArrayOfMarketValuesGroupedByRating_WhatIf[columnName_MarketValue];
        
        var portfolioWhatIf_expected_arrayOfCurrentMarketValuesPercents = [];
        var portfolioWhatIf_expected_arrayOfClientRiskObjectivePercents = [];
        for (var key in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[key];
            portfolioWhatIf_expected_arrayOfCurrentMarketValuesPercents[riskAllocationLevel] = CalculateAllocationLevelPercent_ClientToPortfolio(portfolioWhatIf_MarketValuesGroupByRating, CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel]);
            portfolioWhatIf_expected_arrayOfClientRiskObjectivePercents[riskAllocationLevel] = GetTargetPercentValueFromDataBase(clientNumber, CR1958_RISK_ALLOCATION_CLIENT_PROFILE_CODES[riskAllocationLevel]);
        }
        
        //Validate Risk levels percent labels in the Portfolio simulation mode
        var actual_portfolioWhatIf_arrayOfRiskAllocationGraphInfos = [];
        for (var k in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[k];
            Log.Message("Validations for Risk allocation level '" + riskAllocationLevel + "'.");
            
            var portfolioWhatIf_RiskAllocationLevelPercentsObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskAllocationLevel);
            actual_portfolioWhatIf_arrayOfRiskAllocationGraphInfos[riskAllocationLevel] = {};
            actual_portfolioWhatIf_arrayOfRiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel = GetRectangleDisplayedPercentLabel(portfolioWhatIf_RiskAllocationLevelPercentsObject.WPFControlText);
            actual_portfolioWhatIf_arrayOfRiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel = GetTriangleDisplayedPercentLabel(portfolioWhatIf_RiskAllocationLevelPercentsObject.WPFControlText);
            
            var actual_portfolioWhatIf_currentMarketPercentLabel = actual_portfolioWhatIf_arrayOfRiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel;
            var expected_portfolioWhatIf_currentMarketPercentLabel = GetRiskRatingExpectedPercentageLabel(portfolioWhatIf_expected_arrayOfCurrentMarketValuesPercents[riskAllocationLevel]);
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Current Market Percent Label is : " + expected_portfolioWhatIf_currentMarketPercentLabel);
            CheckEqualsForFormattedNumberWithSuffix(actual_portfolioWhatIf_currentMarketPercentLabel, expected_portfolioWhatIf_currentMarketPercentLabel, "Risk allocation level '" + riskAllocationLevel + "' Current Market Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
            
            var actual_portfolioWhatIf_targetMarketPercentLabel = actual_portfolioWhatIf_arrayOfRiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel;
            var expected_portfolioWhatIf_clientRiskObjectivePercentLabel= GetRiskRatingExpectedPercentageLabel(portfolioWhatIf_expected_arrayOfClientRiskObjectivePercents[riskAllocationLevel]);
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Client Risk Objective Percent Label is : " + expected_portfolioWhatIf_clientRiskObjectivePercentLabel);
            CheckEqualsForFormattedNumberWithSuffix(actual_portfolioWhatIf_targetMarketPercentLabel, expected_portfolioWhatIf_clientRiskObjectivePercentLabel, "Risk allocation level '" + riskAllocationLevel + "' Client Risk Objective Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
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
