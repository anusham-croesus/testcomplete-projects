//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : Check if The Add & Edit button opens the  Window that allow the user to create or modify a given criteria.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-215
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0215_Tit_Chek_if_The_Add_Edit_button_opens_the_window_that_allow_the_user_to_create_or_modify_a_criteria()
{
    try {
        var criteriaEditorWindowAddModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowAddModeTitle", language + client);
        var criteriaEditorWindowEditModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowEditionModeTitle", language + client);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //In the securities modul click on "Risk Rating  Manager"  button, click on Simulation Tab
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("Open the Risk Rating Criteria Manager window.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //1- In the  toolbar of Risk Rating Criteria window click on Add button, check if  the Add a criterion  Window is displayed
        Log.Message("Click on Add button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        CheckIfRiskRatingCriteriaEditorWindowTitleIsTheExpected(criteriaEditorWindowAddModeExpectedTitle);
        
        //2- In the  toolbar of Risk Rating Criteria window click on Edit button, check if  the Edit a Criterion Window is displayed
        Log.Message("Click on Edit button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        CheckIfRiskRatingCriteriaEditorWindowTitleIsTheExpected(criteriaEditorWindowEditModeExpectedTitle);
        
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


function CheckIfRiskRatingCriteriaEditorWindowTitleIsTheExpected(criteriaEditorWindowExpectedTitle)
{
    Log.Message("Check if Risk Rating Criteria Editor Window is displayed.");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true);
        
    if (Get_WinRiskRatingCriteriaEditor().Exists){
        Log.Message("Check if Risk Rating Criteria Editor window title is the expected.");
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowExpectedTitle);
            
        //Close Risk Rating Criteria Editor window
        Get_WinRiskRatingCriteriaEditor_BtnCancel().Click();
    }
}