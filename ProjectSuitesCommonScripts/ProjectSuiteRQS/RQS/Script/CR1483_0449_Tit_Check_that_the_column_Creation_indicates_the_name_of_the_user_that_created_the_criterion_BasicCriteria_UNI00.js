//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions



/**
    Description : Check that the column Creation indicates the name of the user that created the criterion
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-449
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0449_Tit_Check_that_the_column_Creation_indicates_the_name_of_the_user_that_created_the_criterion_BasicCriteria_UNI00()
{
    try {
        var sysAdminUsername = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        var sysAdminPassword = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
        var expectedCreatedByValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "UNI00_Name", language + client);
        var basicCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0449_Criterion1", language + client);
        
        CR1483_0449_Tit_Check_that_the_column_Creation_indicates_the_name_of_the_user_that_created_the_criterion_BasicCriteria(sysAdminUsername, sysAdminPassword, expectedCreatedByValue, basicCriterionName);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        //Delete the criteria
        RestoreRQS(basicCriterionName, null, true);
        //Delete_FilterCriterion(basicCriterionName, vServerRQS);
    } 
}



function CR1483_0449_Tit_Check_that_the_column_Creation_indicates_the_name_of_the_user_that_created_the_criterion_BasicCriteria(sysAdminUsername, sysAdminPassword, expectedCreatedByValue, basicCriterionName)
{
    //Delete the criteria with the same name
    Delete_FilterCriterion(basicCriterionName, vServerRQS);
    
    //Login and go to Security module
    Login(vServerRQS, sysAdminUsername, sysAdminPassword, language);
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    
    //Open the risk rating criteria manager window, click on Simulation Tab
    Log.Message("Open the Risk Rating Criteria Manager window.");
    Get_SecuritiesBar_BtnRiskRatingManager().Click();
    Log.Message("Go to 'Simulation' tab.");
    Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
    
    //Select Basic criteria rating method
    Log.Message("Select 'Basic criteria' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    
    //Créer le critère
    Log.Message("Create the criterion : " + basicCriterionName);
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
    
    Get_WinRiskRatingCriteriaEditor_TxtName().Keys(basicCriterionName);
    Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkActive().set_IsChecked(true);
    Get_WinRiskRatingCriteriaEditor_GrpRating_RdoLow().set_IsChecked(true);
    
    CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToUSD();
    
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
    
    //Send to Production
    SendToProduction();
    
    //Click on Production tab
    Log.Message("Go to 'Production' tab.");
    Get_WinRiskRatingCriteriaManager_TabProduction().Click();
    
    //Click on Basic criteria.
    Log.Message("Click on Basic criteria.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    
    //Check if the "Created by" colomn of the criterion displays the expected value
    var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(basicCriterionName);
    var displayedCreatedByValue = GetBasicOverwriteCriteriaDisplayedCreatedBy(criterionRowIndex);
    aqObject.CompareProperty(displayedCreatedByValue, cmpEqual, expectedCreatedByValue, true, lmError);
    
    //Close Risk Rating Criteria Manager window
    Get_WinRiskRatingCriteriaManager_BtnClose().Click();
    
    //Close Croesus
    Close_Croesus_X();
}