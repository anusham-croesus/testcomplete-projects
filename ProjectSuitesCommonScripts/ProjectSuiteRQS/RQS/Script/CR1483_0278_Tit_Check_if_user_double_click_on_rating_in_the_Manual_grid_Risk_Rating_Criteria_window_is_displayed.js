//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions



/**
    Description : in the securities modul click on Risk Rating Manger button , click on manual overwrite double-click on rating (exemple  Low).Main Window, Risk Rating Method window is displayed
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-278
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0278_Tit_Check_if_user_double_click_on_rating_in_the_Manual_grid_Risk_Rating_Criteria_window_is_displayed()
{
    try {
        var security_number = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0278_Security_Number", language + client);
        var security_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0278_Security_Rating", language + client);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Change Rating manually in order to display the Low Rating row in the Manual overwrite grid
        RateSecurityManually(security_number, security_rating);
        
        //Open the risk rating criteria manager window, click on Simulation Tab, and then Manual overwrite
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("Select 'Manual overwrite' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnManualOverwrite().Click();
        
        //In the datagrid select and double-click on Low Rating, check if  Risk Rating Method window is displayed
        var RatingRowIndex = GetRatingRowIndexInManualOverwriteGrid(security_rating);
        if (RatingRowIndex == null){
            Log.Error("'" + security_rating + "' rating not found in the 'Manual overwrite' grid.");
            return;
        }
        
        var RatingColumnIndex = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChRating().WPFControlOrdinalNo;
        var RatingCell = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", RatingRowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10);
        RatingCell.DblClick();
        
        CheckIfRiskRatingMethodWindowTitleIsTheExpected();
        
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



function CheckIfRiskRatingMethodWindowTitleIsTheExpected()
{
    var riskRatingMethodWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingMethodWindowTitle", language + client);
    
    Log.Message("Check if Risk Rating Method Window is displayed.");
    aqObject.CheckProperty(Get_WinRiskRatingMethodManual(), "Exists", cmpEqual, true);
    
    if (Get_WinRiskRatingMethodManual().Exists){
        Log.Message("Check if Risk Rating Method window title is the expected.");
        aqObject.CheckProperty(Get_WinRiskRatingMethodManual(), "Title", cmpEqual, riskRatingMethodWindowExpectedTitle);
        
        //Close Risk Rating Method window
        Get_WinRiskRatingMethodManual_BtnClose().Click();
    }
}