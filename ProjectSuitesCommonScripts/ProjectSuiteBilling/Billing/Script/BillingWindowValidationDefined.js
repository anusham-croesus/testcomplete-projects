//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Helper

function GenerateAndValidateBillingWindowDefined(executedScript)
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var boldAttribute = Log.CreateNewAttributes();
    boldAttribute.Bold = true;
    
    // Load expected data for Billing window.
    // Expected data is loaded into memory and compared with actual data from Billing window.
    //
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var scriptName = executedScript;
    var excelSheetName = (client == "BNC") ? executedScript + "BNC" : executedScript;
    var excelFile = Excel.Open(filePath_Billing);
    var excelSheet = excelFile.SheetByTitle(excelSheetName);        
    var excelSheetColumn = (language == undefined || language == "english") ? 3 : 2;    
    var relationshipShortName = excelSheet.Cell(excelSheetColumn, 20).Value;
    var relationshipFullName = excelSheet.Cell(excelSheetColumn, 21).Value;    
    
    Log.CallStackSettings.EnableStackOnCheckpoint = true;
    Log.Message("***** Execution of '" + functionName + "' started for script '" + scriptName + "'.", "", pmNormal, boldAttribute);       
    Log.AppendFolder("Loading expected data for Billing window from Excel spreadsheet.");
    Log.Message("Opening Excel file: " + filePath_Billing + ".");
    Log.Message("Reading from Excel sheet: " + excelSheetName + ".");      

    // Load Cashflow Adjustements values (Script)
    //
    Log.AppendFolder("Cashflow Adjustments.");
    Log.Message("Reading Cashflow Adjustments (Test Execution) from Excel spreadsheet.");   
    var cashflowAdjustmentPercentInflow = excelSheet.Cell(excelSheetColumn, 24).Value;
    var cashflowAdjustmentPercentOutflow = excelSheet.Cell(excelSheetColumn, 25).Value;
    var cashflowAdjustmentAmountInflow = excelSheet.Cell(excelSheetColumn, 26).Value;
    var cashflowAdjustmentAmountOutflow = excelSheet.Cell(excelSheetColumn, 27).Value;
    Log.Checkpoint("Reading Cashflow Adjustments (Test Execution) completed.");

    // Load Cashflow Adjustements values (Defaults)
    //    
    Log.Message("Reading Cashflow Adjustments (Defaults) from Excel spreadsheet.");   
    var cashflowAdjustmentPercentInflowDefault = excelSheet.Cell(excelSheetColumn, 30).Value;
    var cashflowAdjustmentPercentOutflowDefault = excelSheet.Cell(excelSheetColumn, 31).Value;
    var cashflowAdjustmentAmountInflowDefault = excelSheet.Cell(excelSheetColumn, 32).Value;
    var cashflowAdjustmentAmountOutflowDefault = excelSheet.Cell(excelSheetColumn, 33).Value;
    Log.Checkpoint("Reading Cashflow Adjustments (Defaults) completed.");     
    Log.PopLogFolder();
    
    // Load expected data in Relationships Groupbox from Excel spreadsheet
    //
    var excelSheetRelationshipsStartRow = excelSheet.Cell(excelSheetColumn, 2).Value;
    var expectedRelationshipsGroupbox = [];
    var expectedNumberElementsRelationshipsGroupbox = excelSheet.Cell(excelSheetColumn, excelSheetRelationshipsStartRow-2).Value;
    var numberColumnsRelationshipsGroupbox = excelSheet.Cell(excelSheetColumn, 6).Value;

    Log.AppendFolder("Expected data in Relationships groupbox.");
    Log.Message("Reading expected data in Relationships groupbox from Excel spreadsheet.");   
    for (var currentElementRelationshipsGroupbox = 0; currentElementRelationshipsGroupbox < expectedNumberElementsRelationshipsGroupbox; currentElementRelationshipsGroupbox++)
    {
      var currentRelationship = [];
      var excelRowOffset = (currentElementRelationshipsGroupbox * (numberColumnsRelationshipsGroupbox + 1));
      
      for (var currentRowNumber = (excelSheetRelationshipsStartRow + excelRowOffset); currentRowNumber < (excelSheetRelationshipsStartRow + excelRowOffset + numberColumnsRelationshipsGroupbox); currentRowNumber++)
      {
        currentRelationship.push(excelSheet.Cell(excelSheetColumn, currentRowNumber).Value);
      }
      
      expectedRelationshipsGroupbox.push(currentRelationship);
    }

    var dateBillingGenerated = aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y");
    var timestampBillingGenerated = dateBillingGenerated + " 12:00:00 AM";
    Log.Message("Generating Billing date: " + dateBillingGenerated + ".");
    
    // Add Billing generation timestamp to expected data from Relationships groupbox
    //
    Log.Message("Billing generation timestamp added to expected data from Relationships groupbox.");
    for (var currentElementRelationshipsGroupbox = 0; currentElementRelationshipsGroupbox < expectedNumberElementsRelationshipsGroupbox; currentElementRelationshipsGroupbox++)
    {
      expectedRelationshipsGroupbox[currentElementRelationshipsGroupbox][2] = timestampBillingGenerated;
      expectedRelationshipsGroupbox[currentElementRelationshipsGroupbox][3] += " 12:00:00 AM";
    }
    
    Log.Checkpoint("Reading expected data in Relationships groupbox from Excel spreadsheet completed.");
    Log.PopLogFolder(); 
    
    // Load expected data in Accounts Groupbox from Excel spreadsheet
    //
    var excelSheetAccountsStartRow = excelSheet.Cell(excelSheetColumn, 3).Value;
    var expectedAccountsGroupbox = [];
    var numberElementsAccountsGroupbox = excelSheet.Cell(excelSheetColumn, excelSheetAccountsStartRow - 2).Value;
    var numberColumnsAccountsGroupbox = excelSheet.Cell(excelSheetColumn, 7).Value;

    var numberFeesAssetClasses = excelSheet.Cell(excelSheetColumn, excelSheetAccountsStartRow + numberColumnsAccountsGroupbox + 1).Value;
    var excelSheetFeesStartRow = excelSheetAccountsStartRow + numberColumnsAccountsGroupbox + 2;
    var numberColumnsFeesExpandableFieldRecord = excelSheet.Cell(excelSheetColumn, 8).Value;
        
    Log.AppendFolder("Expected data in Accounts groupbox.");
    Log.Message("Reading expected data in Accounts groupbox from Excel spreadsheet.");
    
    for (var currentBillingRow = 0; currentBillingRow < expectedNumberElementsRelationshipsGroupbox; currentBillingRow++)
    {
      var currentBillingPeriod = [];
    
      currentBillingPeriod.push(excelSheet.Cell(excelSheetColumn, excelSheetAccountsStartRow + 7));
    
      for (var currentAccountRow = 0; currentAccountRow < numberElementsAccountsGroupbox; currentAccountRow++)
      {
        var currentAccount = [];
        for (var currentAccountColumn = 0; currentAccountColumn < numberColumnsAccountsGroupbox; currentAccountColumn++)
        {
          currentAccount.push(excelSheet.Cell(excelSheetColumn, (excelSheetAccountsStartRow + currentAccountColumn)).Value);
        }
        
        // Add Billing generation timestamp to expected data from Accounts groupbox
        //
        currentAccount[7] += " 12:00:00 AM";
        currentAccount[8] = timestampBillingGenerated;
 
        for (var currentFeesAssetsClassesRow = 0; currentFeesAssetsClassesRow < numberFeesAssetClasses; currentFeesAssetsClassesRow++)
        {
          var currentFees = [];

          for (var currentFeesAssetClassesColumn = 0; currentFeesAssetClassesColumn < numberColumnsFeesExpandableFieldRecord; currentFeesAssetClassesColumn++)
          {
            currentFees.push(excelSheet.Cell(excelSheetColumn, excelSheetFeesStartRow + currentFeesAssetClassesColumn));
          }
          currentAccount.push(currentFees);
          excelSheetFeesStartRow += numberColumnsFeesExpandableFieldRecord;
        }
        
        currentBillingPeriod.push(currentAccount);
        excelSheetAccountsStartRow = excelSheetAccountsStartRow + numberColumnsAccountsGroupbox + (numberFeesAssetClasses * numberColumnsFeesExpandableFieldRecord) + 3;
        excelSheetFeesStartRow = excelSheetAccountsStartRow + numberColumnsAccountsGroupbox + 2;
        numberFeesAssetClasses = excelSheet.Cell(excelSheetColumn, excelSheetAccountsStartRow + numberColumnsAccountsGroupbox + 1).Value;
      }
    
      expectedAccountsGroupbox.push(currentBillingPeriod);
    }

    Log.Checkpoint("Reading expected data in Accounts groupbox from Excel spreadsheet completed.");
    Log.PopLogFolder();
    
    // Load expected data in Messages Groupbox from Excel spreadsheet
    //
    var excelSheetMessagesStartRow = excelSheet.Cell(excelSheetColumn, 4).Value;
    var expectedMessagesGroupbox = [];
    var expectedNumberElementsMessagesGroupbox = excelSheet.Cell(excelSheetColumn, excelSheetMessagesStartRow-1).Value;
    var numberColumnsMessagesGroupbox = excelSheet.Cell(excelSheetColumn, 9).Value;
                  
    Log.AppendFolder("Expected data in Messages groupbox.");
    Log.Message("Reading expected data in Messages groupbox from Excel spreadsheet.");
   
    for (var currentElementMessagesGroupbox = 0; currentElementMessagesGroupbox < expectedNumberElementsMessagesGroupbox; currentElementMessagesGroupbox++)
    {
      expectedMessagesGroupbox.push(excelSheet.Cell(excelSheetColumn, excelSheetMessagesStartRow + currentElementMessagesGroupbox).Value); 
    }
  
    Log.Checkpoint("Reading expected data in Messages groupbox completed.");
    Log.PopLogFolder();

    // Load Summary (CAD) Groupbox data into memory
    //
    Log.AppendFolder("Expected data in Summary (CAD) groupbox.");
    Log.Message("Reading expected data in Summary (CAD) groupbox from Excel spreadsheet.");

    var excelSheetSummaryCADStartRow = excelSheet.Cell(excelSheetColumn, 5).Value;
    var expectedSummaryCADGroupbox = [];
    var numberElementsSummaryCADGroupbox = excelSheet.Cell(excelSheetColumn, excelSheetSummaryCADStartRow-1).Value;

    for (var currentElementSummaryCADGroupbox = 0; currentElementSummaryCADGroupbox < numberElementsSummaryCADGroupbox; currentElementSummaryCADGroupbox++)
    {
      expectedSummaryCADGroupbox.push(excelSheet.Cell(excelSheetColumn, excelSheetSummaryCADStartRow + currentElementSummaryCADGroupbox).Value);
    }

    Log.Checkpoint("Reading expected data in Summary (CAD) groupbox completed.");
    Log.PopLogFolder();
        
    errorCountAfterExecution = Log.ErrCount;
    if (errorCountAfterExecution == errorCountBeforeExecution)
    {
      Log.Checkpoint("Loading expected data for Billing window from Excel spreadsheet completed successfully with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");
    }
    else
    {
      Log.Message("Loading expected data for Billing window from Excel spreadsheet completed with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");      
    }
    Log.PopLogFolder();
        
    // Preparation of vServer and database for script execution
    //
    errorCountBeforeExecution = Log.ErrCount;
          
    Log.AppendFolder("Preparation of test envionment on " + vServerBilling + " for client "+ client + ".");
    Log.Message("Using Excel sheet '" + excelSheetName + "' from file " + filePath_Billing + ".");
    
    Log.AppendFolder("Executing SQL scripts on: " + vServerBilling + ".");
    Log.AppendFolder("EmptyBillingHistory()");
    EmptyBillingHistory();
    Log.PopLogFolder();
    Log.AppendFolder("UncheckedAUMBillable()");
    UncheckedAUMBillable();
    Log.PopLogFolder();
    Log.AppendFolder("UncheckedBillableRelationships()");
    UncheckedBillableRelastionShip();
    Log.PopLogFolder();    
    Log.PopLogFolder();

    errorCountAfterExecution = Log.ErrCount;
    if (errorCountAfterExecution == errorCountBeforeExecution)
    {
      Log.Checkpoint("Preparation of test envronment completed successfully with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");
    }
    else
    {
      Log.Message("Preparation of test environment completed with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");      
    }

    // Launch Croesus Advisor and perform Login
    //   
    errorCountBeforeExecution = Log.ErrCount;
                
    Log.PopLogFolder();
    Log.AppendFolder("Launch Croesus Advisor and Login with user: " + userNameBilling + ".");
    
    Login(vServerBilling, userNameBilling, pswBilling, language);
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
            
    errorCountAfterExecution = Log.ErrCount;
    if (errorCountAfterExecution == errorCountBeforeExecution)
    {
      Log.Checkpoint("Launch of Croesus Advisor and Login with user: " + userNameBilling + " completed successfully with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");
    }
    else
    {
      Log.Message("Launch of Croesus Advisor and Login with user: " + userNameBilling + "completed with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");      
    }
    
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerBilling + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);
    
    // Generating Billing
    //   
    errorCountBeforeExecution = Log.ErrCount;
    Log.AppendFolder("Generation of Billing window in Croesus Advisor.");

    var billingStartDate = excelSheet.Cell(excelSheetColumn, 10).Value;
        
    // Open Relationships module
    Get_ModulesBar_BtnRelationships().Click();
    SearchRelationshipByName(relationshipShortName); 
    // Double-Click on Billing Relationship
    Delay(1000);
    Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipShortName,100).DblClick();
    // Check Billable Relationship
    Delay(1000);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Set_IsChecked(true);
    Delay(1000);
    Get_WinDetailedInfo_BtnApply().Click(); 
    // Select Billing tab
    Delay(3000);
    Get_WinDetailedInfo_TabBillingForRelationship().Click();
    Delay(1000);
    Get_WinDetailedInfo_BtnApply().Click();
    
    if (cashflowAdjustmentAmountInflow != "N/A")
    {
      EnterCashflowAdjustments(cashflowAdjustmentPercentInflow, cashflowAdjustmentPercentOutflow, cashflowAdjustmentAmountInflow, cashflowAdjustmentAmountOutflow);
    }
    
    EnterBillingTabAccountsGroupbox(billingStartDate);
       
    // Close Billing tab
    Delay(1000);
    Get_WinDetailedInfo_BtnApply().Click();
    Delay(1000);
    Get_WinDetailedInfo_BtnOK().Click();
    var inArrears = aqConvert.VarToBool(excelSheet.Cell(excelSheetColumn, 11).Value);
    // Click on Tools/Billing
    Delay(1000);
    Get_MenuBar_Tools().DblClick();
    Get_MenuBar_Tools().Click();
    Get_MenuBar_Tools_Billing().Click();    

    if (inArrears)
    {
      Get_WinBillingParameters_RdoInArrears().Click();      
    }
    else
    {
      Get_WinBillingParameters_RdoInAdvance().Click();
    }
    var frequencyAnnual = aqConvert.VarToBool(excelSheet.Cell(excelSheetColumn, 12).Value);
    var frequencySemiannual = aqConvert.VarToBool(excelSheet.Cell(excelSheetColumn, 13).Value);
    var frequencyQuarterly = aqConvert.VarToBool(excelSheet.Cell(excelSheetColumn, 14).Value);
    var frequencyMonthly = aqConvert.VarToBool(excelSheet.Cell(excelSheetColumn, 15).Value);
    
    Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(frequencyAnnual);
    Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(frequencySemiannual);
    Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(frequencyQuarterly);
    Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(frequencyMonthly);

    var billingParametersYear = excelSheet.Cell(excelSheetColumn, 16).Value;    
    var billingParametersMonth = excelSheet.Cell(excelSheetColumn, 17).Value;
    
    // Select Billing Date
    Get_WinBillingParameters_DtpBillingDate().Click(7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8), Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7);
    Get_Calendar_LstYears_Item(billingParametersYear).Click();
    Delay(1000);
    Get_Calendar_LstMonths_Item(billingParametersMonth).Click();
    Get_Calendar_BtnOK().Click();
    Get_WinBillingParameters_BtnOK().Click();
    WaitUntilCroesusDialogBoxClose();
    Get_WinBilling().Parent.Maximize();
    
    if (Get_WinBilling().Parent.Exists)
    {
      Log.Checkpoint("Billing window successfully generated.");
    }
    else
    {
      Log.Error("Billing window not successfully generated.");
    }
    
    errorCountAfterExecution = Log.ErrCount;
    if (errorCountAfterExecution == errorCountBeforeExecution)
    {
      Log.Checkpoint("Generation of Billing window in Croesus Advisor completed successfully with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");
    }
    else
    {
      Log.Message("Generation of Billing window in Croesus Advisor completed with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");      
    }

    // Retrieve Relationships, Accounts, Fees Tiers, and Messages groupboxes column names
    //
    var propertiesArray = ["ClrClassName", "WPFControlOrdinalNo"];
    var valuesArray = ["LabelPresenter", 1];
    var columnNamesRelationshipsGroupbox = GetColumnNames(Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).FindChild(propertiesArray, valuesArray, 100).Parent, numberColumnsRelationshipsGroupbox);
    var columnNamesAccountsGroupbox = GetColumnNames(Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Find(propertiesArray, valuesArray, 100).Parent, numberColumnsAccountsGroupbox);
    var columnNamesMessagesGroupbox = GetColumnNames(Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Find(propertiesArray, valuesArray, 100).Parent, numberColumnsMessagesGroupbox);
    var accountCount = aqConvert.StrToInt(Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).FindChild("WPFControlOrdinalNo", "17", 100).WPFControlText);

    for (var i = 0; i < accountCount; i++)
    {
      if (Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (i + 1)).ExpansionIndicatorVisibility.OleValue == "Visible")
      {
        Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (i + 1)).set_IsExpanded(true);
        var columnNamesFeesAssetClassExpandable = GetColumnNames(Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (i + 1)).Find(propertiesArray, valuesArray, 100).Parent, numberColumnsFeesExpandableFieldRecord);
        Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (i + 1)).set_IsExpanded(false);
      }    
    }
            
    // Validation of Relationships Groupbox data and Accounts Groupbox data
    //
    errorCountBeforeExecution = Log.ErrCount;
    Log.PopLogFolder();
    Log.AppendFolder("Validation of Relationships and Accounts groupboxes.");
  
    // Get number of billing periods in Relationships groupbox
    var actualNumberElementsRelationshipsGroupbox = Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Count;

    Log.AppendFolder("Validation of number of billing periods in Relationships groupbox.");
    if (actualNumberElementsRelationshipsGroupbox == expectedNumberElementsRelationshipsGroupbox)
    {
      Log.Checkpoint("Expecting " + expectedNumberElementsRelationshipsGroupbox + " billing periods." + " Found " + actualNumberElementsRelationshipsGroupbox + " billing periods as expected.");
    }
    else
    {
      Log.Error("Expecting " + expectedNumberElementsRelationshipsGroupbox + " billing periods." + " Found " + actualNumberElementsRelationshipsGroupbox + " billing periods instead of the expected " + expectedNumberElementsRelationshipsGroupbox + ".");
    }

    Log.PopLogFolder();

    // Validating each row from the Relationships groupbox. While validating Relationships groupbox row, validate corresponding Account and Fees Asset Classes in Accounts Groupbox
    //
    for (var currentRowRelationshipsGroupbox = 0; currentRowRelationshipsGroupbox < actualNumberElementsRelationshipsGroupbox; currentRowRelationshipsGroupbox++)
    {
      var currentBillingPeriod = expectedRelationshipsGroupbox[currentRowRelationshipsGroupbox][3];
      var currentRowObject = Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Find("Value", currentBillingPeriod, 100).Parent;
      
      Log.AppendFolder("Validation of billing period '" + currentBillingPeriod.substr(0, 10) + "'.");
      Log.AppendFolder("Validation of Relationships groupbox element.");
                  
      currentRowObject.Click();
      currentRowObject.Refresh();

      // Validating each column of current row
      //
      var currentExpected;
      var currentActual;
      var currentColumnName;

      for (var currentColumnRelationshipsGroupbox = 0; currentColumnRelationshipsGroupbox < numberColumnsRelationshipsGroupbox; currentColumnRelationshipsGroupbox++)
      {
        currentExpected = aqConvert.VarToStr(expectedRelationshipsGroupbox[currentRowRelationshipsGroupbox][currentColumnRelationshipsGroupbox]);
        currentActual = aqConvert.VarToStr(currentRowObject.FindChild("WPFControlOrdinalNo", (currentColumnRelationshipsGroupbox + 1), 100).WPFControlText);
        currentColumnName = columnNamesRelationshipsGroupbox[currentColumnRelationshipsGroupbox]; 
        CheckIfEqual(currentActual, currentExpected, "Validation of column '" + currentColumnName + "'.");        
      }

      // Validating each account related to current Relationships groupbox element
      //
      // Get number of actual accounts in Accounts groupbox from current Relationships groupbox column "Number of Accounts"
      Log.PopLogFolder();
      Log.AppendFolder("Validation of Accounts groupbox elements.");
      Log.AppendFolder("Validation of number of accounts for Billing period " + currentBillingPeriod.substr(0, 10) + ".");
      
      var expectedNumberAccounts = aqConvert.StrToInt(currentRowObject.FindChild("WPFControlOrdinalNo", "17", 100).WPFControlText);
      var actualNumberAccounts = Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Count;
      
      if (actualNumberAccounts == expectedNumberAccounts)
      {
        Log.Checkpoint("Expecting " + expectedNumberAccounts + " accounts for Billing period " + currentBillingPeriod.substr(0, 10) + ". Found " + actualNumberAccounts + " accounts as expected.");
      }
      else
      {
        Log.Error("Expecting " + expectedNumberAccounts + " accounts for Billing period " + currentBillingPeriod.substr(0,10) + ". Found " + actualNumberAccounts + " accounts.");
      }

      Log.PopLogFolder();
      
      for (currentAccount = 0; currentAccount < actualNumberAccounts; currentAccount++)
      {
        var currentAccountNumber = Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Find("WPFControlText", expectedAccountsGroupbox[currentRowRelationshipsGroupbox][currentAccount+1][1],100).WPFControlText;
        var currentAccountRowObject = Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Find("WPFControlText", expectedAccountsGroupbox[currentRowRelationshipsGroupbox][currentAccount+1][1],100).parent;

        Log.AppendFolder("Validation of account " + currentAccountNumber + " (" + (currentAccount+1) + " of " + actualNumberAccounts + ").");        

        // Validate columns for current account
        //
        for (var currentColumnAccountsGroupbox = 0; currentColumnAccountsGroupbox < numberColumnsAccountsGroupbox; currentColumnAccountsGroupbox++)
        {
          currentExpected = aqConvert.VarToStr(expectedAccountsGroupbox[currentRowRelationshipsGroupbox][currentAccount+1][currentColumnAccountsGroupbox]);
          currentActual = aqConvert.VarToStr(currentAccountRowObject.FindChild("WPFControlOrdinalNo", (currentColumnAccountsGroupbox + 1), 100).WPFControlText);
          currentColumnName = columnNamesAccountsGroupbox[currentColumnAccountsGroupbox]; 
          CheckIfEqual(currentActual, currentExpected, "Validation of column '" + currentColumnName + "'.");           
        }
        
        // Expand Asset Classes and validate for current account
        //
        propertiesArray = ["WPFControlText", "WPFControlOrdinalNo"];
        valuesArray = [currentAccountNumber, 2];
        
        var cellValuePresenterAccount = Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).FindChild(propertiesArray, valuesArray, 100);
        var dataRecordPresenterAccount = GetNthParent(cellValuePresenterAccount, 3);
        
        Log.AppendFolder("Validating Asset Classes for account '" + currentAccountNumber + "' for Billing period '" + currentBillingPeriod.substr(0, 10) + "'.");        
        Log.AppendFolder("Validation of number of Asset Classes for account '" + currentAccountNumber + "' for Billing period '" + currentBillingPeriod.substr(0, 10) + "'.");
        
        if (dataRecordPresenterAccount.ExpansionIndicatorVisibility.OleValue == "Visible")
        {
          dataRecordPresenterAccount.IsExpanded = true;
          Delay(500);
          
          var actualNumberAssetClasses = dataRecordPresenterAccount.WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Count;          
          var expectedNumberAssetClasses = (expectedAccountsGroupbox[currentRowRelationshipsGroupbox][currentAccount + 1].length) - numberColumnsAccountsGroupbox;
          
          if (actualNumberAssetClasses == expectedNumberAssetClasses)
          {
            Log.Checkpoint("Expecting " + expectedNumberAssetClasses + " Asset Classes for account '" + currentAccountNumber + "' for Billing period '" + currentBillingPeriod.substr(0, 10) + "'. Found " + actualNumberAssetClasses + " asset classes as expected.");
            Log.PopLogFolder();
                        
            // Validate Asset Classes
            //
            propertiesArray = ["ClrClassName", "WPFControlOrdinalNo"];
            for (var currentAssetClass = 0; currentAssetClass < actualNumberAssetClasses; currentAssetClass++)    
            {
              valuesArray = ["DataRecordPresenter", currentAssetClass + 1];
              currentAssetClassRow = dataRecordPresenterAccount.WPFObject("RecordListControl", "", 1).Find(propertiesArray, valuesArray, 100);
              Log.AppendFolder("Validating Asset Class " + (currentAssetClass + 1) + " of " + actualNumberAssetClasses + ".");
          
              for (var currentColumnFeesGrid = 0; currentColumnFeesGrid < numberColumnsFeesExpandableFieldRecord; currentColumnFeesGrid++)
              {
                valuesArray = ["CellValuePresenter", currentColumnFeesGrid + 1];
                currentExpected = aqConvert.VarToStr(expectedAccountsGroupbox[currentRowRelationshipsGroupbox][currentAccount + 1][numberColumnsAccountsGroupbox + currentAssetClass][currentColumnFeesGrid].Value);
                currentActual = currentAssetClassRow.FindChild(propertiesArray, valuesArray, 100).WPFControlText;
                currentColumnName = columnNamesFeesAssetClassExpandable[currentColumnFeesGrid];
                CheckIfEqual(currentActual, currentExpected, "Validation of column '" + currentColumnName + "'."); 
              }
              
              Log.PopLogFolder();         
            }
            
            dataRecordPresenterAccount.IsExpanded = false;          
            Log.PopLogFolder();
            Log.PopLogFolder();                      
          }
          else
          {
            Log.Error("Expecting " + expectedNumberAssetClasses + " Asset Classes for account '" + currentAccountNumber + "' for Billing period '" + currentBillingPeriod.substr(0,10) + ". Found " + actualNumberAssetClasses + " accounts.");
            Log.Message("Validation of asset classes for account '" + currentAccountNumber + "' will not continue.");
            Log.PopLogFolder(); // NEW
          }                             
        }
        else
        {          
          if (expectedAccountsGroupbox[currentRowRelationshipsGroupbox][currentAccount + 1].length == numberColumnsAccountsGroupbox)
          {
            Log.Checkpoint("Expecting no asset classes for account '" + currentAccountNumber + "'. Found no asset classes as expected.");
          }
          else
          {
            Log.Error("Expecting asset classes for account '" + currentAccountNumber + "'. Found none.");
            Log.Message("Validation of asset classes for account '" + currentAccountNumber + "' will not continue.");
          }
          Log.PopLogFolder(); 
          Log.PopLogFolder();
          Log.PopLogFolder();    
        }
      }
      
      Log.PopLogFolder();
      Log.PopLogFolder();      
    }
      
    errorCountAfterExecution = Log.ErrCount;
    if (errorCountAfterExecution == errorCountBeforeExecution)
    {
      Log.Checkpoint("Validation of Relationships and Accounts groupboxes completed successfully with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");
    }
    else
    {
      Log.Message("Validation of Relationships and Accounts groupboxes completed with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");      
    }

    // Validation of Messages Groupbox data
    //
    errorCountBeforeExecution = Log.ErrCount;
    Log.PopLogFolder();
    Log.AppendFolder("Validation of Messages groupbox.");      
  
    // Get number of elements in Messages groupbox
    var actualNumberElementsMessagesGroupbox = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;

    Log.AppendFolder("Validation of number of Messages.");   
    if (actualNumberElementsMessagesGroupbox == expectedNumberElementsMessagesGroupbox)
    {
      Log.Checkpoint("Expecting " + expectedNumberElementsMessagesGroupbox + " Messages. Found " + actualNumberElementsMessagesGroupbox + " Messages as expected.");
      Log.PopLogFolder();
      for (var currentElementMessagesGroupbox = 0; currentElementMessagesGroupbox < actualNumberElementsMessagesGroupbox; currentElementMessagesGroupbox++)
      {
         var actualMessage = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Item(currentElementMessagesGroupbox).DataItem.ErrorMessage.OleValue;
         var actualRelationshipName = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Item(currentElementMessagesGroupbox).DataItem.RelationshipName.OleValue;
         Log.AppendFolder("Validating Message " + (currentElementMessagesGroupbox + 1) + " of " + actualNumberElementsMessagesGroupbox + ".");
         CheckIfEqual(actualRelationshipName, relationshipFullName, "Validation of column '" + columnNamesMessagesGroupbox[1] + "'.");
         CheckIfEqual(actualMessage, expectedMessagesGroupbox[currentElementMessagesGroupbox], "Validation of column '" + columnNamesMessagesGroupbox[3] + "'.");
         Log.PopLogFolder();     
      }
    }
    else
    {
      Log.Error("Expecting " + expectedNumberElementsMessagesGroupbox + " Messages. Found " + actualNumberElementsMessagesGroupbox + " Messages instead of the expected " + expectedNumberElementsMessagesGroupbox + " Messages.");
      Log.PopLogFolder();
    }

    errorCountAfterExecution = Log.ErrCount;
    if (errorCountAfterExecution == errorCountBeforeExecution)
    {
      Log.Checkpoint("Validation of Messages groupbox completed successfully with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");
    }
    else
    {
      Log.Message("Validation of Messages groupbox completed with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");      
    }    

    // Validation of Summary (CAD) Groupbox data
    //
    errorCountBeforeExecution = Log.ErrCount;    
    Log.PopLogFolder();
    Log.AppendFolder("Validation of Summary (CAD) groupbox.");      

    Log.AppendFolder("Validating 'Billing Date:' TextBlock.");    
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_LblBillingDate(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_LblBillingDate(), "Visible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_LblBillingDate(), "Enabled", cmpEqual, true);
    Log.PopLogFolder();
            
    Log.AppendFolder("Validating the Billing Date value.");
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtBillingDate(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtBillingDate(), "Visible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtBillingDate(), "Enabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtBillingDate(), "WPFControlText", cmpEqual, expectedSummaryCADGroupbox[0]);
    Log.PopLogFolder(); 
      
    Log.AppendFolder("Validating 'Total Fees:' TextBlock.");
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_LblTotalFees(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_LblTotalFees(), "Visible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_LblTotalFees(), "Enabled", cmpEqual, true);
    Log.PopLogFolder(); 
          
    Log.AppendFolder("Validating the Total Fees value.");
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtTotalFees(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtTotalFees(), "Visible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtTotalFees(), "Enabled", cmpEqual, true);       
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtTotalFees(), "WPFControlText", cmpEqual, expectedSummaryCADGroupbox[1]);
    Log.PopLogFolder(); 
          
    Log.AppendFolder("Validating 'Fees per IA:' TextBlock.");
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_LblIATotalFees(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_LblIATotalFees(), "Visible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_LblIATotalFees(), "Enabled", cmpEqual, true);
    Log.PopLogFolder();  
    
    Log.AppendFolder("Validating the IA Code value.");
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtIATotalFeesBD88(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtIATotalFeesBD88(), "Visible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtIATotalFeesBD88(), "Enabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtIATotalFeesBD88(), "WPFControlText", cmpEqual, expectedSummaryCADGroupbox[2]);
    Log.PopLogFolder(); 
       
    Log.AppendFolder("Validating the Total Fees per IA value."); 
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtIATotalFees9047763(), "Exists", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtIATotalFees9047763(), "Visible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtIATotalFees9047763(), "Enabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtIATotalFees9047763(), "WPFControlText", cmpEqual, expectedSummaryCADGroupbox[3]);    
    
    Log.PopLogFolder();
    errorCountAfterExecution = Log.ErrCount;
    if (errorCountAfterExecution == errorCountBeforeExecution)
    {
      Log.Checkpoint("Validation of Summary (CAD) groupbox completed successfully with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");
    }
    else
    {
      Log.Message("Validation of Summary (CAD) groupbox completed with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");      
    }                
  }
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  
  finally
  {
    errorCountBeforeExecution = Log.ErrCount;
    Log.PopLogFolder();
    Log.AppendFolder("Restauration of test environment");
    Log.AppendFolder("Closing Croesus Advisor.");
    Get_WinBilling_BtnCancel().Click();
    Delay(1000);
    Get_ModulesBar_BtnRelationships().Click();
    SearchRelationshipByName(relationshipShortName);
    Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipShortName,100).DblClick();
    Get_WinDetailedInfo_TabBillingForRelationship().Click();
    
    if (cashflowAdjustmentAmountInflow != "N/A")
    {
      EnterCashflowAdjustments(cashflowAdjustmentPercentInflowDefault, cashflowAdjustmentPercentOutflowDefault, cashflowAdjustmentAmountInflowDefault, cashflowAdjustmentAmountOutflowDefault);
    }

    Get_WinDetailedInfo_BtnOK().Click();
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
    Log.PopLogFolder();
    
    Log.AppendFolder("Terminating Processes.");
    
    Log.Message("Terminating Croesus Advisor process.");
    if (Sys.Process("CroesusClient").Exists) Sys.Process("CroesusClient").Terminate();
    
    Log.Message("Terminating Internet Explorer process.");    
    if (Sys.Process("iexplore").Exists) Sys.Process("iexplore").Terminate();
    
    Log.PopLogFolder();
    
    Log.AppendFolder("Executing SQL scripts on: " + vServerBilling + ".");
    Log.AppendFolder("EmptyBillingHistory()");
    EmptyBillingHistory();
    Log.PopLogFolder();
    Log.AppendFolder("UncheckedAUMBillable()");
    UncheckedAUMBillable();
    Log.PopLogFolder();
    Log.AppendFolder("UncheckedBillableRelationships()");
    UncheckedBillableRelastionShip();
    Log.PopLogFolder();    
    Log.PopLogFolder();
    
    errorCountAfterExecution = Log.ErrCount;
    if (errorCountAfterExecution == errorCountBeforeExecution)
    {
      Log.Checkpoint("Restauration of test environment to initial state completed successfully with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");
    }
    else
    {
      Log.Message("Restauration of test environment to initial state completed with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");      
    }     
    Log.PopLogFolder();

    if (errorCountAfterExecution == 0)
    {
      Log.Checkpoint("***** Execution of script '" + functionName + "' completed successfully with " + errorCountAfterExecution + " errors.", "", pmNormal, boldAttribute);
    }
    else
    {
      Log.Error("***** Execution of script '" + functionName + "' completed with " + errorCountAfterExecution + " errors.", "", pmNormal, boldAttribute, Sys.Process("TestComplete"));
    }    
  }
}