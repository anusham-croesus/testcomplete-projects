//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1153_Cli_Create_PerCurrencyFilter_Icon_Y
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT DBA

//
// Description: Validation de l'affichage des filtres dans le menu Filtres prédéfinis
// Analyste d'assurance qualité: Karima Mehiguene
// Analyste d'automatisation: Youlia Raisper
//
// MAJ: Pierre Lefebvre (June 02, 2021)
//      --> Lorsqu'un filtre est créé, le filtre est enlevé de la grille Clients pour ne pas recevoir un message d'avertissement.  
//      --> Ajout d'information additionelle dans les Logs.
//

function CR1352_1412_Cli_Displaying_Predefined_Filters_inFiltersMenu()
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();
    var filterValue = "test_1412";

    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1412", "Cas de test sur Jira: CROES-1412");
    Log.AppendFolder("Preparation of test envionment on " + vServerClients + " for client " + client + " using username " + userName + ".");        
    Log.AppendFolder("Environment Setup.");
                
    Login(vServerClients, userName, psw ,language);
    
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
        
    Log.PopLogFolder();    
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerClients + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);
    
    // Create 11 new filters in Clients module
    Log.AppendFolder("Creating 11 new filters in Clients module.");   
    Get_ModulesBar_BtnClients().Click();
    Get_MainWindow().Maximize();
           
    if (client == "BNC" )
    {
      for (var currentFilter = 0; currentFilter <= 10; currentFilter++)
      {               
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();     
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();   
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click();                   
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(currentFilter);  
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();                   
        Get_WinCRUFilter_CmbField_ItemRootNo().Click();
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemStartingWith().Click();    
        Get_WinCRUFilter_GrpCondition_TxtValue().Keys(currentFilter);
        Get_WinCRUFilter_BtnOK().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_010e", 10000);  
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
        
        if (IsWarningDialogDisplayed().Exists)
        {
          Get_DlgWarning().Close();
          WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 10000);
        }

        Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.WPFObject("RecordListControl", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 1).WPFObject("Button", "", 2).Click();
        Log.Message("Filter '" + currentFilter + "' has been created.");                        
      } 
    }
    else
    {
      for (var currentFilter = 0; currentFilter <= 10; currentFilter++)
      {  
        var cmbFieldFrench = GetData(filePath_Clients, "CR1352", 374 + currentFilter, language);
        var cmbFieldEnglish = GetData(filePath_Clients, "CR1352", 374 + currentFilter, language);
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();     
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();   
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click();                   
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(currentFilter);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().set_IsDropDownOpen(true);
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
        Get_WinCRUFilter_CmbField_Item(cmbFieldFrench, cmbFieldEnglish).Click();
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
        Get_WinCRUFilter_GrpCondition_TxtValue().Keys(filterValue);
        Get_WinCRUFilter_BtnOK().Click();  
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();

        if (IsWarningDialogDisplayed().Exists)
        {
          Get_DlgWarning().Close();
          WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 10000);
        }        
 
        Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.WPFObject("RecordListControl", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 1).WPFObject("Button", "", 2).Click();
        Log.Message("Filter '" + currentFilter + "' has been created.");                                         
      } 
    }
    
    Log.PopLogFolder();
        
    // Validate that only the last 10 filters created out of the 11 are displayed in the drop-down menu with the topmost being the last one created
    Log.AppendFolder("Validate that only the last 10 filters created are displayed in the drop-down menu."); 
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    
    var numberMenuItems = Get_Toolbar_BtnQuickFilters_ContextMenu().Items.Count; 
    
    Log.PopLogFolder();
    for (var currentMenuItem = 0; currentMenuItem <= numberMenuItems - 1; currentMenuItem++)
    { 
      if (Get_Toolbar_BtnQuickFilters_ContextMenu().Items.Item(currentMenuItem).Get_Tag() == GetData(filePath_Clients, "CR1352", 21, language))
      {
        for (var currentFilter = 1; currentFilter <= 10; currentFilter++)
        {
          aqObject.CheckProperty(Get_Toolbar_BtnQuickFilters_ContextMenu().Items.Item(currentMenuItem + currentFilter), "WPFControlText", cmpEqual, 11 - currentFilter);    
        }      
      }                  
    } 

    // Validate Autres Filtres to ensure that Predefined Filter 0 is present
    Log.AppendFolder("Validate the other filters.");
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        
    if (Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", GetData(filePath_Clients, "CR1352", 99, language)).Exists)
    {
      Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", GetData(filePath_Clients,"CR1352", 99, language), 10).Click();
    }
    else
    {
      Log.Error("The item 'Autres Filtres' is not present in the drop-down menu.");
    }
        
    Check_IfFilterSavedInManageFilters(0);
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();  
  }
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  
  finally
  {
    Log.PopLogFolder();
    Log.AppendFolder("Restore default configuration.");
    Log.Message("Delete added filters.");
    
    for (var currentFilter = 0; currentFilter <= 10; currentFilter++)
    {      
      Delete_FilterCriterion(currentFilter, vServerClients);                 
    }
    
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