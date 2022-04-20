﻿//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions



/**
    Description : Check if the Rating colomn contents is High or Low in (Simulation and Production view)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-255
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0255_Tit_Check_if_the_Rating_colomn_contents_is_High_or_Low_in_Simulation_and_Production_view()
{
    try {
        var lowRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Low", language + client);
        var highRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_High", language + client);
        var arrayOfExpectedRatings = [lowRating, highRating];
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Simulation Tab then Default category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        CheckRatingColumnValues(arrayOfExpectedRatings);
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //Open the risk rating criteria manager window, click on Production Tab then Default category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        CheckRatingColumnValues(arrayOfExpectedRatings);
        
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
    } 
}



function CheckRatingColumnValues(arrayOfExpectedRatings)
{
    if (GetVarType(arrayOfExpectedRatings) != varArray && GetVarType(arrayOfExpectedRatings) != varDispatch)
        arrayOfExpectedRatings = new Array(arrayOfExpectedRatings);
    
    Log.Message("Select 'Default subcategories' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories().Click();
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    //Goto the first row
    Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().Keys("[Home]");
    Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().Keys("[Home]");
    
    //Navigate through the grid in other to find the needed subcategory
    var isEndOfGridReached = false;
    var isIssueFound = false;
    while (!isEndOfGridReached){
        var rowCount = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
        for (var i = 1; i <= rowCount; i++){
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentRatingValue = GetDefaultSubcategoriesDisplayedRating(i);
            if (GetIndexOfItemInArray(arrayOfExpectedRatings, currentRatingValue) == -1){
                isIssueFound = true;
                var currentSubcategoryValue = GetDefaultSubcategoriesDisplayedSubcategory(i);
                Log.Error(currentSubcategoryValue + " subcategory : the rating value '" + currentRatingValue + "' is not expected ; expected rating values are : " + arrayOfExpectedRatings);
            }
        }
        
        var previousFirstSubcategory = GetDefaultSubcategoriesDisplayedSubcategory(1);
        Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().Keys("[PageDown]");
        var currentFirstSubcategory = GetDefaultSubcategoriesDisplayedSubcategory(1);
        
        if (previousFirstSubcategory == currentFirstSubcategory){
            var previousFirstSubcategory = GetDefaultSubcategoriesDisplayedSubcategory(1);
            Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().Keys("[PageDown]");
            var currentFirstSubcategory = GetDefaultSubcategoriesDisplayedSubcategory(1);
            
            if (previousFirstSubcategory == currentFirstSubcategory)
                isEndOfGridReached = true;
        }  
    }
    
    if (!isIssueFound)
        Log.Checkpoint("All displayed rating values are expected, each is one of the following values : " + arrayOfExpectedRatings);
}