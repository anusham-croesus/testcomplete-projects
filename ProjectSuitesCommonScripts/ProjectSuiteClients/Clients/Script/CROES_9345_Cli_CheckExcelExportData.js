//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 

//
// L'exportation vers Excel ne respect pas l'ordre des colonnes dans la grille Clients.
// Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLayout.cs
//
// Vérifier toutes les données exportées vers Excel avec les scénarios suivants:
// 1) une configuration avec la grille Clients utilisant les colonnes par défaut
// 2) une configuration avec la grille Clients utilisant toutes les colonnes disponibles
// 3) une configuration avec la grille Clients utilisant toutes les colonnes disponibles, puis une colonne enlevée et une colonne déplacée
//
// Auteur: Abdel Matmat
// Anomalie: CROES-9345
// Version de scriptage: 90-07-Co-13
//
// MAJ: Pierre Lefebvre (June 02, 2021)
//      --> Ajout de 'eval()' dans la fonction Add_AllColumns() pour convertir string à object.
//      --> Ajout d'information additionelle dans les Logs.
//

function CROES_9345_Cli_CheckExcelExportData()
{         
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();           
    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");    
    var ExpectedFile_DefaultColumns = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "CROES9345_Cli_DefaultColumnsFile", language + client);
    var ExpectedFile_AllColumns = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "CROES9345_Cli_AllColumnsFile", language + client);
    var ExpectedFile_RandomColumns = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "CROES9345_Cli_RandomColumnsFile", language + client);
    var ExpectedFolder = folderPath_Data + "ExportToExcel\\" + client + "\\ExpectedFolder\\Clients\\" + language + "\\";
    var ResultFolder = folderPath_Data + "ExportToExcel\\" + client + "\\ResultFolder\\Clients\\" + language + "\\";

    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
    Log.AppendFolder("Preparation of test envionment on " + vServerClients + " for client " + client + " using username " + userNameKEYNEJ + ".");        
    Log.AppendFolder("Environment Setup.");
                         
    Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
    
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
    
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);  
    Log.PopLogFolder();
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerClients + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);
    
    // 1- Set the default configuration of columns in the Clients grid
    Log.AppendFolder("Test 1: Default configuration for Clients grid columns.");
    SetDefaultConfiguration(Get_ClientsGrid_ChCurrency());
    Log.Message("Remove column 'age' to avoid modifying the datapool with every client anniversary.");
    DeleteColumn(Get_ClientsGrid_ChAge());
                    
    // Click the Export Excel button
    Log.Message("Exporting file to Excel.");
    ClickOnButtonExportExcel_Clients();
    CloseExcel();                    

    // Compare both files
    Log.Message("Checking exported Excel data for default configuration with " + ExpectedFile_DefaultColumns);
    ExcelFilesCompare(ExpectedFolder, ExpectedFile_DefaultColumns, ResultFolder);
    Log.PopLogFolder();                    

    // 2- Add all columns in the Clients grid
    Log.AppendFolder("Test 2: All available columns added to the Clients grid.");
    
    var columnObjectGetExpressionString = 'Get_AccountsGrid_ChCurrency()';
    Add_AllColumns(eval(columnObjectGetExpressionString), columnObjectGetExpressionString);                            

    Log.Message("Remove column 'age' to avoid modifying the datapool with every client anniversary.");
    for (counter = 0; counter < 50; counter++)
    {
      Get_RelationshipsClientsAccountsGrid().Keys("[Right]");
    }
    
    DeleteColumn(Get_ClientsGrid_ChAge());

    // Click the Export Excel button 
    Log.Message("Exporting file to Excel.");
    ClickOnButtonExportExcel_Clients();                    
    CloseExcel();
                  
    // Compare both files
    Log.Message("Checking exported Excel data for all available columns with " + ExpectedFile_AllColumns);             
    ExcelFilesCompare(ExpectedFolder, ExpectedFile_AllColumns, ResultFolder);
    Log.PopLogFolder();
                    
    // 3- Delete column IA Code and move column Name
    Log.AppendFolder("Test 3: Column IA Code removed from Clients grid and column Name moved within Clients grid.");
    for (counter = 0; counter < 50; counter++)
    {
      Get_RelationshipsClientsAccountsGrid().Keys("[Left]");
    }

    DeleteColumn(Get_ClientsGrid_ChIACode());
    MoveColumn(Get_ClientsGrid_ChName());
                    
    // Click the Export Excel button 
    Log.Message("Exporting file to Excel.");
    ClickOnButtonExportExcel_Clients();                    
    CloseExcel();

    // Compare both files
    Log.Message("Checking exported Excel data for delete and move columns with " + ExpectedFile_RandomColumns);
    ExcelFilesCompare(ExpectedFolder, ExpectedFile_RandomColumns, ResultFolder);
    Log.PopLogFolder();                         
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

    // Set the default configuration of columns in the Clients grid
    SetDefaultConfiguration(Get_ClientsGrid_ChClientNo()); 
                    
    // Set the initial configuation of columns 
    if (client == "BNC")
    {
      Log.Message("Set the initial configuration of columns");
      Get_ClientsGrid_ChIACode().ClickR();
      Get_ClientsGrid_ChIACode().ClickR();
      Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
      Get_ClientsGrid_ChAge().ClickR();
      Get_ClientsGrid_ChAge().ClickR();
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
      
      if (language == "french")   
      {
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();
      }
      else
      {
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 7], 10).Click();
      }
      
      Get_ClientsGrid_ChTelephone4().ClickR();
      Get_ClientsGrid_ChTelephone4().ClickR();
      Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
      Get_ClientsGrid_ChTotalValue().ClickR();
      Get_ClientsGrid_ChTotalValue().ClickR();
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
      
      if (language == "french")   
      {
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 12], 10).Click();
      } 
      else
      {
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 16], 10).Click();
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

function ClickOnButtonExportExcel_Clients()
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

  Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").SetFocus();
  Get_MenuBar().FindChild("Uid", "CustomizableMenu_3049", 10).Click();  
  Get_SubMenus().FindChild("Uid", "CFMenuItem_cf20", 10).Click();
  croesusBuildVersion = Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").WPFObject("AboutWin").FindChild(propertiesArray, valuesArray, 10).WPFControlText;
  Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").Click();

  return (croesusBuildVersion);  
}
