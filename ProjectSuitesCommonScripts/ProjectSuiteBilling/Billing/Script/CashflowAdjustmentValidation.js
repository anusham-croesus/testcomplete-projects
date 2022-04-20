//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Helper

function CashflowAdjustmentValidation()
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var boldAttribute = Log.CreateNewAttributes();
    boldAttribute.Bold = true;
    
    // Load expected data for Billing window.
    // Expected data loaded into memory and compared with actual data from Messages groupbox in Billing window.
    //
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var excelSheetName = "CFAdjustmentsValidation" + ((client == "BNC") ? "BNC" : "");
    var excelFile = Excel.Open(filePath_Billing);
    var excelSheet = excelFile.SheetByTitle(excelSheetName);        
    var excelSheetColumn = (language == undefined || language == "english") ? 3 : 2;    
    var relationshipShortName = [];
    var relationshipFullName = [];
    var numberScenarios = excelSheet.Cell(excelSheetColumn, 2).Value;
        
    for (var i = 0; i < 5; i++)
    {
      relationshipShortName[i] = excelSheet.Cell(excelSheetColumn, 15).Value;
      relationshipFullName[i] = excelSheet.Cell(excelSheetColumn, 16).Value;
    }
    
    for (var i = 5; i < numberScenarios; i++)
    {
      relationshipShortName[i] = excelSheet.Cell(excelSheetColumn, 19).Value;
      relationshipFullName[i] = excelSheet.Cell(excelSheetColumn, 20).Value;
    }
    
    Log.CallStackSettings.EnableStackOnCheckpoint = true;
    Log.Message("***** Execution of script '" + functionName + "' started.", "", pmNormal, boldAttribute);       
    Log.AppendFolder("Loading expected data for Messages groupbox from Excel spreadsheet.");
    Log.Message("Opening Excel file: " + filePath_Billing + ".");
    Log.Message("Reading from Excel sheet: " + excelSheetName + ".");      


    var cashflowAdjustmentPercentInflow = [];
    var cashflowAdjustmentPercentOutflow = [];
    var cashflowAdjustmentAmountInflow = [];
    var cashflowAdjustmentAmountOutflow = [];
    
    // Load Cashflow Adjustements values for all scenarios (Script)
    //
    Log.AppendFolder("Cashflow Adjustments.");
    Log.Message("Reading Cashflow Adjustments (Test Execution) from Excel spreadsheet.");
    
    for (var currentScenario = 0; currentScenario < numberScenarios; currentScenario++)
    {
      cashflowAdjustmentPercentInflow[currentScenario] = aqConvert.StrToFloat(excelSheet.Cell(excelSheetColumn, (23 + (6 * currentScenario))).Value);
      cashflowAdjustmentPercentOutflow[currentScenario] = aqConvert.StrToFloat(excelSheet.Cell(excelSheetColumn, (24 + (6 * currentScenario))).Value);
      cashflowAdjustmentAmountInflow[currentScenario] = aqConvert.StrToFloat(excelSheet.Cell(excelSheetColumn, (25 + (6 * currentScenario))).Value);
      cashflowAdjustmentAmountOutflow[currentScenario] = aqConvert.StrToFloat(excelSheet.Cell(excelSheetColumn, (26 + (6 * currentScenario))).Value);
    }
    
    Log.Checkpoint("Reading Cashflow Adjustments (Test Execution) completed.");

    // Load Cashflow Adjustements values (Defaults)
    //    
    Log.Message("Reading Cashflow Adjustments (Defaults) from Excel spreadsheet.");   
    var cashflowAdjustmentPercentInflowDefault = aqConvert.StrToFloat(excelSheet.Cell(excelSheetColumn, 23).Value);
    var cashflowAdjustmentPercentOutflowDefault = aqConvert.StrToFloat(excelSheet.Cell(excelSheetColumn, 24).Value);
    var cashflowAdjustmentAmountInflowDefault = aqConvert.StrToFloat(excelSheet.Cell(excelSheetColumn, 25).Value);
    var cashflowAdjustmentAmountOutflowDefault = aqConvert.StrToFloat(excelSheet.Cell(excelSheetColumn, 26).Value);
    Log.Checkpoint("Reading Cashflow Adjustments (Defaults) completed.");     
    Log.PopLogFolder();
   
    // Load expected data in Messages Groupbox from Excel spreadsheet
    //
    var excelSheetMessagesStartRow = excelSheet.Cell(excelSheetColumn, 3).Value;
    var currentStartRow = excelSheetMessagesStartRow;
    var expectedMessagesGroupbox = [];
    var expectedNumberElementsMessagesGroupbox = excelSheet.Cell(excelSheetColumn, excelSheetMessagesStartRow).Value;
    var numberColumnsMessagesGroupbox = excelSheet.Cell(excelSheetColumn, 4).Value;
                  
    Log.AppendFolder("Expected data in Messages groupbox.");
    Log.Message("Reading expected data in Messages groupbox from Excel spreadsheet.");

    for (var currentScenario = 0; currentScenario < numberScenarios; currentScenario++)
    {
      var currentMessages = [];
      var numberMessages = aqConvert.StrToInt(excelSheet.Cell(excelSheetColumn, currentStartRow).Value)
      
      currentMessages[0] = numberMessages;
      
      for (var currentMessage = 0; currentMessage < numberMessages; currentMessage++)
      {
        currentMessages[currentMessage + 1] = excelSheet.Cell(excelSheetColumn, currentStartRow + currentMessage + 1).Value;
      }
      
      expectedMessagesGroupbox.push(currentMessages);
      currentStartRow = currentStartRow + numberMessages + 3;
    }
  
    Log.Checkpoint("Reading expected data in Messages groupbox completed.");
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
    var billingStartDate = excelSheet.Cell(excelSheetColumn, 5).Value;
    var inArrears = aqConvert.VarToBool(excelSheet.Cell(excelSheetColumn, 6).Value);
    var frequencyAnnual = aqConvert.VarToBool(excelSheet.Cell(excelSheetColumn, 7).Value);
    var frequencySemiannual = aqConvert.VarToBool(excelSheet.Cell(excelSheetColumn, 8).Value);
    var frequencyQuarterly = aqConvert.VarToBool(excelSheet.Cell(excelSheetColumn, 9).Value);
    var frequencyMonthly = aqConvert.VarToBool(excelSheet.Cell(excelSheetColumn, 10).Value);
    var billingParametersYear = excelSheet.Cell(excelSheetColumn, 11).Value;    
    var billingParametersMonth = excelSheet.Cell(excelSheetColumn, 12).Value;
        
    for (var currentScenario = 0; currentScenario < numberScenarios; currentScenario++)
    { 
      errorCountBeforeExecution = Log.ErrCount;
      var scenarioString = aqString.Format("Scenario %0*i", 2, (currentScenario + 1));
    
      Log.AppendFolder("Validation of " + scenarioString + ": Percentage Inflow: " + cashflowAdjustmentPercentInflow[currentScenario] + "% / Percentage Outflow: " + cashflowAdjustmentPercentOutflow[currentScenario] + "% / Amount Inflow: $" + cashflowAdjustmentAmountInflow[currentScenario] + " / Amount Ouflow: $" + cashflowAdjustmentAmountOutflow[currentScenario]);
      Log.AppendFolder("Generation of Billing window in Croesus Advisor for Relationship: " + relationshipFullName[currentScenario] +".");
        
      // Open Relationships module
      Get_ModulesBar_BtnRelationships().Click();
      SearchRelationshipByName(relationshipShortName[currentScenario]); 
      // Double-Click on Billing Relationship
      Delay(1000);
      Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipShortName[currentScenario],100).DblClick();
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
      EnterCashflowAdjustments(cashflowAdjustmentPercentInflow[currentScenario], cashflowAdjustmentPercentOutflow[currentScenario], cashflowAdjustmentAmountInflow[currentScenario], cashflowAdjustmentAmountOutflow[currentScenario]);
      EnterBillingTabAccountsGroupbox(billingStartDate);
       
      // Close Billing tab
      Delay(1000);
      Get_WinDetailedInfo_BtnApply().Click();
      Delay(1000);
      Get_WinDetailedInfo_BtnOK().Click();

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
    
      Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(frequencyAnnual);
      Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(frequencySemiannual);
      Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(frequencyQuarterly);
      Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(frequencyMonthly);
    
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
        Log.Checkpoint("Generation of Billing window in Croesus Advisor for Relationship: " + relationshipFullName[currentScenario] + " completed successfully with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");
      }
      else
      {
        Log.Message("Generation of Billing window in Croesus Advisor for Relationship: " + relationshipFullName[currentScenario] + " completed with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");      
      }

      // Retrieve Messages groupbox column names
      //
      var propertiesArray = ["ClrClassName", "WPFControlOrdinalNo"];
      var valuesArray = ["LabelPresenter", 1];
      var columnNamesMessagesGroupbox = GetColumnNames(Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Find(propertiesArray, valuesArray, 100).Parent, numberColumnsMessagesGroupbox);
  
      // Validation of Messages Groupbox data
      //
      errorCountBeforeExecution = Log.ErrCount;
      Log.PopLogFolder();
      Log.AppendFolder("Validation of Messages groupbox for " + scenarioString + ".");      
  
      // Get number of elements in Messages groupbox
      var actualNumberElementsMessagesGroupbox = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
      var expectedNumberMessages = expectedMessagesGroupbox[currentScenario][0];
    
      Log.AppendFolder("Validation of number of Messages.");   
      if (actualNumberElementsMessagesGroupbox == expectedNumberMessages)
      {
        Log.Checkpoint("Expecting " + expectedNumberMessages + " Messages. Found " + actualNumberElementsMessagesGroupbox + " Messages as expected.");
        Log.PopLogFolder();
        for (var currentElementMessagesGroupbox = 0; currentElementMessagesGroupbox < actualNumberElementsMessagesGroupbox; currentElementMessagesGroupbox++)
        {
           var actualMessage = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Item(currentElementMessagesGroupbox).DataItem.ErrorMessage.OleValue;
           var actualRelationshipName = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Item(currentElementMessagesGroupbox).DataItem.RelationshipName.OleValue;
           Log.AppendFolder("Validating Message " + (currentElementMessagesGroupbox + 1) + " of " + actualNumberElementsMessagesGroupbox + ".");
           CheckIfEqual(actualRelationshipName, relationshipFullName[currentScenario], "Validation of column '" + columnNamesMessagesGroupbox[1] + "'.");
           CheckIfEqual(actualMessage, expectedMessagesGroupbox[currentScenario][currentElementMessagesGroupbox + 1], "Validation of column '" + columnNamesMessagesGroupbox[3] + "'.");
          Log.PopLogFolder();     
        }
      }
      else
      {
        Log.Error("Expecting " + expectedNumberMessages + " Messages. Found " + actualNumberElementsMessagesGroupbox + " Messages instead of the expected " + expectedNumberMessages + " Messages.");
        Log.PopLogFolder();
      }

      errorCountAfterExecution = Log.ErrCount;
      Log.PopLogFolder();
      if (errorCountAfterExecution == errorCountBeforeExecution)
      {
        Log.Checkpoint("Validation of Messages groupbox for " + scenarioString + " completed successfully with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");
      }
      else
      {
        Log.Message("Validation of Messages groupbox for " + scenarioString + " completed with " + (errorCountAfterExecution - errorCountBeforeExecution) + " errors.");      
      }
      
      Get_WinBilling_BtnCancel().Click();
      EmptyBillingHistory();
      UncheckedAUMBillable();
      UncheckedBillableRelastionShip();
      Log.PopLogFolder();    
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
    Log.PopLogFolder();
    Log.AppendFolder("Restauration of test environment");
    Log.AppendFolder("Closing Croesus Advisor.");
    
    // Restauration of first Relationship
    //
    Delay(1000);
    Get_ModulesBar_BtnRelationships().Click();
    SearchRelationshipByName(relationshipShortName[0]);
    Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipShortName[0],100).DblClick();
    
    // Check Billable Relationship
    Delay(1000);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Set_IsChecked(true);
    Delay(1000);
    Get_WinDetailedInfo_BtnApply().Click();
    
    Get_WinDetailedInfo_TabBillingForRelationship().Click();
    EnterCashflowAdjustments(cashflowAdjustmentPercentInflowDefault, cashflowAdjustmentPercentOutflowDefault, cashflowAdjustmentAmountInflowDefault, cashflowAdjustmentAmountOutflowDefault);
    Get_WinDetailedInfo_BtnOK().Click();
    Get_MainWindow().SetFocus();
    
    // Restauration of second Relationship
    //
    Delay(1000);
    Get_ModulesBar_BtnRelationships().Click();
    SearchRelationshipByName(relationshipShortName[5]);
    Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipShortName[5],100).DblClick();
    
    // Check Billable Relationship
    Delay(1000);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Set_IsChecked(true);
    Delay(1000);
    Get_WinDetailedInfo_BtnApply().Click();
    
    Get_WinDetailedInfo_TabBillingForRelationship().Click();
    EnterCashflowAdjustments(cashflowAdjustmentPercentInflowDefault, cashflowAdjustmentPercentOutflowDefault, cashflowAdjustmentAmountInflowDefault, cashflowAdjustmentAmountOutflowDefault);
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