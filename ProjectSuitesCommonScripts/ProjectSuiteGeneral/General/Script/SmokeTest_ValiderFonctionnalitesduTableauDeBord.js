//USEUNIT SmokeTest_Common


/*
    Description : Valider les fonctionnalités du Tableau de bord
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
*/

function SmokeTest_ValiderFonctionnalitesduTableauDeBord()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderFonctionnalitesduTableauDeBord()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        var columnName_Name = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Dashboard_ColumnName_Name", language + client);
        var columnName_FullName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Dashboard_ColumnName_FullName", language + client);
        var columnName_AccountNumber = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Dashboard_ColumnName_AccountNumber", language + client);
        
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked.OleValue", true, 100000);
        
        //1. Déplacer un board dans la surface du Tableau de bord.
        Log.Message("************ MOVE A BOARD IN THE DASHBOARD AREA. ************", "", pmNormal, logAttributes);
        Clear_Dashboard();
        Add_PositiveCashBalanceSummaryBoard();
        Add_NegativeCashBalanceSummaryBoard();
        
        //Move board many times (in either ways)
        Log.Message("1st Move.", "", pmNormal, logAttributes);
        MoveBord();
        
        Log.Message("2nd Move.", "", pmNormal, logAttributes);
        MoveBord();
        
        Log.Message("3rd Move.", "", pmNormal, logAttributes);
        MoveBord();
        
        Log.Message("4th Move.", "", pmNormal, logAttributes);
        MoveBord();
        
        Log.Message("5th Move.", "", pmNormal, logAttributes);
        MoveBord();
        
        
        //2. Double-cliquer sur un client.
        //3. Double-cliquer sur un compte.
        
        //DoubleClickClientAccount for PositiveCashBalanceSummaryBoard
        Log.Message("************ DOUBLE-CLICK ON CLIENT/ACCOUNT IN THE POSITIVE CASH BALANCE SUMMARY BOARD. ************", "", pmNormal, logAttributes);
        Clear_Dashboard();
        Add_PositiveCashBalanceSummaryBoard();
        
        var isDataGridFound = WaitObject(Get_Dashboard_PositiveCashBalanceSummaryBoard(), ["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["RecordListControl", true, 1]);
        var dataGridItemCount = 0;
        if (isDataGridFound){
            var dataGrid = Get_Dashboard_PositiveCashBalanceSummaryBoard_DgvDashboardGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
            dataGridItemCount = dataGrid.Items.Count;
        }
        
        if (dataGridItemCount < 1)
            Log.Warning("There is no item in the Positive Cash Balance Summary Board data grid.");
        else {
            var columnHeader = Get_Dashboard_PositiveCashBalanceSummaryBoard_DgvDashboardGrid_HeaderLabelArea();
            var arrayOfColumnsNames = [columnName_AccountNumber, columnName_FullName, columnName_Name];
            AddColumnsToGrid(columnHeader, arrayOfColumnsNames);
            dataGrid.Refresh();
            
            var dataGridFirstRow = dataGrid.FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, 1], 10); 
            var firstRowFullNameCell = dataGridFirstRow.FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "clientFullName"], 10);
            var firstRowShortNameCell = dataGridFirstRow.FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "clientName"], 10);
            var firstRowAccountNoCell = dataGridFirstRow.FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "accountNumber"], 10);
            
            Log.Message("Double-Click on the Full Name cell and check if the Client window is opened.");
            DoubleClickClientFullName(firstRowFullNameCell, firstRowShortNameCell);
            
            Log.Message("Double-Click on the Short Name cell and check if the Client window is opened.");
            DoubleClickClientShortName(firstRowShortNameCell, firstRowFullNameCell);
            
            Log.Message("Double-Click on the Account No cell and check if the Account window is opened.");
            DoubleClickAccountNo(firstRowAccountNoCell);
        }
        
        
        //DoubleClickClientAccount for NegativeCashBalanceSummaryBoard
        Log.Message("************ DOUBLE-CLICK ON CLIENT/ACCOUNT IN THE NEGATIVE CASH BALANCE SUMMARY BOARD. ************", "", pmNormal, logAttributes);
        Clear_Dashboard();
        Add_NegativeCashBalanceSummaryBoard();
        
        var isDataGridFound = WaitObject(Get_Dashboard_NegativeCashBalanceSummaryBoard(), ["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["RecordListControl", true, 1]);
        var dataGridItemCount = 0;
        if (isDataGridFound){
            var dataGrid = Get_Dashboard_NegativeCashBalanceSummaryBoard_DgvDashboardGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
            dataGridItemCount = dataGrid.Items.Count;
        }
        
        if (dataGridItemCount < 1)
            Log.Warning("There is no item in the Negative Cash Balance Summary Board data grid.")
        else {
            var columnHeader = Get_Dashboard_NegativeCashBalanceSummaryBoard_DgvDashboardGrid_HeaderLabelArea();
            var arrayOfColumnsNames = [columnName_AccountNumber, columnName_FullName, columnName_Name];
            AddColumnsToGrid(columnHeader, arrayOfColumnsNames);
            dataGrid.Refresh();
            
            var dataGridFirstRow = dataGrid.FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, 1], 10); 
            var firstRowFullNameCell = dataGridFirstRow.FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "clientFullName"], 10);
            var firstRowShortNameCell = dataGridFirstRow.FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "clientName"], 10);
            var firstRowAccountNoCell = dataGridFirstRow.FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "accountNumber"], 10);
            
            Log.Message("Double-Click on the Full Name cell and check if the Client window is opened.");
            DoubleClickClientFullName(firstRowFullNameCell, firstRowShortNameCell);
            
            Log.Message("Double-Click on the Short Name cell and check if the Client window is opened.");
            DoubleClickClientShortName(firstRowShortNameCell, firstRowFullNameCell);
            
            Log.Message("Double-Click on the Account No cell and check if the Account window is opened.");
            DoubleClickAccountNo(firstRowAccountNoCell);
        }
        
        
        //DoubleClickClientAccount for InvestmentObjectiveVariationBoard
        Log.Message("************ DOUBLE-CLICK ON CLIENT/ACCOUNT IN THE INVESTMENT OBJECTIVE VARIATION BOARD. ************", "", pmNormal, logAttributes);
        Clear_Dashboard();
        Get_Toolbar_BtnAdd().Click();
        Get_DlgAddBoard_TvwSelectABoard_InvestmentObjectiveVariation().Click();
        Get_DlgAddBoard_BtnOK().Click();
        Get_Dashboard_InvestmentObjectiveVariationBoard().Click(70, 60)
        
        var isDataGridFound = WaitObject(Get_Dashboard_InvestmentObjectiveVariationBoard(), ["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["RecordListControl", true, 1]);
        var dataGridItemCount = 0;
        if (isDataGridFound){
            var dataGrid = Get_Dashboard_InvestmentObjectiveVariationBoard_DgvDashboardGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
            dataGridItemCount = dataGrid.Items.Count;
        }
        
        if (dataGridItemCount < 1)
            Log.Warning("There is no item in the Investment Objective Variation Board data grid.")
        else {
            var columnHeader = Get_Dashboard_InvestmentObjectiveVariationBoard_DgvDashboardGrid_HeaderLabelArea();
            var arrayOfColumnsNames = [columnName_AccountNumber, columnName_Name];
            AddColumnsToGrid(columnHeader, arrayOfColumnsNames);
            dataGrid.Refresh();
            
            var dataGridFirstRow = dataGrid.FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, 1], 10); 
            var firstRowShortNameCell = dataGridFirstRow.FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "clientName"], 10);
            var firstRowAccountNoCell = dataGridFirstRow.FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "accountNumber"], 10);
            
            Log.Message("Double-Click on the Short Name cell and check if the Client window is opened.");
            DoubleClickClientShortName(firstRowShortNameCell);
            
            Log.Message("Double-Click on the Account No cell and check if the Account window is opened.");
            DoubleClickAccountNo(firstRowAccountNoCell);
        }
        
        
        //DoubleClickClientAccount for TriggeredRestrictions
        Log.Message("************ DOUBLE-CLICK ON CLIENT/ACCOUNT IN THE TRIGGERED RESTRICTIONS BOARD. ************", "", pmNormal, logAttributes);
        Clear_Dashboard();
        Get_Toolbar_BtnAdd().Click();
        Get_DlgAddBoard_TvwSelectABoard_TriggeredRestrictions().Click();
        Get_DlgAddBoard_BtnOK().Click();
        Get_Dashboard_TriggeredRestrictionsBoard().Click(70, 60);
        
        var isDataGridFound = WaitObject(Get_Dashboard_TriggeredRestrictionsBoard(), ["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["RecordListControl", true, 1]);
        var dataGridItemCount = 0;
        if (isDataGridFound){
            var dataGrid = Get_Dashboard_TriggeredRestrictionsBoard_DgvDashboardGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
            dataGridItemCount = dataGrid.Items.Count;
        }
        
        if (dataGridItemCount < 1)
            Log.Warning("There is no item in the Triggered Restrictions Board data grid.")
        else {
            var columnHeader = Get_Dashboard_TriggeredRestrictionsBoard_DgvDashboardGrid_HeaderLabelArea();
            var arrayOfColumnsNames = [columnName_AccountNumber, columnName_Name];
            AddColumnsToGrid(columnHeader, arrayOfColumnsNames);
            dataGrid.Refresh();
            
            var dataGridFirstRow = dataGrid.FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, 1], 10);
            var firstRowShortNameCell = dataGridFirstRow.FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "restrictionObjectTypeDescription"], 10);
            var firstRowAccountNoCell = dataGridFirstRow.FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "number"], 10);
            
            Log.Message("Double-Click on the Short Name cell and check if the Client window is opened.");
            DoubleClickClientShortName(firstRowShortNameCell);
            
            Log.Message("Double-Click on the Account No cell and check if the Account window is opened.");
            DoubleClickAccountNo(firstRowAccountNoCell);
        }
        
        //Close Croesus
        Close_Croesus_MenuBar();
        SetAutoTimeOut();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation().Click(Get_DlgConfirmation().Width/3, Get_DlgConfirmation().Height-45);
        RestoreAutoTimeOut();

    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}



function MoveBord()
{   
    var board1 = Get_Dashboard_PositiveCashBalanceSummaryBoard();
    var board2 = Get_Dashboard_NegativeCashBalanceSummaryBoard();
    
    var board1_left = board1.ScreenLeft;
    var board1_top = board1.ScreenTop;
    var board1_width = board1.Width
    
    var board2_left = board2.ScreenLeft;
    var board2_top = board2.ScreenTop;
    var board2_width = board2.Width
    
    //Move board1 to board2 position
    var fromX = board1_width - 100;
    var fromY = 10;
    var distanceX = board2_left - board1_left - 10;
    var distanceY = (board2_top - board1_top < 0)? board2_top - board1_top - 10: board2_top - board1_top + 10;
    Log.Message("Drag Positive Cash Balance Summary Board to : " + distanceX + ", " + distanceY);
    board1.Drag(fromX, fromY, distanceX, distanceY);
    
    //New ScreenLeft or ScreenTop should be different from the former one
    Log.Message("Check if board new position is different from the former one.");
    var new_board1_left = board1.ScreenLeft;
    var new_board1_top = board1.ScreenTop;
    Log.Message("Former position is : " + board1_left + ", " + board1_top);
    Log.Message("New position is : " + new_board1_left + ", " + new_board1_top);
    var isNewPositionDifferentFromTheFormerOne = (new_board1_left != board1_left || new_board1_top != board1_top);
    if (!CompareProperty(isNewPositionDifferentFromTheFormerOne, cmpEqual, true, true, lmError)){
        Log.Error("Make sure that the Dragging delay project option is greater than 50 milliseconds. You could try the maximum value : 1000.");
    }
}



function DoubleClickClientFullName(rowFullNameCell, rowShortNameCell)
{
    SetAutoTimeOut();
    rowFullNameCell.DblClick();
    
    if (Get_DlgInformation().Exists){
        Log.Warning("Information dialog box was displayed.", "", pmHighest, null, Sys.Desktop);
        Get_DlgInformation().Click(Get_DlgInformation().Width/2, Get_DlgInformation().Height - 45);
        RestoreAutoTimeOut();
        return;
    }
    
    RestoreAutoTimeOut();
    
    if (aqObject.CheckProperty(Get_WinDetailedInfo(), "Exists", cmpEqual, true)){
        Get_WinDetailedInfo_TabInfo().Click();
        if (rowShortNameCell != undefined)
            aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().Text, "OleValue", cmpEqual, rowShortNameCell.WPFControlText, true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Text, "OleValue", cmpEqual, rowFullNameCell.WPFControlText, true);
        Get_WinDetailedInfo_BtnCancel().Click();
    }
}



function DoubleClickClientShortName(rowShortNameCell, rowFullNameCell)
{
    SetAutoTimeOut();
    
    rowShortNameCell.DblClick();
    
    if (Get_DlgInformation().Exists){
        Log.Warning("Information dialog box was displayed.", "", pmHighest, null, Sys.Desktop);
        Get_DlgInformation().Click(Get_DlgInformation().Width/2, Get_DlgInformation().Height - 45);
        RestoreAutoTimeOut();
        return;
    }
    
    RestoreAutoTimeOut();
    
    if (aqObject.CheckProperty(Get_WinDetailedInfo(), "Exists", cmpEqual, true)){
        Get_WinDetailedInfo_TabInfo().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().Text, "OleValue", cmpEqual, rowShortNameCell.WPFControlText, true);
        if (rowFullNameCell != undefined)
            aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Text, "OleValue", cmpEqual, rowFullNameCell.WPFControlText, true);
        Get_WinDetailedInfo_BtnCancel().Click();
    }
}



function DoubleClickAccountNo(rowAccountNoCell)
{
    SetAutoTimeOut();
    
    rowAccountNoCell.DblClick();
    
    if (Get_DlgInformation().Exists){
        Log.Warning("Information dialog box was displayed.", "", pmHighest, null, Sys.Desktop);
        Get_DlgInformation().Click(Get_DlgInformation().Width/2, Get_DlgInformation().Height - 45);
        RestoreAutoTimeOut();
        return;
    }
    
    RestoreAutoTimeOut();
    
    if (aqObject.CheckProperty(Get_WinAccountInfo() , "Exists", cmpEqual, true)){
        aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtAccountNumber().Text, "OleValue", cmpEqual, rowAccountNoCell.WPFControlText, true);
        Get_WinAccountInfo_BtnCancel().Click();
    }
}
