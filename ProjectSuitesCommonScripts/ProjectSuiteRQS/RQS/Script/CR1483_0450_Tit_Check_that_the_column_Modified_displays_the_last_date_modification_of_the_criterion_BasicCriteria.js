//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Check that the column "Modified" displays the last date modification of the criterion - Basic Criteria
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-450
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0450_Tit_Check_that_the_column_Modified_displays_the_last_date_modification_of_the_criterion_BasicCriteria()
{
    CR1483_0450_Tit_Check_that_the_column_Modified_displays_the_last_date_modification_of_the_criterion("Basic");
}



/** 
    Le paramètre BasicOrOverwrite doit avoir une des valeurs suivantes :
        - "Basic"
        - "Overwrite"
*/
function CR1483_0450_Tit_Check_that_the_column_Modified_displays_the_last_date_modification_of_the_criterion(BasicOrOverwrite)
{
    if (GetIndexOfItemInArray(["Basic", "Overwrite"], BasicOrOverwrite) == -1){
        Log.error(BasicOrOverwrite + " not expected for the BasicOrOverwrite parameter.");
        return;
    }
        
    try {
        var criteriaEditorWindowEditModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowEditionModeTitle", language + client);
        
        if (BasicOrOverwrite == "Basic")
            var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereCAD", language + client);
        else
            var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereUSD", language + client);
        
        var criterionEditedName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0450_" + BasicOrOverwrite + "Criterion_EditedName", language + client);
        var criterionEditedDate = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0450_" + BasicOrOverwrite + "Criterion_EditedDate", language + client);
        
        //Get Criterion Modified Date
        var criterionOldModifiedDate = GetCriterionModifiedDate(criterionName);
        
        //Change Criterion Modified Date to an old date
        SetCriterionModifiedDate(criterionName, criterionEditedDate);
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Simulation Tab
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Select an active criterion for wich a modified date is different of the system date
        //The criterion Modified Date is supposed to be different from the system date because we modified it by SQL query ; check it.
        
        Log.Message("Select '" + BasicOrOverwrite+ "' rating method.");
        if (BasicOrOverwrite == "Overwrite")
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        else
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
        if (criterionRowIndex == null)
            return;
        
        Log.Message("Check if the criterion Modified date is different of the system date.");
        if (!aqObject.CompareProperty(GetBasicOverwriteCriteriaDisplayedModified(criterionRowIndex), cmpNotEqual, GetCurrentDateString(), true, lmError))
            return;
        
        Log.Message("Check if the criterion Active checkbox is checked.");
        if (!aqObject.CompareProperty(GetBasicOverwriteCriteriaActiveCheckboxValue(criterionRowIndex), cmpEqual, true, true, lmError))
            return;
        
        //Click on Edit button. "Edit a criterion" windows is displayed.
        Log.Message("Select the criterion : " + criterionName);
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10); 
        criterionRow.Click();
        
        Log.Message("Click on Edit button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit().Click();
        
        Log.Message("Check if Risk Rating Criteria Editor Window is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true)){
            Log.Message("Check if Risk Rating Criteria Editor window title is the expected.");
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowEditModeExpectedTitle);
        }
        
        //Change the criterion name
        Log.Message("Change the criterion name to : " + criterionEditedName);
        
        Get_WinRiskRatingCriteriaEditor_TxtName().Clear();
        Get_WinRiskRatingCriteriaEditor_TxtName().Keys(criterionEditedName);
                
        var criterionExpectedModifiedDate = GetCurrentDateString();
        
        //Click on Save button then send to production button (password=GZz7m3vOe).
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        SendToProduction();
        
        //Click on Production tab then Basic Criteria, check if " Modified" colomn displays system date for Criteria edited .
        
        Log.Message("Go to 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        Log.Message("Select '" + BasicOrOverwrite+ "' rating method.");
        if (BasicOrOverwrite == "Overwrite")
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        else
            Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        Log.Message("check if 'Modified' column displays system date for edited criterion : " + criterionEditedName);
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionEditedName);
        aqObject.CompareProperty(GetBasicOverwriteCriteriaDisplayedModified(criterionRowIndex), cmpEqual, criterionExpectedModifiedDate, true, lmError);
        
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



function GetCriterionModifiedDate(criterionName)
{
    //Get the criterion DATE_UPDATED
    var queryString = "SELECT * FROM B_CRIT_RISKRATING where CRIT_ID = " + GetCriterionId(criterionName);
    var fieldName = "DATE_UPDATED";
    Log.Message(queryString);
    return Execute_SQLQuery_GetField(queryString, vServerRQS, fieldName);
}


function SetCriterionModifiedDate(criterionName, newModifiedDate)
{
    //Set the criterion DATE_UPDATED
    var queryString = "UPDATE B_CRIT_RISKRATING SET DATE_UPDATED = " + "CONVERT(datetime, '" + VarToStr(newModifiedDate) + "', 0)" + " where CRIT_ID = " + GetCriterionId(criterionName);
    Log.Message(queryString);
    Execute_SQLQuery(queryString, vServerRQS);
}