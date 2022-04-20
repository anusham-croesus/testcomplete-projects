//USEUNIT Global_variables
//USEUNIT Common_MenuTools_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Common_MenuEdit_Get_functions
//USEUNIT Helper

function ExcelBillingReportNoDuplicateRows()
{
  try
  {
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var FirstRelName = "TCVE_7393_01";
    var SecondRelName = "TCVE_7393_02";
    var RelationshipIACode = "AC42";
    var FirstRelCurr = "USD";
    var FirstRelAcc1 = "800228-FS";
    var FirstRelAcc2 = "800228-JW";    
    var FirstRelAcc3 = "800228-RE";
    var SecondRelCurr = "CAD";
    var SecondRelAcc1 = "800241-FS";
    var SecondRelAcc2 = "800241-GT"; 
    var SecondRelAcc3 = "800241-JW";
    var SecondRelAcc4 = "800241-RE";    
    var SecondRelAcc5 = "800241-SF";      
    var RelationshipBillingFreq = "Quarterly";
    var RelationshipBillingMonths = "Mar, Jun, Sep, Dec";
    var RelationshipBillingTiming = "End of Period";
    var RelationshipFeeBasis = "Interval tiered";
    var RelationshipFirstBill = "10/01/2009";
    var boldAttribute = Log.CreateNewAttributes();
    boldAttribute.Bold = true;
    
    Log.CallStackSettings.EnableStackOnCheckpoint = true;
    Log.Message("***** Execution of script '" + functionName + "' started.", "", pmNormal, boldAttribute);

    // Preparation of vServer and database for script execution
    //
    errorCountBeforeExecution = Log.ErrCount;
          
    Log.AppendFolder("Preparation of test envionment on " + vServerBilling + " for client "+ client + ".");
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
    
    // Create first relationship with IA AC42 and accounts 800228-FS and 800228-JW and 800228-RE
    //
    Log.AppendFolder("Creating relationships " + FirstRelName + " and " + SecondRelName + ".")
    Log.AppendFolder("Relationship " + FirstRelName + ".");
    Get_ModulesBar_BtnRelationships().Click();
    Get_Toolbar_BtnAdd().Click();
    Get_MenuBar_Edit_AddForRelationshipsAndClients_AddRelationship().Click()
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(FirstRelName);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(RelationshipIACode);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationshipWhenIACodeIsTextbox().Keys(FirstRelCurr);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
    Get_WinDetailedInfo_BtnOK().Click();
    Delay(3000);
            
    SearchRelationshipByName(FirstRelName);
    JoinAccountToRelationship(FirstRelAcc1, FirstRelName);
    JoinAccountToRelationship(FirstRelAcc2, FirstRelName);
    JoinAccountToRelationship(FirstRelAcc3, FirstRelName);
    Delay(3000);
        
    Get_RelationshipsClientsAccountsGrid().Find("Value",FirstRelName,100).DblClick();
    Get_WinDetailedInfo_TabBillingForRelationship().Click();
    Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().Keys(RelationshipBillingFreq);
    Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency_Month().Keys(RelationshipBillingMonths);
    Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod().Keys(RelationshipBillingTiming);
    Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
    Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Find("Value",RelationshipFeeBasis,100).Click();
    Get_WinBillingConfiguration_BtnOK().Click();
    FillRelationshipBillingTab([FirstRelAcc1,FirstRelAcc2, FirstRelAcc3], RelationshipFirstBill);
             
    Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnHistory().Click();
    aqObject.CheckProperty(Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1), "HasItems", cmpEqual, false);
    Get_WinBillingHistory_BtnClose().Click();
    Get_WinDetailedInfo_BtnApply().Click();
    Delay(3000);
    Get_WinDetailedInfo_BtnOK().Click();
    Delay(3000);
    Log.PopLogFolder();

    // Create second relationship with IA AC42 and accounts 800241-FS, 800241-GT, 800241-JW, 800241-RE and 800241-SF
    //
    Log.AppendFolder("Relationship " + SecondRelName + ".");
    Get_ModulesBar_BtnRelationships().Click();
    Get_Toolbar_BtnAdd().Click();
    Get_MenuBar_Edit_AddForRelationshipsAndClients_AddRelationship().Click()   
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(SecondRelName);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(RelationshipIACode);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationshipWhenIACodeIsTextbox().Keys(SecondRelCurr);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
    Get_WinDetailedInfo_BtnOK().Click();
    Delay(3000);
            
    SearchRelationshipByName(SecondRelName);
    JoinAccountToRelationship(SecondRelAcc1, SecondRelName);
    JoinAccountToRelationship(SecondRelAcc2, SecondRelName);
    JoinAccountToRelationship(SecondRelAcc3, SecondRelName);
    JoinAccountToRelationship(SecondRelAcc4, SecondRelName);
    JoinAccountToRelationship(SecondRelAcc5, SecondRelName);
    Delay(3000);
        
    Get_RelationshipsClientsAccountsGrid().Find("Value",SecondRelName,100).DblClick();
    Get_WinDetailedInfo_TabBillingForRelationship().Click();
    Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().Keys(RelationshipBillingFreq);
    Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency_Month().Keys(RelationshipBillingMonths);
    Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod().Keys(RelationshipBillingTiming);
    Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
    Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Find("Value",RelationshipFeeBasis,100).Click();
    Get_WinBillingConfiguration_BtnOK().Click();
    FillRelationshipBillingTab([SecondRelAcc1,SecondRelAcc2, SecondRelAcc3, SecondRelAcc4, SecondRelAcc5], RelationshipFirstBill);
             
    Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnHistory().Click();
    aqObject.CheckProperty(Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1), "HasItems", cmpEqual, false);
    Get_WinBillingHistory_BtnClose().Click();
    Get_WinDetailedInfo_BtnApply().Click();
    Delay(3000);
    Get_WinDetailedInfo_BtnOK().Click();
    Delay(3000);
    Log.PopLogFolder(); 
    
    // Select IA Code AC42
    //
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").SetFocus();
    Aliases.CroesusApp.winMain.barMenu.Users.Click();
    Delay(1000);
    Aliases.CroesusApp.subMenus.WPFObject("MenuItem", "Selection...", 4).Click();
    Delay(1000);
    Aliases.CroesusApp.winUserMultiSelection.WPFObject("_tabControl").WPFObject("TabItem", "IA Codes", 3).Click();
    Delay(1000);
    Aliases.CroesusApp.winUserMultiSelection.WPFObject("_tabControl").WPFObject("_availableIACodesGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 11).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "AC42", 1).Click();
    Aliases.CroesusApp.winUserMultiSelection.WPFObject("Button", "_Apply", 1).Click(); 
    Log.PopLogFolder();   
        
    // Generate Billing
    //
    Log.AppendFolder("Generating Billing report.");
    Get_ModulesBar_BtnRelationships().Click();     
    Get_MenuBar_Tools().DblClick();
    Get_MenuBar_Tools().Click();
    Get_MenuBar_Tools_Billing().Click();
    Delay(3000);

    Get_WinBillingParameters_RdoInArrears().Click();
    Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(false);
    Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(true);
    Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
    Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);
    Get_WinBillingParameters_DtpBillingDate().Click();
    Delay(3000);
        
    x = 7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth() / 8);
    y = Get_WinBillingParameters_DtpBillingDate().get_ActualHeight() / 7;
    Get_WinBillingParameters_DtpBillingDate().Click(x, y);
    Get_Calendar_LstYears_Item("2009").Click();
    Get_Calendar_LstMonths_ItemDecember().Click();
    Get_Calendar_BtnOK().Click();
    Delay(3000);
    Get_WinBillingParameters_BtnOK().Click();
    Delay(3000);
    Get_WinBilling_BtnView().Click(); 

    Get_WinOutputSelection_GrpOutput_ChkExportToExcelDetailed().Click();
    Get_WinOutputSelection_BtnOK().Click();
    Log.PopLogFolder();
    Delay(10000); // Delay required in order to let Excel save report to folder before searching for file
    
    // Validate Excel report has no duplicate row
    //
    var tempFolder = Sys.OSInfo.TempDirectory + "\CroesusTemp\\"; 
    var filenameContains= "Tiered Basis Detailled Report (Fixed)" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
    var lastModifiedFilename = FindLastModifiedFileInFolder(tempFolder, filenameContains);
    var excelReportFile = aqFile.OpenTextFile(lastModifiedFilename, aqFile.faRead, aqFile.ctANSI);
    var accountNumbers = new Array();    
    var lineCount = 0;
    
    Log.AppendFolder("Validating Excel report: " + lastModifiedFilename + ".");
   
    while(!excelReportFile.IsEndOfFile())
    {
      var recordContent = excelReportFile.ReadLine().split("	");
      //line = excelReportFile.ReadLine();

      accountNumbers[lineCount] = recordContent[1];
      lineCount++;       
    }
    
    Log.PopLogFolder();  
    if (hasDuplicates(accountNumbers))
    {
      Log.Error("The Excel report contains multiple occurences of the same account number."); 
    }
    else
    {
      Log.Checkpoint("The Excel report does not contain multiple occurrences of the same account number."); 
    }
  }
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally
  {
    // Restore to initial configuration
    //
    errorCountBeforeExecution = Log.ErrCount;
    Log.AppendFolder("Restauration of test environment");
    
    // Close Croesus Advisor
    //
    Log.AppendFolder("Closing Croesus Advisor.");
    Get_WinBilling_BtnCancel().Click();
    Delay(1000);
    Get_ModulesBar_BtnRelationships().Click();
    SearchRelationshipByName(FirstRelName);
    Get_RelationshipsClientsAccountsGrid().Find("Value",FirstRelName,100).Click();
    Aliases.CroesusApp.winMain.barMenu.Edit.Click();
    Get_MenuBar_Edit_Delete().Click();
    Aliases.CroesusApp.dlgConfirmation.WPFObject("MessageWindow", "", 1).WPFObject("PART_Yes").Click();
    Get_ModulesBar_BtnRelationships().Click();
    SearchRelationshipByName(SecondRelName);
    Get_RelationshipsClientsAccountsGrid().Find("Value",SecondRelName,100).Click();
    Aliases.CroesusApp.winMain.barMenu.Edit.Click();
    Get_MenuBar_Edit_Delete().Click();
    Aliases.CroesusApp.dlgConfirmation.WPFObject("MessageWindow", "", 1).WPFObject("PART_Yes").Click();
    
    // Set IA Code to Firm
    //
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").SetFocus();
    Aliases.CroesusApp.winMain.barMenu.Users.Click();
    Delay(1000);
    Aliases.CroesusApp.subMenus.WPFObject("MenuItem", "Firm", 3).Click();
    Delay(1000);
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
    
    if (Aliases.CroesusApp.WPFObject("HwndSource: BaseWindow", "Confirmation").Exists)
    {
      Aliases.CroesusApp.dlgConfirmation.WPFObject("MessageWindow", "", 1).WPFObject("PART_Yes").Click();
    }
    
    Log.PopLogFolder();
    
    // Terminate processes
    //
    Log.AppendFolder("Terminating Processes.");
    Log.Message("Terminating Croesus Advisor process.");
    if (Sys.Process("CroesusClient").Exists) Sys.Process("CroesusClient").Terminate();
    
    Log.Message("Terminating Internet Explorer process.");    
    if (Sys.Process("iexplore").Exists) Sys.Process("iexplore").Terminate();
    
    Log.Message("Terminating Excel process.");    
    if (Sys.Process("Excel").Exists) Sys.Process("Excel").Terminate();
    
    // Run Billing SQL scripts
    //
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

function hasDuplicates(array)
{
  var accountNumbersObserved = [];
  
  for (var i = 0; i < array.length; i++)
  {
    var currentAccountNumber = array[i];
    
    if (indexOf(accountNumbersObserved, currentAccountNumber) !== -1)
    {
      return true;
    }
    
    accountNumbersObserved.push(currentAccountNumber);
  }
  
  return false;
}

function indexOf(array, element)
{
  for (var i = 0; i < array.length; i++)
  {
    if (array[i] == element) { return i;}
  }
  
  return -1;
}