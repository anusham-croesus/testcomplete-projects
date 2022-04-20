//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

//
// Description: Maillage à partir de la section Détails du module CLients vers les modules:
// Script spécifique à BNC
//
//  1) Clients
//  2) Comptes
//  3) Relations
//  4) Portefeuile
//  5) Transactions

//
// Analyste d'assurance qualité: Karima Mehiguene
// Analyste d'automatisation: Youlia Raisper
//
// MAJ: Pierre Lefebvre (June 02, 2021)
//      --> Le maillage de Clients vers Clients est un problème déjà connu (TCVE-176) et donc un Warning est généré au lieu de Error.
//      --> Ajout du maillage de Clients vers Relations car ce cas n'était pas couvert.
//      --> Ajout d'information additionelle dans les Logs.
//
 
function CR1352_2077_Cli_Drag_SecondaryRoot_FromDetailsSection()
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();    
    var clientNumber = "800075";
    var secondaryClientNumber = "800076";
    var roots = GetData(filePath_Clients, "CR1352", 202, language);

    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2077", "Cas de test sur Jira: CROES-2077");
    Log.AppendFolder("Preparation of test envionment on " + vServerClients + " for client " + client + " using username " + userName + ".");        
    Log.AppendFolder("Environment Setup.");
        
    Login(vServerClients, userName, psw, language);
    Get_MainWindow().Maximize();
        
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();

    Log.PopLogFolder();    
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerClients + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);

    //*********************************************** Étape 1: Validation du maillage vers le module Clients *********************************************
    Log.AppendFolder("Étape 1: Validation du maillage vers le module Clients.", "", pmNormal, boldAttribute);  
    //****************************************************************************************************************************************************    
    Log.AppendFolder("Setup.");             
    Get_ModulesBar_BtnClients().Click();         
    Search_Client(clientNumber);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", roots, 10).Find("OriginalValue", secondaryClientNumber, 10).Click();   
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", roots, 10).Find("OriginalValue", secondaryClientNumber, 10), Get_ModulesBar_BtnClients());    
    Log.PopLogFolder();
    Log.PopLogFolder();
    
    if (IsWarningDialogDisplayed().Exists)
    {
      var btnClientsChecked = Get_ModulesBar_BtnClients().IsChecked.OleValue;
      
      if (btnClientsChecked == false)
      {
        Log.Warning("The Clients button is not highlighted. This is not expected. This issue has already be raised in Jira TCVE-176.");
        Log.Message("The Warning dialog has the following message: '" + GetWarningDialogText() + "'.");
      }
      
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, secondaryClientNumber);
      GetWarningDialogOkButton().Click();      
    }
    else
    {
      aqObject.CheckProperty(Get_ModulesBar_BtnClients(), "IsChecked", cmpEqual, true);
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, secondaryClientNumber);
    }
       
    errorCountAfterExecution = Log.ErrCount;
    var errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 1: Validation du maillage vers le module Clients.' completed successfully with " + errorsStep + " errors.");
    }
    else
    {
      Log.Error("***** 'Étape 1: Validation du maillage vers le module Clients.' completed with " + errorsStep + " errors.");
      errorCountAfterExecution = --errorCountAfterExecution;
    }
    
    //********************************************** Étape 2: Validation du maillage vers le module Comptes **********************************************
    Log.AppendFolder("Étape 2: Validation du maillage vers le module Comptes.", "", pmNormal, boldAttribute);  
    //****************************************************************************************************************************************************    
    Log.AppendFolder("Setup.");             
    Get_ModulesBar_BtnClients().Click();         
    Search_Client(clientNumber);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", roots, 10).Find("OriginalValue", secondaryClientNumber, 10).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", roots, 10).Find("OriginalValue", secondaryClientNumber, 10), Get_ModulesBar_BtnAccounts());
    Log.PopLogFolder();
    Log.PopLogFolder();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
    aqObject.CheckProperty(Get_ModulesBar_BtnAccounts(), "IsChecked", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, secondaryClientNumber);    
    
    errorCountAfterExecution = Log.ErrCount;
    var errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 2: Validation du maillage vers le module Comptes.' completed successfully with " + errorsStep + " errors.");
    }
    else
    {
      Log.Error("***** 'Étape 2: Validation du maillage vers le module Comptes.' completed with " + errorsStep + " errors.");
      errorCountAfterExecution = --errorCountAfterExecution;
    }
    
    errorCountBeforeExecution = errorCountAfterExecution;    
      
    //********************************************* Étape 3: Validation du maillage vers le module Relations *********************************************
    Log.AppendFolder("Étape 3: Validation du maillage vers le module Relations.", "", pmNormal, boldAttribute);  
    //****************************************************************************************************************************************************    
    Log.AppendFolder("Setup.");             
    Get_ModulesBar_BtnClients().Click();         
    Search_Client(clientNumber);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", roots, 10).Find("OriginalValue", secondaryClientNumber, 10).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", roots, 10).Find("OriginalValue", secondaryClientNumber, 10), Get_ModulesBar_BtnRelationships());
    Log.PopLogFolder();
    Log.PopLogFolder();
    
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    aqObject.CheckProperty(Get_ModulesBar_BtnRelationships(), "IsChecked", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, secondaryClientNumber);     
        
    errorCountAfterExecution = Log.ErrCount;
    var errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 3: Validation du maillage vers le module Relations.' completed successfully with " + errorsStep + " errors.");
    }
    else
    {
      Log.Error("***** 'Étape 3: Validation du maillage vers le module Relations.' completed with " + errorsStep + " errors.");
      errorCountAfterExecution = --errorCountAfterExecution;
    }
    
    errorCountBeforeExecution = errorCountAfterExecution; 
    
    //******************************************** Étape 4: Validation du maillage vers le module Portefeuille *******************************************
    Log.AppendFolder("Étape 4: Validation du maillage vers le module Portefeuille.", "", pmNormal, boldAttribute);  
    //****************************************************************************************************************************************************    
    Log.AppendFolder("Setup.");             
    Get_ModulesBar_BtnClients().Click();         
    Search_Client(clientNumber);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", roots, 10).Find("OriginalValue", secondaryClientNumber, 10).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", roots, 10).Find("OriginalValue", secondaryClientNumber, 10), Get_ModulesBar_BtnPortfolio());
    Log.PopLogFolder();
    Log.PopLogFolder();
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
    aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);   
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_BtnTreeViewButton().DataContext, "TabTextHeader", cmpContains, secondaryClientNumber);  
        
    errorCountAfterExecution = Log.ErrCount;
    var errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 4: Validation du maillage vers le module Portefeuille.' completed successfully with " + errorsStep + " errors.");
    }
    else
    {
      Log.Error("***** 'Étape 4: Validation du maillage vers le module Portefeuille.' completed with " + errorsStep + " errors.");
      errorCountAfterExecution = --errorCountAfterExecution;
    }
    
    errorCountBeforeExecution = errorCountAfterExecution;
     
    //******************************************** Étape 5: Validation du maillage vers le module Transactions *******************************************
    Log.AppendFolder("Étape 5: Validation du maillage vers le module Transactions.", "", pmNormal, boldAttribute);  
    //****************************************************************************************************************************************************    
    Log.AppendFolder("Setup.");             
    Get_ModulesBar_BtnClients().Click();         
    Search_Client(clientNumber);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", roots, 10).Find("OriginalValue", secondaryClientNumber, 10).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", roots, 10).Find("OriginalValue", secondaryClientNumber, 10), Get_ModulesBar_BtnTransactions());
    Log.PopLogFolder();
    Log.PopLogFolder();
    
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);
    aqObject.CheckProperty(Get_ModulesBar_BtnTransactions(), "IsChecked", cmpEqual, true);    
  
    errorCountAfterExecution = Log.ErrCount;
    var errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 5: Validation du maillage vers le module Transactions.' completed successfully with " + errorsStep + " errors.");
    }
    else
    {
      Log.Error("***** 'Étape 5: Validation du maillage vers le module Transactions.' completed with " + errorsStep + " errors.");
      errorCountAfterExecution = --errorCountAfterExecution;
    }
    
    errorCountBeforeExecution = errorCountAfterExecution;    
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

function IsWarningDialogDisplayed()
{
  var wndCaptionWarning = (language == 'french') ? "Avertissement" : "Warning";
  var processName = Sys.Process("CroesusClient");
  var windowObject = processName.FindChild(["wndCaption", "Exists"], [wndCaptionWarning, true], 0);
  
  return (windowObject);
}

function GetWarningDialogText()
{
  var wndCaptionWarning = (language == 'french') ? "Avertissement" : "Warning";
  var processName = Sys.Process("CroesusClient");
  var windowObject = processName.FindChild(["wndCaption", "Exists"], [wndCaptionWarning, true], 0).FindChild("ClrClassName", "TextBlock", 10);
  
  return (windowObject.WPFControlText);  
}

function GetWarningDialogOkButton()
{
  var wndCaptionWarning = (language == 'french') ? "Avertissement" : "Warning";
  var processName = Sys.Process("CroesusClient");
  var windowObject = processName.FindChild(["wndCaption", "Exists"], [wndCaptionWarning, true], 0).FindChild("WPFControlName", "PART_OK", 10);

  return (windowObject);  
}

function GetCroesusBuildVersion()
{
  var croesusBuildVersion = "";
  var propertiesArray = ["ClrClassName", "WPFControlOrdinalNo"];
  var valuesArray = ["TextBlock", 7];

  Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").SetFocus();
  Get_MenuBar().FindChild("Uid", "CustomizableMenu_3049", 10).Click();  
  Get_SubMenus().FindChild("Uid", "CFMenuItem_cf20", 10).Click();
  croesusBuildVersion = Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").WPFObject("AboutWin").FindChild(propertiesArray, valuesArray, 10).WPFControlText;
  Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").Click();

  return (croesusBuildVersion);  
}
