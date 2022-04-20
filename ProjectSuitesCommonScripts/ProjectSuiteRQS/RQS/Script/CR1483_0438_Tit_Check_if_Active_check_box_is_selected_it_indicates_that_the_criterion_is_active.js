//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Check if Active check box is selected, it indicates that the criterion is active.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-438
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0438_Tit_Check_if_Active_check_box_is_selected_it_indicates_that_the_criterion_is_active()
{
    try {
        var basicCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0438_Criterion1", language + client);
        var basicCriterionDescription = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0438_Criterion1Description", language + client);
        var overwriteCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0438_Criterion2", language + client);
        var overwriteCriterionDescription = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0438_Criterion2Description", language + client);
        
        //Delete the criteria with the same name
        Delete_FilterCriterion(basicCriterionName, vServerRQS);
        Delete_FilterCriterion(overwriteCriterionName, vServerRQS);
        
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        
        // #1 : Validate the contents of the associated grid for the Basic Criteria category
        
        //go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //1.1 : Create a risk rating criterion
        
        //Open the risk rating criteria manager window, click on Simulation Tab then Default category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("Select 'Basic criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        
        //Créer le critère
        Log.Message("Create the criterion : " + basicCriterionName);
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        
        Get_WinRiskRatingCriteriaEditor_TxtName().Keys(basicCriterionName);
        Get_WinRiskRatingCriteriaEditor_TxtDescription().Keys(basicCriterionDescription);
        Get_WinRiskRatingCriteriaEditor_GrpRating_RdoLow().set_IsChecked(true);
        
        CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToUSD();
                
        var basicCriterionExpectedModifiedDate = GetCurrentDateString();
        
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        
        //1.2 : Check if the checkbox Active is checked and the "Modified" field is updated (it displays the current date)
        
        Log.Message("Select 'Basic criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        var basicCriterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(basicCriterionName);
        
        Log.Message("Check if the Active checkbox is checked.");
        aqObject.CompareProperty(GetBasicOverwriteCriteriaActiveCheckboxValue(basicCriterionRowIndex), cmpEqual, true, true, lmError);
        
        Log.Message("Check if the 'Modified' field is updated.");
        aqObject.CompareProperty(GetBasicOverwriteCriteriaDisplayedModified(basicCriterionRowIndex), cmpEqual, basicCriterionExpectedModifiedDate, true, lmError);
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        // #2 : Validate the contents of the associated grid for the Overwrite Criteria category
        
        //go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //2.1 : Create a risk rating criterion
        
        //Open the risk rating criteria manager window, click on Simulation Tab then Default category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("Select 'Overwrite criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        
        
        //Créer le critère
        Log.Message("Create the criterion : " + overwriteCriterionName);
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        
        Get_WinRiskRatingCriteriaEditor_TxtName().Keys(overwriteCriterionName);
        Get_WinRiskRatingCriteriaEditor_TxtDescription().Keys(overwriteCriterionDescription);
        Get_WinRiskRatingCriteriaEditor_GrpRating_RdoMedium().set_IsChecked(true);
        
        CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToCAD();
                
        var overwriteCriterionExpectedModifiedDate = GetCurrentDateString();
        
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        
        //2.2 : Check if the checkbox Active is checked and the "Modified" field is updated (it displays the current date)
        
        Log.Message("Select 'Overwrite criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        
        var overwriteCriterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(overwriteCriterionName);
        
        Log.Message("Check if the Active checkbox is checked.");
        aqObject.CompareProperty(GetBasicOverwriteCriteriaActiveCheckboxValue(overwriteCriterionRowIndex), cmpEqual, true, true, lmError);
        
        Log.Message("Check if the 'Modified' field is updated.");
        aqObject.CompareProperty(GetBasicOverwriteCriteriaDisplayedModified(overwriteCriterionRowIndex), cmpEqual, overwriteCriterionExpectedModifiedDate, true, lmError);
        
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
        
        //Delete the criteria
        RestoreRQS(basicCriterionName, overwriteCriterionName, false, false, false);
        //Delete_FilterCriterion(basicCriterionName, vServerRQS);
        //Delete_FilterCriterion(overwriteCriterionName, vServerRQS);
    } 
}