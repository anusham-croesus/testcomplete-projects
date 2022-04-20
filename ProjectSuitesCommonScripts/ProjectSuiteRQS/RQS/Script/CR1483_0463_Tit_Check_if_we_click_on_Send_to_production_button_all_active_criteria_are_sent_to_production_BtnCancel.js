//USEUNIT CR1483_Common_functions



/**
    Description : Check if we click on Send to production button, all actives criteria are sended to production - Click on BtnCancel
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-463
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0463_Tit_Check_if_we_click_on_Send_to_production_button_all_active_criteria_are_sent_to_production_BtnCancel()
{
    try {
        var winSendToProductionExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinSendToProductionTitle", language + client);
        var basicCriteriaLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "BasicCriteriaLabel", language + client);
        var overwriteCriteriaLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "OverwriteCriteriaLabel", language + client);
        var enabledBasicCriterionNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0463_EnabledBasicCriterionNamePrefix", language + client);
        var disabledBasicCriterionNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0463_DisabledBasicCriterionNamePrefix", language + client);
        var enabledOverwriteCriterionNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0463_EnabledOverwriteCriterionNamePrefix", language + client);
        var disabledOverwriteCriterionNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0463_DisabledOverwriteCriterionNamePrefix", language + client);
        
        
        //Create a set of enabled and disabled criteria
        var nbOfBasicEnabledCriteria = 1;
        var nbOfBasicDisabledCriteria = 1;
        var arrayOfBasicEnabledCriteria = new Array();
        var arrayOfBasicDisabledCriteria = new Array();
        var nbOfOverwriteEnabledCriteria = 1;
        var nbOfOverwriteDisabledCriteria = 1;
        var arrayOfOverwriteEnabledCriteria = new Array();
        var arrayOfOverwriteDisabledCriteria = new Array();
        
        for (var i = 1; i <= nbOfBasicEnabledCriteria; i++){
            var currentCriterionName = enabledBasicCriterionNamePrefix + IntToStr(i);
            arrayOfBasicEnabledCriteria.push(currentCriterionName);
            Delete_FilterCriterion(currentCriterionName, vServerRQS);
        }
        
        for (var i = 1; i <= nbOfBasicDisabledCriteria; i++){
            var currentCriterionName = disabledBasicCriterionNamePrefix + IntToStr(i);
            arrayOfBasicDisabledCriteria.push(currentCriterionName)
            Delete_FilterCriterion(currentCriterionName, vServerRQS);
        }
        
        for (var i = 1; i <= nbOfOverwriteEnabledCriteria; i++){
            var currentCriterionName = enabledOverwriteCriterionNamePrefix + IntToStr(i);
            arrayOfOverwriteEnabledCriteria.push(currentCriterionName);
            Delete_FilterCriterion(currentCriterionName, vServerRQS);
        }
        
        for (var i = 1; i <= nbOfOverwriteDisabledCriteria; i++){
            var currentCriterionName = disabledOverwriteCriterionNamePrefix + IntToStr(i);
            arrayOfOverwriteDisabledCriteria.push(currentCriterionName)
            Delete_FilterCriterion(currentCriterionName, vServerRQS);
        }
        
        //1 : Connect to croesus with sysadmin. Go to the Securities module 
        Log.Message("1 : Connect to croesus with sysadmin. Go to the Securities module.");
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Create Basic criteria
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        for (var i = 0; i < arrayOfBasicEnabledCriteria.length; i++){
            Log.Message("Create criterion : " + arrayOfBasicEnabledCriteria[i]);
            Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
            
            SetCriterionAttributes(arrayOfBasicEnabledCriteria[i], null, "true");
            
            //Criterion Condition
            Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
            Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
            
            Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        }
        
        for (var i = 0; i < arrayOfBasicDisabledCriteria.length; i++){
            Log.Message("Create criterion : " + arrayOfBasicDisabledCriteria[i]);
            Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
            
            SetCriterionAttributes(arrayOfBasicDisabledCriteria[i], null, "false");
            
            //Criterion Condition
            Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
            Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
            
            Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        }
        
        //Create Overwrite criteria
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        
        for (var i = 0; i < arrayOfOverwriteEnabledCriteria.length; i++){
            Log.Message("Create criterion : " + arrayOfOverwriteEnabledCriteria[i]);
            Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
            
            SetCriterionAttributes(arrayOfOverwriteEnabledCriteria[i], null, "true");
            
            //Criterion Condition
            Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
            Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
            
            Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        }
        
        for (var i = 0; i < arrayOfOverwriteDisabledCriteria.length; i++){
            Log.Message("Create criterion : " + arrayOfOverwriteDisabledCriteria[i]);
            Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
            
            SetCriterionAttributes(arrayOfOverwriteDisabledCriteria[i], null, "false");
            
            //Criterion Condition
            Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
            Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
            
            Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        }
        
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //Stop if there is any error in pre-conditions
        if (Log.ErrCount > 0)
            return;
        
        
        //1- Connect to croesus with sysadmin. Go to the Securities module click on Risk Rating Manager button then on Simulation tab.
        Log.Message("1 : Click on Risk Rating Manager button then on Simulation tab.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        //Get Production former Criteria list
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        var arrayOfBasicCriteriaInProduction = GetAllDisplayedCriteriaWithModifiedDateInBasicOverwriteCriteriaGrid();
        Log.Message("There is " + arrayOfBasicCriteriaInProduction.length + " Basic criteria in Production : " + arrayOfBasicCriteriaInProduction, arrayOfBasicCriteriaInProduction);
        
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        var arrayOfOverwriteCriteriaInProduction = GetAllDisplayedCriteriaWithModifiedDateInBasicOverwriteCriteriaGrid();
        Log.Message("There is " + arrayOfOverwriteCriteriaInProduction.length + " Overwrite criteria in Production : " + arrayOfOverwriteCriteriaInProduction, arrayOfOverwriteCriteriaInProduction);
        
        
        //2- In Simulation, Click on Basic criteria and note the list of active criteria and the list of inactive criteria.
        Log.Message("2 : In Simulation, Click on Basic criteria and note the list of active criteria and the list of inactive criteria.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        var arrayOfActiveAndInactiveBasicCriteria = GetListOfActiveAndInactiveCriteriaInBasicOverwriteCriteriaGrid();
        var arrayOfActiveBasicCriteria = arrayOfActiveAndInactiveBasicCriteria[0];
        var arrayOfInactiveBasicCriteria = arrayOfActiveAndInactiveBasicCriteria[1];
        Log.Message("There is " + arrayOfActiveBasicCriteria.length + " active Basic criteria : " + arrayOfActiveBasicCriteria, arrayOfActiveBasicCriteria);
        Log.Message("There is " + arrayOfInactiveBasicCriteria.length + " inactive Basic criteria : " + arrayOfInactiveBasicCriteria, arrayOfInactiveBasicCriteria);
        var nbOfActiveBasicCriteria = arrayOfActiveBasicCriteria.length;
        
        //3- Click on Overwrite criteria and note the list of active criteria and the list of inactive criteria.
        Log.Message("3 : Click on Overwrite criteria and note the list of active criteria and the list of inactive criteria.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        var arrayOfActiveAndInactiveOverwriteCriteria = GetListOfActiveAndInactiveCriteriaInBasicOverwriteCriteriaGrid();
        var arrayOfActiveOverwriteCriteria = arrayOfActiveAndInactiveOverwriteCriteria[0];
        var arrayOfInactiveOverwriteCriteria = arrayOfActiveAndInactiveOverwriteCriteria[1];
        Log.Message("There is " + arrayOfActiveOverwriteCriteria.length + " active Overwrite criteria : " + arrayOfActiveOverwriteCriteria, arrayOfActiveOverwriteCriteria);
        Log.Message("There is " + arrayOfInactiveOverwriteCriteria.length + " inactive Overwrite criteria : " + arrayOfInactiveOverwriteCriteria, arrayOfInactiveOverwriteCriteria);
        var nbOfActiveOverwriteCriteria = arrayOfActiveOverwriteCriteria.length;
        
        //4- Click on Send to production button.
        Log.Message("4 : Click on Send to production button.");
        Get_WinRiskRatingCriteriaManager_BtnSendToProduction().Click();
        Log.Message("Check if 'Send to production' window is displayed.");
        if (aqObject.CheckProperty(Get_WinSendCriteriaToProduction(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinSendCriteriaToProduction(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinSendCriteriaToProduction(), "Title", cmpEqual, winSendToProductionExpectedTitle);
        }
        
        //Get number of Basic criteria and Overwrite criteria displayed in Send Criteria to production window
        Log.Message("Get number of Basic criteria and Overwrite criteria displayed in Send Criteria to production window.");
        var displayedNbOfActiveBasicCriteria = null;
        var displayedNbOfOverwriteCriteria = null;
        var lblNumberOfCriteria = VarToSTr(Get_WinSendCriteriaToProduction_LblNumberOfCriteria().Text.OleValue);
        var arrayLblNumberOfCriteria = lblNumberOfCriteria.split("\r\n");
        for (var i = 0; i < arrayLblNumberOfCriteria.length; i++){
            if (aqString.Find(arrayLblNumberOfCriteria[i], basicCriteriaLabel) != -1)
                displayedNbOfActiveBasicCriteria = StrToInt(Trim(aqString.Replace(arrayLblNumberOfCriteria[i], basicCriteriaLabel, "")));
            
            if (aqString.Find(arrayLblNumberOfCriteria[i], overwriteCriteriaLabel) != -1)
                displayedNbOfOverwriteCriteria = StrToInt(Trim(aqString.Replace(arrayLblNumberOfCriteria[i], overwriteCriteriaLabel, "")));
        }
        
        //5- Check if the number of Basic criteria displayed in Send Criteria to production window is the same active criteria number noted in step 2.
        Log.Message("5 : Check if the number of Basic criteria displayed in Send Criteria to production window is the expected.");
        if (displayedNbOfActiveBasicCriteria === null)
            Log.Error("Unable to get the displayed number of Basic criteria in the 'Send to Production' window.");
        else
            CheckEquals(displayedNbOfActiveBasicCriteria, nbOfActiveBasicCriteria, "Number of Basic criteria displayed in Send Criteria to production window");
        
        //6- Check if the number of Overwrite criteria displayed in Send Criteria to production window is the same active criteria number noted in step 3.
        Log.Message("6 : Check if the number of Overwrite criteria displayed in Send Criteria to production window is the expected.");
        if (displayedNbOfOverwriteCriteria === null)
            Log.Error("Unable to get the displayed number of Overwrite criteria in the 'Send to Production' window.");
        else
            CheckEquals(displayedNbOfOverwriteCriteria, nbOfActiveOverwriteCriteria, "Number of Overwrite criteria displayed in Send Criteria to production window");
        
        
        //7-Click on Cancel button and check if no active criteria and no inactive criteria are sended to production
        Log.Message("7 : Click on Cancel button and check if no active criteria and no inactive criteria are sended to production");
        Get_WinSendCriteriaToProduction_BtnCancel().Click();
        
        //Get Production new Criteria list
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        //Get Production new Basic Criteria list
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        var arrayOfBasicCriteriaInProductionNew = GetAllDisplayedCriteriaWithModifiedDateInBasicOverwriteCriteriaGrid();
        Log.Message("Now, there is " + arrayOfBasicCriteriaInProductionNew.length + " Basic criteria in Production : " + arrayOfBasicCriteriaInProductionNew, arrayOfBasicCriteriaInProductionNew);
        
        CheckEquals(arrayOfBasicCriteriaInProductionNew.length, arrayOfBasicCriteriaInProduction.length, "The new number of Basic criteria in Production");
        
        if (arrayOfBasicCriteriaInProductionNew.length == arrayOfBasicCriteriaInProduction.length){
            for (var i = 0; i < arrayOfBasicCriteriaInProductionNew.length; i++)
                CheckEquals(arrayOfBasicCriteriaInProductionNew[i].toString(), arrayOfBasicCriteriaInProduction[i].toString(), "Basic criteria name and Modified Date in Production in new list at position " + IntToStr(i + 1));
        }
        
        //Get Production new Overwrite Criteria list
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        var arrayOfOverwriteCriteriaInProductionNew = GetAllDisplayedCriteriaWithModifiedDateInBasicOverwriteCriteriaGrid();
        Log.Message("Now, there is " + arrayOfOverwriteCriteriaInProductionNew.length + " Overwrite criteria in Production : " + arrayOfOverwriteCriteriaInProductionNew, arrayOfOverwriteCriteriaInProductionNew);
        
        CheckEquals(arrayOfOverwriteCriteriaInProductionNew.length, arrayOfOverwriteCriteriaInProduction.length, "The new number of Overwrite criteria in Production");
    
        if (arrayOfOverwriteCriteriaInProductionNew.length == arrayOfOverwriteCriteriaInProduction.length){
            for (var i = 0; i < arrayOfOverwriteCriteriaInProductionNew.length; i++)
                CheckEquals(arrayOfOverwriteCriteriaInProductionNew[i].toString(), arrayOfOverwriteCriteriaInProduction[i].toString(), "Overwrite criteria name and Modified Date in Production in new list at position " + IntToStr(i + 1));
        }
        
        //Fermer Croesus
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
		RestoreRQS(arrayOfBasicEnabledCriteria.concat(arrayOfBasicDisabledCriteria), arrayOfOverwriteEnabledCriteria.concat(arrayOfOverwriteDisabledCriteria));
    }
}



function GetAllDisplayedCriteriaWithModifiedDateInBasicOverwriteCriteriaGrid()
{
    var arrayOfDisplayedCriteriaNamesAndModifiedDate = new Array();
    
    var BasicOverwriteCriteriaGrid = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
    if (BasicOverwriteCriteriaGrid.Items.Count == 0)
        return arrayOfDisplayedCriteriaNamesAndModifiedDate;
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    var nameColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName().WPFControlOrdinalNo;
    var modifiedDateColumnIndex = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChModified().WPFControlOrdinalNo;
    
    //Goto the first row
    Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Keys("[Home] [Home]");
    
    //Navigate through the grid
    var isEndOfGridReached = false;
    var arrayOfDisplayedCriteriaNamesAndModifiedDate = new Array();
    while (!isEndOfGridReached){
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().Refresh();
        var rowCount = BasicOverwriteCriteriaGrid.ChildCount;
        for (var rowIndex = 1; rowIndex <= rowCount; rowIndex++){
            var currentRow = BasicOverwriteCriteriaGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentNameValue = currentRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", nameColumnIndex], 10).WPFControlText;
            for (var j = 0; j < arrayOfDisplayedCriteriaNamesAndModifiedDate.length; j++){
                if (arrayOfDisplayedCriteriaNamesAndModifiedDate[j][0] == currentNameValue)
                    continue;
            }
            
            var currentModifiedDateValue = currentRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", modifiedDateColumnIndex], 10).WPFControlText;
            arrayOfDisplayedCriteriaNamesAndModifiedDate.push([currentNameValue, currentModifiedDateValue]);
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
    
    return arrayOfDisplayedCriteriaNamesAndModifiedDate;
}