//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions



/**
    Description : Check the production Final colomn contents in simulation and production view
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-257
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0257_Tit_Check_the_production_Final_colomn_contents_in_simulation_and_production_view()
{
    try {
        //PRECONDITIONS
        
        //In Risk Rating Manager windows select simulation and then on Default subcategories, select Canadian Bonds&Income Funds and validate if production final for this subcategory is different then zero
        var subcategoryNameInGrid = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0257_Criterion_SubcategoryNameInGrid", language + client);
        var subcategoryNameInCondition = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0257_Criterion_SubcategoryNameInCondition", language + client);
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0257_Criterion_Name", language + client);
        var criterionDescription = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0257_Criterion_Description", language + client);
        var criterionActiveStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0257_Criterion_ActiveStatus", language + client);
        var criterionOverwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0257_Criterion_OverwriteStatus", language + client);
        var criterionRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0257_Criterion_Rating", language + client);
        
        
        //STEPS
        
        //1- Go to the securities module, click on "Risk Rating Criteria"  button, in Risk Rating criteria window , click on SimulationTab
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //Go to the securities module,click on "Risk Rating Methods Manager"  button, in Risk Rating Methods Manager window
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Simulation Tab
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        Log.Message("Select 'Default subcategories'.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories().Click();
        
        Log.Message("Select 'Canadian Bonds&Income Funds' and validate if production final for this subcategory is different than zero");
        var subcategoryRowIndex = GetDefaultSubcategoryRowIndex(subcategoryNameInGrid);
        var subcategoryNbProductionFinal = GetDefaultSubcategoriesDisplayedNbOfProductionFinal(subcategoryRowIndex);
        if (!aqObject.CompareProperty(subcategoryNbProductionFinal, cmpNotEqual, 0, true, lmError)){
            Log.Error("Preconditions not met!");
            return;
        }
        
        
        //2- Add criterion
        Log.Message("Click on 'add' button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        
        //Fill fields
        CreateRiskRatingConditionFunction = "CreateRiskRatingCondition_SecuritiesHavingSubcategoryEqualTo('" + subcategoryNameInCondition + "')";
        SetCriterionAttributes(criterionName, criterionDescription, criterionActiveStatus, criterionOverwriteStatus, criterionRating, CreateRiskRatingConditionFunction);
        
        //Click on Save button.
        Log.Message("Click on 'Save' button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        
        //Make sure that only criterion14 is active in basic criteria and in overwrite criteria : The verification is performed in SetIscheckedForCriteriaInBasicCriteriaGrid function
        Log.Message("Make sure that only criterion14 is active in basic criteria and in overwrite criteria");
        SetIscheckedForCriteriaInBasicCriteriaGrid(false);
        SetIscheckedForCriteriaInOverwriteCriteriaGrid(false);
        SetIscheckedForCriteriaInOverwriteCriteriaGrid(true, criterionName);
        
        
        //Send to Production
        SendToProduction();
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //3- Execute SSH commands
        ExecuteDefaultSSHCommands();
        
        
        //4- Click on " Risk Rating Manager"  button, in the risk rating criteria  window , click on simulation tab then on Default subcategories, check if  the number displayed in production Final colomn is null for  Canadian Bonds & Income Funds  Subcategory
        
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        Log.Message("Select 'Default subcategories'.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories().Click();
        
        Log.Message("check if  the number displayed in production Final colomn is null for  Canadian Bonds & Income Funds  Subcategory");
        var subcategoryRowIndex = GetDefaultSubcategoryRowIndex(subcategoryNameInGrid);
        var subcategoryNbProductionFinal = GetDefaultSubcategoriesDisplayedNbOfProductionFinal(subcategoryRowIndex);
        aqObject.CompareProperty(subcategoryNbProductionFinal, cmpEqual, 0, true, lmError);
        
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
        RestoreRQS(null, criterionName, true, true, true);
    } 
}