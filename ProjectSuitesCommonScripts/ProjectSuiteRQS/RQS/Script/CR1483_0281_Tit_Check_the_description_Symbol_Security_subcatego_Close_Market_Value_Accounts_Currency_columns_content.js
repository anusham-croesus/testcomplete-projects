//USEUNIT CR1483_Common_functions



/**
    Description : Check the description, Symbol, Security, subcatego, Close, Market Value, Accounts, Currency columns content.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-281
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0281_Tit_Check_the_description_Symbol_Security_subcatego_Close_Market_Value_Accounts_Currency_columns_content()
{
    try {
        var securitiesNumbers = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0281_Securities_Numbers", language + client);
        var arrayOfSecuritiesNumbers = securitiesNumbers.split("|");
        var securitiesRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0281_Securities_Rating", language + client);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Change Ratings manually
        for (var i = 0 ; i < arrayOfSecuritiesNumbers.length; i++)
            RateSecurityManually(arrayOfSecuritiesNumbers[i], securitiesRating, false);
        
        //1- Click on "Risk Rating Manager"  button, in Risk Rating Criteria window , click on Manual overwrite, in the datagrid select  and double-click on Low Rating.
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Select 'Manual overwrite' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnManualOverwrite().Click();
        
        Log.Message("In the datagrid select and double-click on Rating = " + securitiesRating);
        var RatingRowIndex = GetRatingRowIndexInManualOverwriteGrid(securitiesRating);
        var RatingColumnIndex = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChRating().WPFControlOrdinalNo;
        if (RatingRowIndex == null)
            return Log.Error("In the 'Manual overwrite' grid, there is no corresponding security for Rating = " + securitiesRating);
        
        var RatingCell = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", RatingRowIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", RatingColumnIndex], 10);
        RatingCell.DblClick();

        //Steps 2, 3, 4, 5, 6
        CheckSecurityValuesFromRiskRatingMethodWindow(Get_WinRiskRatingMethodManual());
        
        
        //Close Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        //Restore the ratings
        ExecuteDefaultSSHCommands();
    } 
}



/*
    WinRiskRatingMethodWindowObject : Objet de la fenêtre Risk Rating Method
                                    valeurs : Get_WinRiskRatingMethod() ou Get_WinRiskRatingMethodManual()
*/
function CheckSecurityValuesFromRiskRatingMethodWindow(WinRiskRatingMethodWindowObject)
{
    var nonDeterminatedValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0274_NonDeterminatedValue", language + client);
    
    //Select a random row in the displayed ones
    Log.Message("Select a random row in the displayed ones.");
    var rowCount = Get_WinRiskRatingMethod_DgvSecurities().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
    if (rowCount < 1){
    Log.Error("The securities grid row count is less than 1 ; this is unexpected. Row count is : " + rowCount);
    return;
    }
    
    var randomIndex = 0;
    for (var i = 1; i <= rowCount; i++){
    var currentRow = Get_WinRiskRatingMethod_DgvSecurities().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
    if (!currentRow.Exists)
        break;
        
    randomIndex = Math.round(Math.random()*(i - 1)) + 1;
    }
    
    Log.Message("The selected random security row index is : " + randomIndex);
    var securityRow = Get_WinRiskRatingMethod_DgvSecurities().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", randomIndex], 10);
    securityRow.Click();
    
    //In the datagrid select a security and note the following columns value:Description, Symbol,  Security,Subcategory, Close, Market Value, Accounts, Currency, close this window.
    
    var windowLeft = WinRiskRatingMethodWindowObject.get_Left();
    var windowWidth = WinRiskRatingMethodWindowObject.get_Width();
    WinRiskRatingMethodWindowObject.set_Left(0);
    WinRiskRatingMethodWindowObject.set_Width(Sys.Desktop.Width);
    
    var descriptionColumnIndex = Get_WinRiskRatingMethod_DgvSecurities_ChDescription().WPFControlOrdinalNo;
    var symbolColumnIndex = Get_WinRiskRatingMethod_DgvSecurities_ChSymbol().WPFControlOrdinalNo;
    var securityColumnIndex = Get_WinRiskRatingMethod_DgvSecurities_ChSecurity().WPFControlOrdinalNo;
    var subcategoryColumnIndex = Get_WinRiskRatingMethod_DgvSecurities_ChSubcategory().WPFControlOrdinalNo;
    var closeColumnIndex = Get_WinRiskRatingMethod_DgvSecurities_ChClose().WPFControlOrdinalNo;
    var marketValueColumnIndex = Get_WinRiskRatingMethod_DgvSecurities_ChMarketValue().WPFControlOrdinalNo;
    var accountsColumnIndex = Get_WinRiskRatingMethod_DgvSecurities_ChAccounts().WPFControlOrdinalNo;
    var currencyColumnIndex = Get_WinRiskRatingMethod_DgvSecurities_ChCurrency().WPFControlOrdinalNo;
    
    var riskIndexDescriptionValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", descriptionColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", 1], 10).DisplayText);
    var riskIndexSymbolValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", symbolColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", 1], 10).DisplayText);
    var riskIndexSecurityValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", securityColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", 1], 10).DisplayText);
    var riskIndexSubcategoryValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", subcategoryColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", 1], 10).DisplayText);
    var riskIndexCloseValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", closeColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10).DisplayText);
    var riskIndexMarketValueValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", marketValueColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10).DisplayText);
    var riskIndexAccountsValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", accountsColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10).DisplayText);
    var riskIndexCurrencyValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", currencyColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", 1], 10).DisplayText);
    
    WinRiskRatingMethodWindowObject.set_Left(windowLeft);
    WinRiskRatingMethodWindowObject.set_Width(windowWidth);
    
    //Close Risk Rating Method window
    //Get_WinRiskRatingMethod_BtnClose().Click();
    WinRiskRatingMethodWindowObject.Close();
    
    //Close Risk Rating Criteria Manager window
    Get_WinRiskRatingCriteriaManager_BtnClose().Click();
    
    
    //3- Search the same security as step 2.
    
    Log.Message("Search security '" + riskIndexSecurityValue + "' in the security grid.");
    Search_Security(riskIndexSecurityValue);
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_SecurityGrid_ChDescription().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    //4- Compare the noted values( Description, Symbol,  Security,Subcategory, Close, Market Value )with the dispayed values in the data-gride of the securities module. and Currency in the info security. check if we have the same values.
    
    //Get values in the security grid : Description, Symbol, Security, Subcategory, Close
    
    var isSecurityFound = false;
    var securitiesRowCount = Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
    for (var i = 1; i <= securitiesRowCount; i++){
    var securityRow = Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
    if (!securityRow.Exists)
        break;
        
    var securityColumnIndex = Get_SecurityGrid_ChSecurity().WPFControlOrdinalNo;
    var securityValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", securityColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", 1], 10).DisplayText);
    if (securityValue == riskIndexSecurityValue){
        isSecurityFound = true;
        Log.Message("'" + riskIndexSecurityValue + "' security found in the current page of 'Securities' grid at row index : " + i);
        securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", securityColumnIndex], 10).Click();
        
        var descriptionColumnIndex = Get_SecurityGrid_ChDescription().WPFControlOrdinalNo;
        var symbolColumnIndex = Get_SecurityGrid_ChSymbol().WPFControlOrdinalNo;
        var subcategoryColumnIndex = Get_SecurityGrid_ChSubCategory().WPFControlOrdinalNo;
        var closeColumnIndex = Get_SecurityGrid_ChClose().WPFControlOrdinalNo;
        
        var descriptionValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", descriptionColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", 1], 10).DisplayText);
        var symbolValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", symbolColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", 1], 10).DisplayText);
        var subcategoryValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", subcategoryColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", 1], 10).DisplayText);
        var closeValue = VarToStr(securityRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", closeColumnIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10).DisplayText);
        
        break;
    }
    }
    
    if (!isSecurityFound){
    Log.Error("'" + riskIndexSecurityValue + "' security not found in the 'Securities' grid.");
    return;
    }
    
    //Get values in the Security Info window : Currency
    Get_SecuritiesBar_BtnInfo().Click();
    var currencyValue = VarToStr(Get_WinInfoSecurity_GrpDescription_CmbCurrency().SelectedItem.OleValue);
    Get_WinInfoSecurity_BtnCancel().Click();
    
    //Get values in the Security Total Held window : Market Value, accounts
    Get_SecuritiesBar_BtnTotalHeld().Click();
    var marketValueValue = VarToStr(Get_WinTotalHeld_LblMarketValueValue().Text);
    var accountsValue = VarToStr(Get_WinTotalHeld_LblNumberOfAccountsValue().Text);
    Get_WinTotalHeld_BtnClose().Click();
    
    
    //COMPARE VALUES
        
    CheckEquals(riskIndexDescriptionValue, riskIndexDescriptionValue, 'Description');
    CheckEquals(riskIndexSymbolValue, symbolValue, 'Symbol');
    CheckEquals(riskIndexSecurityValue, securityValue, 'Security');
    CheckEquals(riskIndexSubcategoryValue, subcategoryValue, 'Subcategory');
    
    if (StrToFloat(ConvertStrToNumberFormat(riskIndexCloseValue)) == 0){
    Log.Message("The 'Close' value should be '" + nonDeterminatedValue + "' or '" + GetRoundedNumberString(riskIndexCloseValue, 3) + "'");
    if (closeValue == nonDeterminatedValue || closeValue == GetRoundedNumberString(riskIndexCloseValue, 3))
        Log.Checkpoint("The 'Close' value is the expected : " + closeValue);
    else
        Log.Error("The 'Close' value is not the expected one : " + closeValue);
    }
    else
    CheckEquals(GetRoundedNumberString(riskIndexCloseValue, 3), closeValue, 'Close');
    
    CheckEquals(GetRoundedNumberString(riskIndexMarketValueValue, 2), marketValueValue, 'Market Value');
    CheckEquals(riskIndexAccountsValue, accountsValue, 'Accounts');
    CheckEquals(riskIndexCurrencyValue, currencyValue, 'Currency');
}
