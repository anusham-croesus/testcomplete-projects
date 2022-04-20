//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2273_Commun_Function

//
// Modules: Clients/Relations/Comptes
// Jira: TCVE-1251
// Description: Validation de l'impact des préférences sur les champs ciblés retirés de la création et modification des filtres rapides.  
//    
// Auteur: Abdel Matmat
// Version de scriptage: 90.19.2020.09-7
// Date: 11-09-2020 
//
// MAJ: Pierre Lefebvre (June 01, 2021)
//      --> Correctif pour le WPFControlText qui était erroné ("Clients" au lieu de "Clients racines").
//      --> Ajout d'information additionelle dans les Logs.
//
// MAJ: Philippe Maurice (22 septembre 2021)
//      --> Correction de la fonction pour trouver le numéro de client 800054 dans la fenêtre Root clients (version 90.26.2021.08-60)
//      --> Correction de la fonction pour cliquer sur le bouton OK de la fenêtre Root clients (version 90.26.2021.08-60)
//


function CR2273_TCVE_1251_ValidateTargetedFieldsRemovedFromCreationAndModificationOfQuickFilters()
{             
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();
    var columnCourriel1 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "columnCourriel1", language + client);
    var julieFilter = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "julieFilter", language + client);
    var relationNameTCVE1251 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "relationNameTCVE1251", language + client);
    var clientNumber800054 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "clientNumber800054", language + client);
    var adresseFilterTCVE1251 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "adresseFilterTCVE1251", language + client);
    var filterNameCourriel1 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "fiterNameCourriel1", language + client);
    var filterName800054 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "fiterName800054", language + client);
    var phone1_TCVE1251 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "phone1_TCVE1251", language + client);
    var filterNameTelephone = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "filterNameTelephone", language + client);
    var adressItem = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "adressItem", language + client);
    var mail1Item = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "mail1Item", language + client);
    var mail2Item = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "mail2Item", language + client);
    var mail3Item = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "mail3Item", language + client);
    var phoneItem = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "phoneItem", language + client);
    var NASItem = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "NASItem", language + client);
    var postalCode = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "postalCode", language + client);
    var adressPostalCode = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2273", "adressPostalCode", language + client);
        
    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/browse/TCVE-1251", "Cas de test dans Jira");
    Log.AppendFolder("Preparation of test envionment on " + vServerClients + " for client " + client + " using username " + userName + ".");        
    Log.PopLogFolder();

    // ETAPE 1: Setting preferences to 1) disable encryption and 2) allow user to edit firm level search criteria.
    //  
    Log.AppendFolder("Étape 1: Setting preferences to 1) disable encryption and 2) allow user to edit firm level search criteria.");
    Log.AppendFolder("Preference PREF_TOGGLE_ENCRYPT_FEATURES = NO");
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TOGGLE_ENCRYPT_FEATURES", "NO", vServerClients);           
    Log.PopLogFolder();
    Log.AppendFolder("Preference PREF_EDIT_FIRM_FUNCTIONS = YES");
    Activate_Inactivate_Pref(userName, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerClients);    
    Log.PopLogFolder();
    RestartServices(vServerClients);
    Log.AppendFolder("Login to Croesus Advisor");                  
    Login(vServerClients, userName, psw, language);
    Log.PopLogFolder();
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);    
              
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
    
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerClients + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);
    
    // ETAPE 2: Validation dans le module Clients.
    //
    Log.AppendFolder("Étape 2: Validation dans le module Clients.");       
    Log.AppendFolder("Ajout de la colonne courriel 1 dans la grille Clients.");
    Add_ColumnByLabel(Get_ClientsGrid_ChCurrency(),columnCourriel1);
    Log.PopLogFolder();
          
    Log.AppendFolder("Application d'un filtre rapide.");
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_Email1().Click();
    Log.PopLogFolder();
    
    Log.AppendFolder("Création d'un filtre.");
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemContaining().Click();
    Get_WinCreateFilter_TxtValue().Keys(julieFilter);
    Get_WinCreateFilter_BtnSaveAndApply().Click();
    Get_WinSaveFilter_TxtName().Keys(filterNameCourriel1);
    Get_WinSaveFilter_BtnOK().Click();   
    Log.PopLogFolder();
    
    Log.AppendFolder("Validation of newly created filter.");
            
    var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl;
    var itemCount = grid.Items.Count;
    
    for (currentItem = 0; currentItem < itemCount; currentItem++)
    {
      aqObject.CheckProperty(grid.Items.Item(currentItem).DataItem, "Email1", cmpContains, julieFilter);
    }
          
    Log.PopLogFolder();
    Log.PopLogFolder();
    
    // ETAPE 3: Validation dans le module Relations.
    //
    Log.AppendFolder("Étape 3: Validation dans le module Relations.");
    Log.AppendFolder("Sélectionner un représentant.");               
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    Get_RelationshipsClientsAccountsGrid().Find("value", relationNameTCVE1251, 10).DblClick();
    Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship().Click();
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
    Delay(10000);
    Get_WinDetailedInfo_WinClientRoot().FindChild("Text", clientNumber800054, 10).Click();
    //Get_WinDetailedInfo_WinClientRepresentatives().Find("Text", clientNumber800054, 10).Click();  //semble ne pas fonctionner sur la version 90.26.2021.08-60
    Get_WinDetailedInfo_WinClientRoot_btnOk().Click();
    //Get_WinDetailedInfo_WinClientRepresentatives_btnOk().Click();    /semble ne pas fonctionner sur la version 90.26.2021.08-60
    Get_DlgConfirmation_BtnYes().Click();
    Get_WinDetailedInfo_BtnApply().Click();
    WaitObject(Get_WinDetailedInfo(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10);
    Get_WinDetailedInfo_BtnOK().Click();            
    Log.PopLogFolder();
    
    Log.AppendFolder("Application d'un filtre rapide.");
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_Address().Click();
    Sys.Keys("[Down]");
    Sys.Keys("[Enter]");
    Log.PopLogFolder();
         
    Log.AppendFolder("Création d'un filtre.");
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemStartingWith().Click();
    Get_WinCreateFilter_TxtValue().Keys(adresseFilterTCVE1251);
    Get_WinCreateFilter_BtnSaveAndApply().Click();
    Get_WinSaveFilter_TxtName().Keys(filterName800054);
    Get_WinSaveFilter_BtnOK().Click();
    Log.PopLogFolder();
    Log.PopLogFolder();             
                
    // ETAPE 4: Validation dans le module Comptes.
    //
    Log.AppendFolder("Étape 4: Validation dans le module Comptes.");
    Log.AppendFolder("Application d'un filtre rapide.");
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
    Delay(1000);
    Sys.Keys("8");
    Get_WinQuickSearch_RdoPhone1().set_IsChecked(true);
    Get_WinQuickSearch_TxtSearch().SetText(phone1_TCVE1251);
    Get_WinQuickSearch_BtnFilter().Click();
            
    // Editer le filtre 
    var buttonWidth = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
    
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(buttonWidth - 35, 13);
        
    // Sauvegarder le filtre
    Get_WinCreateFilter_BtnSaveAndApply().Click();
    Get_WinSaveFilter_TxtName().Keys(filterNameTelephone);
    Get_WinSaveFilter_BtnOK().Click();
    Log.PopLogFolder();
    
    Log.AppendFolder("Terminate Croesus Process.");        
    Terminate_CroesusProcess(); 
    Log.PopLogFolder();
    Log.PopLogFolder();  

    // ETAPE 5: Setting preferences to 1) enable encryption and 2) allow user to edit firm level search criteria.
    //  
    Log.AppendFolder("Étape 5: Setting preferences to 1) enable encryption and 2) allow user to edit firm level search criteria.");
    Log.AppendFolder("Preference PREF_TOGGLE_ENCRYPT_FEATURES = YES");
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TOGGLE_ENCRYPT_FEATURES", "YES", vServerClients);           
    Log.PopLogFolder();
    RestartServices(vServerClients);
    Log.AppendFolder("Login to Croesus Advisor");                  
    Login(vServerClients, userName, psw, language);
    Log.PopLogFolder();
    Log.PopLogFolder();      
                        
    // ETAPE 6: Validation dans le module Relations.
    //
    Log.AppendFolder("Étape 6: Validation dans le module Relations.");  
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            
    var grid = Get_SubMenus().WPFObject("ContextMenu", "", 1);
    var itemCount = grid.Items.Count;
    var found = false;
    
    for (currentItem = 0; currentItem < itemCount; currentItem++)
    {
      if (grid.Items.Item(currentItem).WPFControlText == adressItem)
      {
        // Log.error("Item adresse ne doit pas existé dans la liste des filtres");
        // found = true;
        Log.Checkpoint("Item adresse doit existé dans la liste des filtres avec seulement le code postal");
        Get_SubMenus().Find(["ClrClassName", "WPFControlText"], ["MenuItem", adressItem], 10).OpenMenu();
        
        if (Get_SubMenus().ChildCount == 1)
        {
          Log.Checkpoint("Un seul élément affiché");
        }
        
        if (Get_SubMenus().Find("WPFControlText", postalCode, 10).Exists)
        {
          Log.Checkpoint("Seulement le code postal est affiché"); 
        }  
      }
      
      if (grid.Items.Item(currentItem).WPFControlText == mail1Item)
      {
        Log.error("Item Courriel 1 ne doit pas existé dans la liste des filtres.");
        found = true;
      }
              
      if (grid.Items.Item(currentItem).WPFControlText == mail2Item)
      {
        Log.error("Item Courriel 2 ne doit pas existé dans la liste des filtres.");
        found = true;
      }
              
      if (grid.Items.Item(currentItem).WPFControlText == mail3Item)
      {
        Log.error("Item Courriel 3 ne doit pas existé dans la liste des filtres.");
        found = true;
      }
              
      if (grid.Items.Item(currentItem).WPFControlText == phoneItem)
      {
        Log.error("Item Téléphone ne doit pas existé dans la liste des filtres.");
        found = true;
      }
              
      if (grid.Items.Item(currentItem).WPFControlText == filterName800054)
      {
        Log.error("Le filtre 'Adresse_800054' ne doit pas existé dans la liste des filtres prédéfinies.");
        found = true;
      }
    }
            
    if (!found)
    {
      Log.Checkpoint("Aucun filtre n'est affiché.");
    }

    Log.PopLogFolder();
    
    // ETAPE 7: Validation dans le module Clients.
    //
    Log.AppendFolder("Étape 7: Validation dans le module Clients.");                 
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
    Get_MenuBar_Search().OpenMenu();
    Get_MenuBar_Search_QuickFilters().OpenMenu();
    Get_MenuBar_Search_QuickFilters_AddAFilter().Click();
    
    if (language == "french")
    {
      WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", "Ajouter un filtre", true, true]);  
    }
    else
    {
      WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", "Add a Filter", true, true]);  
    }
             
    Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
     
    var itemCount = Get_SubMenus().ChildCount; 
    var found = false;
    
    for (currentItem = 0; currentItem < itemCount; currentItem++)
    {     
      if (Get_SubMenus().DataContext.FilterFields.Item(currentItem).ComboLabel == adressPostalCode)
      {
        Log.Checkpoint("Item adresse doit existé dans la liste des filtres avec seulement le code postal.");
      }
      
      if (Get_SubMenus().DataContext.FilterFields.Item(currentItem).Label == mail1Item)
      {
        Log.error("Item Courriel 1 ne doit pas existé dans la liste des filtres.");
        found = true;
      }
      
      if (Get_SubMenus().DataContext.FilterFields.Item(currentItem).Label == mail2Item)
      {
        Log.error("Item Courriel 2 ne doit pas existé dans la liste des filtres.");
        found = true;
      }
      
      if (Get_SubMenus().DataContext.FilterFields.Item(currentItem).Label == mail3Item)
      {
        Log.error("Item Courriel 3 ne doit pas existé dans la liste des filtres.");
        found = true;
      }
      
      if (Get_SubMenus().DataContext.FilterFields.Item(currentItem).Label == phoneItem)
      {
        Log.error("Item Téléphone ne doit pas existé dans la liste des filtres.");
        found = true;
      }
      
      if (Get_SubMenus().DataContext.FilterFields.Item(currentItem).Label == NASItem)
      {
        Log.error("Le filtre NAS ne doit pas existé dans la liste des filtres.");
        found = true;
      }
    }
            
    if (!found)
    {
      Log.Checkpoint("Aucun filtre n'est affiché.");
    }
    
    Get_WinCRUFilter_BtnCancel().Click();

    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
          
    var grid = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"],["RecordListControl", "1"], 10);
    var itemCount = grid.Items.Count;
    
    for (currentItem = 0; currentItem < itemCount; currentItem++)
    {
      if (grid.Items.Item(currentItem).DataItem.Description == filterNameCourriel1)
      {
        Log.error("Item " + filterNameCourriel1 + " ne doit pas existé dans la liste des filtres.");  
      }           
    } 

    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnEdit().Click();
    Get_WinCRUFilter_GrpCondition_CmbField().DropDown(); 
          
    var itemCount = Get_SubMenus().ChildCount; 
    var found = false;
    
    for (currentItem = 0; currentItem < itemCount; currentItem++)
    {      
      if (Get_SubMenus().DataContext.FilterFields.Item(currentItem).ComboLabel == adressPostalCode)
      {
        Log.Checkpoint("Item adresse doit existé dans la liste des filtres avec seulement le code postal.");
        // found = true;
      }
      
      if (Get_SubMenus().DataContext.FilterFields.Item(currentItem).Label == mail1Item)
      {
        Log.error("Item Courriel 1 ne doit pas existé dans la liste des filtres.");
        found = true;
      }
      
      if (Get_SubMenus().DataContext.FilterFields.Item(currentItem).Label == mail2Item)
      {
        Log.error("Item Courriel 2 ne doit pas existé dans la liste des filtres.");
        found = true;
      }
        
      if (Get_SubMenus().DataContext.FilterFields.Item(currentItem).Label == mail3Item)
      {
        Log.error("Item Courriel 3 ne doit pas existé dans la liste des filtres.");
        found = true;
      }
        
      if (Get_SubMenus().DataContext.FilterFields.Item(currentItem).Label == phoneItem)
      {
        Log.error("Item Téléphone ne doit pas existé dans la liste des filtres.");
        found = true;
      }
        
      if (Get_SubMenus().DataContext.FilterFields.Item(currentItem).Label == NASItem)
      {
        Log.error("Le filtre NAS ne doit pas existé dans la liste des filtres.");
        found = true;
      }
    }
            
    if (!found)
    {
      Log.Checkpoint("Aucun filtre n'est affiché.");
    }
      
    Get_WinCRUFilter_BtnCancel().Click();
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
    Log.PopLogFolder()

    // ETAPE 8: Validation dans le module Comptes.
    //
    Log.AppendFolder("Étape 8: Validation dans le module Comptes.");  
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000); 
            
    var toggleButton = Get_RelationshipsClientsAccountsGrid().RecordListControl.Find("WPFControlText", filterNameTelephone, 10);
            
    if (toggleButton.Exists)
    {
      Log.Error("Le filtre ne doit pas être affiché.");
    }
    else
    {
      Log.Checkpoint("Le filtre n'est plus affiché.");
    }  
      
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    
    var grid = Get_SubMenus().WPFObject("ContextMenu", "", 1);
    var itemCount = grid.Items.Count;
    var found = false;
    
    for (currentItem = 0; currentItem < itemCount; currentItem++)
    {
      if (grid.Items.Item(currentItem).WPFControlText == phoneItem)
      {
        Log.error("Item Téléphone ne doit pas existé dans la liste des filtres.");
        found = true;
      }
      
      if (grid.Items.Item(currentItem).WPFControlText == filterNameTelephone)
      {
        Log.error("Item " + filterNameTelephone + " ne doit pas existé dans la liste des filtres préféfinis.");
        found = true;
      }
    }
            
    if (!found)
    {
      Log.Checkpoint("Aucun filtre n'est affiché.");
    }            
  }
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));    
  }
  
  finally
  {
    Log.PopLogFolder();
    Log.AppendFolder("Restore default configuration.");
    Log.AppendFolder("Delete newly created filters.");
    Delete_FilterCriterion(filterNameCourriel1, vServerClients);
    Delete_FilterCriterion(filterName800054, vServerClients);
    Delete_FilterCriterion(filterNameTelephone, vServerClients);
    Log.PopLogFolder();
          
    Log.AppendFolder("Terminate Croesus process.");
    Terminate_CroesusProcess();
    Log.PopLogFolder();
    
    Log.AppendFolder("Set preferences to default values.");
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TOGGLE_ENCRYPT_FEATURES", "NO", vServerClients);
    Activate_Inactivate_Pref(userName,"PREF_EDIT_FIRM_FUNCTIONS", "NO",vServerClients);
    RestartServices(vServerClients);
    
    Log.PopLogFolder();
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

 
function Get_WinDetailedInfo_WinClientRepresentatives()
{
  if (language == "french")
  {
    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniDialog", "Clients"], 10);
  }
  else
  {
    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniDialog", "Clients"], 10);
  }
}


function Get_WinDetailedInfo_WinClientRepresentatives_btnOk()
{
    return Get_WinDetailedInfo_WinClientRepresentatives().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10);
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