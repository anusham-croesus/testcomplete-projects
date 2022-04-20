//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions



/**
    Description : Check the contents of Risk Rating Criteria Window for Default gategory
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-272
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0272_Tit_Check_the_contents_of_Risk_Rating_Criteria_Window_for_Default_gategory()
{
    try {
        var riskRatingMethodWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingMethodWindowTitle", language + client);
        var riskRatingMethodWindowExpectedSubcategoryLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingMethod_LblSubcategory", language + client);
        var riskRatingMethodWindowExpectedRatingLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingMethod_LblRating", language + client);
        var riskRatingMethodWindowExpectedCloseButtonLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingMethod_BtnClose", language + client);
        var riskRatingMethodWindowExpectedTabCorrespondingSecuritiesLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingMethod_TabCorrespondingSecurities", language + client);
        var riskRatingMethodWindowExpectedTabProductionFinalLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingMethod_TabProductionFinal", language + client);
        var riskRatingMethodWindowExpectedTabSimulationFinalLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingMethod_TabSimulationFinal", language + client);
        
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //In the securities modul click on "Risk Rating  Manager"  button, in Risk Rating Criteria window , click on Default subcategory,
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("Open the Risk Rating Criteria Manager window.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("click on Default subcategories.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories().Click();
        
        //In the datagrid select one subcategory and double-click ; check if  Risk Rating Method window is displayed
        
        //Select a random row in the displayed ones
        var rowCount = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
        if (rowCount < 1){
            Log.Error("The Default Subcategories grid row count is less than 1 ; this is unexpected. Row count is : " + rowCount);
            return;
        }
        
        for (var i = 1; i <= rowCount; i++){
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
            if (!currentRow.Exists){
                --i;
                break;
            }
                
            
        }
        
        var randomIndex = Math.round(Math.random()*(i - 1)) + 1;
        
        //Get the grid data
        var expectedSubcategory = GetDefaultSubcategoriesDisplayedSubcategory(randomIndex);
        var expectedRating = GetDefaultSubcategoriesDisplayedRating(randomIndex);
        var expectedCorrespondingSecurities = GetDefaultSubcategoriesDisplayedNbOfCorrespondingSecurities(randomIndex);
        var expectedProductionFinal = GetDefaultSubcategoriesDisplayedNbOfProductionFinal(randomIndex);
        var expectedSimulationFinal = GetDefaultSubcategoriesDisplayedNbOfSimulationFinal(randomIndex);
        
        //Expected tabs displayed labels
        var expectedTabCorrespondingSecuritiesLabel = riskRatingMethodWindowExpectedTabCorrespondingSecuritiesLabel + " (" + expectedCorrespondingSecurities + ")";
        var expectedTabProductionFinalLabel = riskRatingMethodWindowExpectedTabProductionFinalLabel + " (" + expectedProductionFinal + ")";
        var expectedTabSimulationFinalLabel = riskRatingMethodWindowExpectedTabSimulationFinalLabel + " (" + expectedSimulationFinal + ")";
        
        
        //In the datagrid select one subcategory and double-click ; check if  Risk Rating Method window is displayed
        Log.Message("In the datagrid, double-click on row : " + randomIndex);
        var subcategoryColumnIndex = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChSubcategory().WPFControlOrdinalNo;
        var randomSubcategoryCell = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", randomIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", subcategoryColumnIndex], 10);
        randomSubcategoryCell.DblClick();
        
        
        //Check if Risk Rating Method window contains:
        //- Subcategory and Rating fields.
        //- Three tabs (Corresponding securities, Production Final, Simulation Final)
        //- Close button.
        
        Log.Message("Check if Risk Rating Method window is displayed.");
        if (!aqObject.CheckProperty(Get_WinRiskRatingMethod(), "Exists", cmpEqual, true))
            return;
        
        Log.Message("Check if Subcategory label exists.");
        if (aqObject.CheckProperty(Get_WinRiskRatingMethod_LblSubcategory(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingMethod_LblSubcategory(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingMethod_LblSubcategory(), "WPFControlText", cmpEqual, riskRatingMethodWindowExpectedSubcategoryLabel);
        }
        
        Log.Message("Check if Subcategory field exists and its content is the expected.");
        if (aqObject.CheckProperty(Get_WinRiskRatingMethod_TxtSubcategory(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingMethod_TxtSubcategory(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingMethod_TxtSubcategory(), "Text", cmpEqual, expectedSubcategory);
        }
        
        Log.Message("Check if Rating label exists.");
        if (aqObject.CheckProperty(Get_WinRiskRatingMethod_LblRating(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingMethod_LblRating(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingMethod_LblRating(), "WPFControlText", cmpEqual, riskRatingMethodWindowExpectedRatingLabel);
        }
        
        Log.Message("Check if Rating field exists and its content is the expected.");
        if (aqObject.CheckProperty(Get_WinRiskRatingMethod_TxtRating(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingMethod_TxtRating(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingMethod_TxtRating(), "Text", cmpEqual, expectedRating);
        }
        
        Log.Message("Check if Corresponding securities tab exists and its label is the expected.");
        if (aqObject.CheckProperty(Get_WinRiskRatingMethod_TabCorrespondingSecurities(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingMethod_TabCorrespondingSecurities(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingMethod_TabCorrespondingSecurities(), "WPFControlText", cmpEqual, expectedTabCorrespondingSecuritiesLabel);
        }
        
        Log.Message("Check if Production Final tab exists and its label is the expected.");
        if (aqObject.CheckProperty(Get_WinRiskRatingMethod_TabProductionFinal(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingMethod_TabProductionFinal(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingMethod_TabProductionFinal(), "WPFControlText", cmpEqual, expectedTabProductionFinalLabel);
        }
        
        Log.Message("Check if Simulation Final tab exists and its label is the expected.");
        if (aqObject.CheckProperty(Get_WinRiskRatingMethod_TabSimulationFinal(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingMethod_TabSimulationFinal(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingMethod_TabSimulationFinal(), "WPFControlText", cmpEqual, expectedTabSimulationFinalLabel);
        }
        
        Log.Message("Check if Close button exists and its text is the expected.");
        if (aqObject.CheckProperty(Get_WinRiskRatingMethod_BtnClose(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingMethod_BtnClose(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingMethod_BtnClose(), "WPFControlText", cmpEqual, riskRatingMethodWindowExpectedCloseButtonLabel);
        }
        
        //Close Risk Rating Criteria Method window
        Get_WinRiskRatingMethod_BtnClose().Click();
        
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