//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Check the "Simulate" column contents if we modified a criterion
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-456
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/
/** ***********A METTRE À JOUR ************/
function CR1483_0456_Tit_Check_the_Simulate_column_contents_if_we_modified_a_criterion()
{
    try {
        var basicCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0456_Criterion1", language + client);
        var basicCriterionNameInSecuritiesGrid = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0456_SecuritiesCriterion1", language + client);
        var overwriteCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0456_Criterion2", language + client);
        var overwriteCriterionNameInSecuritiesGrid = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0456_SecuritiesCriterion2", language + client);        
        
        //Delete the criteria with same names
        Delete_FilterCriterion(basicCriterionName, vServerRQS);
        Delete_FilterCriterion(overwriteCriterionName, vServerRQS);
        Delete_FilterCriterion(basicCriterionNameInSecuritiesGrid, vServerRQS);
        Delete_FilterCriterion(overwriteCriterionNameInSecuritiesGrid, vServerRQS);
        
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //1- BASIC CRITERIA
        
        //1.1- Go to the securities module,click on "Risk Rating Methods Manager"  button, in Risk Rating Methods Manager window , click on Basic criteria
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Simulation Tab then Basic Criteria category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        CreateBasicCriteriaInRiskIndex(basicCriterionName);
        
        
        //1.2- Disable all other criterion and click on "simulate all methods" button
        
        DisableAllCriteriaInBasicCriteriaGridExcept(basicCriterionName);
        DisableAllCriteriaInOverwriteCriteriaGridExcept(basicCriterionName);
        Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        var basicCriterionNameRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(basicCriterionName);
        var nbOfSimulationsInBasicCriteriaGrid = GetBasicOverwriteCriteriaDisplayedNbOfSimulation(basicCriterionNameRowIndex);
        
        Log.Message("The number of Simulations in Basic Criteria grid for '" + basicCriterionName + "' is : " + nbOfSimulationsInBasicCriteriaGrid);
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //1.3- In the securities toolbar click on "Manage Search Creteria" button, create a searche Critera:
        
        CreateBasicCriteriaInSecurities(basicCriterionNameInSecuritiesGrid);
        
        //Get The number of checked securities
        Delay(1000); //For the NbOfcheckedElements to be updated
        var nbOfCheckedSecurities = Get_MainWindow_StatusBar_NbOfcheckedElements().Text;
        Log.Message("In the Security grid, The number of checked securities is : " + nbOfCheckedSecurities);
        
        
        //1.4- Check if the number displayed in "Simulation" column equal to the number of checked securities in Securities grid.

        Log.Message("Check if the nbOfCheckedSecurities of the securities grid and the nbOfSimulationsInBasicCriteriaGrid of the Risk Index Manager are the same.");
        nbOfCheckedSecurities = ConvertStrToNumberFormat(nbOfCheckedSecurities);
        nbOfSimulationsInBasicCriteriaGrid = ConvertStrToNumberFormat(nbOfSimulationsInBasicCriteriaGrid);
        aqObject.CompareProperty(StrToInt(nbOfSimulationsInBasicCriteriaGrid), cmpEqual, StrToInt(nbOfCheckedSecurities), true, lmError);       
        
        
        
        //2- OVERWRITE CRITERIA
        
        //2.1- Go to the securities module,click on "Risk Rating Methods Manager"  button, in Risk Rating Methods Manager window , click on Basic criteria
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Simulation Tab then Overwrite Criteria category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        CreateOverwriteCriteriaInRiskIndex(overwriteCriterionName);

        
        //2.2- Disable all other criterion and click on "simulate all methods" button
        
        DisableAllCriteriaInBasicCriteriaGridExcept(overwriteCriterionName);
        DisableAllCriteriaInOverwriteCriteriaGridExcept(overwriteCriterionName);
        Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        
        var overwriteCriterionNameRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(overwriteCriterionName);
        var nbOfSimulationsInOverwriteCriteriaGrid = GetBasicOverwriteCriteriaDisplayedNbOfSimulation(overwriteCriterionNameRowIndex);
        
        Log.Message("The number of Simulations in Overwrite Criteria grid for '" + overwriteCriterionName + "' is : " + nbOfSimulationsInOverwriteCriteriaGrid);
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //2.3- In the securities toolbar click on "Manage Search Creteria" button, create a search Critera:
        
        CreateOverwriteCriteriaInSecurities(overwriteCriterionNameInSecuritiesGrid);
        
        //Get The number of checked securities
        Delay(1000); //For the NbOfcheckedElements to be updated
        var nbOfCheckedSecurities = Get_MainWindow_StatusBar_NbOfcheckedElements().Text;
        Log.Message("In the Security grid, The number of checked securities is : " + nbOfCheckedSecurities);
        
        
        //2.4- Check if the number displayed in "Simulation" column equal to the number of checked securities in Securities grid.
        
        Log.Message("Check if the nbOfCheckedSecurities of the securities grid and the nbOfSimulationsInOverwriteCriteriaGrid of the Risk Index Manager are the same.");
        nbOfCheckedSecurities = ConvertStrToNumberFormat(nbOfCheckedSecurities);
        nbOfSimulationsInOverwriteCriteriaGrid = ConvertStrToNumberFormat(nbOfSimulationsInOverwriteCriteriaGrid);
        aqObject.CompareProperty(StrToInt(nbOfSimulationsInOverwriteCriteriaGrid), cmpEqual, StrToInt(nbOfCheckedSecurities), true, lmError);       
        
        
        //Close Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        //Delete the criteria
        RestoreRQS(basicCriterionName, overwriteCriterionName, false, false, true);
        
        //Delete_FilterCriterion(basicCriterionName, vServerRQS);
        //Delete_FilterCriterion(overwriteCriterionName, vServerRQS);
        Delete_FilterCriterion(basicCriterionNameInSecuritiesGrid, vServerRQS);
        Delete_FilterCriterion(overwriteCriterionNameInSecuritiesGrid, vServerRQS);
        
        //Activate all the remaining criteria
        //Execute_SQLQuery("update B_CRIT_RISKRATING set IS_SELECTED = 'Y'", vServerRQS);
    } 
}



function CreateBasicCriteriaInRiskIndex(basicCriterionName)
{
    Log.Message("Go to 'Simulation' tab.");
    Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
    Log.Message("Select 'Basic criteria' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    
    Log.Message("Create the criterion : " + basicCriterionName);
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
    Get_WinRiskRatingCriteriaEditor_TxtName().Keys(basicCriterionName);
        
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSubcategory", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemBondFunds", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemPriceCurrency", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCAD", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
        
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
}



function CreateOverwriteCriteriaInRiskIndex(overwriteCriterionName)
{
    Log.Message("Go to 'Simulation' tab.");
    Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
    Log.Message("Select 'Basic criteria' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
    
    Log.Message("Create the criterion : " + overwriteCriterionName);
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
    Get_WinRiskRatingCriteriaEditor_TxtName().Keys(overwriteCriterionName);
    
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSubcategory", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCommonStock", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemPriceCurrency", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCAD", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
        
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
}



function CreateBasicCriteriaInSecurities(basicCriterionNameInSecuritiesGrid)
{
    //Delete the criterion if it exists
    Log.Message("Delete criterion : " + basicCriterionNameInSecuritiesGrid);
    Delete_FilterCriterion(basicCriterionNameInSecuritiesGrid, vServerRQS);
    
    //Add the criterion
    Log.Message("Add criterion : " + basicCriterionNameInSecuritiesGrid);
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnManageSearchCriteria().Click();
    Get_WinSearchCriteriaManager_BtnAdd().Click();
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(basicCriterionNameInSecuritiesGrid);
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSubcategory", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemBondFunds", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemPriceCurrency", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCAD", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();

    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
    //Cliquer sur OK si le message "Les éléments de cette requête sont introuvables ou cette liste est vide." apparaît
    if (Get_DlgCroesus().Exists){
        Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/2, Get_DlgCroesus().get_ActualHeight()-45);
        Get_WinSearchCriteriaManager_BtnClose().Click();
    }
    
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 100000);
}


function CreateOverwriteCriteriaInSecurities(overwriteCriterionNameInSecuritiesGrid)
{
    //Delete the criterion if it exists
    Log.Message("Delete criterion : " + overwriteCriterionNameInSecuritiesGrid);
    Delete_FilterCriterion(overwriteCriterionNameInSecuritiesGrid, vServerRQS);
    
    //Add the criterion
    Log.Message("Add criterion : " + overwriteCriterionNameInSecuritiesGrid);
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnManageSearchCriteria().Click();
    Get_WinSearchCriteriaManager_BtnAdd().Click();
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(overwriteCriterionNameInSecuritiesGrid);
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSubcategory", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCommonStock", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemPriceCurrency", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCAD", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();

    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
    //Cliquer sur OK si le message "Les éléments de cette requête sont introuvables ou cette liste est vide." apparaît
    if (Get_DlgCroesus().Exists){
        Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/2, Get_DlgCroesus().get_ActualHeight()-45);
        Get_WinSearchCriteriaManager_BtnClose().Click();
    }
    
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 100000);
}



function DisableAllCriteriaInBasicCriteriaGridExcept(criterionName)
{
    Log.Message("Disable all criteria in Basic Criteria grid, except : '" + criterionName + "'.");
    
    Log.Message("Select 'Basic criteria' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    
    DisableAllCriteriaInBasicOverwriteCriteriaGridExcept(criterionName);
}



function DisableAllCriteriaInOverwriteCriteriaGridExcept(criterionName)
{
    Log.Message("Disable all criteria in Overwrite Criteria grid, except : '" + criterionName + "'.");
    
    Log.Message("Select 'Overwrite criteria' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
    
    DisableAllCriteriaInBasicOverwriteCriteriaGridExcept(criterionName);
}



function DisableAllCriteriaInBasicOverwriteCriteriaGridExcept(criterionName)
{
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    var activeCheckboxColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChActive().WPFControlOrdinalNo;
    
    //Goto the first row
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[Home]");
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[Home]");
    
    //Navigate through the grid
    var isEndOfGridReached = false;
    while (!isEndOfGridReached){
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Refresh();
        var rowCount = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
        for (var rowIndex = 1; rowIndex <= rowCount; rowIndex++){
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentNameValue = GetBasicOverwriteCriteriaDisplayedName(rowIndex);
            var activeCheckbox = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", activeCheckboxColumnIndex], 10).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1);
            if (currentNameValue == criterionName){
                if (!activeCheckbox.IsChecked.OleValue)
                    activeCheckbox.Click();
            }
            else {
                if (activeCheckbox.IsChecked.OleValue)
                    activeCheckbox.Click();
             }  
        }
        
        var previousFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[PageDown]");
        var currentFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
        
        if (previousFirstName == currentFirstName){
            var previousFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
            Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[PageDown]");
            var currentFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
            
            if (previousFirstName == currentFirstName)
                isEndOfGridReached = true;
        }  
    }
}


function SetIscheckedForAllCriteriaInBasicCriteria(isCheckedValue)
{
    Log.Message("Set all criteria in Basic Criteria grid to : " + isCheckedValue);
    
    Log.Message("Select 'Basic criteria' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    
    SetIscheckedForAllCriteriaInBasicOverwriteCriteriaGrid(isCheckedValue);
}



function SetIscheckedForAllCriteriaInOverwriteCriteria(isCheckedValue)
{
    Log.Message("Set all criteria in Overwrite Criteria grid to : " + isCheckedValue);
    
    Log.Message("Select 'Overwrite criteria' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
    
    SetIscheckedForAllCriteriaInBasicOverwriteCriteriaGrid(isCheckedValue);
}



function SetIscheckedForAllCriteriaInBasicOverwriteCriteriaGrid(isCheckedValue)
{
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    var activeCheckboxColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChActive().WPFControlOrdinalNo;
    
    //Goto the first row
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[Home]");
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[Home]");
    
    //Navigate through the grid
    var isEndOfGridReached = false;
    while (!isEndOfGridReached){
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Refresh();
        var rowCount = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
        for (var rowIndex = 1; rowIndex <= rowCount; rowIndex++){
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentNameValue = GetBasicOverwriteCriteriaDisplayedName(rowIndex);
            var activeCheckbox = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", activeCheckboxColumnIndex], 10).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1);
            if (isCheckedValue != activeCheckbox.IsChecked.OleValue)
                activeCheckbox.Click();
        }
        
        var previousFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[PageDown]");
        var currentFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
        
        if (previousFirstName == currentFirstName){
            var previousFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
            Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[PageDown]");
            var currentFirstName = GetBasicOverwriteCriteriaDisplayedName(1);
            
            if (previousFirstName == currentFirstName)
                isEndOfGridReached = true;
        }  
    }
}