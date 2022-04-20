//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT CR1483_EnvironmentPreparation



/**
    Description : Check if Manual rating grid displays three rows, one for each rating possibility (low, medium and high).
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-265
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0265_Tit_Check_if_Manual_rating_grid_displays_three_rows_one_for_each_rating_possibility_low_medium_and_high()
{
    try {
        var security1_number = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0265_Security1_Number", language + client);
        var security1_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0265_Security1_Rating", language + client);
        var security2_number = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0265_Security2_Number", language + client);
        var security2_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0265_Security2_Rating", language + client);
        var security3_number = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0265_Security3_Number", language + client);
        var security3_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0265_Security3_Rating", language + client);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Change Ratings manually
        RateSecurityManually(security1_number, security1_rating, true);
        RateSecurityManually(security2_number, security2_rating, true);
        RateSecurityManually(security3_number, security3_rating, true);
        
        //Open the risk rating criteria manager window, click on Simulation Tab, and then Manual overwrite
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("Select 'Manual overwrite' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnManualOverwrite().Click();
    
        //check if three rows Low, Medium and High are displayed
        Log.Message("Check if all the expected Ratings are displayed in the 'Manual overwrite' grid.");
        var arrayOfExpectedRatingValues = [security1_rating, security2_rating, security3_rating];
        var arrayOfDisplayedRatingValues = GetDisplayedRatingValuesInManualOverwriteGrid();
        
        Log.Message("Expected ratings are : " + arrayOfExpectedRatingValues, arrayOfExpectedRatingValues);
        Log.Message("Displayed ratings are : " + arrayOfDisplayedRatingValues, arrayOfDisplayedRatingValues);
        CheckEquals(arrayOfDisplayedRatingValues.length, arrayOfExpectedRatingValues.length, "Number of displayed Ratings");
        
        for (var i = 0; i < arrayOfExpectedRatingValues.length; i++){
            var isExpectedRatingValueFound = (GetIndexOfItemInArray(arrayOfDisplayedRatingValues, arrayOfExpectedRatingValues[i]) != -1);
            if (isExpectedRatingValueFound)
                Log.Checkpoint("'" + arrayOfExpectedRatingValues[i] + "' rating found in the Manual overwrite grid.");
            else
                Log.Error("'" + arrayOfExpectedRatingValues[i] + "' rating not found in the Manual overwrite grid.");
        }
        
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
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Change securities manual overwrite to false
        RateSecurityManually(security1_number, null, false);
        RateSecurityManually(security2_number, null, false);
        RateSecurityManually(security3_number, null, false);
        
        //Restore the ratings
        ExecuteDefaultSSHCommands();
        
        Terminate_CroesusProcess();
    } 
}



function GetDisplayedRatingValuesInManualOverwriteGrid()
{
    var displayedRatingValues = new Array();
    var RatingColumnIndex = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChRating().WPFControlOrdinalNo;
    var ManualOverwriteGrid = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
    
    //Goto the first row
    ManualOverwriteGrid.Keys("[Home][Home]");
    
    //Navigate through the grid
    var isEndOfGridReached = false;
    while (!isEndOfGridReached){
        ManualOverwriteGrid.Refresh();
        var rowCount = ManualOverwriteGrid.ChildCount;
        for (var rowIndex = 1; rowIndex <= rowCount; rowIndex++){
            var currentRow = ManualOverwriteGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentRatingValue = currentRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10).WPFControlText;
            displayedRatingValues.push(currentRatingValue);
        }
        
        var previousFirstRating = ManualOverwriteGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10).WPFControlText;
        ManualOverwriteGrid.Keys("[PageDown]");
        var currentFirstRating = ManualOverwriteGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10).WPFControlText;
        
        if (previousFirstRating == currentFirstRating){
            var previousFirstRating = ManualOverwriteGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10).WPFControlText;
            ManualOverwriteGrid.Keys("[PageDown]");
            var currentFirstRating = ManualOverwriteGrid.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10).WPFControlText;
            
            if (previousFirstRating == currentFirstRating)
                isEndOfGridReached = true;
        }
    }
    
    return displayedRatingValues;
}