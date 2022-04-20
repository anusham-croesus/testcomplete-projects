//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : Check if Upper Toolbar is activated for the Overwrite and Simple Criteria categories
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-437
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0437_Tit_Check_if_Upper_Toolbar_is_activated_for_the_Overwrite_and_Simple_Criteria_categories()
{
    try {
        Log.Message("Le bouton Edit (Modifier) n'est pas des fois activé. Numéro JIRA à ajouter lorsque Malika aura ouvert le bug.");
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //- Go to the securities module, click on Risk Rating Manager then Simulation tab.
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("In securities module click on 'Risk Rating Manager' button.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Click on Simulation tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        // - Click on Overwrite Criteria, check if  Add/Edit/Copy and Delete buttons are activated.
        Log.Message("Click on Overwrite Criteria, check if Add/Edit/Copy and Delete buttons are activated.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        CheckIfButtonsAreActivated();
        
        //- Click on Basic Criteria categories, check if  Add/Edit / Copy and Delete buttons are activated.
        Log.Message("Click on Basic Criteria, check if Add/Edit/Copy and Delete buttons are activated.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
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



function CheckIfObjectIsEnabledPropertyIsExpected(object, isEnabledExpectedValue, objectName)
{
    Log.Message("Check if '" + objectName + "' IsEnabled property is : " + isEnabledExpectedValue);
    aqObject.CheckProperty(object, "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(object, "IsEnabled", cmpEqual, isEnabledExpectedValue);
}



function CheckIfButtonsAreActivated()
{
    var arrayOfButtonsToBeChecked = new Array();
    arrayOfButtonsToBeChecked.push([Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd(), true, "Add button"]);
    arrayOfButtonsToBeChecked.push([Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit(), true, "Edit button"]);
    arrayOfButtonsToBeChecked.push([Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnCopy(), true, "Copy button"]);
    arrayOfButtonsToBeChecked.push([Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnDelete(), true, "Delete button"]);
    
    for (var i = 0; i < arrayOfButtonsToBeChecked.length; i++)
        CheckIfObjectIsEnabledPropertyIsExpected(arrayOfButtonsToBeChecked[i][0], arrayOfButtonsToBeChecked[i][1], arrayOfButtonsToBeChecked[i][2]);
}