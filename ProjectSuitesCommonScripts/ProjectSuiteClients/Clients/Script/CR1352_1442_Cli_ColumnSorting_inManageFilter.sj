//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1352_1169_Cli_Create_UserAccessFilter
//USEUNIT CR1352_1167_Cli_Create_BranchAccessFilter

//
// Description: CR1352 - Validation du triage des colonnes dans la fenêtre Gestions des Filtres.
//  
// Analyste d'assurance qualité: Karima Mehiguene
// Analyste d'automatisation: Youlia Raisper  
//
// MAJ: Pierre Lefebvre (June 02, 2021)
//      --> Création de la fonction CheckDateColumOrdering() pour valider l'ordre des colonnes comportant des dates. Utilisisation de WPFControlText au lieu de la représentation interne de la date.
//      --> La représentation interne de la colonne 'Accès' est 'PartyLevelName' et non 'Creation' lorsque la fonction Check_columnAlphabeticalSort().  
//      --> Ajout d'information additionelle dans les Logs.
//
 
function CR1352_1442_Cli_ColumnSorting_inManageFilter()
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();    
    var userFiltre = "Utilisateur_Filtre";
    var branchFiltre = "Succursale_Filtre"; 

    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1442", "Cas de test sur Jira: CROES-4078");
    Log.AppendFolder("Preparation of test envionment on " + vServerClients + " for client " + client + " using username " + userName + ".");        
    Log.AppendFolder("Environment Setup.");
              
    Login(vServerClients, userName, psw, language);

    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
        
    Log.PopLogFolder();    
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerClients + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute); 
    
    Log.AppendFolder("Setup.");            
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    // Create first filter
    Log.AppendFolder("Create first filter.");   
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();        
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click();                
    Create_UserAccessFilter(userFiltre);
    Log.PopLogFolder();    
    
    // Create second filter
    Log.AppendFolder("Create second filter.");           
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 
    Create_BranchFilter(branchFiltre);
    Log.PopLogFolder();
    Log.PopLogFolder();   
    
    // Validate first column ordering (Nom/Name)
    Log.AppendFolder("Validate first column ordering (Nom/Name).");    
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Find("WPFControlText", GetData(filePath_Clients, "CR1352", 113, language), 100).Click();
    Log.PopLogFolder();      
    Check_columnAlphabeticalSort(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters(), GetData(filePath_Clients, "CR1352", 113, language), "Description");
    
    // Validate second column ordering (Modifié/Modified)
    Log.AppendFolder("Validate second column (Modifié/Modified).");    
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Find("WPFControlText", GetData(filePath_Clients, "CR1352", 114, language), 100).Click();
    Log.PopLogFolder();
    CheckDateColumOrdering(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters(), GetData(filePath_Clients,"CR1352",114,language));
    
    // Validate third column ordering (Créé/Created)
    Log.AppendFolder("Validate third column (Créé/Created).");     
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Find("WPFControlText", GetData(filePath_Clients, "CR1352", 115, language), 100).Click();
    Log.PopLogFolder(); 
    CheckDateColumOrdering(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters(), GetData(filePath_Clients, "CR1352", 115, language));
    
    // Validate fourth column ordering (Accès/Access)
    Log.AppendFolder("Validate fourth column (Accès/Access).");      
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Find("WPFControlText", GetData(filePath_Clients, "CR1352", 116, language), 100).Click();
    Log.PopLogFolder();
    Check_columnAlphabeticalSort(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters(), GetData(filePath_Clients,  "CR1352",116, language), "PartyLevelName");
        
    // Validate fifth column ordering (Création/Creation)
    Log.AppendFolder("Validate fifth column (Création/Creation).")  
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Find("WPFControlText", GetData(filePath_Clients, "CR1352", 117, language), 100).Click(); 
    Log.PopLogFolder();
    Check_columnAlphabeticalSort(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters(), GetData(filePath_Clients, "CR1352", 117, language), "CreatedByName");
        
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
  }
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  
  finally
  {
    Log.AppendFolder("Restore default configuration.");
    Log.Message("Delete added filters.");
    Delete_FilterCriterion(userFiltre,vServerClients); 
    Delete_FilterCriterion(branchFiltre,vServerClients);
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

function CheckDateColumOrdering(gridObject, visibleColumnName)
{
  var numberGridItems = gridObject.WPFObject("RecordListControl", "", 1).Items.Count;
  var arrayDateItems = [];
  var cellValuePresenterOrdinalNo = gridObject.FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", visibleColumnName], 10).WPFControlOrdinalNo;
  var actualColumnSortStatus = VarToStr(gridObject.Find("WPFControlText", visibleColumnName, 100).get_SortStatus());

  gridObject.Refresh();
    
  for (var currentGridItem = 0; currentGridItem < numberGridItems; currentGridItem++)
  {
    var dataItem = gridObject.WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (currentGridItem + 1));

    arrayDateItems.push(dataItem.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", cellValuePresenterOrdinalNo], 10).WPFControlText);
  }
  
  if (actualColumnSortStatus == "Ascending")
  {
    for (var currentDateItem = 1; currentDateItem < arrayDateItems.length; currentDateItem++)
    {
      if (arrayDateItems[currentDateItem] < arrayDateItems[currentDateItem - 1] && aqString.GetChar(arrayDateItems[currentDateItem - 1], 0) != "~")
      {
        Log.Message("------------------- " + arrayDateItems[currentDateItem] + " -------------------- " + arrayDateItems[currentDateItem - 1] + " --------------------");
        return Log.Error("La colonne '" + visibleColumnName + "' n'est pas trié en ordre chronologique croissant.");
      }
    }
    
    return Log.Checkpoint("La colonne '" + visibleColumnName + "' est trié en ordre chronologique croissant.");  
  }
  else if (actualColumnSortStatus == "Descending")
  {
    for (var currentDateItem = 1; currentDateItem < arrayDateItems.length; currentDateItem++)
    {
      if (arrayDateItems[currentDateItem - 1] < arrayDateItems[currentDateItem] && aqString.GetChar(arrayDateItems[currentDateItem], 0) != "~")
      {
        Log.Message("------------------- " + arrayDateItems[currentDateItem] + " -------------------- " + arrayDateItems[currentDateItem - 1] + " --------------------");
        return Log.Error("La colonne '" + visibleColumnName + "' n'est pas trié en ordre chronologique décroissant.");
      }
    }
    
    return Log.Checkpoint("La colonne '" + visibleColumnName + "' est trié en ordre chronologique décroissant.");  
  }
  else
  {
    Log.Warning("Le statut de la colonne '" + visibleColumnName + "' n'est pas 'Ascending' ou 'Descending' mais plutôt '" + actualColumnSortStatus + "'.", "", pmNormal, null, Sys.Desktop.Picture());
  }
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
