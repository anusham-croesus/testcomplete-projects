//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_0215_Tit_Chek_if_The_Add_Edit_button_opens_the_window_that_allow_the_user_to_create_or_modify_a_criteria



/**
    Description : Check if the Copy button opens a dialog window that allow the user to copy and rename a selected criteria.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-216
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0216_Tit_Check_if_the_Copy_button_opens_Risk_Rating_Method_window_that_allow_the_user_to_copy_a_criteria()
{
    try {
        var criteriaEditorWindowCopyModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowCopyModeTitle", language + client);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);

        //In the securities module click on "Risk Rating Manager"  button,click on Simulation Tab, in the  toolbar of Risk Rating Manager window click on Copy button, check if Copy a criterion Window is displayed
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("Open the Risk Rating Criteria Manager window.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("Click on Copy button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnCopy().Click();
        
        CheckIfRiskRatingCriteriaEditorWindowTitleIsTheExpected(criteriaEditorWindowCopyModeExpectedTitle);
        
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