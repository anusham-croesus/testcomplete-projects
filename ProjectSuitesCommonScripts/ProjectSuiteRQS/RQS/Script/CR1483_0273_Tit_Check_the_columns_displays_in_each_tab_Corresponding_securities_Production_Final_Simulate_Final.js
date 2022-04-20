//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : Check if each tab (Corresponding securities, Production Final, Simulate Final) displays
    the following columns:Description, Symbol, Security, subcategory, Close, Market Value, Accounts, Currency
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-273
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0273_Tit_Check_the_columns_displays_in_each_tab_Corresponding_securities_Production_Final_Simulate_Final()
{
    try {
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //In the securities modul click on "Risk Rating  Manager"  button, in Risk Rating Criteria window , click on Default subcategory,
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //1- Click on " Risk Rating Manager"  button, in the Risk Rating Criteria window , click on Default category, in the datagrid select  and double-click on Subcategory.
        
        Log.Message("Open the Risk Rating Criteria Manager window.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("click on Default subcategories.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories().Click();
        
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
        
        Log.Message("Check if Risk Rating Method window is displayed.");
        if (!aqObject.CheckProperty(Get_WinRiskRatingMethod(), "Exists", cmpEqual, true))
            return;
        
        var windowLeft = Get_WinRiskRatingMethod().get_Left();
        var windowWidth = Get_WinRiskRatingMethod().get_Width();
        Get_WinRiskRatingMethod().set_Left(0);
        Get_WinRiskRatingMethod().set_Width(Sys.Desktop.Width);
        
        //2- Click on Corresponding securities tab and check if the following columns : Description, Symbol,  Security, Subcategory,Close, Market Value, Accounts, Currency are displayed.
        Log.Message("Click on Corresponding securities tab.");
        Get_WinRiskRatingMethod_TabCorrespondingSecurities().Click();
        CheckIfTheExpectedTabsAreDisplayed();
        
        //3- Click on Production Final tab and check if the following columns:Description, Symbol,  Security,subcategory, Close, Market Value, Accounts, Currency are displayed.
        Log.Message("Click on Production Final tab tab.");
        Get_WinRiskRatingMethod_TabProductionFinal().Click();
        CheckIfTheExpectedTabsAreDisplayed();
        
        //4- Click on Simulate Final tab and check if the following columns:Description, Symbol,  Security,subcategory, Close, Market Value, Accounts, Currency are displayed
        Log.Message("Click on Simulation Final tab tab.");
        Get_WinRiskRatingMethod_TabSimulationFinal().Click();
        CheckIfTheExpectedTabsAreDisplayed();
        
        Get_WinRiskRatingMethod().set_Left(windowLeft);
        Get_WinRiskRatingMethod().set_Width(windowWidth);
        
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



function CheckIfTheExpectedTabsAreDisplayed()
{
    //Les fonctions Get des entêtes de colonnes recherchent le texte affiché ; donc si le composant de l'entête existe, cela veut dire que le texte est celui attendu
    
    Log.Message("Check if the following columns : Description, Symbol,  Security, Subcategory, Close, Market Value, Accounts, Currency are displayed.")
    
    Log.Message("Check if the 'Description' column is displayed.");
    if (aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChDescription(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChDescription(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Symbol' column is displayed.");
    if (aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChSymbol(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChSymbol(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Security' column is displayed.");
    if (aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChSecurity(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChSecurity(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Subcategory' column is displayed.");
    if (aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChSubcategory(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChSubcategory(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Close' column is displayed.");
    if (aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChClose(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChClose(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Market Value' column is displayed.");
    if (aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChMarketValue(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChMarketValue(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Accounts' column is displayed.");
    if (aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChAccounts(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChAccounts(), "VisibleOnScreen", cmpEqual, true);
    
    Log.Message("Check if the 'Currency' column is displayed.");
    if (aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChCurrency(), "Exists", cmpEqual, true))
        aqObject.CheckProperty(Get_WinRiskRatingMethod_DgvSecurities_ChCurrency(), "VisibleOnScreen", cmpEqual, true);
}