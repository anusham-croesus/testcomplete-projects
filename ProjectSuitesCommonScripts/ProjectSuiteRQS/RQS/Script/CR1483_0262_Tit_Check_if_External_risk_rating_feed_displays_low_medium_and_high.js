//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions



/**
    Description : Check if External risk rating feed displays low, medium and high 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-262
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0262_Tit_Check_if_External_risk_rating_feed_displays_low_medium_and_high()
{
    try {
        var lowRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Low", language + client);
        var mediumRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Medium", language + client);
        var highRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_High", language + client);
        var expectedRatingValues = [lowRating, mediumRating, highRating];
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Simulation Tab then External risk Rating feed and check columns existence.
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Get All displayed Rating values in External Risk Rating Feed grid
        var displayedRatingValues = GetAllDisplayedRatingValuesInExternalRiskRatingFeed();
        
        //Check if all the expected Rating values were displayed
        Log.Message("Check if all the expected Rating values '" + expectedRatingValues + "' were displayed.")
        
        for (var i = 0; i < expectedRatingValues.length; i++){
            if (GetIndexOfItemInArray(displayedRatingValues, expectedRatingValues[i]) == -1)
                Log.Error(expectedRatingValues[i] + " was not displayed");
            else
                Log.Checkpoint(expectedRatingValues[i] + " was displayed");
        }
        
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