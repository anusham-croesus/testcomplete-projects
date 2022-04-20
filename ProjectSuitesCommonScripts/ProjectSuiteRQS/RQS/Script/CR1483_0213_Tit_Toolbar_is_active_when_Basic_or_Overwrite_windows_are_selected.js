//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT CR1483_0437_Tit_Check_if_Upper_Toolbar_is_activated_for_the_Overwrite_and_Simple_Criteria_categories



/**
    Description : In simulation view,  check if Ttoolbar is active when Basic or Overrite windows are selected 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-213
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0213_Tit_Toolbar_is_active_when_Basic_or_Overwrite_windows_are_selected()
{
    try {
        var basicCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereCAD", language + client);
        var overwriteCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereUSD", language + client);
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //- Go to the securities module, click on Risk Rating Manager then Simulation tab.
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("In securities module click on 'Risk Rating Manager' button.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        
        //1- Click on Simulation tab then Basic Criteria, select a criteria, check if the toolbar (Add, Edit, Copy and Delete button) is active.
        
        Log.Message("Click on Simulation tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        Log.Message("Click on Basic Criteria.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        Log.Message("Select the criterion : " + basicCriterionName);
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(basicCriterionName);
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10); 
        criterionRow.Click();
        
        Log.Message("Add/Edit/Copy and Delete buttons Get functions are related to the toolbar one ; so if they are found, it means that they are in the toolbar.");
        
        Log.Message("Check if Add/Edit/Copy and Delete buttons are activated.");
        CheckIfButtonsAreActivated();
        
        
        //2- Click on Overwrite Criteria, select a criteria, check if the toolbar (Add, Edit, Copy and delete button) is active.
        
        Log.Message("Click on Overwrite Criteria.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        
        Log.Message("Select the criterion : " + overwriteCriterionName);
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(overwriteCriterionName);
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10); 
        criterionRow.Click();
        
        Log.Message("Add/Edit/Copy and Delete buttons Get functions are related to the toolbar one ; so if they are found, it means that they are in the toolbar.");
        
        Log.Message("Check if Add/Edit/Copy and Delete buttons are activated.");
        CheckIfButtonsAreActivated();
        
        
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
    }
}