//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 

//
//  L'exportation vers Excel ne respecte pas l'ordre des colonnes dans la grille Accounts.
//  Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLayout.cs
//    
//  Vérifier toutes les données exportées vers Excel avec les scénarios suivants:
//  1) une configuration avec la grille Accounts utilisant les colonnes par défaut
//  2) une configuration avec la grille Accounts utilisant toutes les colonnes disponibles
//  3) une configuration avec la grille Accounts utilisant toutes les colonnes disponibles, puis une colonne enlevée et une colonne déplacée
//
//  Auteur: Abdel Matmat
//  Anomalie: CROES-9345
//  Version de scriptage:	90-07-CO-19    
//  NB: Ce script couvre le script "CROES_9345_Acc_ExcelExportDoesNotRespectOrderOfColumnsInGrid", ce dernier n'est pas ajouté au projet d'exécution.
//

function CROES_9345_Acc_CheckExcelExportData()
{         
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();
    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
    var ExpectedFile_DefaultColumns = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "CROES9345_Acc_DefaultColumnsFile", language+client);
    var ExpectedFile_AllColumns = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "CROES9345_Acc_AllColumnsFile", language+client);
    var ExpectedFile_RandomColumns = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "CROES9345_Acc_RandomColumnsFile", language+client);
    var ExpectedFolder = folderPath_Data + "ExportToExcel\\" + client + "\\ExpectedFolder\\Accounts\\" + language + "\\";
    var ResultFolder = folderPath_Data + "ExportToExcel\\" + client + "\\ResultFolder\\Accounts\\" + language + "\\"; 
    
    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
    Log.AppendFolder("Preparation of test envionment on " + vServerAccounts + " for client " + client + " using username " + userName + ".");        
    Log.AppendFolder("Environment Setup.");
                        
    Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
    
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
     
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
    Get_MainWindow().Maximize();
    Log.PopLogFolder();
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerAccounts + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);
                        
    // 1- Set the default configuration of columns in the Account grid
    Log.AppendFolder("Test 1: Default configuration for Account grid columns.");
    SetDefaultConfiguration(Get_AccountsGrid_ChCurrency());
                    
    // Click the Export Excel button
    Log.Message("Exporting file to Excel.");
    ClickOnButtonExportExcel_Accounts();
    CloseExcel();
                    
    // Compare both files
    Log.Message("Checking exported Excel data for default configuration with " + ExpectedFile_DefaultColumns);
    Log.PopLogFolder();
    ExcelFilesCompare(ExpectedFolder, ExpectedFile_DefaultColumns, ResultFolder);
                                        
    // 2- Add all columns in the Account grid
    Log.AppendFolder("Test 2: All available columns added to the Account grid.");
    var columnObjectGetExpressionString = 'Get_AccountsGrid_ChCurrency()'; //Par Christophe
    Add_AllColumns(eval(columnObjectGetExpressionString), columnObjectGetExpressionString); //Par Christophe
                    
    // Click the Export Excel button 
    Log.Message("Exporting file to Excel.");
    ClickOnButtonExportExcel_Accounts();                    
    CloseExcel();
                    
    // Compare both files
    Log.Message("Checking exported Excel data for all available columns with " + ExpectedFile_AllColumns);
    Log.Message("-------- Les différences sont liées à la colonne Régime. L'exportation d'un nombre à 12 chiffres est transformée en exponentiel.");
    Log.Message("-------- Les noms qui débutent par un signe mathématique sont transformés en formule.");
    Log.PopLogFolder();
    ExcelFilesCompare(ExpectedFolder, ExpectedFile_AllColumns, ResultFolder);
                    
    // 3- Delete column IA Code and move column Name
    Log.AppendFolder("Test 3: Column IA Code removed from Account grid and column Name moved within Account grid.");
    DeleteColumn(Get_AccountsGrid_ChIACode());
    MoveColumn(Get_AccountsGrid_ChName());
                    
    // Click the Export Excel button 
    Log.Message("Exporting file to Excel.");
    ClickOnButtonExportExcel_Accounts();                    
    CloseExcel();
                    
    // Compare both files
    Log.Message("Checking exported Excel data for delete and move columns with " + ExpectedFile_RandomColumns);
    Log.PopLogFolder();
    ExcelFilesCompare(ExpectedFolder, ExpectedFile_RandomColumns, ResultFolder);         
  } 
          
  catch (e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));                              
  }         

  finally
  {
    Log.AppendFolder("Restore default configuration.");    
    CloseExcel();
          
    // Delete exported Excel files from temp directory
    aqFileSystem.DeleteFile(Sys.OSInfo.TempDirectory + "\CroesusTemp\\*.txt");
                    
    // Set the default configuration of columns in the Account grid
    SetDefaultConfiguration(Get_AccountsGrid_ChCurrency());
                    
    // Set the initial configuation of columns
    if (client == "BNC")
    {
      if (language == "english")
      {
        Get_AccountsGrid_ChAccountNo().ClickR();
        Get_AccountsGrid_ChAccountNo().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
        Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();
      }
                    
      Get_AccountsGrid_ChMargin().ClickR();
      Get_AccountsGrid_ChMargin().ClickR();
      Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
      Get_AccountsGrid_ChTelephone2().ClickR();
      Get_AccountsGrid_ChTelephone2().ClickR()
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();

      if (language == "english")
      {
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 10], 10).Click();  
      }
      else
      {
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 12], 10).Click();   
      }
                    
      if (language == "english")
      {
        Get_AccountsGrid_ChBalance().ClickR();
        Get_AccountsGrid_ChBalance().ClickR()
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 6], 10).Click();

        Get_AccountsGrid_ChBalance().ClickR();
        Get_AccountsGrid_ChBalance().ClickR()
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 12], 10).Click(); 
      }
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

function ClickOnButtonExportExcel_Accounts()
{
  Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"],["Button", 3],10).Click();
  var excelWindow = Sys.Process("EXCEL").WaitWindow("XLMAIN", "*.txt - Excel", -1, 20000);
  
  if (excelWindow.Exists)
  {
    Log.Message("Excel XLMAIN window found.");
  }
  else
  {
    Log.Message("Excel XLMAIN window not found.");
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