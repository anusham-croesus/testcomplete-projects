//USEUNIT CR1483_Common_functions



/**
    Description : Lors de la création d'un nouveau critère pour le RQS, si la description reste vide,
                  il n'est plus possible de mettre à jour la description à partir du bouton modifier.
                  En résumé, si j'ai une description lors de la création du critère, cella sera toujours modifiable,
                  par contre, si la description a été crée vide il n'est sera plus modifiable.
    https://jira.croesus.com/browse/CROES-9163
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-286
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_CROES_9163_Tit_Not_possible_to_update_a_criterion_description_if_it_was_empty_at_creation()
{
    try {
        Log.Message("Bug JIRA CROES-9163");
        
        var riskRatingCriteriaManagerWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingCriteriaManagerWindowTitle", language + client);
        var criteriaEditorWindowAddModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowAddModeTitle", language + client);
        var criteriaEditorWindowEditionModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowEditionModeTitle", language + client);
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_CROES_9163_criterion_name", language + client);
        var criterionDescriptionAtCreation = "";
        var criterionNewDescription = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_CROES_9163_criterion_new_description", language + client);
        
        //Delete the criteria with the same name
        Delete_FilterCriterion(criterionName, vServerRQS);
        
        
        /*
            STEP 1 :
            1-Connect to croesus with sysadmin UNI00

            2-In the tool bare menu of Securities Module, click on the button"Risk Rating  Manager " : "Risk Rating criteria" window is displayed,

            3-click on simulation tab then"add" button. : "Add a criterion" windows is displayed.

            4-filling fields:
            Name: CriteriaLM
            selects the Active status
            selects the "Overwrite Feed" option
            Condition:  for each security  having price currency equal to USD,
            
            5-click on Save button. check if "CriteriaLM" criteria is created : "CriteriaLM" criteria is created
        */
        
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        //Check if "Risk Rating criteria" window is displayed
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Title", cmpEqual, riskRatingCriteriaManagerWindowExpectedTitle);
        
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        Log.Message("Create criterion '" + criterionName + "' with empty description.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        
        //Check if "Add a criterion" windows is displayed.
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowAddModeExpectedTitle);
        
        SetCriterionAttributes(criterionName, criterionDescriptionAtCreation, "true", "true", null, "CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToUSD()");
        
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
            
        //Stop if there is any error in pre-conditions
        if (Log.ErrCount > 0)
            return;
            
            
        /*
            STEP 2 :
            In Simulation tab, Select CriteriaLM and click on edit button,
            enter "criteria description" on description field and click on save buton
            validate if description displays criteria description : description displays criteria description
        */
        
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex == null){
            Log.Error("Criterion '" + criterionName + "' not found in the Basic criteria grid of the Simulate tab.");
            return;
        }
        
        Log.Checkpoint("Criterion '" + criterionName + "' is created.");
        
        Log.Message("Select criterion '" + criterionName + "'.");
        var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
        
        
        //Click on the Edit button and Check if "Edit a criterion" windows is displayed.
        Log.Message("Click on Edit button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowEditionModeExpectedTitle);
        
        
        //Ensure that the former description is empty
        if (Get_WinRiskRatingCriteriaEditor_TxtDescription().Text.OleValue != ""){
            Log.Error("Criterion '" + criterionName + "' former description is not empty, this is not expected.");
            return;
        }
        
        
        //Change the Description
        Log.Message("Change the criterion Description to '" + criterionNewDescription + "'.");
        Get_WinRiskRatingCriteriaEditor_TxtDescription().Keys(criterionNewDescription);
        
        
        //Click on Save button and check if the criterion is updated
        Log.Message("Click on Save button and check if the criterion is updated.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex == null){
            Log.Error("Criterion '" + criterionName + "' not found in the grid, this is unexpected.");
            return;
        }
        
        //Select the criterion and Click on Edit button and check the new Description in the Criteria Editor window
        Log.Message("Select the criterion '" + criterionName + "', click on Edit button and check the Description new value in the Criteria Editor window.");
        var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        
        CheckEquals(Get_WinRiskRatingCriteriaEditor_TxtDescription().Text.OleValue, criterionNewDescription, "Criterion '" + criterionName + "' new Description'");
        
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaEditor_BtnCancel().Click();
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //Close Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        RestoreRQS(null, criterionName);
    }
}
