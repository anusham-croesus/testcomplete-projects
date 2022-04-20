//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Check if we can delete a criterion that is in both simulation tab and production tab
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-391
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0391_Tit_Check_if_we_can_delete_a_criterion_that_is_in_both_simulation_tab_and_production_tab()
{
    try {
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0391_criterion_name", language + client);
        
        //Delete the criteria with the same name
        Delete_FilterCriterion(criterionName, vServerRQS);
        
        //Connect to croesus with sysadmin
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Pre-conditions : Create the criteria and Send it to Production
        Log.Message("Create Basic criterion '" + criterionName + "' and Send it to Production.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
        SetCriterionAttributes(criterionName, null, null, null, null, 'CreateRiskRatingCondition_SecuritiesHavingSecurityCurrencyEqualToUSD()');
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        SendToProduction();
        
        //Get the criterion Production ID
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        var criterionProductionID = null;
        var itemsBasicOverwriteCriteria = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).Items;
        for (var i = 0; i < itemsBasicOverwriteCriteria.Count; i++){
            if (criterionName == itemsBasicOverwriteCriteria.Item(i).DataItem.Name){
                criterionProductionID = itemsBasicOverwriteCriteria.Item(i).DataItem.CriteriaId;
                break;
            }
        }
        
        if (criterionProductionID == null){
            Log.Error("Unable to get criterion '" + criterionName + "' ID, this is unexpected.");
            return;
        }
        
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //Step 1 : Connect to croesus with sysadmin, Go to security module, click on Risk Rating Manager Button, Simulation Tab, Basic criteria
        
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        
        //Step 2 : Select a criterion and make sure that is exist in Production Tab
        
        Log.Message("Click on 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        Log.Message("Select 'Basic criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex == null){
            Log.Error("Criterion '" + criterionName + "' not found in the Basic criteria grid of the Production tab.");
            return;
        }
        
        
        //Step 3 : Select the criterion and click on the Delete button
        DeleteRiskIndexCriterion(criterionName, "basic");
        
        
        //Step 4 : Check if this criterion is deleted
        Log.Message("Check if this criterion is deleted is the Simulation tab.");
        
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
        
        
        //Step 5 : Click on Send to production
        SendToProduction();
        
        
        //Step 6 : Click on production tab and check if the deleted criterion has disappeared in this tab
        Log.Message("Click on production tab and check if the deleted criterion has disappeared in this tab");
        
        Log.Message("Click on 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        Log.Message("Select 'Basic criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex != null){
            Log.Error("Criterion '" + criterionName + "' has not disappeared in the Production tab.");
            return;
        }
        
        Log.Checkpoint("Criterion '" + criterionName + "' has disappeared in the Production tab.");
        
        
        //Step 7 : Check if this criterion is not deleted in  B_CRIT_RISKRATING
        Log.Message("Validate that the criterion '" + criterionName + "' (ID = " + criterionProductionID + ") is not deleted in  B_CRIT_RISKRATING");
        var queryString = "select count(*) as nbCriteria from B_CRIT_RISKRATING where CRIT_ID = " + criterionProductionID;
        var nbCriteria = Execute_SQLQuery_GetField(queryString, vServerRQS, "nbCriteria");
        CheckEquals(nbCriteria, 1, "Number of criteria with ID = " + criterionProductionID + " in the B_CRIT_RISKRATING table");
        
        
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
            RestoreRQS(criterionName, null, true);
    }
}
