//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Check that you can change a high criteria to medium or low criteria
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-304
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0304_Tit_Check_that_you_can_change_a_high_criteria_to_medium_criteria_or_low_criteria()
{
    var criterion1_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0304_criterion1_name", language + client);
    var criterion2_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0304_criterion2_name", language + client);
    var criteria_former_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0304_former_rating", language + client);
    var criteria_update_rating1 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0304_update_rating1", language + client);
    var criteria_update_rating2 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0304_update_rating2", language + client);
        
    CheckBasicCriteriaRatingUpdate([criterion1_name, criterion2_name], criteria_former_rating, [criteria_update_rating1, criteria_update_rating2]);
}



function CheckBasicCriteriaRatingUpdate(criteriaNames, formerRating, updateRatings)
{
    try {
        var riskRatingCriteriaManagerWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingCriteriaManagerWindowTitle", language + client);
        
        //Delete the criteria with the same name
        for (var i = 0; i < criteriaNames.length; i++)
            Delete_FilterCriterion(criteriaNames[i], vServerRQS);
        
        //Connect to croesus with sysadmin
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Pre-conditions : Create the criteria
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        for (var i = 0; i < criteriaNames.length; i++){
            Log.Message("Create criterion : " + criteriaNames[i]);
            Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
            
            SetCriterionAttributes(criteriaNames[i], null, null, null, formerRating, null);
            
            //Criterion Condition
            Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
            Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
            
            Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        }
        
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //Step 1
        
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Click on 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        Log.Message("Select 'Basic criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        //Check that "Risk Rating criteria" window is displayed
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Title", cmpEqual, riskRatingCriteriaManagerWindowExpectedTitle);
        
        
        //Step 2
        var criterion1_name = criteriaNames[0];
        var criterion1_updateRating = updateRatings[0];
        CheckCriterionRatingUpdate(criterion1_name, formerRating, criterion1_updateRating);
        
        
        //Step 3
        var criterion2_name = criteriaNames[1];
        var criterion2_updateRating = updateRatings[1];
        CheckCriterionRatingUpdate(criterion2_name, formerRating, criterion2_updateRating);
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //Close Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        RestoreRQS(criteriaNames, null);
    }
}



function CheckCriterionRatingUpdate(criterionName, formerRating, updateRating)
{
    var criteriaEditorWindowEditionModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowEditionModeTitle", language + client);
    var lowRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Low", language + client);
    var mediumRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Medium", language + client);
    var highRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_High", language + client);
    
    //Select the criterion
    Log.Message("Select a " + formerRating + " criterion : " + criterionName);
    var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        
    if (criterionRowIndex == null){
        Log.Error("Criterion '" + criterionName + "' not found in the Basic criteria grid");
        return;
    }
    
    var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
    
    //Check if the former rating is the right one
    var RatingColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChRating().WPFControlOrdinalNo;
    var criterionRating = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10).WPFControlText;
    if (criterionRating != formerRating){
        Log.Error("Criterion '" + criterionName + "' former rating was expected to be '" + formerRating + "' ; found : " + criterionRating);
        return;
    }
    
    //Select the criterion and click on the Edit button
    var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
    criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
    
    //Check that "Edit a criterion" windows is displayed.
    if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowEditionModeExpectedTitle);
    
    //Check the new rating radio button
    if (updateRating == lowRating)
        Get_WinRiskRatingCriteriaEditor_GrpRating_RdoLow().Click();
    else if (updateRating == mediumRating)
        Get_WinRiskRatingCriteriaEditor_GrpRating_RdoMedium().Click();
    else if (updateRating == highRating)
        Get_WinRiskRatingCriteriaEditor_GrpRating_RdoHigh().Click();
    else
        Log.Error("'" + updateRating + "' rating not supported.");
    
    //Click on Save button.
    Log.Message("Click on 'Save' button.");
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
    
    //Check if the criterion is updated.
    Log.Message("Check if the criterion rating is updated to : " + updateRating);
    var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
    if (criterionRowIndex == null){
        Log.Error("Criterion '" + criterionName + "' not found in the Basic criteria grid");
        return;
    }
    
    //Check if the new rating is the expected one
    Log.Message("Check if the new rating is the expected one.")
    var RatingColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChRating().WPFControlOrdinalNo;
    var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
    var criterionNewRating = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10).WPFControlText;
    
    CheckEquals(criterionNewRating, updateRating, criterionName + " criterion new rating");
}
