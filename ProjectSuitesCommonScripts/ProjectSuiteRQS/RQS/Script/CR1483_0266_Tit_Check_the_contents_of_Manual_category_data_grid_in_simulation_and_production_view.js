//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description : Check if the  associated grid for the Manual category in (simulation and production view)
                  contains the following columns : Rating, Corresponding securities
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-266
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0266_Tit_Check_the_contents_of_Manual_category_data_grid_in_simulation_and_production_view()
{
    try {
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        
        //****** For Simulation view ********
        Log.Message("****** For Simulation view ********");
        
        //Click on Simulation Tab then Manual category and check columns existence.
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        CheckColumnsHeadersOfRiskRatingManagerManualCategory();
        
        
        //****** For Production view ********
        Log.Message("****** For Production view ********");
        
        //Click on Production Tab then Manual category and check columns existence.
        Log.Message("Go to 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        CheckColumnsHeadersOfRiskRatingManagerManualCategory();
        
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



function CheckColumnsHeadersOfRiskRatingManagerManualCategory()
{
    Log.Message("Select 'Manual' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnManualOverwrite().Click();
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    //Les fonction Get des entêtes de colonne recherche le composant par le nom affiché
    //Donc si le coposant existe et est visible alors la colonne est affichée
    
    Log.Message("Check if the 'Rating' column is displayed.");
    if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChRating(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChRating(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Corresponding securities' column is displayed.");
    if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChCorrespondingSecurities(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChCorrespondingSecurities(), "VisibleOnScreen", cmpEqual, true);
}