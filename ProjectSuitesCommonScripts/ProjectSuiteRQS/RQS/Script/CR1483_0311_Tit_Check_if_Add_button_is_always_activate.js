//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT CR1483_0437_Tit_Check_if_Upper_Toolbar_is_activated_for_the_Overwrite_and_Simple_Criteria_categories



/**
    Description : Check if Add button is always activate 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-311
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0311_Tit_Check_if_Add_button_is_always_activate()
{
    try {
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //Go to the securities module click on "Risk Rating Manager" button, in Risk Rating Manager window click on simulation tab
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("In securities module click on 'Risk Rating Manager' button.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Click on Simulation tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        
        //1- click on Basic Criteria, check if the Add button is active.
        Log.Message("1- click on Basic Criteria.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        CheckIfObjectIsEnabledPropertyIsExpected(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd(), true, "Add button");
        
        //2- click on Overwrite Criteria,check if the Add button is active.
        Log.Message("2- click on Overwrite Criteria.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        CheckIfObjectIsEnabledPropertyIsExpected(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd(), true, "Add button");
        
        //3- click on External risk rating feed, check if the Add button is active.
        Log.Message("3- click on External risk rating feed.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnExternalRiskRatingFeed().Click();
        CheckIfObjectIsEnabledPropertyIsExpected(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd(), true, "Add button");
        
        //4- click on Default subcategories, check if the Add button is active.
        Log.Message("4- click on Default subcategories.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories().Click();
        CheckIfObjectIsEnabledPropertyIsExpected(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd(), true, "Add button");
        
        //5- Click on Manual, check if the Add button is active.
        Log.Message("5- Click on Manual.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnManualOverwrite().Click();
        CheckIfObjectIsEnabledPropertyIsExpected(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd(), true, "Add button");
        
        
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