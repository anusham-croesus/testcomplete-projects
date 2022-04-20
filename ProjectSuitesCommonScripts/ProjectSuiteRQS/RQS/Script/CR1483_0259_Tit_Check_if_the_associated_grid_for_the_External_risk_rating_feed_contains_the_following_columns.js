//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : Check if the  associated grid for the External risk rating feed contains the following columns: 
                  Rating, Corresponding securities, Production Final and Simulate Final.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-259
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0259_Tit_Check_if_the_associated_grid_for_the_External_risk_rating_feed_contains_the_following_columns()
{
    try {
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Simulation Tab then External risk Rating feed and check columns existence.
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        CheckColumnsHeadersOfRiskRatingManagerExernalRiskRatingFeed();
        
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



function CheckColumnsHeadersOfRiskRatingManagerExernalRiskRatingFeed()
{
    Log.Message("Select 'External Risk Rating Feed' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnExternalRiskRatingFeed().Click();
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    Log.Message("Check if the 'Rating' column is displayed.");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChRating(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChRating(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Corresponding securities' column is displayed.");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChCorrespondingSecurities(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChCorrespondingSecurities(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Production final' column is displayed.");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChProductionFinal(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChProductionFinal(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Simulation final' column is displayed.");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChSimulationFinal(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvExternalRiskRatingFeed_ChSimulationFinal(), "VisibleOnScreen", cmpEqual, true);
} 