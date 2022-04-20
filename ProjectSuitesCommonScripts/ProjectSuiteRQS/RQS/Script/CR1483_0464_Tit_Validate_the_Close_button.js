//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : Validate the Close button
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-464
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0464_Tit_Validate_the_Close_button()
{
    try {       
        //Connect to croesus with sysadmin
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //In the securities module click on " Risk Rating Manager " button
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("In securities module click on 'Risk Rating Manager' button.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        // Click on Simulation Tab
        Log.Message("Click on Simulation tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Click on Close button, check if Risk Rating Criteria window is closed
        Log.Message("Click on Close button and check if Risk Rating Criteria window is closed.");
        var WinRiskRatingCriteriaManagerUid = VarToStr(Get_WinRiskRatingCriteriaManager().Uid);
        Log.Message("WinRiskRatingCriteriaManagerUid = " + WinRiskRatingCriteriaManagerUid);
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", WinRiskRatingCriteriaManagerUid);
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Exists", cmpEqual, false);
        
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
