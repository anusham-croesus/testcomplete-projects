//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions

//
// Description: Copier et coller l'information du module Comptes
// Analyste d'assurance qualité: Reda Alfaiz
// Analyste d'automatisation: Christophe Paring
//

function CR1352_1512_Acc_Copy_and_paste_the_information_from_the_accounts_module()
{
  var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
  var userName1 = userName;
  var userName2 = "GP1859";
  var boldAttribute = Log.CreateNewAttributes();
  boldAttribute.Bold = true;

  Log.CallStackSettings.EnableStackOnCheckpoint = true;    
  Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);
  Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1512", "Cas de tests JIRA CROES-1512");

  // Execution with user COPERN
  Log.Message("***** Running script with user " + userName1 + " *****", "");
  CR1352_1512_Acc_Copy_and_paste_the_information_from_the_accounts_module_Steps(userName, psw);
    
  //Execution with user GP1859 (due crash with sysadmin when typing CTRL+C in Accounts module)
  Log.Message("***** Running script with user " + userName2 + " *****", "");
  CR1352_1512_Acc_Copy_and_paste_the_information_from_the_accounts_module_Steps(userName2, psw);
}

function CR1352_1512_Acc_Copy_and_paste_the_information_from_the_accounts_module_Steps(userName, password)
{
  try
  {
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();
    var nbOfSelectedAccounts, objExcel, objExcelWorkbook, excelRowCount, croesusRowCount, arrayOfAccountsNo, croesusAccountNo, croesusAccountNo;
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true; 
    
    Log.AppendFolder("Preparation of test envionment on " + vServerAccounts + " for client " + client + " using username " + userName + ".");
    Login(vServerAccounts, userName, password, language);
    
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
    Log.PopLogFolder();
    Log.Message("Croesus Desktop on " + vServerAccounts + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);

    Log.AppendFolder("Setup.");    
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
    arrayOfAccountsNo = GetAllDisplayedAccountsNumbers();
    croesusRowCount = arrayOfAccountsNo.length;
    Terminate_CroesusProcess();
    TerminateProcess("EXCEL");
        
    Login(vServerAccounts, userName, password, language);
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
        
    // Number of accounts selected
    nbOfSelectedAccounts = (VarToStr(Get_MainWindow_StatusBar_NbOfSelectedElements().Text) != "")? StrToInt(Get_MainWindow_StatusBar_NbOfSelectedElements().Text.OleValue): 0;
    
    if (nbOfSelectedAccounts != 0)
    {
      return (Log.Error("There were " + nbOfSelectedAccounts + " accounts selected in the Accounts grid. This is unexpected."));  
    }
    
    // Enter CTRL + C and paste in Excel spreadsheet
    Sys.Keys("^c"); // Copy
    WshShell.Run("EXCEL");
    Sys.WaitProcess("EXCEL", 30000, 1);   
    objExcel = Sys.OleObject("Excel.Application");
    objExcel.Visible = true;
    objExcelWorkbook = objExcel.Workbooks.Add();
    Sys.Keys("^v"); // Paste
    excelRowCount = objExcel.ActiveSheet.UsedRange.Rows.Count;
        
    // Validate Excel row count matches Croesus Desktop Accounts grid row count
    Log.PopLogFolder();
    Log.Message("Validate row count in Excel is equal to row count in Croesus Desktop.");
    
    if (croesusRowCount == excelRowCount)
    {
      Log.Checkpoint("Row count in Excel is equal to row count in Croesus Desktop, as expected. (" + excelRowCount + ")");
    }
    else
    {
      Log.Error("Row count in Excel is not equal to row count in Croesus Desktop. This is not expected. Excel row count was " + excelRowCount + " while the Croesus Desktop row count was " + croesusRowCount + ".");
    }
        
    // Compare Croesus account numbers with the Excel account numbers
    Log.AppendFolder("Validate that account numbers are the same in Excel and Croesus Desktop.");
    
    for (var i = 0; i < arrayOfAccountsNo.length; i++)
    {
      croesusAccountNo = VarToStr(arrayOfAccountsNo[i]);
      excelAccountNo = VarToStr(objExcel.Cells.Item(i + 1, 2));
      CheckEquals(excelAccountNo, croesusAccountNo, "The account number in Excel at line " + (i + 1));
    }
    
    objExcelWorkbook.Close(false);
    objExcel.Quit();
  }
    
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
    
  finally
  {
    Log.PopLogFolder();
    Log.AppendFolder("Restore environment to default configuration.");
    Terminate_CroesusProcess();
    TerminateExcelProcess();
    Log.PopLogFolder(); 
      
    errorCountAfterExecution = Log.ErrCount;
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

function GetCroesusBuildVersion()
{
  var croesusBuildVersion = "";
  var propertiesArray = ["ClrClassName", "WPFControlOrdinalNo"];
  var valuesArray = ["TextBlock", 7];

  // Ensure that Croesus MainWindow is focused
  Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").SetFocus();
  
  // Click on ? in Classic Menu of MainWindow
  Get_MenuBar().FindChild("Uid", "CustomizableMenu_3049", 10).Click();
    
  // Click on About to open About dialog
  Get_SubMenus().FindChild("Uid", "CFMenuItem_cf20", 10).Click();

  // Read version
  croesusBuildVersion = Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").WPFObject("AboutWin").FindChild(propertiesArray, valuesArray, 10).WPFControlText;
  
  // Close About dialog
  Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").Click();
  
  // Return version
  return (croesusBuildVersion);  
}
