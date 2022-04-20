//USEUNIT CR1958_Helper



/**
    Description : Validate if the Portfolio Risk Objectives graph is displayed in Projected Portfolio With Account
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5480
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5480_Mod_Validate_if_the_Portfolio_Risk_Objectives_graph_is_displayed_in_Projected_Portfolio_With_Account()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5480", "CR1958_5480_Mod_Validate_if_the_Portfolio_Risk_Objectives_graph_is_displayed_in_Projected_Portfolio_With_Account()");
    Log.Message("Bug JIRA CROES-11473 : On doit avoir le même comportement pour le graphique 'objectifs de risque' pour un client juste avec des objectifs et un modèle avec juste des targets (dans le sommaire modèles et  portefeuilles) donc il faut l'ajuster les deux cas.");
    Log.Message("Bug JIRA CROES-11419 : Le calculs pour la  valeur de marché courante (%) pour un modèle avec des sous modèles est erroné sur les deux graphes de RQS");
    Log.Message("Bug JIRA CROES-11411 : Une différence entre les deux  Graphes (Objectifs de risque et cote de risque ) dans le module  Modèle et portefeuille pour un modèle avec  des sous modèle quis  a un solde = 0");
    Log.Message("Bug JIRA CROES-11351 : L'application crash si la  PREF_ENABLE_RISK_SCORE_GRAPH est disactivée");
    Log.Message("Bug JIRA CROES-11501 : Les objectifs de risque ne devraient pas être affichés sur les graphes quand une position d'un modèle n'a pas de cote de risque");
    
    try {
        
        //Model name, Securities infos, Accounts numbers
        var modelNumber = null;
        var arrayOfAccountsNumbers = [];
        var accountsIACode = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_AccountsIACode", language + client);
        var arrayOfAccountsNumbers = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_AccountsNumbers", language + client).split("|");
        var arrayOfAccountsPreviousIACodes = new Array(arrayOfAccountsNumbers.length).fill(null);
        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_ModelName", language + client);
        var security1_Description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_Security1_Description", language + client);
        var security1_TargetMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_Security1_TargetMV", language + client);
        var security2_Description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_Security2_Description", language + client);
        var security2_TargetMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_Security2_TargetMV", language + client);
        var security3_Description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_Security3_Description", language + client);
        var security3_TargetMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_Security3_TargetMV", language + client);
        
        var expectedRiskObjectivesGraphTitle = (client == "CIBC")? CR1958_GRAPH_TITLE_RISKOBJECTIVES: CR1958_GRAPH_TITLE_RISKALLOCATION;
        var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_CheckTrianglesDisplayInGraph", language + client));
        var columnName_MarketValuePercent = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "ColumnName_MarketValuePercent", language + client);
                
        //Change the Accounts IACode in order to make them available for the user
        for (var i in arrayOfAccountsNumbers)
            arrayOfAccountsPreviousIACodes[i] = Execute_SQLQuery_GetField("select NO_REP from B_COMPTE where NO_COMPTE = '" + arrayOfAccountsNumbers[i] + "'", vServerRQS, "NO_REP");
        
        for (var i in arrayOfAccountsNumbers)
            UpdateIACodeForAccount(arrayOfAccountsNumbers[i], accountsIACode, vServerRQS)
        
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
        AddPositionBySecurityDescription(security1_Description, security1_TargetMV, null);
        AddPositionBySecurityDescription(security2_Description, security2_TargetMV, null);
        AddPositionBySecurityDescription(security3_Description, security3_TargetMV, null);
        SaveReinitializeSavePortfolio();
        
        //Go to Models module, assign Clients to the model, and Perform a Rebalancing till the step 4
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        for (var i in arrayOfAccountsNumbers)
            AssociateAccountWithModel(modelName, arrayOfAccountsNumbers[i]);
        RebalanceTillProjectedPortfolio();
        CheckRiskObjectivesGraphDisplayInProjectedPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
        
        //1. VALIDATIONS IN THE PROJECTED PORTFOLIO
        
        //Validation for each client
        for (var j in arrayOfAccountsNumbers){
            Log.AppendFolder("Validation for Account '" + arrayOfAccountsNumbers[j] + "'.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
            Get_WinRebalance_BtnClose().HoverMouse();
            
            //Get the currently Selected Account Number
            var selectedAccountNumber = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator()
                                       .FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)
                                       .FindChild(["ClrClassName", "IsActive"], ["DataRecordPresenter", true], 10)
                                       .FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "Id"], 10)
                                       .WPFControlText;
            
            //Select the account number if different from the currently selected one
            if (arrayOfAccountsNumbers[j] != selectedAccountNumber){
                Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator()
                                       .FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)
                                       .FindChild(["ClrClassName", "Uid", "WPFControlText"], ["CellValuePresenter", "Id", arrayOfAccountsNumbers[j]], 10).Click();
                selectedAccountNumber = arrayOfAccountsNumbers[j];
            }
            
            var selectedClientNumber = Trim(Execute_SQLQuery_GetField("select NO_CLIENT from B_COMPTE where NO_COMPTE = '" + selectedAccountNumber + "'", vServerRQS, "NO_CLIENT"));
            
            Log.Message("VALIDATIONS IN PROJECTED PORTFOLIO.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
            
            //Retrieve information from the datagrid
            var arrayOfArrayOfColumnsData = GetColumnsDataFromDataGrid(columnName_MarketValuePercent, Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio());
            var arrayOfArrayOfMarketValuesGroupedByRating = GroupColumnsDataByRiskRating(arrayOfArrayOfColumnsData);
            var projectedPortfolioMarketValuesGroupByRating = arrayOfArrayOfMarketValuesGroupedByRating[columnName_MarketValuePercent];
            var projectedPortfolioPicture = Get_WinRebalance().Parent.Picture();
            
            //Perform validation for each Risk allocation level
            var projectedPortfolio_RiskAllocationGraphInfos = [];
            for (var k in CR1958_RISK_ALLOCATION_LEVELS){
                try {
                    var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[k];
                    Log.Message("Validations for Risk allocation level '" + riskAllocationLevel + "'.");
                    var projectedPortfolio_RiskAllocationLevelPercentsObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskAllocationLevel);
                    projectedPortfolio_RiskAllocationGraphInfos[riskAllocationLevel] = {};
                    projectedPortfolio_RiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel = GetRectangleDisplayedPercentLabel(projectedPortfolio_RiskAllocationLevelPercentsObject.WPFControlText);
                    projectedPortfolio_RiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel = GetTriangleDisplayedPercentLabel(projectedPortfolio_RiskAllocationLevelPercentsObject.WPFControlText);
                    
                    //1.1 : Validate the Target Market Value (Relative position of Triangle) in the Projected Portfolio
                    Log.Message("1.1 : Validate the Target Market Value (Relative position of Triangle) in the Projected Portfolio for selected client : " + selectedClientNumber);
                    var expected_ProjectedPortfolioTargetMarketValue = GetTargetPercentValueFromDataBase(selectedClientNumber, CR1958_RISK_ALLOCATION_CLIENT_PROFILE_CODES[riskAllocationLevel]);
                    var expected_ProjectedPortfolioTargetMarketLabel = GetRiskRatingExpectedPercentageLabel(expected_ProjectedPortfolioTargetMarketValue);
                    Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Target Market Value percentage is : " + expected_ProjectedPortfolioTargetMarketLabel);
                    CheckEqualsForFormattedNumberWithSuffix(projectedPortfolio_RiskAllocationGraphInfos[riskAllocationLevel].targetPercentLabel, expected_ProjectedPortfolioTargetMarketLabel, "Risk allocation level '" + riskAllocationLevel + "' Target Market Value percentage", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
                    
                    //1.2 : Validate the Current Market Value (Relative length of bar) in the Projected Portfolio
                    Log.Message("1.2 : Validate the Current Market Value (Relative length of bar) in the Projected Portfolio");
                    var expected_ProjectedPortfolioCurrentMarketValue = CalculateAllocationLevelPercent_ModelToPortfolio_PositiveBalance(projectedPortfolioMarketValuesGroupByRating, CR1958_RISK_ALLOCATION_LEVELS_WEIGHTS[riskAllocationLevel]);
                    var expected_ProjectedPortfolioCurrentMarketLabel = GetRiskRatingExpectedPercentageLabel(expected_ProjectedPortfolioCurrentMarketValue);
                    Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Current Market Value percentage is : " + expected_ProjectedPortfolioCurrentMarketLabel);
                    CheckEqualsForFormattedNumberWithSuffix(projectedPortfolio_RiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel, expected_ProjectedPortfolioCurrentMarketLabel, "Risk allocation level '" + riskAllocationLevel + "' Current Market Value percentage", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL);
                }
                catch (projectedPortfolioException){
                    Log.Error("Exception : " + projectedPortfolioException.message, VarToStr(projectedPortfolioException.stack));
                    projectedPortfolioException = null;
                }
            }
            
            
            //4. VALIDATIONS IN THE PORTFOLIO
            Log.Message("VALIDATIONS IN PORTFOLIO.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
            
            //Drag the model to Portfolio
            Get_ModulesBar_BtnModels().HoverMouse();
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
            SearchModelByName(modelName);
            Drag(Get_ModelsGrid().Find("Value", modelName, 10), Get_ModulesBar_BtnPortfolio());
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
            Get_PortfolioGrid_GrpSummary().set_IsExpanded(true);
            Get_PortfolioGrid_GrpSummary().Click(Get_PortfolioGrid_GrpSummary().Width - 40, Get_PortfolioGrid_GrpSummary().Height - 8);
            CheckRiskObjectivesGraphDisplayInPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
            
            //Validate if the Current Market Value (Relative length of bar) in the Portfolio is the same as in the Projected Portfolio
            Log.Message("Validate if the Current Market Value (Relative length of bar) in the Portfolio is the same as in the Projected Portfolio.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
            
            //Perform validation for each rating level
            var portfolio_RiskAllocationGraphInfos = [];
            for (var k in CR1958_RISK_ALLOCATION_LEVELS){
                try {
                    var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[k];
                    Log.Message("Validation for Risk allocation level '" + riskAllocationLevel + "'.");
                    var portfolio_RiskAllocationLevelPercentsObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskAllocationLevel);
                    portfolio_RiskAllocationGraphInfos[riskAllocationLevel] = {};
                    portfolio_RiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel = GetRectangleDisplayedPercentLabel(portfolio_RiskAllocationLevelPercentsObject.WPFControlText);
                    Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Current Market Value percentage in Portfolio compared to the Projected Portfolio is : " + projectedPortfolio_RiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel);
                    if (!CheckEqualsForFormattedNumberWithSuffix(portfolio_RiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel, projectedPortfolio_RiskAllocationGraphInfos[riskAllocationLevel].marketPercentLabel, "Risk allocation level '" + riskAllocationLevel + "' Current Market Value percentage in Portfolio compared to the Projected Portfolio", CR1958_PERCENT_VALUES_TOLERANCE, CR1958_GRAPH_TOOLTIP_PERCENT_SYMBOL))
                        Log.Picture(projectedPortfolioPicture, "For the picture of the related Projected Portfolio, please refer to the Picture tab at the bottom of the log panel.", "", pmNormal, CR1958_LOG_ATTRIBUTES_BOLD);
                }
                catch (portfolioException){
                    Log.Error("Exception : " + portfolioException.message, VarToStr(portfolioException.stack));
                    portfolioException = null;
                }
            }
            
            Log.PopLogFolder();
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
        
        //Restore Accounts IA Code
        for (var i in arrayOfAccountsNumbers)
            UpdateIACodeForAccount(arrayOfAccountsNumbers[i], arrayOfAccountsPreviousIACodes[i], vServerRQS);
        
        //Restore prefs
        UpdateFirmArrayOfPrefs(vServerRQS, firm_code, arrayOfPrefsPreviousValues, arrayOfPrefsValues);
        
        //Terminate Croesus process
        Terminate_CroesusProcess();
    }
}

