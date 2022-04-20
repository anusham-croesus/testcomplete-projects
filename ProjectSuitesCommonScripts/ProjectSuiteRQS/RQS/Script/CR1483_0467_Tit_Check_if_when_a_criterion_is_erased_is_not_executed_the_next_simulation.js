//USEUNIT CR1483_Common_functions



/**
    Description : Check if when a criterion is erased is not executed the next simulation
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-467
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0467_Tit_Check_if_when_a_criterion_is_erased_is_not_executed_the_next_simulation()
{
    try {
        var criterion1_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0467_BasicCriterion1_Name", language + client);
        var criterion1_description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0467_BasicCriterion1_Description", language + client);
        var criterion1_activeStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0467_BasicCriterion1_ActiveStatus", language + client);
        var criterion1_overwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0467_BasicCriterion1_OverwriteStatus", language + client);
        var criterion1_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0467_BasicCriterion1_Rating", language + client);
        
        var criterion2_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0467_BasicCriterion2_Name", language + client);
        var criterion2_description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0467_BasicCriterion2_Description", language + client);
        var criterion2_activeStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0467_BasicCriterion2_ActiveStatus", language + client);
        var criterion2_overwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0467_BasicCriterion2_OverwriteStatus", language + client);
        var criterion2_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0467_BasicCriterion2_Rating", language + client);
        var criterion2_subcategory = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0467_BasicCriterion2_Subcategory", language + client);
        
        
        //Delete criterion with the same name 
        Delete_FilterCriterion(criterion1_name, vServerRQS);
        Delete_FilterCriterion(criterion2_name, vServerRQS);
        
        //1.1- Connect to croesus with sysadmin.Go to the securities module, click on Risk Rating Manager Button then Simulation Tab.
        Log.Message("1.1 : Connect to croesus with sysadmin. Go to the securities module, click on Risk Rating Manager Button then Simulation Tab.");
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Disable all other criteria
        //SetIscheckedForCriteriaInBasicCriteriaGrid(false);
        //SetIscheckedForCriteriaInOverwriteCriteriaGrid(false);
        
        //1.2- Create Basic criteria
        Log.Message("1.2.a : Create basic criterion : " + criterion1_name);
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
        
        SetCriterionAttributes(criterion1_name, criterion1_description, criterion1_activeStatus, criterion1_overwriteStatus, criterion1_rating, "CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToCAD()");
        
        Log.Message("Click on 'Save' button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        //Check if criterion 1 was created
        if (GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion1_name) == null)
            return Log.Error("Criterion '" + criterion1_name + "' was not created.");
        
        Log.Checkpoint("Criterion '" + criterion1_name + "' was created.");
        
        Log.Message("1.2.b : Create basic criterion : " + criterion2_name);
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
        
        SetCriterionAttributes(criterion2_name, criterion2_description, criterion2_activeStatus, criterion2_overwriteStatus, criterion2_rating);
        
        CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToCAD();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
        CreateRiskRatingCondition_SecuritiesHavingSubcategoryEqualTo(criterion2_subcategory);
        
        Log.Message("Click on 'Save' button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        //Check if criterion 2 was created
        if (GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion2_name) == null)
            return Log.Error("Criterion '" + criterion2_name + "' was not created.");
        
        Log.Checkpoint("Criterion '" + criterion2_name + "' was created.");
        
        
        //3- Click on Simulate all methods button.
        Log.Message("3 : Click on Simulate all methods button.");
        Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods().Click();
        
        
        //4- Note the number displayed in Simulate column for this criteria.
        Log.Message("4 : Get the number displayed in 'Simulation' column for criteria '" + criterion1_name + "' and '" + criterion2_name + "'");
        
        var windowLeft = Get_WinRiskRatingCriteriaManager().get_Left();
        var windowWidth = Get_WinRiskRatingCriteriaManager().get_Width();
        Get_WinRiskRatingCriteriaManager().set_Left(0);
        Get_WinRiskRatingCriteriaManager().set_Width(Sys.Desktop.Width);
        
        var simulationColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulation().WPFControlOrdinalNo;
        
        //For Criterion 1
        var criterion1RowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion1_name);
        if (criterion1RowIndex == null)
            return Log.Error("Criterion '" + criterion1_name + "' not found in the grid.");
        
        var criterion1Row = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterion1RowIndex], 10);
        var criterion1_nbOfSimulation = VarToInt(criterion1Row.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationColumnIndex], 10).WPFControlText);
        
        Log.Message("Number of 'Simulation'  for criterion '" + criterion1_name + "' is : " + criterion1_nbOfSimulation);
        
        
        //For Criterion 2
        var criterion2RowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion2_name);
        if (criterion2RowIndex == null)
            return Log.Error("Criterion '" + criterion2_name + "' not found in the grid.");
        
        var criterion2Row = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterion2RowIndex], 10);
        var criterion2_nbOfSimulation = VarToInt(criterion2Row.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationColumnIndex], 10).WPFControlText);
        
        Log.Message("Number of 'Simulation'  for criterion '" + criterion2_name + "' is : " + criterion2_nbOfSimulation);
        
        
        //5- Delete criteria 3792 and click on Simulate All Methods button.
        Log.Message("5 : Delete criteria 3792 and click on Simulate All Methods button.");
        DeleteRiskIndexCriterion(criterion2_name, "basic");
        
        Log.Message("Click on 'Simulate all' methods button.");
        Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods().Click();
        
        
        //6- Check if the number displayed in Simulate column for criteria 3791 is the same whith the number noted for simulate column( criteria 3791) in step 4.
        Log.Message("6 : Check if the number displayed in Simulate column for criteria 3791 is the same whith the number noted for simulate column( criteria 3791) in step 4.");
        
        var criterion1RowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion1_name);
        if (criterion1RowIndex == null)
            return Log.Error("Criterion '" + criterion1_name + "' not found in the grid.");
        
        var criterion1Row = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterion1RowIndex], 10);
        var criterion1_nbOfSimulationNew = VarToInt(criterion1Row.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationColumnIndex], 10).WPFControlText);
        
        Log.Message("New number of 'Simulation'  for criterion '" + criterion1_name + "' is : " + criterion1_nbOfSimulationNew);        
        
        //Check actual values of Simulation
        CheckEquals(criterion1_nbOfSimulationNew, criterion1_nbOfSimulation, "The number of 'Simulation' for criterion '" + criterion1_name + "'");
        
        Get_WinRiskRatingCriteriaManager().set_Left(windowLeft);
        Get_WinRiskRatingCriteriaManager().set_Width(windowWidth);
        
        //Fermer Croesus
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
		RestoreRQS([criterion1_name, criterion2_name]);
    }
}
