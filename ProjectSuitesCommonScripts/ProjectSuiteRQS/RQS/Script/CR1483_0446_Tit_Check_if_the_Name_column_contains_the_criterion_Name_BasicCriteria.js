//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Check if the Name column contains the criterion Name (for Basic Criteria)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-446
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0446_Tit_Check_if_the_Name_column_contains_the_criterion_Name_BasicCriteria()
{
    CR1483_0446_Tit_Check_if_the_Name_column_contains_the_criterion_Name("basic");
}



function CR1483_0446_Tit_Check_if_the_Name_column_contains_the_criterion_Name(BasicOrOverwriteCriteria)
{
    if (GetIndexOfItemInArray(["basic", "overwrite"], BasicOrOverwriteCriteria) == -1){
        Log.error(BasicOrOverwriteCriteria + " not expected for the BasicOrOverwriteCriteria parameter.");
        return;
    }
        
    try {
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0446_Criterion1", language + client);
        var criterionDescription = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0446_Criterion1Description", language + client);
        var criterionActiveStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0446_ActiveStatus", language + client);
        var criterionOverwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0446_OverwriteStatus", language + client);
        var criterionRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0446_Rating", language + client);
        
        //Delete the criteria with the same names
        Delete_FilterCriterion(criterionName, vServerRQS);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
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
        
        //Créer le critère
        Log.Message("Create the criterion : " + criterionName);
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        
        //Fill fields
        SetCriterionAttributes(criterionName, criterionDescription, criterionActiveStatus, criterionOverwriteStatus, criterionRating, "CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToCAD()");
        
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        //Send to Production
        SendToProduction();
        
        //Click on Production tab
        Log.Message("Go to 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        //Select the Rating Method.
        if (BasicOrOverwriteCriteria == "overwrite"){
            Log.Message("Select 'Overwrite criteria' rating method.");
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        }
        else {
            Log.Message("Select 'Basic criteria' rating method.");
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        }
        
        //Check if criterion is displayed in Basic/Overwrite criteria grid
        var isCriterionDisplayed = CheckIfCriterionIsDisplayedInBasicOverwriteCriteriaGrid(criterionName);
        aqObject.CompareProperty(isCriterionDisplayed, cmpEqual, true, true, lmError);
        
        
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
        
        if (BasicOrOverwriteCriteria == "overwrite")
            RestoreRQS(null, criterionName, true);
        else
            RestoreRQS(criterionName, null, true);
    } 
}