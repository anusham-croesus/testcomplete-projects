//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Check the contents of "Simulate" column if we add a criterion - Basic criteria
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-445
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0445_Tit_Check_the_contents_of_Simulate_column_if_we_add_a_criterion_BasicCriteria()
{
    CR1483_0445_Tit_Check_the_contents_of_Simulate_column_if_we_add_a_criterion("Basic");
}


/** 
    Le paramètre BasicOrOverwrite doit avoir une des valeurs suivantes :
        - "Basic"
        - "Overwrite"
*/

function CR1483_0445_Tit_Check_the_contents_of_Simulate_column_if_we_add_a_criterion(BasicOrOverwrite)
{
    try {
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
            
        //Créer le critère
        Log.Message("Click on 'add' button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        
        //Check that "Add a criterion" windows is displayed.
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowAddModeExpectedTitle);
        
        //Fill fields
        CreateRiskRatingConditionFunction = "CreateRiskRatingCondition_SecuritiesHavingSubcategoryEqualTo('" + subcategoryName + "')";
        SetCriterionAttributes(criterionName, criterionDescription, activeStatus, overwriteStatus, rating, CreateRiskRatingConditionFunction);
        
        //Click on Save button.
        Log.Message("Click on 'Save' button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        
        //2-Disactive all other criterion and click on simulate all methods button 
        //La partie ci-dessous a été mise en suspens, on assume que la BD ne contient pas de manual risk rating or external pour Bond Funds subcategory
        //and make sure that no manual risk rating or external for  equal to Bond Funds subcategory
        
        SetIscheckedForCriteriaInBasicCriteriaGrid(false);
        SetIscheckedForCriteriaInOverwriteCriteriaGrid(false);
        
        if (BasicOrOverwrite == "Overwrite")
            SetIscheckedForCriteriaInOverwriteCriteriaGrid(true, criterionName);
        else
            SetIscheckedForCriteriaInBasicCriteriaGrid(true, criterionName);
        
        //Click on simulate all methods button 
        Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods().Click();
        
        //Go to the criteria grid
        Log.Message("Select '" + BasicOrOverwrite+ "' rating method.");
        if (BasicOrOverwrite == "Overwrite")
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        else
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        //Get the number of Simulations in the Grid
        var criterionNameRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        var nbOfSimulationsInCriteriaGrid = GetBasicOverwriteCriteriaDisplayedNbOfSimulation(criterionNameRowIndex);
        
        Log.Message("The number of Simulations in Criteria grid for '" + criterionName + "' is : " + nbOfSimulationsInCriteriaGrid);
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //3- In the securities toolbar click on "Manage Search Creteria" button, create a searche Critera:
        CreateSubcategoryCriterionInSecurities(criterionNameInSecuritiesGrid, criterionDescriptionInSecuritiesGrid, subcategoryName);
        
        //Get The number of checked securities
        Delay(1000); //For the NbOfcheckedElements to be updated
        var nbOfCheckedSecurities = Get_MainWindow_StatusBar_NbOfcheckedElements().Text;
        Log.Message("In the Security grid, The number of checked securities is : " + nbOfCheckedSecurities);
        
        
        //4- Check if the number displayed in "Simulation" column equal to the number of checked securities in Securities grid.
        Log.Message("Check if the nbOfCheckedSecurities of the securities grid and the nbOfSimulationsInCriteriaGrid of the Risk Index Manager are the same.");
        nbOfCheckedSecurities = ConvertStrToNumberFormat(nbOfCheckedSecurities);
        nbOfSimulationsInCriteriaGrid = ConvertStrToNumberFormat(nbOfSimulationsInCriteriaGrid);
        aqObject.CompareProperty(StrToInt(nbOfSimulationsInCriteriaGrid), cmpEqual, StrToInt(nbOfCheckedSecurities), true, lmError);       
        
        
        //Close Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        //Delete the criterion
        //Delete_FilterCriterion(criterionName, vServerRQS);
        Delete_FilterCriterion(criterionNameInSecuritiesGrid, vServerRQS);
        
        //Activate all the remaining criteria
        //Execute_SQLQuery("update B_CRIT_RISKRATING set IS_SELECTED = 'Y'", vServerRQS);
        
        
        if (BasicOrOverwrite == "Overwrite")
            RestoreRQS(null, criterionName, false, false, true);
        else
            RestoreRQS(criterionName, null, false, false, true);
    } 
}