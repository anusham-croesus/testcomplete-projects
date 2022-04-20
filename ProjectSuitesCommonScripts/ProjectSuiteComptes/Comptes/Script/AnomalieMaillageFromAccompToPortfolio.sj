//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA

//
// Description : Dans le module Comptes, sélectionner un compte et mailler vers le module Portefeuille avec les trois façons (Right-CLick, Menu et Drag-and-Drop)
// Auteur: Sana Ayaz
// Version de scriptage: ref90-09-9--V9-croesus-co7x-1_4_546
//

function AnomalieMaillageFromAccompToPortfolio()
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();    
    var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
    var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");

    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);
    Log.AppendFolder("Preparation of test envionment on " + vServerAccounts + " for client " + client + " using username " + userName + ".");
        
    Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);

    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
    
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerAccounts + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);
             
    // Mailler un compte vers le module Portefeuille avec les 3 façons
    // Method 1: Drag-and-Drop
    Log.AppendFolder("Test 1: Drag-and-Drop one account to Portfolio.");
    MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(), Get_ModulesBar_BtnPortfolio(), "dragDrop", "SelectOnItem", Get_RelationshipsClientsAccountsGrid());
    Log.PopLogFolder();
          
    // Method 2: Right-Click
    Log.AppendFolder("Test 2: Right-Click one account to Portfolio.");
    MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(), Get_ModulesBar_BtnPortfolio(), "clickRightFunction", "SelectOnItem", Get_RelationshipsClientsAccountsGrid());
    Log.PopLogFolder();
        
    // Method 3: Menu
    Log.AppendFolder("Test 3: Menu one account to Portfolio.");
    MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(), Get_ModulesBar_BtnPortfolio(), "menuModule", "SelectOnItem", Get_RelationshipsClientsAccountsGrid());
    Log.PopLogFolder();

    // Mailler 20 compte vers le module Portefeuille avec les 3 façons
    // Method 1: Drag-and-Drop
    Log.AppendFolder("Test 4: Drag-and-Drop 20 accounts to Portfolio.");                
    MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(), Get_ModulesBar_BtnPortfolio(), "dragDrop", "SelectManyItem", Get_RelationshipsClientsAccountsGrid());
    Log.PopLogFolder();
    
    // Method 2: Right-Click
    Log.AppendFolder("Test 5: Right-Click 20 accounts to Portfolio.");    
    MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(), Get_ModulesBar_BtnPortfolio(), "clickRightFunction", "SelectManyItem", Get_RelationshipsClientsAccountsGrid());
    Log.PopLogFolder();

    // Method 3: Menu
    Log.AppendFolder("Test 6: Menu 20 accounts to Portfolio.");    
    MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(), Get_ModulesBar_BtnPortfolio(), "menuModule", "SelectManyItem", Get_RelationshipsClientsAccountsGrid());
    Log.PopLogFolder();       
  }
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  
  finally
  {
    Log.AppendFolder("Restore default configuration."); 
    Terminate_CroesusProcess();
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