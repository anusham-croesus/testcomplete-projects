//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Check if the Name column contains the criterion Name
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-439
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0439_Tit_Check_if_the_Name_column_contains_the_criterion_Name()
{
    try {
        var basicCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0439_Criterion1", language + client);
        var overwriteCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0439_Criterion2", language + client);
        
        //Delete the criteria with the same names
        Delete_FilterCriterion(basicCriterionName, vServerRQS);
        Delete_FilterCriterion(overwriteCriterionName, vServerRQS);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Simulation Tab then Default category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("Select 'Basic criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        var isOverwriteChecked = false;
        CreateCriterion(basicCriterionName, isOverwriteChecked);
        
        //Check if criterion is displayed in Basic/Overwrite criteria grid
        var isCriterionDisplayed = CheckIfCriterionIsDisplayedInBasicOverwriteCriteriaGrid(basicCriterionName);
        aqObject.CompareProperty(isCriterionDisplayed, cmpEqual, true, true, lmError);
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //Open the risk rating criteria manager window, click on Production Tab then Default category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("Select 'Overwrite criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        
        var isOverwriteChecked = true;
        CreateCriterion(overwriteCriterionName, isOverwriteChecked);
        
        //Check if criterion is displayed in Basic/Overwrite criteria grid
        var isCriterionDisplayed = CheckIfCriterionIsDisplayedInBasicOverwriteCriteriaGrid(overwriteCriterionName);
        aqObject.CompareProperty(isCriterionDisplayed, cmpEqual, true, true, lmError);
        
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



function CreateCriterion(criterionName, isOverwriteChecked)
{
    //Créer le critère
    Log.Message("Create the criterion : " + criterionName);
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
    
    Get_WinRiskRatingCriteriaEditor_TxtName().Keys(criterionName);
    
    CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToUSD();
        
    Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkActive().set_IsChecked(true);
    Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwriteCriteria().set_IsChecked(isOverwriteChecked);
    Get_WinRiskRatingCriteriaEditor_GrpRating_RdoLow().set_IsChecked(true);
    
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
}