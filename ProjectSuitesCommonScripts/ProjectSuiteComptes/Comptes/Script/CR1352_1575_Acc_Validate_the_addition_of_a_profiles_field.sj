//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT CR1352_1551_Acc_Manage_Account_Profiles_and_hide_empty_profiles_checkbox

//
// Description: Valider l'ajout d'un champ de type 'profils'
// Analyste d'assurance qualité: Reda Alfaiz
// Analyste d'automatisation: Christophe Paring
//

function CR1352_1575_Acc_Validate_the_addition_of_a_profiles_field()
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
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1575", "Cas de tests JIRA CROES-1575");
    Log.AppendFolder("Preparation of test envionment on " + vServerAccounts + " for client " + client + " using username " + userName + ".");    
 
    Login(vServerAccounts, userName, psw, language);

    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
    Log.PopLogFolder();
    Log.Message("Croesus Desktop on " + vServerAccounts + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);    

    // Test 1
    Log.AppendFolder("Test 1: Restore default column settings for Accounts grid and validate.");     
    Log.AppendFolder("Setup.");           
    CheckAllDefaultProfilesForAccounts();
    Log.Message("Restore column default settings for Accounts grid.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    Log.PopLogFolder();        

    if (Get_AccountsGrid_ChHobbies().Exists)
    {
      Log.Error("Validate 'Loisirs' column is not visible. 'Loisirs' column is visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("Validate 'Loisirs' column is not visible. 'Loisirs' column is not visible as expected.");
    }

    // Test 2
    Log.PopLogFolder();
    Log.AppendFolder("Test 2: Add 'Loisir' column and validate.");
    Log.AppendFolder("Setup.");
    Log.Message("Add 'Loisir' column.");        
    Get_AccountsGrid_ChMargin().ClickR();
    Get_GridHeader_ContextualMenu_InsertField().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Profiles().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Profiles_Hobbies().Click();
    Log.PopLogFolder();       

    if (Get_AccountsGrid_ChHobbies().Exists)
    {
      Log.Checkpoint("Validate 'Loisirs' column exists and is visible. 'Loisirs' column exists and is visible as expected.");
    }
    else
    {
      Log.Error("Validate 'Loisirs' column exists and is visible. 'Loisirs' column is not visible. This is not expected.");
    }

    CheckColumnExistsUnderAnotherColumn(Get_AccountsGrid_ChMargin(), Get_AccountsGrid_ChHobbies(), "Marge", "Loisirs");
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

function CheckAllDefaultProfilesForAccounts()
{
  Get_ModulesBar_BtnAccounts().Click();    
  Get_AccountsBar_BtnInfo().Click();
  Get_WinAccountInfo_TabProfile().Click();   
  
  // Ouvrir la fenêtre de configuration des profils, décocher toutes les cases à cocher et cliquer sur Sauvegarder
  Log.Message("Deselecting all profiles from Visible Profiles Configuration Window.");     
  Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false);
  Get_WinInfo_TabProfile_BtnSetup().Click();
  
  if (client != "RJ" && client != "US" && client != "TD" && client != "CIBC")
  {
    // Scroll down
    var height = Get_WinVisibleProfilesConfiguration().Height;
    var width = Get_WinVisibleProfilesConfiguration().Width;
    Get_WinVisibleProfilesConfiguration().Click(width - 25, height - 105);
  }
    
  Set_IsCheckedForAllCheckboxes(Get_WinVisibleProfilesConfiguration(), false);
  Get_WinVisibleProfilesConfiguration_BtnSave().Click();

  // Ouvrir la fenêtre de configuration des profils, cocher toutes les cases à cocher du groupe Défaut et Cliquer sur Sauvegarder
  Log.Message("Selecting all profiles from Visible Profiles Configuration Window.");
  Get_WinInfo_TabProfile_BtnSetup().Click();
        
  if (client != "RJ" && client != "US" && client != "TD" && client != "CIBC")
  {
    // Scroll down
    var height = Get_WinVisibleProfilesConfiguration().Height;
    var width = Get_WinVisibleProfilesConfiguration().Width;
    Get_WinVisibleProfilesConfiguration().Click(width - 25, height - 105);
  }
        
  Set_IsCheckedForAllCheckboxes(Get_WinVisibleProfilesConfiguration(), true);    
  Get_WinVisibleProfilesConfiguration_BtnSave().Click();
  Get_WinAccountInfo_BtnOK().Click();  
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