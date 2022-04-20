//USEUNIT CR1958_Helper




/**
    Description : Validate the tooltips displayed on the Portfolio Risk Objectives graph in Models Module.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5528
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5528_Mod_Validate_the_tooltips_displayed_on_the_Portfolio_Risk_Objectives_graph_in_Models_Module()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5528", "CR1958_5528_Mod_Validate_the_tooltips_displayed_on_the_Portfolio_Risk_Objectives_graph_in_Models_Module()");
    Log.Message("Bug JIRA CROES-11473 : On doit avoir le même comportement pour le graphique 'objectifs de risque' pour un client juste avec des objectifs et un modèle avec juste des targets (dans le sommaire modèles et  portefeuilles) donc il faut l'ajuster les deux cas.");
    Log.Message("Bug JIRA CROES-11419 : Le calculs pour la  valeur de marché courante (%) pour un modèle avec des sous modèles est erroné sur les deux graphes de RQS");
    Log.Message("Bug JIRA CROES-11411 : Une différence entre les deux  Graphes (Objectifs de risque et cote de risque ) dans le module  Modèle et portefeuille pour un modèle avec  des sous modèle quis  a un solde = 0");
    Log.Message("Bug JIRA CROES-11351 : L'application crash si la  PREF_ENABLE_RISK_SCORE_GRAPH est disactivée");
    Log.Message("Bug JIRA CROES-11501 : Les objectifs de risque ne devraient pas être affichés sur les graphes quand une position d'un modèle n'a pas de cote de risque");
    
    var modelNumber = null, clientNumber = null, clientPreviousIACode = null;
    
    try {
        //Levels to test in Projected Portfolio, for Tooltips (step 4)
        var arrayOfRiskAllocationLevelsToTestInProjectedPortfolio = CR1958_RISK_ALLOCATION_LEVELS;
        
        //Levels to test in Portfolio, for Tooltips (step 5)
        var arrayOfRiskAllocationLevelsToTestInPortfolio = CR1958_RISK_ALLOCATION_LEVELS;
        
        var expectedRiskObjectivesGraphTitle = (client == "CIBC")? CR1958_GRAPH_TITLE_RISKOBJECTIVES: CR1958_GRAPH_TITLE_RISKALLOCATION;
        var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5528_CheckTrianglesDisplayInGraph", language + client));
        
        //Needed columns names
        var columnName_MarketValuePercent = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "ColumnName_MarketValuePercent", language + client);
        var columnName_MarketValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "ColumnName_MarketValue", language + client);
        var columnName_TargetValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "ColumnName_TargetValue", language + client);
        
        //Expected labels
        var expected_LabelRiskAllocationLevel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_LabelRiskAllocationLevel", language + client);
        var expected_LabelCurrentMarketValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_LabelCurrentMarketValuePercent", language + client);
        var expected_LabelTargetMarketValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_LabelTargetMarketValuePercent", language + client);
        var expected_LabelClientRiskObjectivePercent = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_LabelClientRiskObjectivePercent", language + client);
        var expected_LabelPercentOfWholePortfolioSuffix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_LabelSuffixOfWholePortfolio", language + client);
        var expected_LabelPercentOfWholeModelSuffix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_LabelSuffixOfWholeModel", language + client);
        
        //expected Graph Tooltip DataGrid labels
        var expected_Graph_Tooltip_ColumnHeader_SecuritiesRiskRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_ColumnHeader_SecuritiesRiskRating", language + client);
        var expected_Graph_Tooltip_ColumnHeader_Allocation = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_ColumnHeader_Allocation", language + client);
        var expected_Graph_Tooltip_ColumnHeader_CurrentMarketValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_ColumnHeader_CurrentMarketValue", language + client);
        var expected_Graph_Tooltip_Column_SecuritiesRiskRating_TotalRowLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_Column_SecuritiesRiskRating_TotalRowLabel", language + client);
        var expected_Graph_Tooltip_Column_SecuritiesRiskRating_LabelAppendChar = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_Column_SecuritiesRiskRating_LabelAppendChar", language + client);
        
        //Model name, Securities infos, Accounts numbers
        var clientIACode = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5528_ClientIACode", language + client);
        var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5528_ClientNumber", language + client);
        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5528_ModelName", language + client);
        var security1_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5528_Security1_Symbol", language + client);
        var security1_TargetMVAndMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5528_Security1_TargetMVAndMV", language + client);
        var security2_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5528_Security2_Symbol", language + client);
        var security2_TargetMVAndMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5528_Security2_TargetMVAndMV", language + client);
        var security3_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5528_Security3_Symbol", language + client);
        var security3_TargetMVAndMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5528_Security3_TargetMVAndMV", language + client);
        
        //User DARWIC
        var userDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var pswdDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
        //Change the client IACode in order to make it available for the user
        clientPreviousIACode = Execute_SQLQuery_GetField("select NO_REP from B_CLIENT where NO_CLIENT = '" + clientNumber + "'", vServerRQS, "NO_REP");
        UpdateIACodeForClient(clientNumber, clientIACode, vServerRQS)
        
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
        
        Log.Message("1. Create Model '" + modelName + "', drag the model to the Portfolio and add Positions, Save + Reinitialize + Save Portfolio.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        
        //Go to the Models module and create the model
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        Create_Model(modelName, null, clientIACode);
        modelNumber = Get_ModelNo(modelName);
        
        //Drag the model to the Portfolio and add Positions
        Drag(Get_ModelsGrid().Find("Value", modelName, 10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
        AddPositionBySecuritySymbol(security1_Symbol, security1_TargetMVAndMV, security1_TargetMVAndMV);
        AddPositionBySecuritySymbol(security2_Symbol, security2_TargetMVAndMV, security2_TargetMVAndMV);
        AddPositionBySecuritySymbol(security3_Symbol, security3_TargetMVAndMV, security3_TargetMVAndMV);
        SaveReinitializeSavePortfolio();
                
        //Go to Models module, assign Client to the model and Perform a Rebalancing till the step 4
        Log.Message("2. Go to Models module and assign Client '" + clientNumber + "' to the model '" + modelName + "'.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        AssociateClientWithModel(modelName, clientNumber);
        RebalanceTillProjectedPortfolio();
        CheckRiskObjectivesGraphDisplayInProjectedPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
        
        //Check if the currently Selected Client Number is actually the one assigned to the model
        var selectedClientNumber = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator()
                                   .FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)
                                   .FindChild(["ClrClassName", "IsActive"], ["DataRecordPresenter", true], 10)
                                   .FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "Id"], 10)
                                   .WPFControlText;
        CompareProperty(selectedClientNumber, cmpEqual, clientNumber, true, lmError);
        
        
        //3. VALIDATE RELATIVE LENGTH OF BAR AND RELATIVE POSITION OF TRIANGLE IN PROJECTED PORTFOLIO GRAPH AND IN PORTFOLIO GRAPH
        Log.AppendFolder("3. VALIDATE RELATIVE LENGTH OF BAR AND RELATIVE POSITION OF TRIANGLE IN PROJECTED PORTFOLIO GRAPH AND IN PORTFOLIO GRAPH.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        
        Log.Message("Validate values percent labels in the Projected Portfolio", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        
        //Expected values in Projected Portfolio
        var projectedPortfolio_ArrayOfArrayOfColumnsData = GetColumnsDataFromDataGrid([columnName_MarketValue, columnName_MarketValuePercent], Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio());
        var projectedPortfolio_ArrayOfArrayOfColumnsData_GroupedByRating = GroupColumnsDataByRiskRating(projectedPortfolio_ArrayOfArrayOfColumnsData);
        var projectedPortfolio_MarketValues_GroupedBySecurityRating = projectedPortfolio_ArrayOfArrayOfColumnsData_GroupedByRating[columnName_MarketValue];
        var projectedPortfolio_MarketValuesPercent_GroupedBySecurityRating = projectedPortfolio_ArrayOfArrayOfColumnsData_GroupedByRating[columnName_MarketValuePercent];
        var projectedPortfolioPicture = Get_WinRebalance().Parent.Picture();
        
        var expected_ProjectedPortfolio_ArrayOfCurrentMarketValuesPercents = [];
        var expected_ProjectedPortfolio_ArrayOfTargetMarketValuesPercents = [];
        for (var key in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[key];
            expected_ProjectedPortfolio_ArrayOfCurrentMarketValuesPercents[riskAllocationLevel] = CalculateAllocationLevelPercent_ModelToPortfolio_NegativeBalance(projectedPortfolio_MarketValuesPercent_GroupedBySecurityRating, CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel]);
            expected_ProjectedPortfolio_ArrayOfTargetMarketValuesPercents[riskAllocationLevel] = GetTargetPercentValueFromDataBase(clientNumber, CR1958_RISK_ALLOCATION_CLIENT_PROFILE_CODES[riskAllocationLevel]);
        }
        
        //Displayed values versus Expected values in Projected Portfolio
        var projectedPortfolio_arrayOfDisplayedRiskAllocationGraphInfos = [];
        for (var k in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[k];
            Log.Message("Validations for Risk allocation level '" + riskAllocationLevel + "'.");
            var projectedPortfolio_RiskAllocationLevelPercentsObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskAllocationLevel);
            projectedPortfolio_arrayOfDisplayedRiskAllocationGraphInfos[riskAllocationLevel] = {};
            projectedPortfolio_arrayOfDisplayedRiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel = GetRectangleDisplayedPercentLabel(projectedPortfolio_RiskAllocationLevelPercentsObject.WPFControlText);
            projectedPortfolio_arrayOfDisplayedRiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel = GetTriangleDisplayedPercentLabel(projectedPortfolio_RiskAllocationLevelPercentsObject.WPFControlText);
            
            var displayed_projectedPortfolio_currentMarketPercentLabel = projectedPortfolio_arrayOfDisplayedRiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel;
            var expected_projectedPortfolio_currentMarketPercentLabel = GetRiskRatingExpectedPercentageLabel(expected_ProjectedPortfolio_ArrayOfCurrentMarketValuesPercents[riskAllocationLevel], CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS);
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Current Market Percent Label is : " + expected_projectedPortfolio_currentMarketPercentLabel);
            CheckEqualsForFormattedNumberWithSuffix(displayed_projectedPortfolio_currentMarketPercentLabel, expected_projectedPortfolio_currentMarketPercentLabel, "Risk allocation level '" + riskAllocationLevel + "' Current Market Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
            
            var displayed_projectedPortfolio_targetMarketPercentLabel = projectedPortfolio_arrayOfDisplayedRiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel;
            var expected_projectedPortfolio_targetMarketPercentLabel = GetRiskRatingExpectedPercentageLabel(expected_ProjectedPortfolio_ArrayOfTargetMarketValuesPercents[riskAllocationLevel], CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS);
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Target Market Percent Label is : " + expected_projectedPortfolio_targetMarketPercentLabel);
            CheckEqualsForFormattedNumberWithSuffix(displayed_projectedPortfolio_targetMarketPercentLabel, expected_projectedPortfolio_targetMarketPercentLabel, "Risk allocation level '" + riskAllocationLevel + "' Target Market Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
        }
        
        //Drag the model to Portfolio
        Log.Message("Drag the model to Portfolio");
        Get_ModulesBar_BtnModels().HoverMouse();
        SearchModelByName(modelName);
        Drag(Get_ModelsGrid().Find("Value", modelName, 10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_PortfolioGrid_GrpSummary().set_IsExpanded(true);
        Get_PortfolioGrid_GrpSummary().Click(Get_PortfolioGrid_GrpSummary().Width - 40, Get_PortfolioGrid_GrpSummary().Height - 8);
        CheckRiskObjectivesGraphDisplayInPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
        
        //Expected CurrentMarketValues, TargetMarketValues, ClientRiskObjective
        var portfolio_ArrayOfArrayOfColumnsData = GetColumnsDataFromDataGrid([columnName_MarketValuePercent, columnName_TargetValue], Get_Portfolio_AssetClassesGrid());
        var portfolio_ArrayOfArrayOfColumnsData_GroupedByRating = GroupColumnsDataByRiskRating(portfolio_ArrayOfArrayOfColumnsData);
        var portfolio_MarketValuesPercents_GroupedBySecurityRating = portfolio_ArrayOfArrayOfColumnsData_GroupedByRating[columnName_MarketValuePercent];
        var portfolio_TargetValuesPercents_GroupedBySecurityRating = portfolio_ArrayOfArrayOfColumnsData_GroupedByRating[columnName_TargetValue];
        
        var expected_Portfolio_ArrayOfCurrentMarketValuesPercents = [];
        var expected_Portfolio_ArrayOfTargetMarketValuesPercents = [];
        for (var key in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[key];
            expected_Portfolio_ArrayOfCurrentMarketValuesPercents[riskAllocationLevel] = CalculateAllocationLevelPercent_ModelToPortfolio_NegativeBalance(portfolio_MarketValuesPercents_GroupedBySecurityRating, CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel]);
            expected_Portfolio_ArrayOfTargetMarketValuesPercents[riskAllocationLevel] = CalculateAllocationLevelPercent_ModelToPortfolio_NegativeBalance(portfolio_TargetValuesPercents_GroupedBySecurityRating, CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel]);
        }
        
        //Validate labels in the portfolio
        Log.Message("Validate values percent labels in the Portfolio", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        var portfolio_arrayOfDisplayedRiskAllocationGraphInfos = [];
        for (var k in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[k];
            Log.Message("Validations for Risk allocation level '" + riskAllocationLevel + "'.");
            var portfolio_RiskAllocationLevelPercentsObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskAllocationLevel);
            portfolio_arrayOfDisplayedRiskAllocationGraphInfos[riskAllocationLevel] = {};
            portfolio_arrayOfDisplayedRiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel = GetRectangleDisplayedPercentLabel(portfolio_RiskAllocationLevelPercentsObject.WPFControlText);
            portfolio_arrayOfDisplayedRiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel = GetTriangleDisplayedPercentLabel(portfolio_RiskAllocationLevelPercentsObject.WPFControlText);
            
            var displayed_portfolio_currentMarketPercentLabel = portfolio_arrayOfDisplayedRiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel;
            var expected_portfolio_currentMarketPercentLabel = GetRiskRatingExpectedPercentageLabel(expected_Portfolio_ArrayOfCurrentMarketValuesPercents[riskAllocationLevel], CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS);
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Current Market Percent Label is : " + expected_portfolio_currentMarketPercentLabel);
            CheckEqualsForFormattedNumberWithSuffix(displayed_portfolio_currentMarketPercentLabel, expected_portfolio_currentMarketPercentLabel, "Risk allocation level '" + riskAllocationLevel + "' Current Market Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
            
            var displayed_portfolio_targetMarketPercentLabel = portfolio_arrayOfDisplayedRiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel;
            var expected_portfolio_targetMarketPercentLabel = GetRiskRatingExpectedPercentageLabel(expected_Portfolio_ArrayOfTargetMarketValuesPercents[riskAllocationLevel], CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS);
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Target Market Percent Label is : " + expected_portfolio_targetMarketPercentLabel);
            CheckEqualsForFormattedNumberWithSuffix(displayed_portfolio_targetMarketPercentLabel, expected_portfolio_targetMarketPercentLabel, "Risk allocation level '" + riskAllocationLevel + "' Target Market Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
        }
        
        Log.Message("Validate that Current Market values in the Portfolio are the same as in the Projected Portfolio.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        for (var k in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[k];
            Log.Message("Validation for Risk allocation level '" + riskAllocationLevel + "'.");
            var displayed_portfolio_currentMarketPercentLabel = portfolio_arrayOfDisplayedRiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel;
            var displayed_projectedPortfolio_currentMarketPercentLabel = projectedPortfolio_arrayOfDisplayedRiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel;
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Current Market value in Portfolio compared to the Projected Portfolio is : " + displayed_projectedPortfolio_currentMarketPercentLabel);
            if (!CheckEqualsForFormattedNumberWithSuffix(displayed_portfolio_currentMarketPercentLabel, displayed_projectedPortfolio_currentMarketPercentLabel, "Risk allocation level '" + riskAllocationLevel + "' Current Market value in Portfolio compared to the Projected Portfolio", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL))
                Log.Picture(projectedPortfolioPicture, "For the picture of the related Projected Portfolio, please refer to the Picture tab at the bottom of the log panel.", "", pmNormal, CR1958_LOG_ATTRIBUTES_BOLD);
        }
        Log.PopLogFolder();
        
        
        //4. VALIDATE THE TOOLTIPS INFORMATION IN PROJECTED PORTFOLIO GRAPH.
        Log.AppendFolder("4. VALIDATE THE TOOLTIPS INFORMATION IN PROJECTED PORTFOLIO GRAPH.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        Get_WinRebalance_BtnClose().HoverMouse();
        
        //Expected tooltip information for each level in projected Portfolio
        var expected_arrayOfProjectedPortfolioTooltipCurrentMarketValueLabel = [];
        var expected_arrayOfProjectedPortfolioTooltipClientRiskObjectiveValueLabel = [];
        var expected_arrayOfProjectedPortfolioTooltipDataGridContent = [];
        for (var key in arrayOfRiskAllocationLevelsToTestInProjectedPortfolio){
            var riskAllocationLevel = arrayOfRiskAllocationLevelsToTestInProjectedPortfolio[key];
            
            //Tooltip Current Market Value percent expected label
            expected_arrayOfProjectedPortfolioTooltipCurrentMarketValueLabel[riskAllocationLevel] = GetTooltipDisplayedNumber(expected_ProjectedPortfolio_ArrayOfCurrentMarketValuesPercents[riskAllocationLevel]) + expected_LabelPercentOfWholePortfolioSuffix;
            
            //Tooltip Client Risk Objective Value percent expected label
            expected_arrayOfProjectedPortfolioTooltipClientRiskObjectiveValueLabel[riskAllocationLevel] = GetTooltipDisplayedNumber(expected_ProjectedPortfolio_ArrayOfTargetMarketValuesPercents[riskAllocationLevel]) + expected_LabelPercentOfWholePortfolioSuffix;
            
           //Tooltip data grid expected content
            var expected_arrayOfGridContentHeaders = [expected_Graph_Tooltip_ColumnHeader_SecuritiesRiskRating,
                                                      expected_Graph_Tooltip_ColumnHeader_Allocation,
                                                      expected_Graph_Tooltip_ColumnHeader_CurrentMarketValue];
            var expected_arrayOfArrayOfProjectedPortfolioTooltipDataGridContent = [expected_arrayOfGridContentHeaders];
            var totalValueForRiskAllocationLevel = 0;
            for (var securityRiskRatingIndex in CR1958_SECURITY_RISK_RATINGS){
                var securityRiskRating = CR1958_SECURITY_RISK_RATINGS[securityRiskRatingIndex];
                var securityRiskRatingWeight = CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel][securityRiskRating];
                if (securityRiskRatingWeight == 0 || securityRiskRatingWeight == undefined)
                    continue;
                
                var riskRatingCurrentMarketValue = (projectedPortfolio_MarketValues_GroupedBySecurityRating[securityRiskRating]) * securityRiskRatingWeight/100;
                expected_arrayOfArrayOfProjectedPortfolioTooltipDataGridContent.push([securityRiskRating + expected_Graph_Tooltip_Column_SecuritiesRiskRating_LabelAppendChar, securityRiskRatingWeight + CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL, GetTooltipDisplayedNumber(riskRatingCurrentMarketValue, 2)]);
                totalValueForRiskAllocationLevel += riskRatingCurrentMarketValue;
            }
            
            /*
            //Old
            if (expected_arrayOfArrayOfProjectedPortfolioTooltipDataGridContent.length > 2)
                expected_arrayOfArrayOfProjectedPortfolioTooltipDataGridContent.push([expected_Graph_Tooltip_Column_SecuritiesRiskRating_TotalRowLabel, "", GetTooltipDisplayedNumber(totalValueForRiskAllocationLevel, CR1958_GRAPH_MARKET_VALUES_NB_DECIMALS)]);
            */
            
            //https://jira.croesus.com/browse/RISK-1269 ; https://jira.croesus.com/browse/DOCUM-1059
            var totalValueDisplayForRiskAllocationLevel = GetTooltipDisplayedNumber(totalValueForRiskAllocationLevel, CR1958_GRAPH_MARKET_VALUES_NB_DECIMALS);
            for (var rowIndex = 1;  rowIndex < expected_arrayOfArrayOfProjectedPortfolioTooltipDataGridContent.length; rowIndex++){
                if (totalValueDisplayForRiskAllocationLevel == expected_arrayOfArrayOfProjectedPortfolioTooltipDataGridContent[rowIndex][2])
                    break;
                if (rowIndex == expected_arrayOfArrayOfProjectedPortfolioTooltipDataGridContent.length - 1)
                    expected_arrayOfArrayOfProjectedPortfolioTooltipDataGridContent.push([expected_Graph_Tooltip_Column_SecuritiesRiskRating_TotalRowLabel, "", totalValueDisplayForRiskAllocationLevel]);
            }

            expected_arrayOfProjectedPortfolioTooltipDataGridContent[riskAllocationLevel] = expected_arrayOfArrayOfProjectedPortfolioTooltipDataGridContent;            
        }
        
        //Validate tooltip information for each level in projected Portfolio
        SetAutoTimeOut(1000);
        for (var key in arrayOfRiskAllocationLevelsToTestInProjectedPortfolio){
            try {
                var riskAllocationLevel = arrayOfRiskAllocationLevelsToTestInProjectedPortfolio[key];
                Log.AppendFolder("Risk allocation level '" +  riskAllocationLevel + "' tooltip information validation in Projected Portfolio graph", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
                
                var graphObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(riskAllocationLevel);
                if (graphObject.Width < 2){
                    Log.Warning("Risk allocation level '" + riskAllocationLevel + "' Rectangle component Width < 2, the HoverMouse action will be done on the graph rating label instead.", "", pmHigher, null, Sys.Desktop.Picture());
                    graphObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblLabelForLevel(riskAllocationLevel);
                }
                
                //Check if the popup window is transient
                Log.Message("Check if the popup window for Risk allocation level '" + riskAllocationLevel + "' is transient.");
                var transientCheckTimeout = 15000;
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], transientCheckTimeout))
                        Log.Checkpoint("The popup windows for Risk allocation level '" + riskAllocationLevel + "' appeared and then disappeared by timeout ; it is transient.");
                    else
                        Log.Error("The popup windows for Risk allocation level '" + riskAllocationLevel + "' appeared but did not disappear by timeout (~" + transientCheckTimeout + " ms) ; may be it is not transient.");
                }
                
                //Validate Tooltip title label
                Log.Message("Validate Tooltip title label for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblRiskAllocationLevel();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' tooltip title label is : " + expected_LabelRiskAllocationLevel);
                    CheckEquals(componentObject.WPFControlText, expected_LabelRiskAllocationLevel, "Risk allocation level '" +  riskAllocationLevel + "' tooltip title label", desktopPicture);
                }
                
                //Validate Tooltip title level
                Log.Message("Validate Tooltip title level for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtRiskAllocationLevel();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' tooltip title level is : " + riskAllocationLevel);
                    CheckEquals(componentObject.WPFControlText, riskAllocationLevel, "Risk allocation level '" + riskAllocationLevel + "' tooltip title level", desktopPicture);
                }
                
                //Validate the tooltip data grid content
                Log.Message("Validate Tooltip data grid content for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var desktopPicture = Sys.Desktop.Picture();
                    var arrayOfArrayOfGridContent = GetRiskAllocationTooltipDataGridContent(graphObject, "PROJECTED PORTFOLIO");
                    Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' tooltip datagrid content (| char is the column separator) is : " + GetStringOfArray2D(expected_arrayOfProjectedPortfolioTooltipDataGridContent[riskAllocationLevel]), GetStringOfArray2D(expected_arrayOfProjectedPortfolioTooltipDataGridContent[riskAllocationLevel]));
                    CheckEqualsForTooltipDataGridContent(arrayOfArrayOfGridContent, expected_arrayOfProjectedPortfolioTooltipDataGridContent[riskAllocationLevel], "Risk allocation level '" + riskAllocationLevel + "' tooltip datagrid content (| char is the column separator)", CR1958_GRAPH_TOOLTIP_MARKET_VALUES_TOLERANCE, desktopPicture);
                }
                
                //Validate Tooltip Label for Current Market Value
                Log.Message("Validate Tooltip Current Market Value Label for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblCurrentMarketValuePercent();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Current Market Value is : " + expected_LabelCurrentMarketValue);
                    CheckEquals(componentObject.WPFControlText, expected_LabelCurrentMarketValue, "Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Current Market Value", desktopPicture);
                }
                
                //Validate Tooltip Current Market Value Percent Label
                Log.Message("Validate Tooltip Current Market Value Percent for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtCurrentMarketValuePercent();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Current Market Value Percent Label is : " + expected_arrayOfProjectedPortfolioTooltipCurrentMarketValueLabel[riskAllocationLevel]);
                    CheckEqualsForFormattedNumberWithSuffix(componentObject.WPFControlText, expected_arrayOfProjectedPortfolioTooltipCurrentMarketValueLabel[riskAllocationLevel], "Risk allocation level '" +  riskAllocationLevel + "' tooltip Current Market Value Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, expected_LabelPercentOfWholePortfolioSuffix, desktopPicture);
                }
                
                //Validate Tooltip Label for Client Risk Objective
                Log.Message("Validate Tooltip Client Risk Objective Label for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblClientRiskObjectiveOrTargetMarketValue();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Client Risk Objective is : " + expected_LabelClientRiskObjectivePercent);
                    CheckEquals(componentObject.WPFControlText, expected_LabelClientRiskObjectivePercent, "Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Client Risk Objective", desktopPicture);
                }
                
                //Validate Tooltip Client Risk Objective Percent Label
                Log.Message("Validate Tooltip Client Risk Objective Percent for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtClientRiskObjectiveOrTargetMarketValue();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Client Risk Objective Percent Label : " + expected_arrayOfProjectedPortfolioTooltipClientRiskObjectiveValueLabel[riskAllocationLevel]);
                    CheckEqualsForFormattedNumberWithSuffix(componentObject.WPFControlText, expected_arrayOfProjectedPortfolioTooltipClientRiskObjectiveValueLabel[riskAllocationLevel], "Risk allocation level '" +  riskAllocationLevel + "' tooltip Client Risk Objective Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, expected_LabelPercentOfWholePortfolioSuffix, desktopPicture);
                }
                
                //Validate Tooltip Rectangle color
                Log.Message("Validate Tooltip Rectangle color for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var rectangleObject = Get_SubMenus_Tooltip_RectangleForRiskAllocation();
                    var desktopPicture = Sys.Desktop.Picture();
                    if (!rectangleObject.Exists){
                        Log.Error("Risk allocation level '" + riskAllocationLevel + "' tooltip Rectangle component not found.");
                    }
                    else {
                        var actualColor = rectangleObject.Fill.Color;
                        var actualColorHexValue = aqString.Format("%02x%02x%02x", actualColor.R, actualColor.G, actualColor.B);
                        var expectedColor = CR1958_RISK_ALLOCATION_LEVELS_COLORS[riskAllocationLevel];
                        if (!CheckEquals(actualColorHexValue, expectedColor.Hex, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color #", desktopPicture)){
                            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component is : " + expectedColor.R);
                            CheckEquals(actualColor.R, expectedColor.R, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component", desktopPicture);
                            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component is : " + expectedColor.G);
                            CheckEquals(actualColor.G, expectedColor.G, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component", desktopPicture);
                            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component is : " + expectedColor.B);
                            CheckEquals(actualColor.B, expectedColor.B, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component", desktopPicture);
                        }
                    }
                }
            }
            catch (tooltipCheckException){
                Log.Error("Exception : " + tooltipCheckException.message, VarToStr(tooltipCheckException.stack));
                tooltipCheckException = null;
            }
            finally {
                Log.PopLogFolder();
            }
         
        }
        RestoreAutoTimeOut();
        Log.PopLogFolder();
        
        
        //5. VALIDATE THE TOOLTIPS INFORMATION IN PORTFOLIO GRAPH.
        Log.AppendFolder("5. VALIDATE THE TOOLTIPS INFORMATION IN PORTFOLIO GRAPH.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        Get_ModulesBar_BtnPortfolio().HoverMouse();
        Get_ModulesBar_BtnPortfolio().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_PortfolioGrid_GrpSummary().set_IsExpanded(true);
        Get_PortfolioGrid_GrpSummary().Click(Get_PortfolioGrid_GrpSummary().Width - 40, Get_PortfolioGrid_GrpSummary().Height - 8);
        
        //Expected tooltip information for each level in Portfolio
        var expected_arrayOfPortfolioTooltipCurrentMarketValueLabel = [];
        var expected_arrayOfPortfolioTooltipTargetMarketValueLabel = [];
        var expected_arrayOfPortfolioTooltipDataGridContent = [];
        for (var key in arrayOfRiskAllocationLevelsToTestInPortfolio){
            var riskAllocationLevel = arrayOfRiskAllocationLevelsToTestInPortfolio[key];
            
            //Tooltip Current Market Value percent expected label
            expected_arrayOfPortfolioTooltipCurrentMarketValueLabel[riskAllocationLevel] = GetTooltipDisplayedNumber(expected_Portfolio_ArrayOfCurrentMarketValuesPercents[riskAllocationLevel]) + expected_LabelPercentOfWholeModelSuffix;
            
            //Tooltip Target Market Value percent expected label
            expected_arrayOfPortfolioTooltipTargetMarketValueLabel[riskAllocationLevel] = GetTooltipDisplayedNumber(expected_Portfolio_ArrayOfTargetMarketValuesPercents[riskAllocationLevel]) + expected_LabelPercentOfWholeModelSuffix;
            
           //Tooltip data grid expected content
            var expected_arrayOfGridContentHeaders = [expected_Graph_Tooltip_ColumnHeader_SecuritiesRiskRating,
                                                      expected_Graph_Tooltip_ColumnHeader_Allocation,
                                                      expected_Graph_Tooltip_ColumnHeader_CurrentMarketValue];
            var expected_arrayOfArrayOfPortfolioTooltipDataGridContent = [expected_arrayOfGridContentHeaders];
            var totalValueForRiskAllocationLevel = 0;
            for (var securityRiskRatingIndex in CR1958_SECURITY_RISK_RATINGS){
                var securityRiskRating = CR1958_SECURITY_RISK_RATINGS[securityRiskRatingIndex];
                var securityRiskRatingWeight = CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel][securityRiskRating];
                if (securityRiskRatingWeight == 0 || securityRiskRatingWeight == undefined)
                    continue;
                
                var riskRatingCurrentMarketValue = CalculateCurrentMarketValuePercentForSecurityRating_Portfolio(portfolio_MarketValuesPercents_GroupedBySecurityRating, portfolio_MarketValuesPercents_GroupedBySecurityRating[securityRiskRating] * securityRiskRatingWeight/100);
                expected_arrayOfArrayOfPortfolioTooltipDataGridContent.push([securityRiskRating + expected_Graph_Tooltip_Column_SecuritiesRiskRating_LabelAppendChar, securityRiskRatingWeight + CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL, GetRiskRatingExpectedPercentageLabel(riskRatingCurrentMarketValue, CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS)]);
                totalValueForRiskAllocationLevel += riskRatingCurrentMarketValue;
            }
            
            /*
            //Old
            if (expected_arrayOfArrayOfPortfolioTooltipDataGridContent.length > 2)
                expected_arrayOfArrayOfPortfolioTooltipDataGridContent.push([expected_Graph_Tooltip_Column_SecuritiesRiskRating_TotalRowLabel, "", GetRiskRatingExpectedPercentageLabel(totalValueForRiskAllocationLevel, CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS)]);
            */
            
            //https://jira.croesus.com/browse/RISK-1269 ; https://jira.croesus.com/browse/DOCUM-1059
            var totalValueDisplayForRiskAllocationLevel = GetRiskRatingExpectedPercentageLabel(totalValueForRiskAllocationLevel, CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS);
            for (var rowIndex = 1;  rowIndex < expected_arrayOfArrayOfPortfolioTooltipDataGridContent.length; rowIndex++){
                if (totalValueDisplayForRiskAllocationLevel == expected_arrayOfArrayOfPortfolioTooltipDataGridContent[rowIndex][2])
                    break;
                if (rowIndex == expected_arrayOfArrayOfPortfolioTooltipDataGridContent.length - 1)
                    expected_arrayOfArrayOfPortfolioTooltipDataGridContent.push([expected_Graph_Tooltip_Column_SecuritiesRiskRating_TotalRowLabel, "", totalValueDisplayForRiskAllocationLevel]);
            }
            
            expected_arrayOfPortfolioTooltipDataGridContent[riskAllocationLevel] = expected_arrayOfArrayOfPortfolioTooltipDataGridContent;            
        }
        
        //Validate tooltip information for each level in Portfolio
        SetAutoTimeOut(1000);
        for (var key in arrayOfRiskAllocationLevelsToTestInPortfolio){
            try {
                var riskAllocationLevel = arrayOfRiskAllocationLevelsToTestInPortfolio[key];
                Log.AppendFolder("Risk allocation level '" +  riskAllocationLevel + "' tooltip information validation in Portfolio graph", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
                
                var graphObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(riskAllocationLevel);
                if (graphObject.Width < 2){
                    Log.Warning("Risk allocation level '" +  riskAllocationLevel + "' Rectangle component Width < 2, the HoverMouse action will be done on the graph rating label instead.", "", pmHigher, null, Sys.Desktop.Picture());
                    graphObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblLabelForLevel(riskAllocationLevel);
                }
                
                //Check if the popup window is transient
                Log.Message("Check if the popup window for Risk allocation level '" +  riskAllocationLevel + "' is transient.");
                var transientCheckTimeout = 15000;
                if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], transientCheckTimeout))
                        Log.Checkpoint("The popup windows for Risk allocation level '" +  riskAllocationLevel + "' appeared and then disappeared by timeout ; it is transient.");
                    else
                        Log.Error("The popup windows for Risk allocation level '" +  riskAllocationLevel + "' appeared but did not disappear by timeout (~" + transientCheckTimeout + " ms) ; may be it is not transient.");
                }
                                
                //Validate Tooltip title label
                Log.Message("Validate Tooltip title label for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblRiskAllocationLevel();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip title label is " + expected_LabelRiskAllocationLevel);
                    CheckEquals(componentObject.WPFControlText, expected_LabelRiskAllocationLevel, "Risk allocation level '" +  riskAllocationLevel + "' tooltip title label", desktopPicture);
                }
                
                //Validate Tooltip title level
                Log.Message("Validate Tooltip title level for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtRiskAllocationLevel();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip title level is : " + riskAllocationLevel);
                    CheckEquals(componentObject.WPFControlText, riskAllocationLevel, "Risk allocation level '" +  riskAllocationLevel + "' tooltip title level", desktopPicture);
                }
                
                //Validate the tooltip data grid content
                Log.Message("Validate Tooltip data grid content for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                    var desktopPicture = Sys.Desktop.Picture();
                    var arrayOfArrayOfGridContent = GetRiskAllocationTooltipDataGridContent(graphObject, "PORTFOLIO");
                    Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' tooltip datagrid content (| char is the column separator) is : " + GetStringOfArray2D(expected_arrayOfPortfolioTooltipDataGridContent[riskAllocationLevel]), GetStringOfArray2D(expected_arrayOfPortfolioTooltipDataGridContent[riskAllocationLevel]));
                    CheckEqualsForTooltipDataGridContent(arrayOfArrayOfGridContent, expected_arrayOfPortfolioTooltipDataGridContent[riskAllocationLevel], "Risk allocation level '" + riskAllocationLevel + "' tooltip datagrid content (| char is the column separator)", CR1958_GRAPH_TOOLTIP_MARKET_VALUES_TOLERANCE, desktopPicture);
                }
                
                //Validate Tooltip Label for Current Market Value
                Log.Message("Validate Tooltip Current Market Value Label for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblCurrentMarketValuePercent();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Current Market Value is : " + expected_LabelCurrentMarketValue);
                    CheckEquals(componentObject.WPFControlText, expected_LabelCurrentMarketValue, "Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Current Market Value", desktopPicture);
                }
                
                //Validate Tooltip Current Market Value Percent Label
                Log.Message("Validate Tooltip Current Market Value Percent for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtCurrentMarketValuePercent();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' tooltip Current Market Value Percent Label is : " + expected_arrayOfPortfolioTooltipCurrentMarketValueLabel[riskAllocationLevel]);
                    CheckEqualsForFormattedNumberWithSuffix(componentObject.WPFControlText, expected_arrayOfPortfolioTooltipCurrentMarketValueLabel[riskAllocationLevel], "Risk allocation level '" + riskAllocationLevel + "' tooltip Current Market Value Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, expected_LabelPercentOfWholeModelSuffix, desktopPicture);
                }
                
                //Validate Tooltip Label for Target Market Value
                Log.Message("Validate Tooltip Target Market Value Label for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblClientRiskObjectiveOrTargetMarketValue();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Target Market Value is : " + expected_LabelTargetMarketValue);
                    CheckEquals(componentObject.WPFControlText, expected_LabelTargetMarketValue, "Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Target Market Value", desktopPicture);
                }
                
                //Validate Tooltip Target Market Value Percent Label
                Log.Message("Validate Tooltip Target Market Value Percent for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtClientRiskObjectiveOrTargetMarketValue();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Target Market Value Percent Label is : " + expected_arrayOfPortfolioTooltipTargetMarketValueLabel[riskAllocationLevel]);
                    CheckEqualsForFormattedNumberWithSuffix(componentObject.WPFControlText, expected_arrayOfPortfolioTooltipTargetMarketValueLabel[riskAllocationLevel], "Risk allocation level '" +  riskAllocationLevel + "' tooltip Target Market Value Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, expected_LabelPercentOfWholeModelSuffix, desktopPicture);
                }
                
                //Validate Tooltip Rectangle color
                Log.Message("Validate Tooltip Rectangle color for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                    var rectangleObject = Get_SubMenus_Tooltip_RectangleForRiskAllocation();
                    var desktopPicture = Sys.Desktop.Picture();
                    if (!rectangleObject.Exists){
                        Log.Error("Risk allocation level '" + riskAllocationLevel + "' tooltip Rectangle component not found.");
                    }
                    else {
                        var actualColor = rectangleObject.Fill.Color;
                        var actualColorHexValue = aqString.Format("%02x%02x%02x", actualColor.R, actualColor.G, actualColor.B);
                        var expectedColor = CR1958_RISK_ALLOCATION_LEVELS_COLORS[riskAllocationLevel];
                        Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color # is : " + expectedColor.Hex);
                        if (!CheckEquals(actualColorHexValue, expectedColor.Hex, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color #", desktopPicture)){
                            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component is : " + expectedColor.R);
                            CheckEquals(actualColor.R, expectedColor.R, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component", desktopPicture);
                            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component is : " + expectedColor.G);
                            CheckEquals(actualColor.G, expectedColor.G, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component", desktopPicture);
                            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component is : " + expectedColor.B);
                            CheckEquals(actualColor.B, expectedColor.B, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component", desktopPicture);
                        }
                    }
                }
            }
            catch (tooltipCheckException){
                Log.Error("Exception : " + tooltipCheckException.message, VarToStr(tooltipCheckException.stack));
                tooltipCheckException = null;
            }
            finally {
                Log.PopLogFolder();
            }
         
        }
        RestoreAutoTimeOut();
        Log.PopLogFolder();
        
        //Cancel the Rebalancing and Close Croesus
        Get_WinRebalance_BtnClose().HoverMouse();
        Get_WinRebalance_BtnClose().Click();
        Get_DlgConfirmation_BtnContinue().Click();
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        //Cleanup Model
        CleanupModel(modelNumber, vServerRQS);
        
        //Restore Client IA Code
        UpdateIACodeForClient(clientNumber, clientPreviousIACode, vServerRQS);
        
        //Restore prefs
        UpdateFirmArrayOfPrefs(vServerRQS, firm_code, arrayOfPrefsPreviousValues, arrayOfPrefsValues);
        
        //Terminate Croesus process
        Terminate_CroesusProcess();
    }
}
