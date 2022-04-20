//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Check that the column "Modified" displays the last date modification of the criterion (for Basic Criteria).
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-442
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0442_Tit_Check_that_the_column_Modified_displays_the_last_date_modification_of_the_criterion_BasicCriteria()
{
    var basicCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereCAD", language + client);
    var basicCriterionUpdatedName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0442_Criterion1", language + client);
    CR1483_0442_Tit_Check_that_the_column_Modified_displays_the_last_date_modification_of_the_criterion(basicCriterionName, basicCriterionUpdatedName, "basic");
}





function CR1483_0442_Tit_Check_that_the_column_Modified_displays_the_last_date_modification_of_the_criterion(criterionName, criterionUpdatedName, BasicOrOverwriteCriteria)
{
    try {
        if (GetIndexOfItemInArray(["basic", "overwrite"], BasicOrOverwriteCriteria) == -1){
            Log.error(BasicOrOverwriteCriteria + " not expected for the BasicOrOverwriteCriteria parameter.");
            return;
        }
        
        //Delete the criteria with the same name
        Delete_FilterCriterion(criterionUpdatedName, vServerRQS);
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        
        //go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        
        //Open the risk rating criteria manager window, click on Simulation Tab then Default category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();

        //Select the Rating Method.
        if (BasicOrOverwriteCriteria == "overwrite"){
            Log.Message("Select 'Overwrite criteria' rating method.");
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        }
        else {
            Log.Message("Select 'Basic criteria' rating method.");
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        }
        
        
        //Select a criterion
        Log.Message("Select the criterion : " + criterionName);
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10); 
        criterionRow.Click();
        
        //Click on Edit button
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        Get_WinRiskRatingCriteriaEditor_TxtName().Keys(criterionUpdatedName);
        
        var criterionExpectedModifiedDate = GetCurrentDateString();
        
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        
        //Check if " Modified" colomn displays system date.
        
        //Select the Rating Method.
        if (BasicOrOverwriteCriteria == "overwrite"){
            Log.Message("Select 'Overwrite criteria' rating method.");
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        }
        else {
            Log.Message("Select 'Basic criteria' rating method.");
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        }
        
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionUpdatedName);
        
        Log.Message("Check if the 'Modified' field is updated.");
        aqObject.CompareProperty(GetBasicOverwriteCriteriaDisplayedModified(criterionRowIndex), cmpEqual, criterionExpectedModifiedDate, true, lmError);
        
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
        
        //Restore the criterion name
        var SQLQueryString = "UPDATE B_MSG SET DESCRIPTION = '" + criterionName + "' WHERE DESCRIPTION = '" + criterionUpdatedName + "'";
        Execute_SQLQuery(SQLQueryString, vServerRQS);
    } 
}