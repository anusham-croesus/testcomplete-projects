//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT CR1483_0273_Tit_Check_the_columns_displays_in_each_tab_Corresponding_securities_Production_Final_Simulate_Final



/**
    Description : Check the contents of Risk Rating Criteria Window for Manual category
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-279
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0279_Tit_Check_the_contents_of_Risk_Rating_Criteria_Window_for_Manual_category()
{
    try {
        var security1_number = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0279_Security1_Number", language + client);
        var security1_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0279_Security1_Rating", language + client);
        var security2_number = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0279_Security2_Number", language + client);
        var security2_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0279_Security2_Rating", language + client);
        var security3_number = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0279_Security3_Number", language + client);
        var security3_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0279_Security3_Rating", language + client);
        var riskRatingMethodWindowExpectedRatingLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingMethod_LblRating", language + client);
        var riskRatingMethodWindowExpectedCloseButtonLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingMethod_BtnClose", language + client);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Change Ratings manually in order to display all the Ratings in the Manual overwrite grid
        RateSecurityManually(security1_number, security1_rating);
        RateSecurityManually(security2_number, security2_rating);
        RateSecurityManually(security3_number, security3_rating);
        
        //Open the risk rating criteria manager window, click on Manual overwrite
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Select 'Manual overwrite' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnManualOverwrite().Click();
        
        //Select a random row in the displayed ones
        var rowCount = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
        if (rowCount < 1){
            Log.Error("The 'Manual overwrite' grid row count is less than 1 ; this is unexpected. Row count is : " + rowCount);
            return;
        }
        
        for (var i = 1; i <= rowCount; i++){
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
            if (!currentRow.Exists){
                --i;
                break;
            }
        }
        
        var randomIndex = Math.round(Math.random()*(i - 1)) + 1;
        
        //In the datagrid select one rating and double-click ;
        Log.Message("In the datagrid, double-click on row : " + randomIndex);
        var ratingColumnIndex = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChRating().WPFControlOrdinalNo;
        var randomRatingCell = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", randomIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", ratingColumnIndex], 10);
        var expectedRating = randomRatingCell.WPFControlText;
        randomRatingCell.DblClick();
        
        Log.Message("Check if Risk Rating Method window is displayed.");
        if (!aqObject.CheckProperty(Get_WinRiskRatingMethodManual(), "Exists", cmpEqual, true))
            return;
        
        //Maximize the Risk Rating Method window width
        var windowLeft = Get_WinRiskRatingMethodManual().get_Left();
        var windowWidth = Get_WinRiskRatingMethodManual().get_Width();
        Get_WinRiskRatingMethodManual().set_Left(0);
        Get_WinRiskRatingMethodManual().set_Width(Sys.Desktop.Width);
        
        //Check if Risk Rating Method window contains: Rating fields.
        Log.Message("Check if Rating label exists.");
        if (aqObject.CheckProperty(Get_WinRiskRatingMethodManual_LblRating(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingMethodManual_LblRating(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingMethodManual_LblRating(), "WPFControlText", cmpEqual, riskRatingMethodWindowExpectedRatingLabel);
        }
        
        Log.Message("Check if Rating field exists and its content is the expected.");
        if (aqObject.CheckProperty(Get_WinRiskRatingMethodManual_TxtRating(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingMethodManual_TxtRating(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingMethodManual_TxtRating(), "Text", cmpEqual, expectedRating);
        }
        
        //Check if Risk Rating Method window contains: Description,Symbol,security,subcategory,close, market value, accounts,currency columns
        CheckIfTheExpectedTabsAreDisplayed();
        
        //Check if Risk Rating Method window contains: Close button.
        Log.Message("Check if Close button exists and its text is the expected.");
        if (aqObject.CheckProperty(Get_WinRiskRatingMethodManual_BtnClose(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingMethodManual_BtnClose(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingMethodManual_BtnClose(), "WPFControlText", cmpEqual, riskRatingMethodWindowExpectedCloseButtonLabel);
        }
        
        //Restore Risk Rating Method window size and position
        Get_WinRiskRatingMethodManual().set_Left(windowLeft);
        Get_WinRiskRatingMethodManual().set_Width(windowWidth);
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingMethodManual_BtnClose().Click();
        
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
        
        //Restore Ratings
        ExecuteDefaultSSHCommands();
    }
}