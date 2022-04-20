//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

//
// Description: Valider l'impression du brouillon de travail dans le module Comptes.
// Analyste d'assurance qualité: antonb
// Analyste d'automatisation: Asma Alaoui
// Version: ref90-10-Fm-6--V9
//

function Regression_CROES_4120_Acc_ChangeColumnsConfigurationAndPrintAccountList()
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var pdf = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "pdf", language + client);
    var timestamp = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S");
    var pdfFilename = pdf + timestamp;
    var folderPath = Project.Path + "PDF";
    var pdfFilenameFullPath = folderPath + "\\" + pdfFilename + ".pdf";    
    var boldAttribute = Log.CreateNewAttributes();
    boldAttribute.Bold = true;
    
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4120", "CROES-4120");
    Log.Message("PDF report will be saved as: " + pdfFilenameFullPath + ".");
    Create_Folder(folderPath + "\\");
    Log.AppendFolder("Preparation of test envionment on " + vServerAccounts + " for client " + client + " using username " + userName + ".");        
      
    Login(vServerAccounts, userName, psw, language);

    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
    Log.PopLogFolder();
    Log.Message("Croesus Desktop on " + vServerAccounts + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute); 

    Log.AppendFolder("Add 'État' column, print from File menu and validate that .pdf file is correctly saved.");               
    Get_ModulesBar_BtnAccounts().Click();
     
    Log.Message("Add the 'État' column.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Status().Click();
               
    // Vérifier que la colonne 'État' est affichée      
    if (Get_AccountsGrid_ChStatus().Exists)
    {
      Log.Checkpoint("'État' column exists and is visible as expected.");      
    }
    else
    {
      Log.Error("'État' column is not visible. This is not expected.");
    }

    // Lancer l'impression à partir du menu "Fichier"
    Get_MenuBar_File().Click();
    Get_MenuBar_File_Print().Click();
       
    // Imprimer en mode "Print to PDF"
    while (Get_DlgPrint_SelectPrinter().wSelectedItems != "Microsoft Print to PDF")
    {
      Get_DlgPrint_SelectPrinter().Keys("[Up]");
    }
    
    Get_DlgPrint_BtnPrint().Click();
    
    var windowsDisplayLanguage = GetWindowsDisplayLanguage();
    
    Log.Message("Windows Display Language is '" + VarToStr(WINDOWS_DISPLAY_LANGUAGE) + "'.");
        
    if (windowsDisplayLanguage == "english")
    {
      Sys.Process("CroesusClient").Window("#32770", "Save Print Output As", 1).SetFocus();
      Sys.Process("CroesusClient").Window("#32770", "Save Print Output As", 1).FindChild(["WndClass", "Index"], ["ComboBox", "1"], 10).SetText(pdfFilenameFullPath);
      Log.Picture(Sys.Process("CroesusClient").Window("#32770", "", 1), "Picture of Save dialog box");
      Sys.Process("CroesusClient").Window("#32770", "Save Print Output As", 1).Window("Button", "&Save", 1).Click(); 
    }
    else if (windowsDisplayLanguage == "french")
    {
      Sys.Process("CroesusClient").Window("#32770", "", 1).SetFocus();
      Sys.Process("CroesusClient").Window("#32770", "", 1).FindChild(["WndClass", "Index"], ["ComboBox", "1"], 10).SetText(pdfFilenameFullPath);
      Log.Picture(Sys.Process("CroesusClient").Window("#32770", "", 1), "Picture of Save dialog box");
      Sys.Process("CroesusClient").Window("#32770", "", 1).Window("Button", "&Sauvegarder", 1).Click();  
    }
    else
    {
      Log.Error("The display language for Windows could not be determined.");
    }
    
    Log.PopLogFolder();
    
    if (aqFile.Exists(pdfFilenameFullPath))
    {
      Log.Checkpoint("Validate that file was correctly saved. The file was correctly saved to " + pdfFilenameFullPath + ".");
    }
    else
    {
      Log.Error("Validate that file was correctly saved. The file was not correctly saved to " + pdfFilenameFullPath + ".");
    }
  }
   
  catch(e)
  {  
    Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
  }
    
  finally
  {
    Log.AppendFolder("Restore environment to default configuration.");
    Log.Message("Restoring default column configuration.");
    Terminate_CroesusProcess();
    Login(vServerAccounts, userName, psw, language);
    Get_ModulesBar_BtnAccounts().Click();
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
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

