//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : Check if when a user selects (double-click) on subcategory in the Default datagrid, Risk Rating Method window is displayed
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-271
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0271_Tit_Check_if_when_user_double_click_on_subcategory_in_the_default_datagrid_Risk_Rating_Method_window()
{
    try {        
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
        
        var randomIndex = 0;
        for (var i = 1; i <= rowCount; i++){
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
            if (!currentRow.Exists)
                break;
                
            randomIndex = Math.round(Math.random()*(i - 1)) + 1;
        }
        
        //In the datagrid select one subcategory and double-click ; check if  Risk Rating Method window is displayed
        Log.Message("In the datagrid, double-click on row : " + randomIndex);
        var subcategoryColumnIndex = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_ChSubcategory().WPFControlOrdinalNo;
        var randomSubcategoryCell = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", randomIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", subcategoryColumnIndex], 10);
        randomSubcategoryCell.DblClick();
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
    }
}



function CheckIfRiskRatingMethodWindowTitleIsTheExpected()
{
    var riskRatingMethodWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingMethodWindowTitle", language + client);
        
    Log.Message("Check if Risk Rating Method Window is displayed.");
    aqObject.CheckProperty(Get_WinRiskRatingMethod(), "Exists", cmpEqual, true);
        
    if (Get_WinRiskRatingMethod().Exists){
        Log.Message("Check if Risk Rating Method window title is the expected.");
        aqObject.CheckProperty(Get_WinRiskRatingMethod(), "Title", cmpEqual, riskRatingMethodWindowExpectedTitle);
            
        //Close Risk Rating Method window
        Get_WinRiskRatingMethod_BtnClose().Click();
    }
}