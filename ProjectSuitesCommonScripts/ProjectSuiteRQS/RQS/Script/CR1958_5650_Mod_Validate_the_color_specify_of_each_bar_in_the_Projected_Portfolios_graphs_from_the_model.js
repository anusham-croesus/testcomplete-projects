//USEUNIT CR1958_Helper




/**
    Description : Validate the color specify of each bar in the Projected Portfolios graphs from the model
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5650
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5650_Mod_Validate_the_color_specify_of_each_bar_in_the_Projected_Portfolios_graphs_from_the_model()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5650", "CR1958_5650_Mod_Validate_the_color_specify_of_each_bar_in_the_Projected_Portfolios_graphs_from_the_model()");
    Log.Message("Bug JIRA CROES-11473 : On doit avoir le même comportement pour le graphique 'objectifs de risque' pour un client juste avec des objectifs et un modèle avec juste des targets (dans le sommaire modèles et  portefeuilles) donc il faut l'ajuster les deux cas.");
    Log.Message("Bug JIRA CROES-11351 : L'application crash si la  PREF_ENABLE_RISK_SCORE_GRAPH est disactivée");
    Log.Message("Bug JIRA CROES-11501 : Les objectifs de risque ne devraient pas être affichés sur les graphes quand une position d'un modèle n'a pas de cote de risque");
    
    try {
        //Model name
        var modelNumber = null;
        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5650_ModelName", language + client);
        var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5650_ClientNumber", language + client);
        
        var expectedRiskObjectivesGraphTitle = (client == "CIBC")? CR1958_GRAPH_TITLE_RISKOBJECTIVES: CR1958_GRAPH_TITLE_RISKALLOCATION;
        var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5650_CheckTrianglesDisplayInGraph", language + client));
        
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
        
        //Go to the Models module, select a model and Rebalance till step 4
        Log.Message("Go to the Models module, select a model and Rebalance till step 4.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        CleanupModelsByName(modelName, vServerRQS);
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        Create_Model(modelName);
        modelNumber = Get_ModelNo(modelName);
        AssociateClientWithModel(modelName, clientNumber);
        RebalanceTillProjectedPortfolio();
        
        //Check if portfolio risk objectives graph is displayed in summary section with values
        Log.Message("Check if portfolio risk objectives graph is displayed in summary section with values.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        if (!Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().Exists){
            Log.Error("The RQS Charts (containing the Risk objectives graph) was not found.");
            return;
        }
        
        var pnlRQSChartsUid = VarToStr(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts().Uid);
        var isPnlRQSChartsFoundInSummary = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild("Uid", pnlRQSChartsUid, 10).Exists;
        var isPnlRQSChartsVisible = aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts(), "IsVisible", cmpEqual, true);
        if (isPnlRQSChartsVisible && isPnlRQSChartsFoundInSummary)
            Log.Checkpoint("The RQS Charts is displayed in summary section.");
        else
            Log.Error("The RQS Charts is not displayed in summary section.");
        
        CheckRiskObjectivesGraphDisplayInProjectedPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
        
        //Validate the Color chart used for the bars
        Log.Message("Validate the Color chart used for the bars.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        for (var key in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[key];
            Log.Message("Validation for Risk allocation level '" + riskAllocationLevel + "'.");
            var rectangleObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(riskAllocationLevel);
            if (!rectangleObject.Exists){
                Log.Error("Risk allocation level '" + riskAllocationLevel + "' Rectangle component not found.");
                continue;
            }
            var actualColor = rectangleObject.Fill.Color;
            var actualColorHexValue = aqString.Format("%02x%02x%02x", actualColor.R, actualColor.G, actualColor.B);
            var expectedColor = CR1958_RISK_ALLOCATION_LEVELS_COLORS[riskAllocationLevel];
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color # is : " + expectedColor.Hex);
            if (!CheckEquals(actualColorHexValue, expectedColor.Hex, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color #")){
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component is : " + expectedColor.R);
                CheckEquals(actualColor.R, expectedColor.R, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component");
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component is : " + expectedColor.G);
                CheckEquals(actualColor.G, expectedColor.G, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component");
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component is : " + expectedColor.B);
                CheckEquals(actualColor.B, expectedColor.B, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component");
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
        
        Terminate_CroesusProcess();
    }
}