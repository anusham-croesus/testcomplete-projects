//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : Check if the data grid for the Default Criteria categories(Simulation and Production view) contains
                  the following columns : Subcategory, Rating, Corresponding securities, Production Final and Simulation Final
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-251
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0251_Tit_Check_the_contents_of_data_grid_for_the_Default_Criteria_categories_Simulation_and_Production_view()
{
    try {
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Simulation Tab then Default category and check columns existence.
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        CheckColumnsHeadersOfRiskRatingManagerDefaultCategory();
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //Open the risk rating criteria manager window, click on Production Tab then Default category and check columns existence.
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        CheckColumnsHeadersOfRiskRatingManagerDefaultCategory();
        
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



function CheckColumnsHeadersOfRiskRatingManagerDefaultCategory()
{
    Log.Message("Select 'Default subcategories' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories().Click();
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    Log.Message("Check if the 'Subcategory' column is displayed.");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChSubcategory(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChSubcategory(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Rating' column is displayed.");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChRating(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChRating(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Corresponding securities' column is displayed.");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChCorrespondingSecurities(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChCorrespondingSecurities(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Production final' column is displayed.");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChProductionFinal(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChProductionFinal(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Simulation final' column is displayed.");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChSimulationFinal(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChSimulationFinal(), "VisibleOnScreen", cmpEqual, true);
} 