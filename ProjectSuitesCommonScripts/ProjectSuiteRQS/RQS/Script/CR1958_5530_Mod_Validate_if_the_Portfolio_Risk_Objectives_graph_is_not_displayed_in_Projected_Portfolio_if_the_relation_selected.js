//USEUNIT CR1958_Helper



/**
    Description : Validate if the Portfolio Risk Objectives graph is not displayed in Projected Portfolio if the relation selected
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5480
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5530_Mod_Validate_if_the_Portfolio_Risk_Objectives_graph_is_not_displayed_in_Projected_Portfolio_if_the_relation_selected()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5530", "CR1958_5530_Mod_Validate_if_the_Portfolio_Risk_Objectives_graph_is_not_displayed_in_Projected_Portfolio_if_the_relation_selected()");
    Log.Message("Bug JIRA CROES-11473 : On doit avoir le même comportement pour le graphique 'objectifs de risque' pour un client juste avec des objectifs et un modèle avec juste des targets (dans le sommaire modèles et  portefeuilles) donc il faut l'ajuster les deux cas.");
    Log.Message("Bug JIRA CROES-11419 : Le calculs pour la  valeur de marché courante (%) pour un modèle avec des sous modèles est erroné sur les deux graphes de RQS");
    Log.Message("Bug JIRA CROES-11411 : Une différence entre les deux  Graphes (Objectifs de risque et cote de risque ) dans le module  Modèle et portefeuille pour un modèle avec  des sous modèle quis  a un solde = 0");
    Log.Message("Bug JIRA CROES-11351 : L'application crash si la  PREF_ENABLE_RISK_SCORE_GRAPH est disactivée");
    Log.Message("Bug JIRA CROES-11501 : Les objectifs de risque ne devraient pas être affichés sur les graphes quand une position d'un modèle n'a pas de cote de risque");
    
    try {
        //Model name, Securities infos, Accounts numbers
        var modelNumber = null, relationshipName = null;
        var arrayOfRelationshipAccountsNumbers = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5530_Relationship_AccountsNumbers", language + client).split("|");
        var relationshipName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5530_Relationship_Name", language + client);
        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5530_ModelName", language + client);
        var security1_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5530_Security1_Symbol", language + client);
        var security1_TargetMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_Security1_TargetMV", language + client);
        var security2_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5530_Security2_Symbol", language + client);
        var security2_TargetMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_Security2_TargetMV", language + client);
        var security3_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5530_Security3_Symbol", language + client);
        var security3_TargetMV = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5480_Security3_TargetMV", language + client);
        
        var expectedRiskObjectivesGraphTitle = CR1958_GRAPH_TITLE_RISKALLOCATION;
        
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
        AddPositionBySecuritySymbol(security1_Symbol, security1_TargetMV, null);
        AddPositionBySecuritySymbol(security2_Symbol, security2_TargetMV, null);
        AddPositionBySecuritySymbol(security3_Symbol, security3_TargetMV, null);
        SaveReinitializeSavePortfolio();
        
        //Create the Relationship and join Accounts
        CreateRelationship(relationshipName);
        for (var i in arrayOfRelationshipAccountsNumbers)
            JoinAccountToRelationship(arrayOfRelationshipAccountsNumbers[i], relationshipName);
        
        //Go to Models module, assign Relationship to the model, and Perform a Rebalancing till the step 4
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        AssociateRelationshipWithModel(modelName, relationshipName);
        RebalanceTillProjectedPortfolio();
        CheckRiskObjectivesGraphDisplayInProjectedPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, false);
        
        //1. VALIDATIONS IN THE PROJECTED PORTFOLIO
        
        //Prior, validate the selected relationship
        var selectedRelationshipName = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator()
                                   .FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)
                                   .FindChild(["ClrClassName", "IsActive"], ["DataRecordPresenter", true], 10)
                                   .FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "ShortName"], 10)
                                   .WPFControlText;
        CompareProperty(selectedRelationshipName, cmpEqual, relationshipName, true, lmError);
        
        //Validate that there is no triangle displayed
        Log.Message("Validate that there is no triangle displayed.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        
        //Generic validation for any potential triangle polygon
        var allDisplayedTriangleObjects = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectivesItemsControl().FindAllChildren(["ClrClassName", "IsVisible", "Points.Count"], ["Polygon", true, 3], 10).toArray();
        Log.Message("Check if the Number of Triangles objects displayed in the graph is : " + 0);
        CheckEquals(allDisplayedTriangleObjects.length, 0, "Number of Triangles objects displayed in the graph");
        
        //Validation for All known allocation levels
        for (var key in CR1958_RISK_ALLOCATION_LEVELS){
            var riskAllocationLevel = CR1958_RISK_ALLOCATION_LEVELS[key];
            Log.Message("Validation for Risk allocation level '" + riskAllocationLevel + "'.");
            Log.Message("Check if no triangle is displayed for Risk allocation level '" + riskAllocationLevel + "'.");
            var riskAllocationLevelTriangleObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_TriangleForLevel(riskAllocationLevel);
            if (riskAllocationLevelTriangleObject.Exists && riskAllocationLevelTriangleObject.IsVisible)
                Log.Error("Risk allocation level '" + riskAllocationLevel + "' triangle is displayed, this is unexpected.");
            
            Log.Message("Check if triangle percent is displayed in the percent label for Risk allocation level '" + riskAllocationLevel + "'.");
            var riskAllocationLevelPercentsObject = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_PnlRQSCharts_GraphRiskObjectives_LblPercentsForLevel(riskAllocationLevel);
            if (riskAllocationLevelPercentsObject.Exists && riskAllocationLevelPercentsObject.IsVisible && Trim(VarToStr(riskAllocationLevelPercentsObject.WPFControlText)) != ""){
                if (aqString.Find(Trim(VarToStr(riskAllocationLevelPercentsObject.WPFControlText)), "/") != -1)
                    Log.Warning("There may be a triangle percent label displayed for Risk allocation level '" + riskAllocationLevel + "'.");
            }
            else {
                Log.Error("There is no Percent label displayed for Risk allocation level '" + riskAllocationLevel + "', this is unexpected.");
            }
        }
        
        //Cancel the Rebalancing and Close Croesus
        Get_WinRebalance_BtnClose().Click();
        Get_DlgConfirmation_BtnContinue().Click();
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        //Cleanup Model and relationship
        CleanupModel(modelNumber, vServerRQS);
        CleanupRelationship(relationshipName, vServerRQS);
        
        //Restore prefs
        UpdateFirmArrayOfPrefs(vServerRQS, firm_code, arrayOfPrefsPreviousValues, arrayOfPrefsValues);
        
        //Terminate Croesus process
        Terminate_CroesusProcess();
    }
}
