//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Check if we can copy an assigned criterion
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-308
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0308_Tit_Check_if_we_can_copy_an_assigned_criterion()
{
    try {
        var riskRatingCriteriaManagerWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingCriteriaManagerWindowTitle", language + client);
        var fromCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereCAD", language + client);
        var criterionCopyName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0308_criterion_copy_name", language + client);
        
        //Delete the criteria with the same name
        Delete_FilterCriterion(criterionCopyName, vServerRQS);
        
        
        //Step 1 : Connect to croesus with sysadmin, Go to security module, click on Risk Rating Manager Button, Simulation Tab, Basic criteria
        
        //Connect to croesus with sysadmin
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        //Check that "Risk Rating criteria" window is displayed
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Title", cmpEqual, riskRatingCriteriaManagerWindowExpectedTitle);
        
        
        //Step 2 : Select  a criterion for which Yesterday, yesterday final, simulate and simulate final is not zero and click on copy button,  
            
        //Make sure that Production, Production final, simulation and simulation final are not null
        Log.Message("Make sure that Production, Production final, simulation and simulation final are not null");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(fromCriterionName);
        if (criterionRowIndex == null){
            Log.Error("Criterion '" + fromCriterionName + "' not found in the Basic criteria grid of the Simulate tab.");
            return;
        }
        
        var windowLeft = Get_WinRiskRatingCriteriaManager().get_Left();
        var windowWidth = Get_WinRiskRatingCriteriaManager().get_Width();
        Get_WinRiskRatingCriteriaManager().set_Left(0);
        Get_WinRiskRatingCriteriaManager().set_Width(Sys.Desktop.Width);
        
        var productionColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProduction().WPFControlOrdinalNo;
        var productionFinalColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProductionFinal().WPFControlOrdinalNo;
        var simulationColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulation().WPFControlOrdinalNo;
        var simulationFinalColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulationFinal().WPFControlOrdinalNo;
        
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        var nbOfProduction = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", productionColumnIndex], 10).WPFControlText;
        var nbOfProductionFinal = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", productionFinalColumnIndex], 10).WPFControlText;
        var nbOfSimulation = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationColumnIndex], 10).WPFControlText;
        var nbOfSimulationFinal = criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", simulationFinalColumnIndex], 10).WPFControlText;
        
        Get_WinRiskRatingCriteriaManager().set_Left(windowLeft);
        Get_WinRiskRatingCriteriaManager().set_Width(windowWidth);
        
        if (   !aqObject.CompareProperty(StrToInt(nbOfProduction), cmpGreater, 0, true, lmError)
            || !aqObject.CompareProperty(StrToInt(nbOfProductionFinal), cmpGreater, 0, true, lmError)
            || !aqObject.CompareProperty(StrToInt(nbOfSimulation), cmpGreater, 0, true, lmError)
            || !aqObject.CompareProperty(StrToInt(nbOfSimulationFinal), cmpGreater, 0, true, lmError))
            return;
        
        
        //Step 3 : Rename the criteria and click on save button, check if the modified criteria is saved.
        CheckCopyCriterion(fromCriterionName, criterionCopyName);
        
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
        RestoreRQS(criterionCopyName, null);
    }
}



function CheckCopyCriterion(fromCriterionName, criterionCopyName)
{
    var criteriaEditorWindowCopyModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowCopyModeTitle", language + client);
    
    Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(fromCriterionName);
    if (criterionRowIndex == null){
        Log.Error("Criterion '" + fromCriterionName + "' not found in the Basic criteria grid of the Simulate tab.");
        return;
    }
    
    //Select the critrerion and Click on copy button
    var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
    var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
    criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
    
    Log.Message("Click on copy button.");
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnCopy().Click();
    
    //Check that "Copy a criterion" windows is displayed.
    if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowCopyModeExpectedTitle);
    
    
    //Rename the criteria and click on save button
    Log.Message("Rename the criteria and click on save button");
    Get_WinRiskRatingCriteriaEditor_TxtName().Clear();
    Get_WinRiskRatingCriteriaEditor_TxtName().Keys(criterionCopyName);
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
    
    //Check if the modified criteria is saved.
    Log.Message("Check if the modified criteria is saved.");
    var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionCopyName);
    if (criterionRowIndex == null){
        Log.Error("Modified criterion '" + criterionCopyName + "' not found.");
        return;
    }
    
    Log.Checkpoint("Modified criterion '" + criterionCopyName + "' is saved");
}
