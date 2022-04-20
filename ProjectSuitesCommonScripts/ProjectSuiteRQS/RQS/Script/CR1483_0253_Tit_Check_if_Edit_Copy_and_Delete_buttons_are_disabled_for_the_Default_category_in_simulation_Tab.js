//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : Check if Edit / Copy and Delete buttons are disabled for the Default category in simulation Tab
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-253
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0253_Tit_Check_if_Edit_Copy_and_Delete_buttons_are_disabled_for_the_Default_category_in_simulation_Tab()
{
    try {
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Simulation Tab
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        Log.Message("Click on Default Subcategories.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories().Click();
        
        Log.Message("Check if Edit button is disabled.");
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit(), "IsEnabled", cmpEqual, false);
        
        Log.Message("Check if Copy button is disabled.");
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnCopy(), "IsEnabled", cmpEqual, false);
        
        Log.Message("Check if Delete button is disabled.");
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnDelete(), "IsEnabled", cmpEqual, false);
        
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