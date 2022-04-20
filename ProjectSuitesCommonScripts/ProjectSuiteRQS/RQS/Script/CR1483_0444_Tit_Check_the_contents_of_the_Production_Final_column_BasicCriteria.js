//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA
//USEUNIT CR1483_EnvironmentPreparation



/**
    Description : Check if the"Production Final" column displays the number of securities for the selected  criterion that were rated during last processing - Basic Criteria
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-444
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0444_Tit_Check_the_contents_of_the_Production_Final_column_BasicCriteria()
{
    CR1483_0444_Tit_Check_the_contents_of_the_Production_Final_column("Basic");
}



/** 
    Le paramètre BasicOrOverwrite doit avoir une des valeurs suivantes :
        - "Basic"
        - "Overwrite"
*/
function CR1483_0444_Tit_Check_the_contents_of_the_Production_Final_column(BasicOrOverwrite)
{
    if (GetIndexOfItemInArray(["Basic", "Overwrite"], BasicOrOverwrite) == -1){
        Log.Error(BasicOrOverwrite + " not expected for the BasicOrOverwrite parameter.");
        return;
    }
    
    try {
        //Make sure that there is no manual overwrite rating
        var SQLQueryString = "delete from b_risk_rating where source like '%manual%'";
        Log.Message(SQLQueryString);
        Execute_SQLQuery(SQLQueryString, vServerRQS);
        
        //Make sure that there is no external feed rating
        var SQLQueryString = "delete from b_risk_rating where source like '%feed%'";
        Log.Message(SQLQueryString);
        Execute_SQLQuery(SQLQueryString, vServerRQS);
        
    
        var criterion1_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0444_" + BasicOrOverwrite + "Criterion1_Name", language + client);
        var criterion1_description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0444_" + BasicOrOverwrite + "Criterion1_Description", language + client);
        var criterion1_activeStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0444_" + BasicOrOverwrite + "Criterion1_ActiveStatus", language + client);
        var criterion1_overwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0444_" + BasicOrOverwrite + "Criterion1_OverwriteStatus", language + client);
        var criterion1_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0444_" + BasicOrOverwrite + "Criterion1_Rating", language + client);
        
        var criterion2_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0444_" + BasicOrOverwrite + "Criterion2_Name", language + client);
        var criterion2_description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0444_" + BasicOrOverwrite + "Criterion2_Description", language + client);
        var criterion2_activeStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0444_" + BasicOrOverwrite + "Criterion2_ActiveStatus", language + client);
        var criterion2_overwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0444_" + BasicOrOverwrite + "Criterion2_OverwriteStatus", language + client);
        var criterion2_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0444_" + BasicOrOverwrite + "Criterion2_Rating", language + client);
        
        var criteriaEditorWindowAddModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowAddModeTitle", language + client);        
        
        
        //Delete the criteria with the same name
        Delete_FilterCriterion(criterion1_name, vServerRQS);
        Delete_FilterCriterion(criterion2_name, vServerRQS);
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //1- Create a risk rating criterion: click on "Risk Rating Manager"  button, in the risk rating criteria manager window/simulation tab , click on Basic Criteria, click on Add button. "Add a criterion" windows is displayed.
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
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
        
        
        //1- Create Risk Rating criterion 1
        
        Log.Message("Click on 'add' button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        
        //Check that "Add a criterion" windows is displayed.
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowAddModeExpectedTitle);
        
        //Fill fields
        var CreateRiskRatingConditionFunction = "CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToUSDorCAD()";
        SetCriterionAttributes(criterion1_name, criterion1_description, criterion1_activeStatus, criterion1_overwriteStatus, criterion1_rating, CreateRiskRatingConditionFunction);
        
        //Click on Save button.
        Log.Message("Click on 'Save' button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();

        
        //2- Create Risk Rating criterion 2
        
        Log.Message("Click on 'add' button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        
        //Check that "Add a criterion" windows is displayed.
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowAddModeExpectedTitle);
        
        //Fill fields
        var CreateRiskRatingConditionFunction = "CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToUSD()";
        SetCriterionAttributes(criterion2_name, criterion2_description, criterion2_activeStatus, criterion2_overwriteStatus, criterion2_rating, CreateRiskRatingConditionFunction);
        
        //Click on Save button.
        Log.Message("Click on 'Save' button.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        
        //3- Disable all other criteria
        SetIscheckedForCriteriaInBasicCriteriaGrid(false);
        SetIscheckedForCriteriaInOverwriteCriteriaGrid(false);
        
        if (BasicOrOverwrite == "Overwrite")
            SetIscheckedForCriteriaInOverwriteCriteriaGrid(true, [criterion1_name, criterion2_name]);
        else
            SetIscheckedForCriteriaInBasicCriteriaGrid(true, [criterion1_name, criterion2_name]);
            
        //4- Send to Production
        SendToProduction();
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //5- Execute SSH commands
        ExecuteDefaultSSHCommands();
        
        
        //6- Go to the Risk Rating Manager and Verify results
        
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
        
        var criterion1_Index = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion1_name);
        var criterion1_NbProduction = GetBasicOverwriteCriteriaDisplayedNbOfProduction(criterion1_Index);
        var criterion1_NbProductionFinal = GetBasicOverwriteCriteriaDisplayedNbOfProductionFinal(criterion1_Index);
        
        var criterion2_Index = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterion2_name);
        var criterion2_NbProduction = GetBasicOverwriteCriteriaDisplayedNbOfProduction(criterion2_Index);
        var criterion2_NbProductionFinal = GetBasicOverwriteCriteriaDisplayedNbOfProductionFinal(criterion2_Index);
        
        
        //Compare
        var N1 = StrToFloat(ConvertStrToNumberFormat(criterion1_NbProduction));
        var N2 = StrToFloat(ConvertStrToNumberFormat(criterion2_NbProduction));
        CheckEquals(StrToFloat(ConvertStrToNumberFormat(criterion1_NbProductionFinal)), N1 - N2, "Number of Production Final for criterion " + criterion1_name);
        CheckEquals(criterion2_NbProduction, criterion2_NbProductionFinal, "Number of Production and Production Final for criterion " + criterion2_name);
        
        
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
        
        //Restore RQS
        if (BasicOrOverwrite == "Overwrite")
            RestoreRQS(null, [criterion1_name, criterion2_name], true, true, false);
        else
            RestoreRQS([criterion1_name, criterion2_name], null, true, true, false);
        
        //Restore external feed
        CR1483_EnvironmentPreparation_Step6();
    } 
}