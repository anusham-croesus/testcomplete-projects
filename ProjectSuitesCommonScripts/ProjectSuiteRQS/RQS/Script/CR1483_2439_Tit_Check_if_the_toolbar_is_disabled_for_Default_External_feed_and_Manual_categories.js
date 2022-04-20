//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT CR1483_0437_Tit_Check_if_Upper_Toolbar_is_activated_for_the_Overwrite_and_Simple_Criteria_categories



/**
    Description : Check if the toolbar is  disabled when the Default , External risk rating feed and  Manual  criteria categories are selected
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2439
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_2439_Tit_Check_if_the_toolbar_is_disabled_for_Default_External_feed_and_Manual_categories()
{
    try {
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //In the securities modul click on "Risk Rating Manager" button, in Risk Rating criteria window.
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("In securities module click on 'Risk Rating Manager' button.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        //1- Click on Simulation Tab then Default categories, check if the toolbar(Edit, Copy and Delete button) are disabled.
        Log.Message("Click on Simulation tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("Click on Default subcategories.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories().Click();
        CheckIfButtonsAreDisabled();
        
        //2- Click on External risk rating Feed, check if the toolbar(Edit, Copy and Delete button) are disabled.
        Log.Message("Click on External risk rating Feed.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnExternalRiskRatingFeed().Click();
        CheckIfButtonsAreDisabled();
        
        //3- Click on Manual category, check if the toolbar (Edit, Copy and Delete button) are disabled.
        Log.Message("Click on Manual category.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnManualOverwrite().Click();
        CheckIfButtonsAreDisabled();
        
        
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



function CheckIfButtonsAreDisabled()
{
    Log.Message("check if the toolbar (Edit, Copy and Delete buttons) are disabled.");
    
    var arrayOfButtonsToBeChecked = new Array();
    arrayOfButtonsToBeChecked.push([Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit(), false, "Edit button"]);
    arrayOfButtonsToBeChecked.push([Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnCopy(), false, "Copy button"]);
    arrayOfButtonsToBeChecked.push([Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnDelete(), false, "Delete button"]);
    
    for (var i = 0; i < arrayOfButtonsToBeChecked.length; i++)
        CheckIfObjectIsEnabledPropertyIsExpected(arrayOfButtonsToBeChecked[i][0], arrayOfButtonsToBeChecked[i][1], arrayOfButtonsToBeChecked[i][2]);
}