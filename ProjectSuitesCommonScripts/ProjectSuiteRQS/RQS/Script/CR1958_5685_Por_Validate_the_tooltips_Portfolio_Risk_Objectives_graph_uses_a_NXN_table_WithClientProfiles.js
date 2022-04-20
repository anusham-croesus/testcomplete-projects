//USEUNIT CR1958_Helper


/**
    Description : Validate the tooltips Portfolio Risk Objectives graph in portfolio Module uses a NXN table
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5685
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5685_Por_Validate_the_tooltips_Portfolio_Risk_Objectives_graph_uses_a_NXN_table_WithClientProfiles()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5685", "CR1958_5685_Por_Validate_the_tooltips_Portfolio_Risk_Objectives_graph_uses_a_NXN_table_WithClientProfiles()");
    
    var isWithClientsProfiles = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5685_AreClientProfilesConfigured", language + client));
    if (isWithClientsProfiles === false)
        return Log.Warning("Les données du cas indiquent qu'il n'y a pas de Profils Client d'objectifs de risque. Les Profils Client d'objectifs de risque sont un requis pour ce script.");
    
    var expectedRiskObjectivesGraphTitle = CR1958_GRAPH_TITLE_RISKOBJECTIVES;
    var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5685_WithClientProfiles_CheckTrianglesDisplayInGraph", language + client));
    CR1958_5685_Por_Validate_the_tooltips_Portfolio_Risk_Objectives_graph_uses_a_NXN_table(true, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
}



function CR1958_5685_Por_Validate_the_tooltips_Portfolio_Risk_Objectives_graph_uses_a_NXN_table(isWithClientsProfiles, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay)
{
    Log.Message("Bug JIRA CROES-11473 : On doit avoir le même comportement pour le graphique 'objectifs de risque' pour un client juste avec des objectifs et un modèle avec juste des targets (dans le sommaire modèles et  portefeuilles) donc il faut l'ajuster les deux cas.");
    Log.Message("Bug JIRA CROES-11419 : Le calculs pour la  valeur de marché courante (%) pour un modèle avec des sous modèles est erroné sur les deux graphes de RQS");
    Log.Message("Bug JIRA CROES-11411 : Une différence entre les deux  Graphes (Objectifs de risque et cote de risque ) dans le module  Modèle et portefeuille pour un modèle avec  des sous modèle quis  a un solde = 0");
    Log.Message("Bug JIRA CROES-11351 : L'application crash si la  PREF_ENABLE_RISK_SCORE_GRAPH est disactivée");
    Log.Message("Bug JIRA CROES-11501 : Les objectifs de risque ne devraient pas être affichés sur les graphes quand une position d'un modèle n'a pas de cote de risque");
    
    if (isWithClientsProfiles == undefined || (isWithClientsProfiles !== true && isWithClientsProfiles !== false))
        return Log.Error("isWithClientsProfiles must be defined, should be True or False.");
    
    var arrayOfRiskAllocationLevelsToTest = CR1958_RISK_ALLOCATION_LEVELS;
    
    try {
        //Model name, IA Code
        var modelNumber = null;
        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5685_ModelName", language + client);
        var clientIACode = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5685_IACode", language + client);
        
        var security1_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5685_Security1_Symbol", language + client);
        var security1_TargetMVAndMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5685_Security1_TargetMVAndMV", language + client);
        var security2_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5685_Security2_Symbol", language + client);
        var security2_TargetMVAndMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5685_Security2_TargetMVAndMV", language + client);
        var security3_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5685_Security3_Symbol", language + client);
        var security3_TargetMVAndMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5685_Security3_TargetMVAndMV", language + client);
        var arrayOfClientsNumbers = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5685_ClientsNumbers", language + client).split("|");
        
        //Needed columns names
        var columnName_MarketValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "ColumnName_MarketValue", language + client);
        var columnName_MarketValuePercent = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "ColumnName_MarketValuePercent", language + client);
        
        //Expected labels
        var expected_LabelRiskAllocationLevel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_LabelRiskAllocationLevel_ForCanonicalTable", language + client);
        var expected_LabelCurrentMarketValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_LabelCurrentMarketValue", language + client);
        var expected_LabelCurrentMarketValuePercent = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_LabelCurrentMarketValuePercent", language + client);
        var expected_LabelPercentOfWholePortfolioSuffix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_LabelSuffixOfWholePortfolio", language + client);
        var expected_LabelClientRiskObjectivePercent = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_Graph_Tooltip_LabelClientRiskObjectivePercent", language + client);
        
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

        //Weights For Canonical table
        var arrayOfArrayOfSecurityRiskRatingsCanonicalWeights = [];
        for (var securityRiskRatingRow in CR1958_SECURITY_RISK_RATINGS_WEIGHTS){
            arrayOfArrayOfSecurityRiskRatingsCanonicalWeights[securityRiskRatingRow] = [];
            for (var riskAllocationLevelColumn in CR1958_SECURITY_RISK_RATINGS_WEIGHTS[securityRiskRatingRow])
                arrayOfArrayOfSecurityRiskRatingsCanonicalWeights[securityRiskRatingRow][riskAllocationLevelColumn] = CR1958_SECURITY_RISK_RATINGS_WEIGHTS[securityRiskRatingRow][riskAllocationLevelColumn];
        }
        
        var riskAllocationDefaultLevelColumn = null;
        for (var securityRiskRatingRow in arrayOfArrayOfSecurityRiskRatingsCanonicalWeights){
            for (var riskAllocationLevelColumn in arrayOfArrayOfSecurityRiskRatingsCanonicalWeights[securityRiskRatingRow]){
                if (riskAllocationDefaultLevelColumn === null && GetIndexOfItemInArray(CR1958_RISK_ALLOCATION_LEVELS, riskAllocationLevelColumn) != -1)
                    riskAllocationDefaultLevelColumn = riskAllocationLevelColumn;
                arrayOfArrayOfSecurityRiskRatingsCanonicalWeights[securityRiskRatingRow][riskAllocationLevelColumn] = (securityRiskRatingRow == riskAllocationLevelColumn || (riskAllocationLevelColumn == riskAllocationDefaultLevelColumn && GetIndexOfItemInArray(CR1958_RISK_ALLOCATION_LEVELS, securityRiskRatingRow) == -1))? 100: 0;
            }
        }
        
        if (isWithClientsProfiles === true){
            SetRiskAllocationLevelsWeightsAndClientProfileNames(arrayOfArrayOfSecurityRiskRatingsCanonicalWeights, CR1958_RISK_ALLOCATION_CLIENT_PROFILE_NAMES, false);
        }
        else {
            var arrayOfEmptyRiskAllocationClientProfileNames = [];
            for (var i in CR1958_RISK_ALLOCATION_LEVELS)
                arrayOfEmptyRiskAllocationClientProfileNames[CR1958_RISK_ALLOCATION_LEVELS[i]] = "";
            
            SetRiskAllocationLevelsWeightsAndClientProfileNames(arrayOfArrayOfSecurityRiskRatingsCanonicalWeights, arrayOfEmptyRiskAllocationClientProfileNames, false);
        }
        
        //User DARWIC
        var userDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var pswdDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
        
        //Login
        Login(vServerRQS, userDARWIC, pswdDARWIC, language);
        
        //Go to the Models module select a model and rebalance till step 4
        Log.Message("1. Select a model in the Models module and rebalance till step 4.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
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
        
        //Go to Models module, assign Clients to the model, and Perform a Rebalancing till the step 4
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        for (var i in arrayOfClientsNumbers)
            AssociateClientWithModel(modelName, arrayOfClientsNumbers[i]);
        RebalanceTillProjectedPortfolio();
        
        Log.Message("Check if portfolio risk objectives graph is displayed in summary section", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        if (!Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().Exists){
            Log.Error("The Risk objectives graph was not found.");
            CloseCroesus();
            return;
        }
        
        var pnlRQSChartsUid = VarToStr(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().Uid);
        var isPnlRQSChartsFoundInSummary = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", pnlRQSChartsUid, 10).Exists;
        var isPnlRQSChartsVisible = aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts(), "IsVisible", cmpEqual, true);
        if (isPnlRQSChartsVisible && isPnlRQSChartsFoundInSummary)
            Log.Checkpoint("The projected portfolio risk objectives graph is displayed in summary section.");
        else
            Log.Error("The projected portfolio risk objectives graph is not displayed in summary section.");
        
        //Global validation of the graph
        CheckRiskObjectivesGraphDisplayInProjectedPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
        
        Log.Message("2. Validate the Graph tooltips information.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        
        
        var arrayOfArrayOfColumnsData = GetColumnsDataFromDataGrid([columnName_MarketValue, columnName_MarketValuePercent], Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio());
        var arrayOfArrayOfMarketValuesGroupedByRating = GroupColumnsDataByRiskRating(arrayOfArrayOfColumnsData);
        var projectedPortfolioMarketValuesGroupedByRating = arrayOfArrayOfMarketValuesGroupedByRating[columnName_MarketValue];
        var projectedPortfolioMarketValuesPercentsGroupedByRating = arrayOfArrayOfMarketValuesGroupedByRating[columnName_MarketValuePercent];
        
        var expected_arrayOfCurrentMarketValues = [];
        var expected_arrayOfCurrentMarketValuesPercents = [];
        var expected_arrayOfTooltipCurrentMarketValueLabel = [];
        var expected_arrayOfTooltipCurrentMarketPercentValueLabel = [];
        var expected_arrayOfClientRiskObjectivePercents = [];
        var expected_arrayOfTooltipClientRiskObjectiveValueLabel = [];
        var expected_arrayOfTooltipDataGridContent = [];
        for (var key in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[key];
            
            //Tooltip Current Market Value expected label
            expected_arrayOfCurrentMarketValues[riskAllocationLevel] = projectedPortfolioMarketValuesGroupedByRating[riskAllocationLevel];
            expected_arrayOfTooltipCurrentMarketValueLabel[riskAllocationLevel] = GetTooltipDisplayedNumber(expected_arrayOfCurrentMarketValues[riskAllocationLevel], 2);
            
            //Tooltip Current Market Value percent expected label
            var arrayOfArrayOfRiskAllocationCanonicalWeights = GetTransposedArray2D(arrayOfArrayOfSecurityRiskRatingsCanonicalWeights)
            expected_arrayOfCurrentMarketValuesPercents[riskAllocationLevel] = CalculateAllocationLevelPercent_ModelToPortfolio_PositiveBalance(projectedPortfolioMarketValuesPercentsGroupedByRating, arrayOfArrayOfRiskAllocationCanonicalWeights[riskAllocationLevel]);
            expected_arrayOfTooltipCurrentMarketPercentValueLabel[riskAllocationLevel] = GetTooltipDisplayedNumber(expected_arrayOfCurrentMarketValuesPercents[riskAllocationLevel]) + expected_LabelPercentOfWholePortfolioSuffix;
            
            //Tooltip Client Risk Objective Value percent expected label
            if (isWithClientsProfiles === true){
                var selectedClientNumber = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator()
                                   .FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)
                                   .FindChild(["ClrClassName", "IsActive"], ["DataRecordPresenter", true], 10)
                                   .FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "Id"], 10)
                                   .WPFControlText;
                expected_arrayOfClientRiskObjectivePercents[riskAllocationLevel] = GetTargetPercentValueFromDataBase(selectedClientNumber, CR1958_RISK_ALLOCATION_CLIENT_PROFILE_CODES[riskAllocationLevel]);
                expected_arrayOfTooltipClientRiskObjectiveValueLabel[riskAllocationLevel] = GetTooltipDisplayedNumber(expected_arrayOfClientRiskObjectivePercents[riskAllocationLevel]) + expected_LabelPercentOfWholePortfolioSuffix;
            }
            
           //Tooltip data grid expected content
            expected_arrayOfTooltipDataGridContent[riskAllocationLevel] = [[null, null, null]];
        }
        
        //Validate tooltip information for each level
        Get_WinRebalance_BtnClose().HoverMouse();
        SetAutoTimeOut(1000);
        for (var key in arrayOfRiskAllocationLevelsToTest){
            try {
                var riskAllocationLevel = arrayOfRiskAllocationLevelsToTest[key];
                Log.AppendFolder("Risk allocation level '" +  riskAllocationLevel + "' tooltip information validation in Portfolio graph", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
                
                var graphObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(riskAllocationLevel);
                if (graphObject.Width < 2){
                    Log.Warning("Risk allocation level '" +  riskAllocationLevel + "' Rectangle component Width < 2, the HoverMouse action will be done on the graph rating label instead.", "", pmHigher, null, Sys.Desktop.Picture());
                    graphObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblLabelForLevel(riskAllocationLevel);
                }
                
                //Check if the popup window is transient
                Log.Message("Check if the popup window for Risk allocation level '" +  riskAllocationLevel + "' is transient.");
                var transientCheckTimeout = 15000;
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], transientCheckTimeout))
                        Log.Checkpoint("The popup for Risk allocation level '" +  riskAllocationLevel + "' windows appeared and then disappeared by timeout ; it is transient.");
                    else
                        Log.Error("The popup windows for Risk allocation level '" +  riskAllocationLevel + "' appeared but did not disappear by timeout (~" + transientCheckTimeout + " ms) ; may be it is not transient.");
                }
                
                //Validate Tooltip title label
                Log.Message("Validate Tooltip title label for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblRiskAllocationLevel();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip title label is : " + expected_LabelRiskAllocationLevel);
                    CheckEquals(componentObject.WPFControlText, expected_LabelRiskAllocationLevel, "Risk allocation level '" +  riskAllocationLevel + "' tooltip title label", desktopPicture);
                }
                
                //Validate Tooltip title level
                Log.Message("Validate Tooltip title level for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtRiskAllocationLevel();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip title level is : " + riskAllocationLevel);
                    CheckEquals(componentObject.WPFControlText, riskAllocationLevel, "Risk allocation level '" +  riskAllocationLevel + "' tooltip title level", desktopPicture);
                }
                
                //Validate the tooltip data grid content
                Log.Message("Validate Tooltip data grid content for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var desktopPicture = Sys.Desktop.Picture();
                    var arrayOfArrayOfGridContent = GetRiskAllocationTooltipDataGridContent(graphObject, "PROJECTED PORTFOLIO");
                    Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' tooltip datagrid content (| char is the column separator) is : " + GetStringOfArray2D(expected_arrayOfTooltipDataGridContent[riskAllocationLevel]), GetStringOfArray2D(expected_arrayOfTooltipDataGridContent[riskAllocationLevel]));
                    CheckEqualsForTooltipDataGridContent(arrayOfArrayOfGridContent, expected_arrayOfTooltipDataGridContent[riskAllocationLevel], "Risk allocation level '" + riskAllocationLevel + "' tooltip datagrid content (| char is the column separator)", CR1958_GRAPH_TOOLTIP_MARKET_VALUES_TOLERANCE, desktopPicture);
                }
                
                //Validate Tooltip Label for Current Market Value
                Log.Message("Validate Tooltip Current Market Value Label for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblCurrentMarketValue();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Current Market Value is : " + expected_LabelCurrentMarketValue);
                    CheckEquals(componentObject.WPFControlText, expected_LabelCurrentMarketValue, "Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Current Market Value", desktopPicture);
                }
                
                //Validate Tooltip Current Market Value Label
                Log.Message("Validate Tooltip Current Market Value for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtCurrentMarketValue();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Current Market Value Label is : " + expected_arrayOfTooltipCurrentMarketValueLabel[riskAllocationLevel]);
                    CheckEqualsForFormattedNumberWithSuffix(componentObject.WPFControlText, expected_arrayOfTooltipCurrentMarketValueLabel[riskAllocationLevel], "Risk allocation level '" +  riskAllocationLevel + "' tooltip Current Market Value Label", CR1958_GRAPH_TOOLTIP_MARKET_VALUES_TOLERANCE, "", desktopPicture);
                }
                
                //Validate Tooltip Label for Current Market Percent Value
                Log.Message("Validate Tooltip Current Market Value Percent Label for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblCurrentMarketValuePercent();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Current Market Percent Value is : " + expected_LabelCurrentMarketValuePercent);
                    CheckEquals(componentObject.WPFControlText, expected_LabelCurrentMarketValuePercent, "Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Current Market Percent Value", desktopPicture);
                }
                
                //Validate Tooltip Current Market Value Percent Label Value
                Log.Message("Validate Tooltip Current Market Value Percent for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtCurrentMarketValuePercent();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Current Market Value Percent Label Value is : " + expected_arrayOfTooltipCurrentMarketPercentValueLabel[riskAllocationLevel]);
                    CheckEqualsForFormattedNumberWithSuffix(componentObject.WPFControlText, expected_arrayOfTooltipCurrentMarketPercentValueLabel[riskAllocationLevel], "Risk allocation level '" +  riskAllocationLevel + "' tooltip Current Market Value Percent Label Value", CR1958_PERCENT_VALUES_TOLERANCE, expected_LabelPercentOfWholePortfolioSuffix, desktopPicture);
                }
                
                //Validate Tooltip Rectangle color
                Log.Message("Validate Tooltip Rectangle color for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                    var desktopPicture = Sys.Desktop.Picture();
                    var rectangleObject = Get_SubMenus_Tooltip_RectangleForRiskAllocation();
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
                
                if (isWithClientsProfiles === true){
                    //Validate Tooltip Label for Client Risk Objective
                    Log.Message("Valide Tooltip Client Risk Objective Label for Risk allocation level '" + riskAllocationLevel + "'.");
                    if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                        var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblClientRiskObjectiveOrTargetMarketValue();
                        var desktopPicture = Sys.Desktop.Picture();
                        Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Client Risk Objective is : " + expected_LabelClientRiskObjectivePercent);
                        CheckEquals(componentObject.WPFControlText, expected_LabelClientRiskObjectivePercent, "Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Client Risk Objective", desktopPicture);
                    }
                    
                    //Validate Tooltip Client Risk Objective Percent Label
                    Log.Message("Valide Tooltip Client Risk Objective Percent for Risk allocation level '" + riskAllocationLevel + "'.");
                    if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                        var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtClientRiskObjectiveOrTargetMarketValue();
                        var desktopPicture = Sys.Desktop.Picture();
                        Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Client Risk Objective Percent Label is : " + expected_arrayOfTooltipClientRiskObjectiveValueLabel[riskAllocationLevel]);
                        CheckEqualsForFormattedNumberWithSuffix(componentObject.WPFControlText, expected_arrayOfTooltipClientRiskObjectiveValueLabel[riskAllocationLevel], "Risk allocation level '" +  riskAllocationLevel + "' tooltip Client Risk Objective Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, expected_LabelPercentOfWholePortfolioSuffix, desktopPicture);
                    }
                }
                else {
                    //Validate that Tooltip Label for Client Risk Objective Or Target Market Value is not displayed
                    Log.Message("Validate that Risk allocation level '" + riskAllocationLevel + "' Tooltip Label for Client Risk Objective Or Target Market Value is not displayed.");
                    if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                        if (Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblClientRiskObjectiveOrTargetMarketValue().Exists)
                            Log.Error("Risk allocation level '" + riskAllocationLevel + "' label for Client Risk Objective Or Target Market Value is displayed, this is unexpected.");
                        else
                            Log.Checkpoint("Risk allocation level '" + riskAllocationLevel + "' label for Client Risk Objective Or Target Market Value is not displayed, this expected.");
                    }
                    
                    //Validate that Tooltip Label for Client Risk Objective Or Target Market Value Percent is not displayed
                    Log.Message("Validate that Risk allocation level '" + riskAllocationLevel + "' Tooltip Label for Client Risk Objective Or Target Market Value Percent is not displayed.");
                    if (HoverMouseOnComponentInProjectedPortfolioGraph(graphObject)){
                        if (Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtClientRiskObjectiveOrTargetMarketValue().Exists)
                            Log.Error("Risk allocation level '" + riskAllocationLevel + "' label for Client Risk Objective Or Target Market Value Percent is displayed, this is unexpected.");
                        else
                            Log.Checkpoint("Risk allocation level '" + riskAllocationLevel + " label for Client Risk Objective Or Target Market Value Percent is not displayed, this expected.");
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
