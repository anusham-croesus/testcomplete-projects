//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

//
// Description: Valider que le critère de recherche ne s’affiche pas si la pref = NON, module Comptes
// Analyste d'assurance qualité: Marina Gasin
// Analyste d'automatisation: Asma Alaoui
//

function CR2050_5747_ACC_ValidateCriteriaNotPreservedWhenPrefNO()
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();
    var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");      
    var criterion = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "Croes_5747_NumeroCompte", language+client);
    var test = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "NomCritère_5747", language+client);
    var preferenceName = "PREF_ENABLE_AUTOMATIC_CRITERIA";
    var preferenceActive = "YES";
    var preferenceInactive = "NO";
    boldAttribute.Bold = true;

    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5747", "CR2050");
    Log.AppendFolder("Preparation of test envionment on " + vServerAccounts + " for client " + client + " using username " + userName + ".");  
 
    Activate_Inactivate_Pref(userName, preferenceName, preferenceActive, vServerAccounts);
    RestartServices(vServerAccounts);
        
    Login(vServerAccounts, userName, password, language);

    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
    Log.PopLogFolder();
    Log.Message("Croesus Desktop on " + vServerAccounts + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute); 

    // Test 1
    Log.AppendFolder("Test 1: Enter search criteria and validate.");             
    Get_ModulesBar_BtnAccounts().Click();
    Get_Toolbar_BtnManageSearchCriteria().Click();     
    AddCriteria(test, criterion);
           
    // Valider bouton "Réafficher tout et conserver les crochets" et le nom du criètre de recherche s'affiche dans un rectangle bleu
    Log.PopLogFolder();
    Log.AppendFolder("Validate that search criteria is properly displayed.");
    aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(), "IsChecked", cmpEqual, true);
    aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(), "VisibleOnScreen", cmpEqual, true);
    aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10), "VisibleOnScreen", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10), "IsChecked", cmpEqual, true);
    Log.PopLogFolder();
        
    // Valider les comptes avec le critère de recherche défini
    Log.AppendFolder("Validate search criteria results.");         
    ValidateMatchesCriteriaComptes(criterion);
    Log.PopLogFolder();

    // Test 2    
    Log.AppendFolder("Test 2: Restart Croesus Desktop and validate that search criteria is still active.");
    Terminate_CroesusProcess();
        
    Login(vServerAccounts, userName, password, language);
        
    Get_ModulesBar_BtnAccounts().Click();
       
    // Valider l'affichage du critère de recherche
    Log.PopLogFolder();
    Log.AppendFolder("Validate that search criteria is properly displayed.");
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"Exists",cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"VisibleOnScreen",cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"IsVisible",cmpEqual, true);
    Log.PopLogFolder();
              
    // Valider que seulement le compte affiché est celui avec le critère de recherche défini
    Log.AppendFolder("Validate search criteria results."); 
    Search_Account(criterion);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", criterion, 10).DataContext.DataItem, "AccountNumber", cmpEqual, criterion);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", criterion, 10).DataContext.DataItem, "MatchesCriterion", cmpEqual, true);
    Log.PopLogFolder();

    // Test 3    
    Log.AppendFolder("Test 3: Set preference to No, restart Croesus Desktop and validate that search criteria is not active.");        
    Terminate_CroesusProcess();        
    Activate_Inactivate_Pref(userName, preferenceName, preferenceInactive, vServerAccounts);
    RestartServices(vServerAccounts);
          
    Login(vServerAccounts, userName, psw, language);
 
    Get_ModulesBar_BtnAccounts().Click();
        
    // Valider qu'aucun critère n'est appliqué dans la liste des comptes
    Log.PopLogFolder();
    Log.AppendFolder("Validate search criteria results.");
    ValidateNoMatchesCriteriaComptes();
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
    Terminate_CroesusProcess();
    
    Delete_FilterCriterion(test, vServerAccounts);      
    Activate_Inactivate_Pref(userName, preferenceName, preferenceActive, vServerAccounts);
    RestartServices(vServerAccounts); 

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

function AddCriteria(test, criterion)
{
  Get_WinSearchCriteriaManager_BtnAdd().Click(); 
  Get_WinAddSearchCriterion_TxtName().Keys(test);
    
  // Sur "Definition" modifier <Verbe> à "ayant"
  Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
  Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    
  // Sur <Champ> choisir "Informatif" ensuite " numéro de compte"
  Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
  Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
  Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemAccountNumber().Click();
    
  // Sur <Opérateur> choisir "égal(e) à"
  Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
  Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
    
  // Entrer la valeur "800066-NA" 
  Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();      
  Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys(criterion);
        
  // Sur <Suivant> choisir le point "."
  Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
  Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    
  // Cliquer sur "Sauvgarder et actualiser"
  Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();   
}
    
function ValidateMatchesCriteriaComptes(criterion) 
{    
  var gridContent = Get_Grid_ContentArray(Get_RelationshipsClientsAccountsGrid(), Get_AccountsGrid_ChAccountNo());

  for(currentLine = 0; currentLine < gridContent.length; currentLine++)
  {  
    Log.Message(gridContent[currentLine]);
    var line = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(currentLine);
    var valueMatchesCriterion = line.DataItem.MatchesCriterion;
    var accountNumber = line.DataItem.AccountNumber.OleValue;
           
    if ((valueMatchesCriterion == true && accountNumber == criterion) || (valueMatchesCriterion == false && accountNumber != criterion))
    {                      
      Log.Checkpoint("Search criteria for account " + accountNumber + " is respected.");
    }
    else
    { 
      Log.Error("Search criteria for account " + accountNumber + " is not respected."); 
    }            
  }         
}

function ValidateNoMatchesCriteriaComptes()
{
  var gridContent = Get_Grid_ContentArray(Get_RelationshipsClientsAccountsGrid(), Get_AccountsGrid_ChAccountNo());

  for(currentLine = 0; currentLine < gridContent.length; currentLine++)
  { 
    Log.Message(gridContent[currentLine]);    
    var line = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(currentLine);
    var valueMatchesCriterion = line.DataItem.MatchesCriterion;
    var accountNumber = line.DataItem.AccountNumber.OleValue;
           
    if (valueMatchesCriterion == true)
    {     
      Log.Error("Search criteria for account " + accountNumber + " is not respected.");
    }               
    else
    {                                        
      Log.Checkpoint("Search criteria for account " + accountNumber + " is respected.");             
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

