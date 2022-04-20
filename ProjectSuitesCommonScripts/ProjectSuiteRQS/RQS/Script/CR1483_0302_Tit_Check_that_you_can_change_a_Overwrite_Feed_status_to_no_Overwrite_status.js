//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions




/**
    Description : Check that you can change a Overwrite Feed status to no Overwrite status
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-302
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0302_Tit_Check_that_you_can_change_a_Overwrite_Feed_status_to_no_Overwrite_status()
{
    try {
        var riskRatingCriteriaManagerWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingCriteriaManagerWindowTitle", language + client);
        var criteriaEditorWindowEditionModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowEditionModeTitle", language + client);
        var criterionNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0302_CriterionNamePrefix", language + client);
        
        
        //Pre-condition : Create a set of Overwrite criteria
        var nbOfOverwriteCriteriaToBeAdded = 5;
        var arrayOfOverwriteCriteria = new Array();
        
        for (var i = 1; i <= nbOfOverwriteCriteriaToBeAdded; i++){
            var currentCriterionName = criterionNamePrefix + IntToStr(i);
            arrayOfOverwriteCriteria.push(currentCriterionName);
            Delete_FilterCriterion(currentCriterionName, vServerRQS);
        }
        
        //Connect to croesus with sysadmin
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        
        for (var i = 0; i < arrayOfOverwriteCriteria.length; i++){
            Log.Message("Create criterion : " + arrayOfOverwriteCriteria[i]);
            Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
            
            SetCriterionAttributes(arrayOfOverwriteCriteria[i]);
            
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
        var randomIndex = Math.round(Math.random()*(nbOfOverwriteCriteriaToBeAdded - 1));
        var criterionName = arrayOfOverwriteCriteria[randomIndex];
        
        
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
        Log.Message("Select 'Overwrite criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        
        
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex == null){
            Log.Error("Criterion '" + criterionName + "' not found in the Overwrite criteria grid of the Simulate tab.");
            return;
        }
        
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        var criterionModifiedColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChModified().WPFControlOrdinalNo;
        var formerCriterionModifiedDateTime = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", criterionModifiedColumnIndex], 10).WPFControlText;
        
        //Click on Edit button
        var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
        criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
        Log.Message("Click on Edit button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        if (!aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            return;
        
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowEditionModeExpectedTitle);
        
        //Validate that the criterion initial Overwrite Status is true
        var isCriterionOverwriteChecked = Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwriteCriteria().IsChecked.OleValue;
        if (!isCriterionOverwriteChecked){
            Log.Error("Criterion '" + criterionName + "' initial Overwrite checkbox Status should be : " + true + ", it is : " + isCriterionOverwriteChecked);
            return;
        }
        
        //Change the Overwrite status
        Log.Message("Click to change te Overwrite status.");
        Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwriteCriteria().Click();
        
        Log.Message("Click on Save button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        //Step 3 : Check if the criteria is updated and is displayed in Basic criteria window
        Log.Message("Check if criterion " + criterionName + " is displayed in the Basic criteria grid.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex == null){
            Log.Error("Criterion '" + criterionName + "' not found in the Basic criteria grid.");
            return;
        }
        
        Log.Checkpoint("Criterion " + criterionName + " is displayed in the Basic criteria grid.");
        
        //Check if the criterion is updated
        Log.Message("Check if criterion " + criterionName + " is updated.");
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        var criterionModifiedColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChModified().WPFControlOrdinalNo;
        var newCriterionModifiedDateTime = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", criterionModifiedColumnIndex], 10).WPFControlText;
        aqObject.CompareProperty(formerCriterionModifiedDateTime, cmpNotEqual, newCriterionModifiedDateTime, true, lmError);
        
        
        //Validate that the criterion new Overwrite Status is false
        var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
        criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        if (!aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            return;
        
        var isCriterionOverwriteChecked = Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwriteCriteria().IsChecked.OleValue;
        CheckEquals(isCriterionOverwriteChecked, false, "Criterion '" + criterionName + "' new Overwrite checkbox Status")
        
        
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
        RestoreRQS(criterionName, arrayOfOverwriteCriteria);
    }
}