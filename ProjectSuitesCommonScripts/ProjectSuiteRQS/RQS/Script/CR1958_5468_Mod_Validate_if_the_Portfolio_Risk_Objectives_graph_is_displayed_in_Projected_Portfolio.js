//USEUNIT CR1958_Helper




/**
    Description : Validate if the Portfolio Risk Objectives graph is displayed in Projected Portfolio and 
                  Validate if the targets must also be weighted according to the risk allocation table.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5468
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5468_Mod_Validate_if_the_Portfolio_Risk_Objectives_graph_is_displayed_in_Projected_Portfolio()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5468", "CR1958_5468_Mod_Validate_if_the_Portfolio_Risk_Objectives_graph_is_displayed_in_Projected_Portfolio()");
    Log.Message("Bug JIRA CROES-11473 : On doit avoir le même comportement pour le graphique 'objectifs de risque' pour un client juste avec des objectifs et un modèle avec juste des targets (dans le sommaire modèles et  portefeuilles) donc il faut l'ajuster les deux cas.");
    Log.Message("Bug JIRA CROES-11419 : Le calculs pour la  valeur de marché courante (%) pour un modèle avec des sous modèles est erroné sur les deux graphes de RQS");
    Log.Message("Bug JIRA CROES-11411 : Une différence entre les deux  Graphes (Objectifs de risque et cote de risque ) dans le module  Modèle et portefeuille pour un modèle avec  des sous modèle quis  a un solde = 0");
    Log.Message("Bug JIRA CROES-11351 : L'application crash si la  PREF_ENABLE_RISK_SCORE_GRAPH est disactivée");
    Log.Message("Bug JIRA CROES-11501 : Les objectifs de risque ne devraient pas être affichés sur les graphes quand une position d'un modèle n'a pas de cote de risque");
    
    try {
        
        //Model name, Securities infos, Clients numbers
        var modelNumber = null;
        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5468_ModelName", language + client);
        var security1_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5468_Security1_Symbol", language + client);
        var security1_TargetMVAndMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5468_Security1_TargetMVAndMV", language + client);
        var security2_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5468_Security2_Symbol", language + client);
        var security2_TargetMVAndMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5468_Security2_TargetMVAndMV", language + client);
        var security3_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5468_Security3_Symbol", language + client);
        var security3_TargetMVAndMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5468_Security3_TargetMVAndMV", language + client);
        var arrayOfClientsNumbers = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5468_ClientsNumbers", language + client).split("|");
        
        var expectedRiskObjectivesGraphTitle = (client == "CIBC")? CR1958_GRAPH_TITLE_RISKOBJECTIVES: CR1958_GRAPH_TITLE_RISKALLOCATION;
        var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5468_CheckTrianglesDisplayInGraph", language + client));
        
        //Needed columns names
        var columnName_MarketValuePercent = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "ColumnName_MarketValuePercent", language + client);
        var columnName_TargetValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "ColumnName_TargetValue", language + client);
        
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
        
        //Go to the Models module and create the model
        CleanupModelsByName(modelName, vServerRQS);
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        Create_Model(modelName);
        modelNumber = Get_ModelNo(modelName);
        
        //Drag the model to the Portfolio and add Positions
        Drag(Get_ModelsGrid().Find("Value", modelName, 10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
        AddPositionBySecuritySymbol(security1_Symbol, security1_TargetMVAndMV, security1_TargetMVAndMV);
        AddPositionBySecuritySymbol(security2_Symbol, security2_TargetMVAndMV, security2_TargetMVAndMV);
        AddPositionBySecuritySymbol(security3_Symbol, security3_TargetMVAndMV, security3_TargetMVAndMV);
        SaveReinitializeSavePortfolio();
        
        //Go to Models module, assign Clients to the model, and Perform a Rebalancing till the step 4
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        for (var i in arrayOfClientsNumbers)
            AssociateClientWithModel(modelName, arrayOfClientsNumbers[i]);
        
        RebalanceTillProjectedPortfolio();
        CheckRiskObjectivesGraphDisplayInProjectedPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
       
        
        //1. VALIDATIONS IN THE PROJECTED PORTFOLIO
        
        //Get the currently Selected Client Number
        var selectedClientNumber = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator()
                                   .FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)
                                   .FindChild(["ClrClassName", "IsActive"], ["DataRecordPresenter", true], 10)
                                   .FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "Id"], 10)
                                   .WPFControlText;
                
        Log.Message("VALIDATIONS IN PROJECTED PORTFOLIO.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        for (var j in arrayOfClientsNumbers){
            //Select a Client
            if (arrayOfClientsNumbers[j] != selectedClientNumber){
                Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator()
                                       .FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)
                                       .FindChild(["ClrClassName", "Uid", "WPFControlText"], ["CellValuePresenter", "Id", arrayOfClientsNumbers[j]], 10).Click();
                selectedClientNumber = arrayOfClientsNumbers[j];
            }
            
            Log.AppendFolder("Validation for Client '" + selectedClientNumber + "' in Projected Portfolio.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
            
            //Retrieve information from the datagrid
            var projectedPortfolio_ArrayOfArrayOfColumnsData = GetColumnsDataFromDataGrid([columnName_MarketValuePercent], Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio());
            var projectedPortfolio_ArrayOfArrayOfColumnsData_GroupedByRating = GroupColumnsDataByRiskRating(projectedPortfolio_ArrayOfArrayOfColumnsData);
            var projectedPortfolioMarketValuesGroupByRating = projectedPortfolio_ArrayOfArrayOfColumnsData_GroupedByRating[columnName_MarketValuePercent];
            
            //Perform validation for each rating level
            var projectedPortfolio_RiskAllocationGraphInfos = [];
            for (var k in CR1958_RISK_ALLOCATION_LEVELS){
                try {
                    var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[k];
                    
                    var projectedPortfolio_RiskAllocationLevelPercentsObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskAllocationLevel);
                    projectedPortfolio_RiskAllocationGraphInfos[riskAllocationLevel] = {};
                    projectedPortfolio_RiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel = GetRectangleDisplayedPercentLabel(projectedPortfolio_RiskAllocationLevelPercentsObject.WPFControlText);
                    projectedPortfolio_RiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel = GetTriangleDisplayedPercentLabel(projectedPortfolio_RiskAllocationLevelPercentsObject.WPFControlText);
                    
                    //1.1 : Validate the Target Market Value (Relative position of Triangle) in the Projected Portfolio
                    Log.Message("1.1 : Validate the Target Market Value (Relative position of Triangle) in the Projected Portfolio for selected client : " + selectedClientNumber);
                    var expected_ProjectedPortfolioTargetMarketValue = GetTargetPercentValueFromDataBase(selectedClientNumber, CR1958_RISK_ALLOCATION_CLIENT_PROFILE_CODES[riskAllocationLevel]);
                    var expected_ProjectedPortfolioTargetMarketLabel = GetRiskRatingExpectedPercentageLabel(expected_ProjectedPortfolioTargetMarketValue);
                    Log.Message("Check if Risk allocation level " + riskAllocationLevel + "' Target Market Value percentage label is : " + expected_ProjectedPortfolioTargetMarketLabel);
                    CheckEqualsForFormattedNumberWithSuffix(projectedPortfolio_RiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel, expected_ProjectedPortfolioTargetMarketLabel, "Risk allocation level " + riskAllocationLevel + "' Target Market Value percentage label", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
                    
                    //1.2 : Validate the Current Market Value (Relative length of bar) in the Projected Portfolio
                    Log.Message("1.2 : Validate the Current Market Value (Relative length of bar) in the Projected Portfolio");
                    var expected_ProjectedPortfolioCurrentMarketValue = CalculateAllocationLevelPercent_ModelToPortfolio_PositiveBalance(projectedPortfolioMarketValuesGroupByRating, CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel]);
                    var expected_ProjectedPortfolioCurrentMarketLabel = GetRiskRatingExpectedPercentageLabel(expected_ProjectedPortfolioCurrentMarketValue);
                    Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Current Market Value percentage label is : " + expected_ProjectedPortfolioCurrentMarketLabel);
                    CheckEqualsForFormattedNumberWithSuffix(projectedPortfolio_RiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel, expected_ProjectedPortfolioCurrentMarketLabel, "Risk allocation level '" + riskAllocationLevel + "' Current Market Value percentage label", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
                }
                catch (projectedPortfolioException){
                    Log.Error("Exception : " + projectedPortfolioException.message, VarToStr(projectedPortfolioException.stack));
                    projectedPortfolioException = null;
                }
            }
            Log.PopLogFolder();
        }
        
        //2. VALIDATIONS IN THE PORTFOLIO
        
        //Drag the model to Portfolio
        Get_ModulesBar_BtnModels().HoverMouse();
        SearchModelByName(modelName);
        Drag(Get_ModelsGrid().Find("Value", modelName, 10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_PortfolioGrid_GrpSummary().set_IsExpanded(true);
        Get_PortfolioGrid_GrpSummary().Click(Get_PortfolioGrid_GrpSummary().Width - 40, Get_PortfolioGrid_GrpSummary().Height - 8);
        CheckRiskObjectivesGraphDisplayInPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
        
        //Retrieve information from the datagrid
        var portfolio_ArrayOfArrayOfColumnsData = GetColumnsDataFromDataGrid([columnName_MarketValuePercent, columnName_TargetValue], Get_Portfolio_AssetClassesGrid());
        var portfolio_ArrayOfArrayOfColumnsData_GroupedByRating = GroupColumnsDataByRiskRating(portfolio_ArrayOfArrayOfColumnsData);
        var portfolioMarketValuesGroupByRating = portfolio_ArrayOfArrayOfColumnsData_GroupedByRating[columnName_MarketValuePercent];
        var portfolioTargetValuesGroupByRating = portfolio_ArrayOfArrayOfColumnsData_GroupedByRating[columnName_TargetValue];
        
        //Perform validation for each rating level
        Log.Message("VALIDATIONS IN PORTFOLIO.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        var portfolio_RiskAllocationGraphInfos = [];
        for (var k in CR1958_RISK_ALLOCATION_LEVELS){
            try {
                var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[k];
                                
                var portfolio_RiskAllocationLevelPercentsObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskAllocationLevel);
                portfolio_RiskAllocationGraphInfos[riskAllocationLevel] = {};
                portfolio_RiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel = GetRectangleDisplayedPercentLabel(portfolio_RiskAllocationLevelPercentsObject.WPFControlText);
                portfolio_RiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel = GetTriangleDisplayedPercentLabel(portfolio_RiskAllocationLevelPercentsObject.WPFControlText);
                
                //Validate Target Market Value in the Portfolio
                Log.Message("2.1 : Validate the Target Market Value (Relative position of Triangle) in the Portfolio");
                var expected_PortfolioTargetMarketValue = CalculateAllocationLevelPercent_ModelToPortfolio_PositiveBalance(portfolioTargetValuesGroupByRating, CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel]);
                var expected_PortfolioTargetMarketLabel = GetRiskRatingExpectedPercentageLabel(expected_PortfolioTargetMarketValue);
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Target Market Value percentage is : " + expected_PortfolioTargetMarketLabel);
                CheckEqualsForFormattedNumberWithSuffix(portfolio_RiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel, expected_PortfolioTargetMarketLabel, "Risk allocation level '" + riskAllocationLevel + "' Target Market Value percentage", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
                
                //2.2 : Validate the Current Market Value (Relative length of bar) in the Portfolio
                Log.Message("2.2 : Validate the Current Market Value (Relative length of bar) in the Portfolio");
                var expected_PortfolioCurrentMarketValue = CalculateAllocationLevelPercent_ModelToPortfolio_PositiveBalance(portfolioMarketValuesGroupByRating, CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel]);
                var expected_PortfolioCurrentMarketLabel = GetRiskRatingExpectedPercentageLabel(expected_PortfolioCurrentMarketValue);
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Current Market Value percentage is : " + expected_PortfolioCurrentMarketLabel);
                CheckEqualsForFormattedNumberWithSuffix(portfolio_RiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel, expected_PortfolioCurrentMarketLabel, "Risk allocation level '" + riskAllocationLevel + "' Current Market Value percentage", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
            }
            catch (portfolioException){
                Log.Error("Exception : " + portfolioException.message, VarToStr(portfolioException.stack));
                portfolioException = null;
            }
        }
        
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
        
        //Restore prefs
        UpdateFirmArrayOfPrefs(vServerRQS, firm_code, arrayOfPrefsPreviousValues, arrayOfPrefsValues);
        
        //Terminate Croesus process
        Terminate_CroesusProcess();
    }
}
