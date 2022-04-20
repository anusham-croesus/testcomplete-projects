//USEUNIT CR1483_0297_Tit_Check_that_you_can_change_a_Name_for_an_unassigned_criterion



/**
    Description : Check that you can change a Description fo an unassigned criterion
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-298
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0298_Tit_Check_that_you_can_change_a_Description_for_an_unassigned_criterion()
{
    try {
        var criteriaEditorWindowEditionModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowEditionModeTitle", language + client);
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0298_criterion_name", language + client);
        var criterionDescription = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0298_criterion_description", language + client);
        var criterionNewDescription = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0298_criterion_new_description", language + client);
        
        //Delete the criteria with the same name
        Delete_FilterCriterion(criterionName, vServerRQS);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        
        //Step 1 : Select a criterion and validate taht Production, Production Final, Simulation, and Simulation Final are null
        if (!CreateBasicCriterionAndCheckIfProductionSimulationAreNull(criterionName, criterionDescription))
            return;
            
        //Stop if there is any error in pre-conditions
        if (Log.ErrCount > 0)
            return;
        
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
        
        
        //Step 2 : Click on the Edit button and Check if "Edit a criterion" windows is displayed.
        Log.Message("Click on Edit button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowEditionModeExpectedTitle);
        
        
        //Step 3 : Change the Description values
        Log.Message("Change the criterion Description values to '" + criterionNewDescription + "'.");
        var DescriptionTextbox = Get_WinRiskRatingCriteriaEditor_TxtDescription();
        var arrayOfCultures = GetCriteriaCulturesList(DescriptionTextbox);
        for (var i = 0; i < arrayOfCultures.length; i++){
            SelectCriterionCulture(DescriptionTextbox, arrayOfCultures[i]);
            Get_WinRiskRatingCriteriaEditor_TxtDescription().Clear();
            Get_WinRiskRatingCriteriaEditor_TxtDescription().Keys(criterionNewDescription);
        }
        
        
        //Step 4 : Click on Save button and check if the criterion is updated
        Log.Message("Click on Save button and check if the criterion is updated.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex == null){
            Log.Error("Criterion '" + criterionName + "' not found in the grid, this is unexpected.");
            return;
        }
        
        //Select the criterion and Click on Edit button and check the new Description values in the Criteria Editor window
        Log.Message("Select the criterion '" + criterionName + "', click on Edit button and check the Description new values in the Criteria Editor window.");
        var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        
        for (var i = 0; i < arrayOfCultures.length; i++){
            SelectCriterionCulture(DescriptionTextbox, arrayOfCultures[i]);
            CheckEquals(Get_WinRiskRatingCriteriaEditor_TxtDescription().Text.OleValue, criterionNewDescription, "Criterion new Description for culture '" + arrayOfCultures[i] + "'");
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
        RestoreRQS(criterionName);
    }
}

