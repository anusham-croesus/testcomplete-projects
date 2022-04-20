//USEUNIT CR1483_0297_Tit_Check_that_you_can_change_a_Name_for_an_unassigned_criterion




/**
    Description : Check that you can change a Condition for an unassigned criterion
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-299
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0299_Tit_Check_that_you_can_change_a_Condition_for_an_unassigned_criterion()
{
    try {
        var criteriaEditorWindowEditionModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowEditionModeTitle", language + client);
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0299_criterion_name", language + client);
        
        //Delete the criteria with the same name
        Delete_FilterCriterion(criterionName, vServerRQS);
        
        //Login and go to Security module       
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        
        //Step 1 : In the tool bare menu of Securities Module, click on the button" Risk Rating Manager",
        //Step 2 : Click on Simulation tab then Basic criteria, select  a criterion for which Yesterday, yesterday final, simulate and simulate final is zero and click on the"edit" button.
        if (!CreateBasicCriterionAndCheckIfProductionSimulationAreNull(criterionName, null, "CreateRiskRatingCondition_SecuritiesHavingSecurityCurrencyEqualToUSD()"))
            return;
            
        //Stop if there is any error in pre-conditions
        if (Log.ErrCount > 0)
            return;
        
        var formerCriterionValues = new Array();
        formerCriterionValues.push(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSecurityCurrency", language + client));
        formerCriterionValues.push(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemUSD", language + client));
        
        var newCriterionValues = new Array();
        newCriterionValues.push(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemPriceCurrency", language + client));
        newCriterionValues.push(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCAD", language + client));
        
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex == null){
            Log.Error("Criterion '" + criterionName + "' not found in the Basic criteria grid of the Simulate tab.");
            return;
        }
        
        var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
        
        
        //Click on the Edit button and Check if "Edit a criterion" windows is displayed.
        Log.Message("Click on Edit button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowEditionModeExpectedTitle);
        
        //Validate that the former targetted values are the expected ones
        var criterionValuesIndexes = new Array(); 
        for (var i = 0; i < formerCriterionValues.length; i++){
            Log.Message("Validate that the value '" + formerCriterionValues[i] + "' is present in the former condition.")
            CheckEquals(Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(formerCriterionValues[i]).Exists, true, formerCriterionValues[i] + " value is present");
            //Get targetted value indexe
            criterionValuesIndexes.push(Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(formerCriterionValues[i]).WPFControlOrdinalNo);
        }
        
        //Get Former Condition
        var formerConditionString = GetRiskRatingCriteriaConditionDisplayedText();
        
        //Step 3 : Change the values ​​of the Condition:  for each security  having price currency equal to CAD
        Log.Message("Change the change the values ​​of the Condition to : 'for each security  having price currency equal to CAD'");
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSecurityCurrency", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemPriceCurrency", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
        Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCAD", language + client)).Click();        
        
        //Click on Save button and check if the criterion is updated
        Log.Message("Click on Save button and check if the criterion is updated.");
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex == null){
            Log.Error("Criterion '" + criterionName + "' not found in the grid, this is unexpected.");
            return;
        }
        
        //Select the criterion and Click on Edit button and check the new Condition in the Criteria Editor window
        Log.Message("Select the criterion '" + criterionName + "', click on Edit button and check the new Condition in the Criteria Editor window.");
        var NameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10);
        criterionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NameColumnIndex], 10).Click();
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        
        var newConditionString = GetRiskRatingCriteriaConditionDisplayedText();
        
        if (newConditionString == formerConditionString)
            Log.Error("The new condition string is the same as the former one : " + newConditionString);
        else
            Log.Checkpoint("The new condition string is different from the former one : ", "Former condition string = " + formerConditionString + "\nNew condition string = " + newConditionString);
        
        //Double-check if the targetted values have changed 
        for (var i = 0; i < formerCriterionValues.length; i++){
            Log.Message("Validate that the value '" + formerCriterionValues[i] + "' is not present in the new condition.")
            CheckEquals(Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(formerCriterionValues[i]).Exists, false, formerCriterionValues[i] + " value is present");
        }
        
        for (var i = 0; i < newCriterionValues.length; i++){
            Log.Message("Validate that the value '" + newCriterionValues[i] + "' is present in the new condition.")
            CheckEquals(Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(newCriterionValues[i]).Exists, true, newCriterionValues[i] + " value is present");
            Log.Message("Value '" + newCriterionValues[i] + "' item index should be : " + criterionValuesIndexes[i]);
            CheckEquals(Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(newCriterionValues[i]).WPFControlOrdinalNo, criterionValuesIndexes[i], newCriterionValues[i] + " value item index");
        }
        
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
        RestoreRQS(criterionName);
    }
}



function GetRiskRatingCriteriaConditionDisplayedText()
{
    var arrayOfItemsDisplayedText = new Array();
    
    for (var ListBoxItemIndex = 1; ListBoxItemIndex <= Get_WinRiskRatingCriteriaEditor_LstCondition().ChildCount; ListBoxItemIndex++){
        var ListBoxItemObject = Get_WinRiskRatingCriteriaEditor_LstCondition().WPFObject("ListBoxItem", "", ListBoxItemIndex);
        var arrayOfItemsObjects = ListBoxItemObject.FindAllChildren(["ClrClassName", "VisibleOnScreen"], ["*", true]).toArray();
        var CharRepeaterIndex = 0;
        var PartControlIndex = 0;
        for (var i = arrayOfItemsObjects.length - 1; i >= 0; i--){
            if (arrayOfItemsObjects[i].Find("ClrClassName", "CharRepeater", 0).Exists)
                var itemDisplayedText = VarToStr(ListBoxItemObject.WPFObject("CharRepeater", "", ++CharRepeaterIndex).DataContext.Character.OleValue);
            else {
                var itemDisplayedText = VarToStr(ListBoxItemObject.WPFObject("PartControl", "", ++PartControlIndex).DataContext.SelectedValue.OleValue);
                if (Trim(itemDisplayedText) == "")
                    itemDisplayedText = VarToStr(ListBoxItemObject.WPFObject("PartControl", "", ++PartControlIndex).DataContext.SelectedValue.OleValue);
            }
            
            if (Trim(itemDisplayedText) != "")
                arrayOfItemsDisplayedText.push(itemDisplayedText);
        }
    }
    
    return arrayOfItemsDisplayedText.join(" ");
}
