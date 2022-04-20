//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : risk rating criteria window is opened by the " Risk Rating Manager" button
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-211
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0211_Tit_risk_rating_criteria_window_is_opened_by_the_Risk_Rating_Manager_button()
{
    try {
        var riskRatingCriteriaManagerWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingCriteriaManagerWindowTitle", language + client);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);

        //In securities module click on "Risk Rating  Manager"  button
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("In securities module click on 'Risk Rating Manager' button.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Check if Risk Rating criteria window is opened.");
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Exists", cmpEqual, true);
        
        if (Get_WinRiskRatingCriteriaManager().Exists){
            Log.Message("Check if Risk Rating criteria window title is the expected.");
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Title", cmpEqual, riskRatingCriteriaManagerWindowExpectedTitle);
            
            //Close Risk Rating Criteria Manager window
            Get_WinRiskRatingCriteriaManager_BtnClose().Click();
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