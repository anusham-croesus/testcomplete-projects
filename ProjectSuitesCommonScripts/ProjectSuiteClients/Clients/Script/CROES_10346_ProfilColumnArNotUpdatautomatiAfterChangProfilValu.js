//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA

//
// Auteur: Sana Ayaz
// Anomalie: CROES-10346
// Version de scriptage: ref90-07-Co-9--V9-Be_1-co6x
//
// MAJ: Pierre Lefebvre (June 02, 2021)
//      --> L'ajout de profil est accompli en effectuant un right-click sur la colonne `Telephone 1' au lieu de 'Telephone 4' qui n'existe pas.
//      --> Retrait de la fermeture de Croesus en fin de Try{} pour éviter un délai car le Finally{} contient un Login inutile.
//      --> Ajout d'information additionelle dans les Logs.
//


function CROES_10346_ProfilColumnArNotUpdatautomatiAfterChangProfilValu()
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();    
    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");  
    var clientNumber800300 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NumberClient800300", language + client);
    var groupBoxCroes10346 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "GroupBoxCROES10346", language + client);
    var wpfControlOrdinalColumnCroes10346 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "WPFControlOrdinalColumnCROES10346", language + client);
    var wpfControlOrdinalLineCroes10346 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "WPFControlOrdinalLineCROES10346", language + client);
    var addedProfileCroes10346 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "ProfilAjouteCROES10346", language + client);
    var enterValueProfileCroes10346 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "EnterValueProfileCROES10346", language + client);
    var displayValueProfileCroes10346 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "DisplaValuProfilCROES10346", language + client);
    var tabProfileText = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "TabProfilText", language + client);
    var maximumNumberRetry = 5
      
    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/browse/CROES-10346", "Cas de tests JIRA CROES-10346");
    Log.AppendFolder("Preparation of test envionment on " + vServerClients + " for client " + client + " using username " + userNameKEYNEJ + ".");        
    Log.AppendFolder("Environment Setup.");
        
    Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
    
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
           
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
    SetDefaultConfiguration(Get_ClientsGrid_ChCurrency());      
    Log.PopLogFolder();
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerClients + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);    
    Log.AppendFolder("Setup.");
    
    // Adding column 'Arbre F' to Clients pad
    Log.Message("Adding column '" + addedProfileCroes10346 + "' from Profiles.");
    Get_ClientsGrid_ChTelephone1().ClickR(); 
    Get_ClientsGrid_ChTelephone1().ClickR(); 
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
    Delay(1000);
    Get_GridHeader_ContextualMenu_AddColumn_Profiles().Click();
    Delay(1000);
    Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();

    // Edit 'Arbre F' value for Client 800300         
    Log.Message("Edit value of '" + addedProfileCroes10346 + "' for Client " + clientNumber800300 + ".");      
    Search_Client(clientNumber800300);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber800300, 10).DblClick();
    Get_WinDetailedInfo_TabProfile().Click();  
    WaitObject(Get_CroesusApp(), ["WPFControlText", "VisibleOnScreen", "IsSelected"], [tabProfileText, true, true]);
    Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false);  
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["GroupBox", groupBoxCroes10346], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", 1], 10).Keys(enterValueProfileCroes10346)
    Get_WinDetailedInfo_BtnApply().Click();
    Get_WinDetailedInfo_RobustBtnOKclick(maximumNumberRetry);
        
    // Validate that entered value was automatically updated in the Clients grid  
    var actualProfileValue = Get_ProfileCellValue(addedProfileCroes10346, clientNumber800300);
    
    Log.PopLogFolder();       
    Log.Message("Validating that new value of '" + addedProfileCroes10346 + "' for Client " + clientNumber800300 + " was automatically updated."); 
    
    if (actualProfileValue == false)
    {
      Log.Error("Client number " + clientNumber800300 + " was not found. The script will be aborted.");   
    }
    else if (actualProfileValue.profileCellValue == displayValueProfileCroes10346)
    {
      Log.Checkpoint("The profile value was correctly auto-updated. Expected value = " + displayValueProfileCroes10346 + ". Actual value = " + actualProfileValue.profileCellValue);
    }
    else
    {
      Log.Error("The profile value was not correctly auto-updated. Expected value = " + displayValueProfileCroes10346 + ". Actual value = " + actualProfileValue.profileCellValue);
    }
  }
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  
  finally
  {
    Log.AppendFolder("Restore default configuration.");
    ResetData(clientNumber800300, groupBoxCroes10346, addedProfileCroes10346);

    Close_Croesus_MenuBar();
    CloseConfirmationMsg("Yes"); 
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

function ResetData(clientNumber, groupBoxCroes10346, addedProfileCroes10346)
{    
  Get_ModulesBar_BtnClients().Click();
  Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
  Search_Client(clientNumber);
  Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10).DblClick();
  Get_WinDetailedInfo_TabProfile().Click();
  Get_WinDetailedInfo_TabProfile().WaitProperty("IsSelected", true, 60000);
    
  Log.Message("Resetting value of '" + addedProfileCroes10346 + " for Client " + clientNumber + ".");  
  Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["GroupBox", groupBoxCroes10346], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", 1], 10).Clear();
  Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(true);  
  Get_WinDetailedInfo_BtnApply().Click();
  Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 30000);   
  Get_WinDetailedInfo().Close()
  SetDefaultConfiguration(Get_ClientsGrid_ChCurrency());
}

function ChArbre_ClientsGrid(addedProfileCroes10346)
{
  return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", addedProfileCroes10346], 10);
}

function Get_ProfileCellValue(addedProfileCroes10346, clientNumber)
{    
  var arrayClientsGrid = Get_Grid_ContentArray(Get_RelationshipsClientsAccountsGrid(), Get_ClientsGrid_ChClientNo());
  
  if (Get_RowIndex(arrayClientsGrid, clientNumber) == -1)
  {
    Log.Error("Client " + clientNumber + " was not found in the Clients pad.");
    return false;
  }
     
  var rowIndex = Get_RowIndex(arrayClientsGrid, clientNumber);
  var columnIndex = Get_ColumnIndex(ChArbre_ClientsGrid(addedProfileCroes10346));   
     
  return {profileCellValue : arrayClientsGrid[rowIndex-1][columnIndex]};
}

function Get_WinDetailedInfo_RobustBtnOKclick(maximumNumberRetry)
{
  SetAutoTimeOut(2000);
    
  for (currentAttempt = 1; currentAttempt <= maximumNumberRetry; currentAttempt++)
  {
    visibilityBefore = WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 2000);
        
    if (visibilityBefore == true)
    {
      Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 10000);
      Get_WinDetailedInfo_BtnOK().Click();
      Log.Message("Details Window: Wait for OK button to no longer be visible.");
      visibilityAfter = WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 2000);
      
      if (visibilityAfter == false)
      {
        Log.Message("Details Window: The OK button is no longer visible (" + currentAttempt + ").");
        break;
      }
      else
      {
        if (currentAttempt == maximumNumberRetry)
        {
          Log.Error("The OK button is still visible after " + currentAttempt + " attempts.");
        }
        else
        {
          Log.Message("The OK button is still visible after " + currentAttempt + " attempt(s) out of " + maximumNumberRetry + ".");
        }
      }
    }
    else
    {
      Log.Message("Details Window: The OK button is not visible.");
      break;
    }
        
    Delay(2000);
  }
    
  RestoreAutoTimeOut();
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
