//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions

//
// Description : Gestion des profils Comptes et case masquer champs vides
// Analyste d'assurance qualité: Reda Alfaiz
// Analyste d'automatisation: Christophe Paring
//

function CR1352_1551_Acc_Manage_Account_Profiles_and_hide_empty_profiles_checkbox()
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
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1551", "Cas de tests JIRA CROES-1551");
    Log.AppendFolder("Preparation of test envionment on " + vServerAccounts + " for client " + client + " using username " + userName + ".");    

    Login(vServerAccounts, userName, psw, language);

    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerAccounts + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);

    Log.AppendFolder("Test 1: Selecting all default profiles in the Visible Profiles Configuration window and validating all components are visible.");
    Log.AppendFolder("Setup.");
            
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
        
    // Ouvrir la fenêtre de configuration des profils, cocher toutes les cases à cocher du groupe Défaut et cliquer sur Sauvegarder
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

    Log.PopLogFolder();
    Log.Message("Validating the presence of all selected profiles.");
                
    var componentName = (language == "french") ? "Loisirs" : "Hobbies";
    CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local(componentName), componentName);
    componentName = (language == "french") ? "Numéro du compte du courtier" : "Broker Account Number";   
    CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local(componentName), componentName);
    componentName = (language == "french") ? "Numéro du compte de l'intervenant" : "Middleman Account Number";
    CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local(componentName), componentName);
    componentName = (language == "french") ? "Compte conjoint" : "Joint Account";
    CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local(componentName), componentName);
    componentName = (language == "french") ? "Désignation du compte" : "Acount Designation";
    CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_CmbObject_Local(componentName), componentName);
            
    if (client != "RJ" && client != "US" && client != "TD" && client != "CIBC")
    {
      CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_CmbObject_Local("VIEUX_CONFIGURATEUR"), "VIEUX_CONFIGURATEUR");
      CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local("Pif"), "Pif");
      CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_ChkObject_Local("Checkbox"), "Checkbox");
      CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_DblTxtObject_Local("TT57915"), "TT57915");
      CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local("Locomotive Texte"), "Locomotive Texte");
      CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_DtpObject_Local("Canis"), "Canis");
      CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_CmbObject_Local("Partenariat"), "Partenariat");
    }
        
    // Remplir seulement le champ "Désignation du compte" et cliquer sur Masquer champs vides
    Log.PopLogFolder();
    Log.AppendFolder("Test 2: Entering text in only one component, checking 'Hide Empty Profiles' checkbox and validating only text-populated component is visible.");
    componentName = (language == "french") ? "Désignation du compte" : "Acount Designation";
    Log.AppendFolder("Setup.");
    Log.Message("Entering text in only the '" + componentName + "' textbox then checking the 'Hide Empty Profiles' checkbox.");

    Get_WinAccountInfo_TabProfile_DefaultExpander_CmbObject_Local(componentName).Click();
    Get_SubMenus().WPFObject("ComboBoxItem", "", 2).Click();
    Get_WinInfo_TabProfile_ChkHideEmptyProfiles().Click();

    Log.Message("Validating that only the '" + componentName + "' component is visible.");
    Log.PopLogFolder();
    CheckComponentExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_CmbObject_Local(componentName), componentName);
    componentName = (language == "french") ? "Loisirs" : "Hobbies";
    CheckComponentNonExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local(componentName), componentName);
    componentName = (language == "french") ? "Numéro du compte du courtier" : "Broker Account Number";    
    CheckComponentNonExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local(componentName), componentName);
    componentName = (language == "french") ? "Numéro du compte de l'intervenant" : "Middleman Account Number";    
    CheckComponentNonExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local(componentName), componentName);
    componentName = (language == "french") ? "Compte conjoint" : "Joint Account";    
    CheckComponentNonExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local(componentName), componentName);
        
    if (client != "RJ" && client != "US" && client != "TD" && client != "CIBC")
    {    
      CheckComponentNonExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_CmbObject_Local("VIEUX_CONFIGURATEUR"), "VIEUX_CONFIGURATEUR");
      CheckComponentNonExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local("Pif"), "Pif");
      CheckComponentNonExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_ChkObject_Local("Checkbox"), "Checkbox");
      CheckComponentNonExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_DblTxtObject_Local("TT57915"), "TT57915");
      CheckComponentNonExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local("Locomotive Texte"), "Locomotive Texte");
      CheckComponentNonExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_DtpObject_Local("Canis"), "Canis");
      CheckComponentNonExistence(Get_WinAccountInfo_TabProfile_DefaultExpander_CmbObject_Local("Partenariat"), "Partenariat");
    }
    
    Log.PopLogFolder();         
  }
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  
  finally
  {
    Log.AppendFolder("Restore environment to default configuration.");
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

function Set_IsCheckedForAllCheckboxes(parentComponentObject, booleanValue)
{
  parentComponentObject.WaitProperty("VisibleOnScreen", true, 30000);
  var arrayOfCheckboxes = parentComponentObject.FindAllChildren(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["XamCheckEditor", true, 1], 100).toArray();
  
  for (var i = 0; i < arrayOfCheckboxes.length; i++)
  {
    if (booleanValue != arrayOfCheckboxes[i].get_IsChecked())
    {
      arrayOfCheckboxes[i].Click();
    }
  }
}

function CheckComponentExistence(componentObject, componentName)
{
  if (componentObject.Exists && componentObject.IsVisible )
  {
    Log.Checkpoint("The component '" + componentName + "' exists and is visible as expected.");
  }
  else
  {
    Log.Error("The component '" + componentName + "' was not found.");
  }
}

function CheckComponentNonExistence(componentObject, componentName)
{
  if (componentObject.Exists && componentObject.IsVisible )
  {
    Log.Error("The component '" + componentName + "' was unexpectedly found.");
  }
  else
  {
    Log.Checkpoint("The component '" + componentName + "' was not found as expected.");
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

function Get_WinAccountInfo_TabProfile_DefaultExpander_TxtObject_Local(componentName)
{
  return (Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", componentName], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10)); 
}

function Get_WinAccountInfo_TabProfile_DefaultExpander_DblTxtObject_Local(componentName)
{
  return (Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", componentName], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", 1], 10)); 
}

function Get_WinAccountInfo_TabProfile_DefaultExpander_CmbObject_Local(componentName)
{
  return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", componentName], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", "1"], 10);
}

function Get_WinAccountInfo_TabProfile_DefaultExpander_ChkObject_Local(componentName)
{
  return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", componentName], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CheckBox", "1"], 10);
}

function Get_WinAccountInfo_TabProfile_DefaultExpander_DtpObject_Local(componentName)
{
  return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["ContentControl", componentName], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10);
}