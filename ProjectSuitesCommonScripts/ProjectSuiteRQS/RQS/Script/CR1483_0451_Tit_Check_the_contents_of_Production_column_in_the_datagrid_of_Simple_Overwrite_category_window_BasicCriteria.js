//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Check the contents of "Production" column in the datagrid of Simple/Overwrite te category window - Basic Criteria
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-451
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0451_Tit_Check_the_contents_of_Production_column_in_the_datagrid_of_Simple_Overwrite_category_window_BasicCriteria()
{
    CR1483_0451_Tit_Check_the_contents_of_Production_column_in_the_datagrid_of_Simple_Overwrite_category_window("Basic");
}



/** 
    Le paramètre BasicOrOverwrite doit avoir une des valeurs suivantes :
        - "Basic"
        - "Overwrite"
*/
/** SCRIPT À METTRE À JOUR SUITE À LA MISE À JOUR DE MALIKA */
function CR1483_0451_Tit_Check_the_contents_of_Production_column_in_the_datagrid_of_Simple_Overwrite_category_window(BasicOrOverwrite)
{
    if (GetIndexOfItemInArray(["Basic", "Overwrite"], BasicOrOverwrite) == -1){
        Log.error(BasicOrOverwrite + " not expected for the BasicOrOverwrite parameter.");
        return;
    }
        
    try {
        
        //Make sure that there is no manual overwrite rating
        var SQLQueryString = "delete from b_risk_rating where source like '%manual%'";
        Log.Message(SQLQueryString);
        Execute_SQLQuery(SQLQueryString, vServerRQS);
        
        
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0445_" + BasicOrOverwrite + "Criterion_Name", language + client);
        var criterionDescription = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0445_" + BasicOrOverwrite + "Criterion_Description", language + client);
        var activeStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0445_" + BasicOrOverwrite + "Criterion_ActiveStatus", language + client);
        var overwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0445_" + BasicOrOverwrite + "Criterion_OverwriteStatus", language + client);
        var rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0445_" + BasicOrOverwrite + "Criterion_Rating", language + client);
        var subcategoryName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0445_" + BasicOrOverwrite + "Criterion_Subcategory", language + client);
        var criterionNameInSecuritiesGrid = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0445_" + BasicOrOverwrite + "Criterion_NameInSecurities", language + client);
        var criterionDescriptionInSecuritiesGrid = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0445_" + BasicOrOverwrite + "Criterion_DescriptionInSecurities", language + client);
        
        var riskRatingCriteriaManagerWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingCriteriaManagerWindowTitle", language + client);
        var criteriaEditorWindowAddModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowAddModeTitle", language + client);        
        
        
        //Delete the criteria with the same name
        Delete_FilterCriterion(criterionName, vServerRQS);
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //1- BASIC CRITERIA
        
        //1- Create a risk rating criterion: click on "Risk Rating Manager"  button, in the risk rating criteria manager window/simulation tab , click on Basic Criteria, click on Add button. "Add a criterion" windows is displayed.
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Simulation Tab then Basic Criteria category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        //Check that "Risk Rating criteria" window is displayed
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Title", cmpEqual, riskRatingCriteriaManagerWindowExpectedTitle);
        
        //3-Click on simulation tab then "add" button. 
        
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Select the Rating Method.
        Log.Message("Select '" + BasicOrOverwrite+ "' rating method.");
        if (BasicOrOverwrite == "Overwrite")
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        else
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        
        //Créer le critère
        Log.Message("Click on 'add' button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        
        //Check that "Add a criterion" windows is displayed.
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowAddModeExpectedTitle);
        
        //Fill fields
        CreateRiskRatingConditionFunction = "CreateRiskRatingCondition_BasicCriteria1()";
        SetCriterionAttributes(criterionName, criterionDescription, activeStatus, overwriteStatus, rating, CreateRiskRatingConditionFunction);
        
        //Click on Save button.
        Log.Message("Click on 'Save' button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        
        
        //2- Create criterion in Securities
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        CreateAndRefreshCriterionInSecurities(criterionName, criterionDescription, "CreateCriterionInSecurities_BasicCriteria1()");
        
        //Get The number of checked securities
        var N1 = Get_MainWindow_StatusBar_NbOfcheckedElements().Text;
        Log.Message("In the Security grid, The number of checked securities is : " + N1);

        
        
        //3- Create Risk Rating criterion 2
        
        //Open the risk rating criteria manager window, click on Simulation Tab then Basic Criteria category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Select the Rating Method.
        Log.Message("Select '" + BasicOrOverwrite+ "' rating method.");
        if (BasicOrOverwrite == "Overwrite")
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        else
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        //Créer le critère
        Log.Message("Click on 'add' button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        
        //Fill fields
        CreateRiskRatingConditionFunction = "CreateRiskRatingCondition_BasicCriteria2()";
        SetCriterionAttributes(criterionName, criterionDescription, activeStatus, overwriteStatus, rating, CreateRiskRatingConditionFunction);
        
        //Click on Save button.
        Log.Message("Click on 'Save' button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        
        
        //4- Create criterion in Securities
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        CreateAndRefreshCriterionInSecurities(criterionName, criterionDescription, "CreateCriterionInSecurities_BasicCriteria2()");
        
        //Get The number of checked securities
        var N2 = Get_MainWindow_StatusBar_NbOfcheckedElements().Text;
        Log.Message("In the Security grid, The number of checked securities is : " + N2);
        
        
        
        //Go to the Risk Rating Manager and Send to Production
        
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        
        //5- Send to Production
        SendToProduction();
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //6- Execute SSH commands
        ExecuteDefaultSSHCommands();
        
        
        //Go to the Risk Rating Manager and Verify results
        
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        var criterion1_Index = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion1Name)
        var criterion1_NbProduction = GetBasicOverwriteCriteriaDisplayedNbOfProduction(criterion1_Index);
        var criterion1_NbProductionFinal = GetBasicOverwriteCriteriaDisplayedNbOfProductionFinal(criterion1_Index);
        
        var criterion2_Index = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion2Name)
        var criterion2_NbProduction = GetBasicOverwriteCriteriaDisplayedNbOfProduction(criterion2_Index);
        var criterion2_NbProductionFinal = GetBasicOverwriteCriteriaDisplayedNbOfProductionFinal(criterion2_Index);
        
        
        //Compare
        CheckEquals(StrToInt(ConvertStrToNumberFormat(criterion1_NbProduction)), StrToInt(N1), "Number of Production for criterion : " + criterion1Name);
        CheckEquals(StrToInt(ConvertStrToNumberFormat(criterion1_NbProductionFinal)), StrToInt(N1) - StrToInt(N2), "Number of Production Final for criterion : " + criterion1Name);
        CheckEquals(StrToInt(ConvertStrToNumberFormat(criterion2_NbProduction)), StrToInt(N2), "Number of Production for criterion : " + criterion2Name);
        CheckEquals(StrToInt(ConvertStrToNumberFormat(criterion2_NbProductionFinal)), StrToInt(N2), "Number of Production Final for criterion : " + criterion2Name);
        
        
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
        if (criterionName != undefined && criterionEditedName != undefined){
            var SQLQueryString = "UPDATE B_MSG SET DESCRIPTION = '" + criterionName + "' WHERE DESCRIPTION = '" + criterionEditedName + "'";
            Log.Message(SQLQueryString);
            Execute_SQLQuery(SQLQueryString, vServerRQS);
        }
        
        //Restore the criterion ModifiedDate
        if (criterionName != undefined && criterionOldModifiedDate != undefined)
            SetCriterionModifiedDate(criterionName, criterionOldModifiedDate);
        
        //Restore RQS
        RestoreRQS(null, null, true);
    } 
}



function CreateRiskRatingCondition_BasicCriteria1()
{
    CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToUSD();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemOr", language + client)).Click();
    CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToCAD();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
    var subcategoryName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0451_BasicCriterion1_Subcategory", language + client);
    CreateRiskRatingCondition_SecuritiesHavingSubcategoryNotEqualTo(subcategoryName);
}


function CreateCriterionInSecurities_BasicCriteria1()
{
    CreateCriterionConditionInSecurities_SecuritiesHavingPriceCurrencyEqualToUSD();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemOr", language + client)).Click();
    CreateCriterionConditionInSecurities_SecuritiesHavingPriceCurrencyEqualToCAD();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
    CreateCriterionConditionInSecurities_NotManualSecurities();
}


function CreateRiskRatingCondition_BasicCriteria2()
{
    CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToUSD();
}


function CreateCriterionInSecurities_BasicCriteria2()
{
    CreateCriterionConditionInSecurities_SecuritiesHavingPriceCurrencyEqualToUSD();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
    var subcategoryName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0451_BasicCriterion1_Subcategory", language + client);
    CreateCriterionConditionInSecurities_SecuritiesHavingSubcategoryNotEqualTo(subcategoryName);
}