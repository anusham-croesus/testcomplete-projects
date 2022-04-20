//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA


/**
    Description : Check that you can change a Name for an unassigned criterion
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-297
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0297_Tit_Check_that_you_can_change_a_Name_for_an_unassigned_criterion()
{
    try {
        var criteriaEditorWindowEditionModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowEditionModeTitle", language + client);
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0297_criterion_name", language + client);
        var criterionNewName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0297_criterion_new_name", language + client);
        
        //Delete the criteria with the same name
        Delete_FilterCriterion(criterionName, vServerRQS);
        Delete_FilterCriterion(criterionNewName, vServerRQS);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Steps 1, 2 : Open Risk Rating Manager window, Select a criterion and validate taht Production, Production Final, Simulation, and Simulation Final are null  and click on the"edit" button
        if (!CreateBasicCriterionAndCheckIfProductionSimulationAreNull(criterionName))
            return;
        
        //Stop if there is any error in pre-conditions
        if (Log.ErrCount > 0)
            return;
        
        //Select the criterion and Click on Edit button
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex == null){
            Log.Error("Criterion '" + criterionName + "' not found in the Basic criteria grid of the Simulate tab.");
            return;
        }
        
        var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
        
        Log.Message("Click on Edit button and check if 'Edit a criterion' window is displayed");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowEditionModeExpectedTitle);
        
        
        //Step 3 : Change the criterion Name values
        Log.Message("Change the criterion Name values to '" + criterionNewName + "'.");
        var NameTextbox = Get_WinRiskRatingCriteriaEditor_TxtName();
        var arrayOfCultures = GetCriteriaCulturesList(NameTextbox);
        for (var i = 0; i < arrayOfCultures.length; i++){
            SelectCriterionCulture(NameTextbox, arrayOfCultures[i]);
            Get_WinRiskRatingCriteriaEditor_TxtName().Clear();
            Get_WinRiskRatingCriteriaEditor_TxtName().Keys(criterionNewName);
        }
        
        
        //Step 4 : Click on Save button
        Log.Message("Click on Save button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        
        //Step 5 : Check if the criterion is updated
        Log.Message("Check if the criterion is updated.");
        
        //Check if the criterion former name has disappeared
        Log.Message("Check if the criterion former name has disappeared.");
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex != null){
            Log.Error("Criterion former name '" + criterionName + "' found in the grid, this is unexpected.");
            return;
        }
        
        Log.Checkpoint("Criterion former name '" + criterionName + "' not found in the grid, this is expected.");
        
        //Check if the modified criteria is saved.
        Log.Message("Check if the modified criteria is saved.");
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionNewName);
        if (criterionRowIndex == null){
            Log.Error("Criterion new name '" + criterionNewName + "' not found in the grid, this is unexpected.");
            return;
        }
        
        Log.Checkpoint("Criterion new name '" + criterionNewName + "' found in the grid, this is expected.");
        
        //Select the criterion and Click on Edit button and check the new name in the Criteria Editor window
        Log.Message("Select the criterion '" + criterionNewName + "', click on Edit button and check the new name in the Criteria Editor window.");
        var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        
        for (var i = 0; i < arrayOfCultures.length; i++){
            SelectCriterionCulture(NameTextbox, arrayOfCultures[i]);
            CheckEquals(Get_WinRiskRatingCriteriaEditor_TxtName().Text.OleValue, criterionNewName, "Criterion new name in the Criteria Editor window for culture '" + arrayOfCultures[i] + "'");
        }
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaEditor_BtnCancel().Click();
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //Close Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        RestoreRQS([criterionName, criterionNewName]);
    }
}



function CreateBasicCriterionAndCheckIfProductionSimulationAreNull(criterionName, criterionDescription, criterionConditionFunction)
{
    var riskRatingCriteriaManagerWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingCriteriaManagerWindowTitle", language + client);
    
    Get_SecuritiesBar_BtnRiskRatingManager().Click();
    Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    Log.Message("Create criterion : " + criterionName);
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
    
    SetCriterionAttributes(criterionName, criterionDescription, null, null, null, criterionConditionFunction);
    
    //Criterion Condition
    if (criterionConditionFunction == undefined){
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
    }
    
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
    Get_WinRiskRatingCriteriaManager_BtnClose().Click();
    
    Log.Message("Open the Risk Rating Criteria Manager window");
    Get_SecuritiesBar_BtnRiskRatingManager().Click();
    
    //Check that "Risk Rating criteria" window is displayed
    if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Title", cmpEqual, riskRatingCriteriaManagerWindowExpectedTitle);
    
    
    //Step 2 : Select  a criterion for which Yesterday, yesterday final, simulate and simulate final is not zero and click on copy button,  
    
    //Make sure that Production, Production final, simulation and simulation final are not null
    Log.Message("Make sure that Production, Production final, simulation and simulation final are null");
    Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
    if (criterionRowIndex == null){
        Log.Error("Criterion '" + criterionName + "' not found in the Basic criteria grid of the Simulate tab.");
        return false;
    }
    
    var windowLeft = Get_WinRiskRatingCriteriaManager().get_Left();
    var windowWidth = Get_WinRiskRatingCriteriaManager().get_Width();
    Get_WinRiskRatingCriteriaManager().set_Left(0);
    Get_WinRiskRatingCriteriaManager().set_Width(Sys.Desktop.Width);
    
    var productionColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProduction().WPFControlOrdinalNo;
    var productionFinalColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProductionFinal().WPFControlOrdinalNo;
    var simulationColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulation().WPFControlOrdinalNo;
    var simulationFinalColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulationFinal().WPFControlOrdinalNo;
    
    var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
    var nbOfProduction = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", productionColumnIndex], 10).WPFControlText;
    var nbOfProductionFinal = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", productionFinalColumnIndex], 10).WPFControlText;
    var nbOfSimulation = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationColumnIndex], 10).WPFControlText;
    var nbOfSimulationFinal = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationFinalColumnIndex], 10).WPFControlText;
    
    Get_WinRiskRatingCriteriaManager().set_Left(windowLeft);
    Get_WinRiskRatingCriteriaManager().set_Width(windowWidth);
    
    if (   !aqObject.CompareProperty(StrToInt(nbOfProduction), cmpEqual, 0, true, lmError)
        || !aqObject.CompareProperty(StrToInt(nbOfProductionFinal), cmpEqual, 0, true, lmError)
        || !aqObject.CompareProperty(StrToInt(nbOfSimulation), cmpEqual, 0, true, lmError)
        || !aqObject.CompareProperty(StrToInt(nbOfSimulationFinal), cmpEqual, 0, true, lmError))
        return false;
    
    return true;
}
