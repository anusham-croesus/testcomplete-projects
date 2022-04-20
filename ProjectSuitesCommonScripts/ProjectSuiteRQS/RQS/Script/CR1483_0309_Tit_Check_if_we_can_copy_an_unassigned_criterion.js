//USEUNIT CR1483_0308_Tit_Check_if_we_can_copy_an_assigned_criterion
//USEUNIT CR1483_0297_Tit_Check_that_you_can_change_a_Name_for_an_unassigned_criterion



/**
    Description : Check if we can copy an unassigned criterion
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-309
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0309_Tit_Check_if_we_can_copy_an_unassigned_criterion()
{
    try {
        var riskRatingCriteriaManagerWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingCriteriaManagerWindowTitle", language + client);
        var fromCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0309_from_criterion_name", language + client);
        var criterionCopyName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0309_criterion_copy_name", language + client);
        
        //Delete the criteria with the same name
        Delete_FilterCriterion(fromCriterionName, vServerRQS);
        Delete_FilterCriterion(criterionCopyName, vServerRQS);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Step 2 : Select a criterion and validate taht Production, Production Final, Simulation, and Simulation Final are null
        if (!CreateBasicCriterionAndCheckIfProductionSimulationAreNull(fromCriterionName))
            return;
        
        //Step 3 : Rename the criteria and click on save button, check if the modified criteria is saved.
        CheckCopyCriterion(fromCriterionName, criterionCopyName);
        
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
        RestoreRQS([fromCriterionName, criterionCopyName]);
    }
}
