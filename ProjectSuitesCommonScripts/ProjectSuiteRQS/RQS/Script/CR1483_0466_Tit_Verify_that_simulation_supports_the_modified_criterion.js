//USEUNIT CR1483_Common_functions



/**
    Description : Verify that simulation supports the modified criterion
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-466
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0466_Tit_Verify_that_simulation_supports_the_modified_criterion()
{
    try {
        var criterion_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0466_BasicCriterion_Name", language + client);
        var criterion_description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0466_BasicCriterion_Description", language + client);
        var criterion_activeStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0466_BasicCriterion_ActiveStatus", language + client);
        var criterion_overwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0466_BasicCriterion_OverwriteStatus", language + client);
        var criterion_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0466_BasicCriterion_Rating", language + client);
        var criterion_updateTypeClassValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0466_BasicCriterionTypeClassValue", language + client);
        
        //Delete criterion with the same name 
        Delete_FilterCriterion(criterion_name, vServerRQS);
        
        //1.1- Connect to croesus with sysadmin.Go to the securities module, click on Risk Rating Manager Button then Simulation Tab.
        Log.Message("1.1 : Connect to croesus with sysadmin. Go to the securities module, click on Risk Rating Manager Button then Simulation Tab.");
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //1.2- Create Basic criteria
        Log.Message("1.2 : Create basic criterion : " + criterion_name);
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
        
        SetCriterionAttributes(criterion_name, criterion_description, criterion_activeStatus, criterion_overwriteStatus, criterion_rating);
        
        //Criterion Condition
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemIndustryCode", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEnergy", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
        
        //1.3- Click on Save button.
        Log.Message("1.3 : Click on 'Save' button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        //1.4- Click on Simulate all methods button.
        Log.Message("1.4: Click on Simulate all methods button.");
        Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods().Click();
        
        //1.5- Note the number displayed in Simulate and Simulate Final column for this criteria.
        Log.Message("1.5 :Note the number displayed in Simulate and Simulate Final column for this criteria.");
        
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion_name);
        if (criterionRowIndex == null)
            return Log.Error("Criterion '" + criterion_name + "' not found in the grid.");
        
        var windowLeft = Get_WinRiskRatingCriteriaManager().get_Left();
        var windowWidth = Get_WinRiskRatingCriteriaManager().get_Width();
        Get_WinRiskRatingCriteriaManager().set_Left(0);
        Get_WinRiskRatingCriteriaManager().set_Width(Sys.Desktop.Width);
        
        var nameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
        var simulationColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulation().WPFControlOrdinalNo;
        var simulationFinalColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulationFinal().WPFControlOrdinalNo;
        
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        var nbOfSimulation = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationColumnIndex], 10).WPFControlText;
        var nbOfSimulationFinal = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationFinalColumnIndex], 10).WPFControlText;
        
        Get_WinRiskRatingCriteriaManager().set_Left(windowLeft);
        Get_WinRiskRatingCriteriaManager().set_Width(windowWidth);
        
        Log.Message("Number of 'Simulation'  for criterion '" + criterion_name + "' is : " + nbOfSimulation);
        Log.Message("Number of 'Simulation final' for criterion '" + criterion_name + "' is : " + nbOfSimulationFinal);
        
        
        //2.1- Edit criteria378 and change the Condition to : List of securities having industry code equal to Energy and having type/class(subcategory) equal to 330.
        Log.Message("2.1 : Edit criteria378 and change the Condition to : List of securities having industry code equal to Energy and having type/class(subcategory) equal to 330.");
        criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", nameColumnIndex], 10).Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        
        //Update Criterion Condition
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemTypeClass", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).DblClick();    
        Sys.Keys(criterion_updateTypeClassValue);
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
        
        //Click on Save button.
        Log.Message("Click on 'Save' button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        //2.3- Click on Simulate all methods button.
        Log.Message("2.3 : Click on Simulate all methods button.");
        Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods().Click();
        
        //2.4- Check if  the number displayed in Simulate and Simulate Final column for this criteria is lower.
        Log.Message("2.4 : Check if  the number displayed in Simulate and Simulate Final column for this criteria is lower.");
        
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion_name);
        if (criterionRowIndex == null)
            return Log.Error("Criterion '" + criterion_name + "' not found in the grid.");
        
        var windowLeft = Get_WinRiskRatingCriteriaManager().get_Left();
        var windowWidth = Get_WinRiskRatingCriteriaManager().get_Width();
        Get_WinRiskRatingCriteriaManager().set_Left(0);
        Get_WinRiskRatingCriteriaManager().set_Width(Sys.Desktop.Width);
        
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        var nbOfSimulationNew = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationColumnIndex], 10).WPFControlText;
        var nbOfSimulationFinalNew = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationFinalColumnIndex], 10).WPFControlText;
        
        Get_WinRiskRatingCriteriaManager().set_Left(windowLeft);
        Get_WinRiskRatingCriteriaManager().set_Width(windowWidth);
        
        Log.Message("New number of 'Simulation'  for criterion '" + criterion_name + "' is : " + nbOfSimulationNew);
        if (VarToInt(nbOfSimulationNew) < VarToInt(nbOfSimulation))
            Log.Checkpoint("The new number of 'Simulation' (" + nbOfSimulationNew + ") is lower than the former one (" + nbOfSimulation +"), this is expected.");
        else
            Log.Error("The new number of 'Simulation' (" + nbOfSimulationNew + ") is not lower than the former one (" + nbOfSimulation +"), this is unexpected.");
        
        Log.Message("New number of 'Simulation final' for criterion '" + criterion_name + "' is : " + nbOfSimulationFinalNew);
        if (VarToInt(nbOfSimulationFinalNew) < VarToInt(nbOfSimulationFinal))
            Log.Checkpoint("The new number of 'Simulation final' (" + nbOfSimulationFinalNew + ") is lower than the former one (" + nbOfSimulationFinal +"), this is expected.");
        else
            Log.Error("The new number of 'Simulation final' (" + nbOfSimulationFinalNew + ") is not lower than the former one (" + nbOfSimulationFinal +"), this is unexpected.");
        
        //Fermer Croesus
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
		RestoreRQS(criterion_name);
    }
}
