//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions




/**
    Description : Check that you can Activate a disabled criteria
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-300
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0300_Tit_Check_that_you_can_Activate_a_disabled_criteria()
{
    var isCriterionInitiallyEnabled = false;
    Check_that_you_can_change_the_active_status_of_a_criterion(isCriterionInitiallyEnabled);
}



/*
    isCriterionInitiallyEnabled : true or false
*/

function Check_that_you_can_change_the_active_status_of_a_criterion(isCriterionInitiallyEnabled)
{
    try {
        var riskRatingCriteriaManagerWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingCriteriaManagerWindowTitle", language + client);
        var criteriaEditorWindowEditionModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowEditionModeTitle", language + client);
        var enabledCriterionNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0300_0301_EnabledCriterionNamePrefix", language + client);
        var disabledCriterionNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0300_0301_DisabledCriterionNamePrefix", language + client);
        
        
        //Pre-condition : Create a set of enabled and disabled criteria
        var nbOfEnabledCriteria = 4;
        var nbOfDisabledCriteria = 6;
        var arrayOfEnabledCriteria = new Array();
        var arrayOfDisabledCriteria = new Array();
        
        for (var i = 1; i <= nbOfEnabledCriteria; i++){
            var currentCriterionName = enabledCriterionNamePrefix + IntToStr(i);
            arrayOfEnabledCriteria.push(currentCriterionName);
            Delete_FilterCriterion(currentCriterionName, vServerRQS);
        }
        
        for (var i = 1; i <= nbOfDisabledCriteria; i++){
            var currentCriterionName = disabledCriterionNamePrefix + IntToStr(i);
            arrayOfDisabledCriteria.push(currentCriterionName)
            Delete_FilterCriterion(currentCriterionName, vServerRQS);
        }
        
        //Connect to croesus with sysadmin
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        for (var i = 0; i < arrayOfEnabledCriteria.length; i++){
            Log.Message("Create criterion : " + arrayOfEnabledCriteria[i]);
            Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
            
            SetCriterionAttributes(arrayOfEnabledCriteria[i], null, "true");
            
            //Criterion Condition
            Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
            Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
            
            Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        }
        
        for (var i = 0; i < arrayOfDisabledCriteria.length; i++){
            Log.Message("Create criterion : " + arrayOfDisabledCriteria[i]);
            Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
            
            SetCriterionAttributes(arrayOfDisabledCriteria[i], null, "false");
            
            //Criterion Condition
            Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
            Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
            
            Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        }
        
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //Stop if there is any error in pre-conditions
        if (Log.ErrCount > 0)
            return;
        
            
        //Get a random criterion
        var randomIndex = (isCriterionInitiallyEnabled)? Math.round(Math.random()*(nbOfEnabledCriteria - 1)): Math.round(Math.random()*(nbOfDisabledCriteria - 1));
        var criterionName = (isCriterionInitiallyEnabled)? arrayOfEnabledCriteria[randomIndex]: arrayOfDisabledCriteria[randomIndex];
        
        
        //Step 1 : In the tool bare menu of Securities Module, click on the button"Risk Rating Manager",
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        //Check that "Risk Rating criteria" window is displayed
        if (!aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Exists", cmpEqual, true))
            return;
        
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Title", cmpEqual, riskRatingCriteriaManagerWindowExpectedTitle);
        
        
        //Step 2 :
        Log.Message("Click on 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("Select 'Basic criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        //Validate that the criterion initial Active Status
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex == null){
            Log.Error("Criterion '" + criterionName + "' not found in the Basic criteria grid of the Simulate tab.");
            return;
        }
        
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        var activeCheckboxColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChActive().WPFControlOrdinalNo;
        var isCriterionActiveInGrid = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", activeCheckboxColumnIndex], 10).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1).IsChecked.OleValue;
        if (isCriterionActiveInGrid != isCriterionInitiallyEnabled){
            Log.Error("Criterion '" + criterionName + "' initial Active Status in the grid should be : " + isCriterionInitiallyEnabled + ", it is : " + isCriterionActive);
            return;
        }
        
        //Click on Edit button
        var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
        criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
        Log.Message("Click on Edit button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        if (!aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            return;
        
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowEditionModeExpectedTitle);
        
        //Validate that the criterion initial Active Status in the Criteria Editor window
        var isCriterionActiveInCriteriaEditorWindow = Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkActive().IsChecked.OleValue;
        if (isCriterionActiveInCriteriaEditorWindow != isCriterionInitiallyEnabled){
            Log.Error("Criterion '" + criterionName + "' initial Active Status in the Criteria Editor window should be : " + isCriterionInitiallyEnabled + ", it is : " + isCriterionActiveInCriteriaEditorWindow);
            return;
        }
        
        Log.Checkpoint("Criterion '" + criterionName + "' initial Active Status in the Criteria Editor window is the expected : " + isCriterionInitiallyEnabled);
        
        //Change the Active status
        Log.Message("Click to change the Active status.");
        Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkActive().Click();
        
        Log.Message("Click on Save button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        //Step 3 : Check the criterion new active status
        Log.Message("Check if the new criterion Active Status is : " + !isCriterionInitiallyEnabled);
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex == null){
            Log.Error("Criterion '" + criterionName + "' not found in the Basic criteria grid of the Simulate tab.");
            return;
        }
        
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        var activeCheckboxColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChActive().WPFControlOrdinalNo;
        var isCriterionActiveInGrid = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", activeCheckboxColumnIndex], 10).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1).IsChecked.OleValue;
        CheckEquals(isCriterionActiveInGrid, !isCriterionInitiallyEnabled, "Criterion '" + criterionName + "' new Active Status in the grid");        
        
        //Validate that the criterion new Active Status in the Criteria Editor window
        var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
        criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        if (!aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            return;
        
        var isCriterionActiveInCriteriaEditorWindow = Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkActive().IsChecked.OleValue;
        CheckEquals(isCriterionActiveInCriteriaEditorWindow, !isCriterionInitiallyEnabled, "Criterion '" + criterionName + "' new Active Status in the Criteria Editor window");  
        
        
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
        RestoreRQS(arrayOfEnabledCriteria.concat(arrayOfDisabledCriteria));
    }
}