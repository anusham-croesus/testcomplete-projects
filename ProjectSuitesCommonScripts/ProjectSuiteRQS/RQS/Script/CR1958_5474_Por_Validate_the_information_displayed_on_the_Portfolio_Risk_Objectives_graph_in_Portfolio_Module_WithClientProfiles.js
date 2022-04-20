//USEUNIT CR1958_Helper



/**
    Description : Validate the information displayed on the Portfolio Risk Objectives graph in Portfolio Module
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5474
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5474_Por_Validate_the_information_displayed_on_the_Portfolio_Risk_Objectives_graph_in_Portfolio_Module_WithClientProfiles()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5474", "CR1958_5474_Por_Validate_the_information_displayed_on_the_Portfolio_Risk_Objectives_graph_in_Portfolio_Module_WithClientProfiles()");
    
    var isWithClientsProfiles = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5474_AreClientProfilesConfigured", language + client));
    if (isWithClientsProfiles === false)
        return Log.Warning("Les données du cas indiquent qu'il n'y a pas de Profils Client d'objectifs de risque. Les Profils Client d'objectifs de risque sont un requis pour ce script.");
    
    var expectedRiskObjectivesGraphTitle = (client == "CIBC")? CR1958_GRAPH_TITLE_RISKOBJECTIVES: CR1958_GRAPH_TITLE_RISKALLOCATION;
    var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5474_WithClientProfiles_CheckTrianglesDisplayInGraph", language + client));
    CR1958_5474_Por_Validate_the_information_displayed_on_the_Portfolio_Risk_Objectives_graph_in_Portfolio_Module(true, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
}





function CR1958_5474_Por_Validate_the_information_displayed_on_the_Portfolio_Risk_Objectives_graph_in_Portfolio_Module(isWithClientsProfiles, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay)
{
    Log.Message("Bug JIRA CROES-11292 : On ne doit pas avoir les  triangles  sur le graphe de répartition de risque si on maille plusieurs clients ou comptes qui ont des objectifs de risque différents.");
    Log.Message("Bug JIRA CROES-11351 : L'application crash si la  PREF_ENABLE_RISK_SCORE_GRAPH est disactivée");
    Log.Message("Bug JIRA CROES-11340 : RQS - Sur le graphe de répartition de risque, les tooltips sont incomplets");
    
    if (isWithClientsProfiles == undefined || (isWithClientsProfiles !== true && isWithClientsProfiles !== false))
        return Log.Error("isWithClientsProfiles must be defined, should be True or False.");
    
    var arrayOfRiskAllocationLevelsToTest = CR1958_RISK_ALLOCATION_LEVELS;
    
    try {
        //Client Number
        var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5474_ClientNumber", language + client);
        var expectedClientPortfolioName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5474_PortFolio_DisplayedName", language + client);
        
        //Needed columns names
        var columnName_MarketValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "ColumnName_MarketValue", language + client);
        
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
        
        if (isWithClientsProfiles === true)
            SetRiskAllocationLevelsWeightsAndClientProfileNames(CR1958_SECURITY_RISK_RATINGS_WEIGHTS, CR1958_RISK_ALLOCATION_CLIENT_PROFILE_NAMES, true);
        else {
            var arrayOfEmptyRiskAllocationClientProfileNames = [];
            for (var i in CR1958_RISK_ALLOCATION_LEVELS)
                arrayOfEmptyRiskAllocationClientProfileNames[CR1958_RISK_ALLOCATION_LEVELS[i]] = "";
            SetRiskAllocationLevelsWeightsAndClientProfileNames(CR1958_SECURITY_RISK_RATINGS_WEIGHTS, arrayOfEmptyRiskAllocationClientProfileNames, false);
        }
        
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
        Get_PortfolioGrid_GrpSummary().set_IsExpanded(true);
        Get_PortfolioGrid_GrpSummary().Click(Get_PortfolioGrid_GrpSummary().Width - 40, Get_PortfolioGrid_GrpSummary().Height - 8);
        aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_TxtPortfolioName(), "WPFControlText", cmpEqual, expectedClientPortfolioName);
        CheckIfRiskAllocationGraphIsDisplayedAtTheBottomRightSideOfTheScreen();
        CheckRiskObjectivesGraphDisplayInPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
        
        Log.Message("2. Validate the Graph tooltips information.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        
        var arrayOfArrayOfColumnsData = GetColumnsDataFromDataGrid([columnName_MarketValue], Get_Portfolio_AssetClassesGrid());
        var arrayOfArrayOfMarketValuesGroupedByRating = GroupColumnsDataByRiskRating(arrayOfArrayOfColumnsData);
        var portfolioMarketValuesGroupedBySecurityRating = arrayOfArrayOfMarketValuesGroupedByRating[columnName_MarketValue];
        
        var expected_arrayOfCurrentMarketValuesPercents = [];
        var expected_arrayOfClientRiskObjectivePercents = [];
        
        var expected_arrayOfTooltipCurrentMarketValueLabel = [];
        var expected_arrayOfTooltipClientRiskObjectiveValueLabel = [];
        var expected_arrayOfTooltipDataGridContent = [];
        for (var key in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[key];
            expected_arrayOfCurrentMarketValuesPercents[riskAllocationLevel] = CalculateAllocationLevelPercent_ClientToPortfolio(portfolioMarketValuesGroupedBySecurityRating, CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel]);
            expected_arrayOfClientRiskObjectivePercents[riskAllocationLevel] = GetTargetPercentValueFromDataBase(clientNumber, CR1958_RISK_ALLOCATION_CLIENT_PROFILE_CODES[riskAllocationLevel]);
            
            //Tooltip Current Market Value percent expected label
            expected_arrayOfTooltipCurrentMarketValueLabel[riskAllocationLevel] = GetTooltipDisplayedNumber(expected_arrayOfCurrentMarketValuesPercents[riskAllocationLevel], CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS) + expected_LabelPercentOfWholePortfolioSuffix;
            
            //Tooltip Client Risk Objective Value percent expected label
            expected_arrayOfTooltipClientRiskObjectiveValueLabel[riskAllocationLevel] = GetTooltipDisplayedNumber(expected_arrayOfClientRiskObjectivePercents[riskAllocationLevel], CR1958_GRAPH_PERCENT_VALUES_NB_DECIMALS) + expected_LabelPercentOfWholePortfolioSuffix;
            
           //Tooltip data grid expected content
            var expected_arrayOfGridContentHeaders = [expected_Graph_Tooltip_ColumnHeader_SecuritiesRiskRating,
                                                      expected_Graph_Tooltip_ColumnHeader_Allocation,
                                                      expected_Graph_Tooltip_ColumnHeader_CurrentMarketValue];
            var expected_arrayOfArrayOfTooltipDataGridContent = [expected_arrayOfGridContentHeaders];
            var totalValueForRiskAllocationLevel = 0;
            for (var securityRiskRatingIndex in CR1958_SECURITY_RISK_RATINGS){
                var securityRiskRating = CR1958_SECURITY_RISK_RATINGS[securityRiskRatingIndex];
                var securityRiskRatingWeight = CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel][securityRiskRating];
                if (securityRiskRatingWeight == 0 || securityRiskRatingWeight == undefined)
                    continue;
                
                var riskRatingCurrentMarketValue = (portfolioMarketValuesGroupedBySecurityRating[securityRiskRating]) * securityRiskRatingWeight/100;
                expected_arrayOfArrayOfTooltipDataGridContent.push([securityRiskRating + expected_Graph_Tooltip_Column_SecuritiesRiskRating_LabelAppendChar, securityRiskRatingWeight + CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL, GetTooltipDisplayedNumber(riskRatingCurrentMarketValue, CR1958_GRAPH_MARKET_VALUES_NB_DECIMALS)]);
                totalValueForRiskAllocationLevel += riskRatingCurrentMarketValue;
            }
            /*
            //Old
            if (expected_arrayOfArrayOfTooltipDataGridContent.length > 2)
                expected_arrayOfArrayOfTooltipDataGridContent.push([expected_Graph_Tooltip_Column_SecuritiesRiskRating_TotalRowLabel, "", GetTooltipDisplayedNumber(totalValueForRiskAllocationLevel, CR1958_GRAPH_MARKET_VALUES_NB_DECIMALS)]);
            */
            //https://jira.croesus.com/browse/RISK-1269 ; https://jira.croesus.com/browse/DOCUM-1059
            var totalValueDisplayForRiskAllocationLevel = GetTooltipDisplayedNumber(totalValueForRiskAllocationLevel, CR1958_GRAPH_MARKET_VALUES_NB_DECIMALS);
            for (var rowIndex = 1;  rowIndex < expected_arrayOfArrayOfTooltipDataGridContent.length; rowIndex++){
                if (totalValueDisplayForRiskAllocationLevel == expected_arrayOfArrayOfTooltipDataGridContent[rowIndex][2])
                    break;
                if (rowIndex == expected_arrayOfArrayOfTooltipDataGridContent.length - 1)
                    expected_arrayOfArrayOfTooltipDataGridContent.push([expected_Graph_Tooltip_Column_SecuritiesRiskRating_TotalRowLabel, "", totalValueDisplayForRiskAllocationLevel]);
            }
                
            expected_arrayOfTooltipDataGridContent[riskAllocationLevel] = expected_arrayOfArrayOfTooltipDataGridContent;            
            
        }
        
        
        //Validate tooltip information for each level in Portfolio
        SetAutoTimeOut(1000);
        for (var key in arrayOfRiskAllocationLevelsToTest){
            try {
                var riskAllocationLevel = arrayOfRiskAllocationLevelsToTest[key];
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
                Log.Message("Valide Tooltip title label for Risk allocation level '" + riskAllocationLevel + "'.");
                if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                    var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblRiskAllocationLevel();
                    var desktopPicture = Sys.Desktop.Picture();
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip title label is : " + expected_LabelRiskAllocationLevel);
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
                    Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' tooltip datagrid content (| char is the column separator) is : " + GetStringOfArray2D(expected_arrayOfTooltipDataGridContent[riskAllocationLevel]), GetStringOfArray2D(expected_arrayOfTooltipDataGridContent[riskAllocationLevel]));
                    CheckEqualsForTooltipDataGridContent(arrayOfArrayOfGridContent, expected_arrayOfTooltipDataGridContent[riskAllocationLevel], "Risk allocation level '" + riskAllocationLevel + "' tooltip datagrid content (| char is the column separator)", CR1958_GRAPH_TOOLTIP_MARKET_VALUES_TOLERANCE, desktopPicture);
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
                    Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Current Market Value Percent Label is : " + expected_arrayOfTooltipCurrentMarketValueLabel[riskAllocationLevel]);
                    CheckEqualsForFormattedNumberWithSuffix(componentObject.WPFControlText, expected_arrayOfTooltipCurrentMarketValueLabel[riskAllocationLevel], "Risk allocation level '" +  riskAllocationLevel + "' tooltip Current Market Value Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, expected_LabelPercentOfWholePortfolioSuffix, desktopPicture);
                }
                
                if (isWithClientsProfiles === true){
                    //Validate Tooltip Label for Client Risk Objective
                    Log.Message("Validate Tooltip Client Risk Objective Label for Risk allocation level '" + riskAllocationLevel + "'.");
                    if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                        var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblClientRiskObjectiveOrTargetMarketValue();
                        var desktopPicture = Sys.Desktop.Picture();
                        Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Client Risk Objective is : " + expected_LabelClientRiskObjectivePercent);
                        CheckEquals(componentObject.WPFControlText, expected_LabelClientRiskObjectivePercent, "Risk allocation level '" +  riskAllocationLevel + "' tooltip Label for Client Risk Objective", desktopPicture);
                    }
                    
                    //Validate Tooltip Client Risk Objective Percent Label
                    Log.Message("Validate Tooltip Client Risk Objective Percent for Risk allocation level '" + riskAllocationLevel + "'.");
                    if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                        var componentObject = Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtClientRiskObjectiveOrTargetMarketValue();
                        var desktopPicture = Sys.Desktop.Picture();
                        Log.Message("Check if Risk allocation level '" +  riskAllocationLevel + "' tooltip Client Risk Objective Percent Label is : " + expected_arrayOfTooltipClientRiskObjectiveValueLabel[riskAllocationLevel]);
                        CheckEqualsForFormattedNumberWithSuffix(componentObject.WPFControlText, expected_arrayOfTooltipClientRiskObjectiveValueLabel[riskAllocationLevel], "Risk allocation level '" +  riskAllocationLevel + "' tooltip Client Risk Objective Percent Label", CR1958_PERCENT_VALUES_TOLERANCE, expected_LabelPercentOfWholePortfolioSuffix, desktopPicture);
                    }
                }
                else {
                    //Validate that Tooltip Label for Client Risk Objective Or Target Market Value is not displayed
                    Log.Message("Validate that Risk allocation level '" + riskAllocationLevel + "' Tooltip Label for Client Risk Objective Or Target Market Value is not displayed.");
                    if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                        if (Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblClientRiskObjectiveOrTargetMarketValue().Exists)
                            Log.Error("Risk allocation level '" + riskAllocationLevel + "' Client Risk Objective (%) label is displayed, this is unexpected.");
                        else
                            Log.Checkpoint("Risk allocation level '" + riskAllocationLevel + "' Client Risk Objective (%) label is not displayed, this expected.");
                    }
                    
                    //Validate that Tooltip Label for Client Risk Objective Or Target Market Value Percent is not displayed
                    Log.Message("Validate that Risk allocation level '" + riskAllocationLevel + "' Tooltip Label for Client Risk Objective Or Target Market Value Percent is not displayed.");
                    if (HoverMouseOnComponentInPortfolioGraph(graphObject)){
                        if (Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtClientRiskObjectiveOrTargetMarketValue().Exists)
                            Log.Error("Risk allocation level '" + riskAllocationLevel + "' Client Risk Objective (%) Percent Value label is displayed, this is unexpected.");
                        else
                            Log.Checkpoint("Risk allocation level '" + riskAllocationLevel + "' Client Risk Objective (%) Percent Value label is not displayed, this expected.");
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
