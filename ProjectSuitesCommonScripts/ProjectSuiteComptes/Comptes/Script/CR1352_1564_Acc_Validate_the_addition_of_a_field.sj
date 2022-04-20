//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions

//
// Description : Valider l'ajout d'un champ dans la grille Comptes
// Analyste d'assurance qualité: Reda Alfaiz
// Analyste d'automatisation: Christophe Paring
//

function CR1352_1564_Acc_Validate_the_addition_of_a_field()
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();
    boldAttribute.Bold = true;    
  
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1564", "Cas de tests JIRA CROES-1564");
    Log.AppendFolder("Preparation of test envionment on " + vServerAccounts + " for client " + client + " using username " + userName + ".");  
         
    Login(vServerAccounts, userName, psw, language);
    
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
    Log.PopLogFolder();
    Log.Message("Croesus Desktop on " + vServerAccounts + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);

    // Test 1
    Log.AppendFolder("Test 1: Restore default column settings for Accounts grid and validate.");          
    Log.AppendFolder("Setup.");
    Log.Message("Restore column default settings for Accounts grid.");
    Get_ModulesBar_BtnAccounts().Click();
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    Log.PopLogFolder();        
       
    if (Get_AccountsGrid_ChMargin().Exists)
    {
      Log.Checkpoint("Validate 'Marge' column exists and is visible. 'Marge' column exists and is visible as expected.");
    }
    else
    {
      Log.Error("Validate 'Marge' column exists and is visible. 'Marge' column not visible. This is not expected.");
    }
 
    if (Get_AccountsGrid_ChStatus().Exists)
    {
      Log.Error("Validate 'État' column is not visible. 'État' column exists and is visible. This is not expected.");                
    }
    else
    {
      Log.Checkpoint("Validate 'État' column is not visible. 'État' column is not visible as expected.");
    }

    // Test 2
    Log.PopLogFolder();
    Log.AppendFolder("Test 2: Insert 'État' field under 'Marge' column and validate.");    
    Log.AppendFolder("Setup.");            
    Log.Message("Insert 'État' field under 'Marge' column.");
    
    Get_AccountsGrid_ChMargin().ClickR();
    Get_GridHeader_ContextualMenu_InsertField().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Status().Click();

    Log.PopLogFolder();
       
    if (Get_AccountsGrid_ChMargin().Exists)
    {
      Log.Checkpoint("Validate 'Marge' column exists and is visible. 'Marge' column exists and is visible as expected.");
    }
    else
    {
      Log.Error("Validate 'Marge' column exists and is visible. 'Marge' column not visible. This is not expected.");
    }        

    Log.Message("Validate 'État' column exists and is visible.");
 
    if (Get_AccountsGrid_ChStatus().Exists)
    {
      Log.Checkpoint("Validate 'État' column exists and is visible. 'État' column exist and is visible as expected.");               
    }
    else
    {
      Log.Error("Validate 'État' column exists and is visible. 'État' column not visible. This is not expected."); 
    }             

    CheckColumnExistsUnderAnotherColumn(Get_AccountsGrid_ChMargin(), Get_AccountsGrid_ChStatus(), "Marge", "État"); 
  }
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
    
  finally
  {
    Log.PopLogFolder();
    Log.AppendFolder("Restore environment to default configuration.");
    Log.Message("Restore columns default configuration.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();        
    Close_Croesus_SysMenu();

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

function CheckColumnExistsUnderAnotherColumn(topColumn, bottomColumn, topColumnDescription, bottomColumnDescription)
{
  var leftMarginsValidationOk = false;
  var topMarginValidationOk = false;
  
  // Calculate expected Position X for bottomColumn  
  var actualBottomColumnLeftMarginPositionX = bottomColumn.Left;
  var expectedBottomColumnLeftMarginPositionX = topColumn.Left;
  
  // Calculate expected Position Y for bottomColumn
  var actualTopColumnTopMarginPositionY = topColumn.Top;
  var actualTopColumnHeight = topColumn.Height;
  var actualBottomColumnTopMarginPositionY = bottomColumn.Top;
  var expectedBottomColumnTopMarginPositionY = actualTopColumnTopMarginPositionY + actualTopColumnHeight - 1;

  Log.Message("Validating that '" + bottomColumnDescription + "' field is directly under the '" + topColumnDescription + "' column header.");
  Log.Message("Actual left margin of '" + bottomColumnDescription + "' field was: " + actualBottomColumnLeftMarginPositionX);  
  Log.Message("Actual top margin of '" + bottomColumnDescription + "' field was: " + actualBottomColumnTopMarginPositionY);
  
  // Validating horizontal positioning of the field
  if (actualBottomColumnLeftMarginPositionX == expectedBottomColumnLeftMarginPositionX)
  {
    Log.Checkpoint("The left margin of '" + bottomColumnDescription + "' lines up with the left margin of '" + topColumnDescription + "' as expected.");
    leftMarginsValidationOk = true;
  }
  else if (actualBottomColumnLeftMarginPositionX == 822)
  {
    Log.Warning("The left margin of '" + bottomColumnDescription + "' does not line up with the margin of '" + topColumnDescription + "'. However, this issue is being tracked by CROES-4942.");
    leftMarginsValidationOk = false;
  }
  else
  {
    Log.Error("The left margin of '" + bottomColumnDescription + "' does not line up with the margin of '" + topColumnDescription + "'.");
    leftMarginsValidationOk = false;
  }

  // Validating vertical positioning of the field
  if (actualBottomColumnTopMarginPositionY == expectedBottomColumnTopMarginPositionY)
  {
    Log.Checkpoint("The top margin of '" + bottomColumnDescription + "' lines up with the bottom margin of '" + topColumnDescription + "' as expected.");
    topMarginValidationOk = true;  
  }
  else
  {
    Log.Error("The top margin of '" + bottomColumnDescription + "' does not line up with the bottom margin of '" + topColumnDescription + ".");
    topMarginValidationOk = false;
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