//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : Check if Add button is active for the All category in Simulation tab
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-252
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0252_Tit_Check_if_Add_button_is_active_for_the_All_category_in_Simulation_tab()
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
        
        //1- Click on Default Subcategories, in the toolbar check if the Add button is active.
        Log.Message("1- Click on Default Subcategories, in the toolbar check if the Add button is active and working properly.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories().Click();
        CheckIfAddButtonIsActiveAndWorkingProperly();
        
        //2- Click on Basic criteria, in the toolbar check if the Add button is active.
        Log.Message("2- Click on Basic criteria, in the toolbar check if the Add button is active and working properly.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        CheckIfAddButtonIsActiveAndWorkingProperly();
        
        //3- Click on External risk rating feed category, in the toolbar check if the Add button is active.
        Log.Message("3- Click on External risk rating feed category, in the toolbar check if the Add button is active and working properly.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnExternalRiskRatingFeed().Click();
        CheckIfAddButtonIsActiveAndWorkingProperly();
        
        //4- Click on Overwrite category, in the toolbar check if the Add button is active.
        Log.Message("4- Click on Overwrite category, in the toolbar check if the Add button is active and working properly.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        CheckIfAddButtonIsActiveAndWorkingProperly();
        
        //5- Click on Manual category, in the toolbar check if the Add button is active.
        Log.Message("5- Click on Manual category, in the toolbar check if the Add button is active and working properly.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnManualOverwrite().Click();
        CheckIfAddButtonIsActiveAndWorkingProperly();
        
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



function CheckIfAddButtonIsActiveAndWorkingProperly()
{
    Log.Message("Check if the 'Add' button is active.");
    if (!Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().WaitProperty("IsEnabled", true, 30000)){
        Log.Error("'Add' button was not active within 30 seconds.");
        return;
    }
    
    Log.Checkpoint("'Add' button was active.");
    
    Log.Message("Check if the 'Add' button is working properly", "Click on 'Add' button and verify if 'Risk Rating Criteria Editor' windows is displayed.");
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
    
    var maxWaitTime = 30000;
    var waitTime = 0;
    var isFound = false;
    do {
        isFound = Get_WinRiskRatingCriteriaEditor().Exists;
        Delay(100);
        waitTime += 100;
    } while (!isFound && waitTime < maxWaitTime)
    
    if (isFound){
        Log.Checkpoint("Risk Rating Criteria Editor window was displayed.");
        Get_WinRiskRatingCriteriaEditor_BtnCancel().Click();
    }
    else
        Log.Error("Risk Rating Criteria Editor window was not displayed within " + maxWaitTime + " milliseconds.");
}