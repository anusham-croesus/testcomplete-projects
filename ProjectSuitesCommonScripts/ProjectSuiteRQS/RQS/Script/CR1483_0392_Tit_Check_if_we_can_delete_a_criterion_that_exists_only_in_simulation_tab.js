//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Check if we can delete a criterion that exists only in simulation tab
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-392
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0392_Tit_Check_if_we_can_delete_a_criterion_that_exists_only_in_simulation_tab()
{
    try {
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0392_criterion_name", language + client);
        
        //Delete the criteria with the same name
        Delete_FilterCriterion(criterionName, vServerRQS);
        
        //Connect to croesus with sysadmin
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Pre-condition : Create the criteria
        Log.Message("Create Basic criterion '" + criterionName);
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
        SetCriterionAttributes(criterionName, null, null, null, null, 'CreateRiskRatingCondition_SecuritiesHavingSecurityCurrencyEqualToUSD()');
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //Step 1, 2 : Connect to croesus with sysadmin, Go to security module, click on Risk Rating Manager Button, Simulation Tab, Basic criteria
        
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        
        //Step 3 : Select a criterion and make sure that it not exists in Production Tab
        
        Log.Message("Click on 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        Log.Message("Select 'Basic criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex != null){
            Log.Error("Criterion '" + criterionName + "' found in the Basic criteria grid of the Production tab.");
            return;
        }
        
        
        //Step 4 : Select the criterion and click on the Delete button
        DeleteRiskIndexCriterion(criterionName, "basic");
        
        
        //Check if this criterion is deleted
        Log.Message("Check if the selected criterion is deleted is the Simulation tab.");
        
        Log.Message("Click on 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        Log.Message("Select 'Basic criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex != null){
            Log.Error("Criterion '" + criterionName + "' is not deleted in the Simulation tab..");
            return;
        }
        
        Log.Checkpoint("Criterion '" + criterionName + "' is deleted in the Simulation tab.");
                
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
        
        if (Log.ErrCount > 0)
            RestoreRQS(criterionName, null);
    }
}
