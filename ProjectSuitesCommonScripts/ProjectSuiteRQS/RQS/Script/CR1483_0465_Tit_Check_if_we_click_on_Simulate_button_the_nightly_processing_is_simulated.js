//USEUNIT CR1483_Common_functions



/**
    Description : Check if we click on Simulate button, the nightly processing is simulated
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-465
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0465_Tit_Check_if_we_click_on_Simulate_button_the_nightly_processing_is_simulated()
{
    try {
        var criterion1_nameInSecurities = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion1_NameInSecurities", language + client);
        var criterion1_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion1_Name", language + client);
        var criterion1_description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion1_Description", language + client);
        var criterion1_activeStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion1_ActiveStatus", language + client);
        var criterion1_overwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion1_OverwriteStatus", language + client);
        var criterion1_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion1_Rating", language + client);
        var criterion1_subcategory = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion1_Subcategory", language + client);
        
        var criterion2_nameInSecurities = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion2_NameInSecurities", language + client);
        var criterion2_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion2_Name", language + client);
        var criterion2_description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion2_Description", language + client);
        var criterion2_activeStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion2_ActiveStatus", language + client);
        var criterion2_overwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion2_OverwriteStatus", language + client);
        var criterion2_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion2_Rating", language + client);
        var criterion2_subcategory = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion2_Subcategory", language + client);
        var criterion2_symbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0465_BasicCriterion2_Symbol", language + client);
        
        
        //Delete criterion with the same name 
        Delete_FilterCriterion(criterion1_nameInSecurities, vServerRQS);
        Delete_FilterCriterion(criterion1_name, vServerRQS);
        Delete_FilterCriterion(criterion2_nameInSecurities, vServerRQS);
        Delete_FilterCriterion(criterion2_name, vServerRQS);
        
        //1.1- Connect to croesus with sysadmin.Go to the securities module, click on Risk Rating Manager Button then Simulation Tab.
        Log.Message("1.1 : Connect to croesus with sysadmin. Go to the securities module, click on Risk Rating Manager Button then Simulation Tab.");
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Disable all other criteria
        SetIscheckedForCriteriaInBasicCriteriaGrid(false);
        SetIscheckedForCriteriaInOverwriteCriteriaGrid(false);
        
        //1.2- Create Basic criteria
        Log.Message("1.2.a : Create basic criterion : " + criterion1_name);
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
        
        var criterion1_ConditionFunction = "CreateRiskRatingCondition_SecuritiesHavingSubcategoryEqualTo('" + criterion1_subcategory + "')";
        SetCriterionAttributes(criterion1_name, criterion1_description, criterion1_activeStatus, criterion1_overwriteStatus, criterion1_rating, criterion1_ConditionFunction);
        
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
        CreateRiskRatingCondition_SecuritiesHavingSubcategoryEqualTo(criterion2_subcategory);
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
        CreateRiskRatingCondition_SecuritiesHavingSymbolEqualTo(criterion2_symbol);

        
        Log.Message("Click on 'Save' button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        //Check if criterion 2 was created
        if (GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion2_name) == null)
            return Log.Error("Criterion '" + criterion2_name + "' was not created.");
        
        Log.Checkpoint("Criterion '" + criterion2_name + "' was created.");
        
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //2.1-2 Go to the securities module and Create 2 Search Criteria
        Log.Message("2.1,2 : Go to the securities module and Create 2 Search Criteria.");

        Log.Message("2.2.a : Create criterion : " + criterion1_nameInSecurities);
        var criterion1_ConditionFunctionInSecurities = "CreateCriterionConditionInSecurities_SecuritiesHavingSubcategoryEqualTo('" + criterion1_subcategory + "')";
        if (CreateAndRefreshCriterionInSecurities(criterion1_nameInSecurities, criterion1_description, criterion1_ConditionFunctionInSecurities))
            Log.Checkpoint("Criterion '" + criterion1_nameInSecurities + "' is created and loaded in Securities.")
        else
            return Log.Error("Criterion '" + criterion1_nameInSecurities + "' is not created in Securities.")
        
        //Get The number of checked securities for criterion 1
        var criterion1_nbOfCheckedSecurities = VarToInt(Get_MainWindow_StatusBar_NbOfcheckedElements().Text.OleValue);
        Log.Message("In the Security grid, The number of checked securities for criterion '" + criterion1_nameInSecurities + "' is : " + criterion1_nbOfCheckedSecurities);
        
        Log.Message("2.2.b : Create criterion : " + criterion2_nameInSecurities);
//        var criterion2_ConditionFunctionInSecurities = "CreateCriterionConditionInSecurities_SecuritiesHavingSymbolEqualTo('" + criterion2_symbol + "')";
//        if (CreateAndRefreshCriterionInSecurities(criterion2_nameInSecurities, criterion2_description, criterion2_ConditionFunctionInSecurities))
        if (CreateAndRefreshCriterion2InSecurities(criterion2_nameInSecurities, criterion2_description, criterion2_subcategory, criterion2_symbol))
            Log.Checkpoint("Criterion '" + criterion2_nameInSecurities + "' is created and loaded in Securities.")
        else
            return Log.Error("Criterion '" + criterion2_nameInSecurities + "' is not created in Securities.")
        
        //Get The number of checked securities for criterion 2
        var criterion2_nbOfCheckedSecurities = VarToInt(Get_MainWindow_StatusBar_NbOfcheckedElements().Text.OleValue);
        Log.Message("In the Security grid, The number of checked securities for criterion '" + criterion2_nameInSecurities + "' is : " + criterion2_nbOfCheckedSecurities);

        
        //3- Go to the securities modele, click on Risk Rating Criteria button, Click on Simulation Tab then Simulate all methods button .
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Click on Simulate all methods button.
        Log.Message("Click on Simulate all methods button.");
        Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods().Click();
        
        
        //Note the number displayed in Simulate and Simulate Final column for this criteria.
        Log.Message("Get the number displayed in 'Simulation' and 'Simulation final' column for criteria '" + criterion1_name + "' and '" + criterion2_name + "'");
        
        var windowLeft = Get_WinRiskRatingCriteriaManager().get_Left();
        var windowWidth = Get_WinRiskRatingCriteriaManager().get_Width();
        Get_WinRiskRatingCriteriaManager().set_Left(0);
        Get_WinRiskRatingCriteriaManager().set_Width(Sys.Desktop.Width);
        
        var simulationColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulation().WPFControlOrdinalNo;
        var simulationFinalColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulationFinal().WPFControlOrdinalNo;
        
        //For Criterion 1
        var criterion1RowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion1_name);
        if (criterion1RowIndex == null)
            return Log.Error("Criterion '" + criterion1_name + "' not found in the grid.");
        
        var criterion1Row = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterion1RowIndex], 10);
        var criterion1_nbOfSimulation = VarToInt(criterion1Row.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationColumnIndex], 10).WPFControlText);
        var criterion1_nbOfSimulationFinal = VarToInt(criterion1Row.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationFinalColumnIndex], 10).WPFControlText);
        
        Log.Message("Number of 'Simulation'  for criterion '" + criterion1_name + "' is : " + criterion1_nbOfSimulation);
        Log.Message("Number of 'Simulation final' for criterion '" + criterion1_name + "' is : " + criterion1_nbOfSimulationFinal);
        
        
        //For Criterion 2
        var criterion2RowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion2_name);
        if (criterion2RowIndex == null)
            return Log.Error("Criterion '" + criterion2_name + "' not found in the grid.");
        
        var criterion2Row = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterion2RowIndex], 10);
        var criterion2_nbOfSimulation = VarToInt(criterion2Row.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationColumnIndex], 10).WPFControlText);
        var criterion2_nbOfSimulationFinal = VarToInt(criterion2Row.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationFinalColumnIndex], 10).WPFControlText);
        
        Log.Message("Number of 'Simulation'  for criterion '" + criterion2_name + "' is : " + criterion2_nbOfSimulation);
        Log.Message("Number of 'Simulation final' for criterion '" + criterion2_name + "' is : " + criterion2_nbOfSimulationFinal);
        
        //Check actual values
        var criterion1_expectedNbOfSimulation = criterion1_nbOfCheckedSecurities;
        var criterion2_expectedNbOfSimulation = criterion2_nbOfCheckedSecurities;
        var criterion1_expectedNbOfSimulationFinal = criterion1_nbOfCheckedSecurities - criterion2_nbOfCheckedSecurities;
        var criterion2_expectedNbOfSimulationFinal = criterion2_nbOfCheckedSecurities;
        CheckEquals(criterion1_nbOfSimulation, criterion1_expectedNbOfSimulation, "The number of 'Simulation' for criterion '" + criterion1_name + "'");
        CheckEquals(criterion2_nbOfSimulation, criterion2_expectedNbOfSimulation, "The number of 'Simulation' for criterion '" + criterion2_name + "'");
        CheckEquals(criterion1_nbOfSimulationFinal, criterion1_expectedNbOfSimulationFinal, "The number of 'Simulation final' for criterion '" + criterion1_name + "'");
        CheckEquals(criterion2_nbOfSimulationFinal, criterion2_expectedNbOfSimulationFinal, "The number of 'Simulation final' for criterion '" + criterion2_name + "'");
        
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
        Delete_FilterCriterion(criterion1_nameInSecurities, vServerRQS);
        Delete_FilterCriterion(criterion2_nameInSecurities, vServerRQS);
		RestoreRQS([criterion1_name, criterion2_name]);
    }
}



function CreateAndRefreshCriterion2InSecurities(criterionName, criterionDescription, subcategoryName, symbol)
{
    //Delete the criterion if it exists
    Log.Message("Delete criterion : " + criterionName);
    Delete_FilterCriterion(criterionName, vServerRQS);
    
    Log.Message("Add criterion : " + criterionName);
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    
    if (Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().IsChecked.OleValue){
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", false, 100000);
    }
    
    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
    
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(criterionName);
    Get_WinAddSearchCriterion_TxtDescription().Clear();
    Get_WinAddSearchCriterion_TxtDescription().Keys(criterionDescription);
    
    
    CreateCriterionConditionInSecurities_SecuritiesHavingSubcategoryEqualTo(subcategoryName);
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
    CreateCriterionConditionInSecurities_SecuritiesHavingSymbolEqualTo(symbol);
    
    
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
    if (Get_DlgCroesus().Exists){
        Log.Picture(Sys.Desktop, "There was an unexpected issue while creating the criterion '" + criterionName + "'");
        Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/2, Get_DlgCroesus().get_ActualHeight()-45);
        Get_WinAddSearchCriterion_BtnCancel().Click();
        return false;
    }
    
    //Cliquer sur OK si le message "Les éléments de cette requête sont introuvables ou cette liste est vide." apparaît
    if (Get_DlgWarning().Exists){
        Log.Picture(Sys.Desktop, "The Warning dialogbox were displayed upon the creation of criterion '" + criterionName + "'");
        Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
    }
    
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 100000);
    Delay(1000); //For the NbOfcheckedElements to be updated
    
    //Check if criterion is actually created and loaded in Securities
    return (VarToStr(Get_MainWindow_StatusBar_NbOfcheckedElements().ToolTip.OleValue) == criterionName)
}
