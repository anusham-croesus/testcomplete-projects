//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA

//
// Description: CR1501 (Gestion des notes)
//  
// Automatisation de deux Jira FA-5362 et FA-5565:
// 1) Étape 1: (FA-5362) Validation que la création d'une nouvelle note pour un client ne suprime pas une note plus ancienne.
// 2) Étape 2: (FA-5565) Validation du nouveau message d'erreur générique dans le module Clients. Validation de l'absence du message d'avertissement.
// 3) Étape 3: (FA-5565) Validation du nouveau message d'erreur générique dans le module Comptes. Validation de l'absence du message d'avertissement.
// 3) Étape 4: (FA-6153) Validation du nouveau message d'erreur générique dans le module Relations. Validation de l'absence du message d'avertissement.
//  
// Analyste d'assurance qualité: Karima Me
// Analyste d'automatisation: Emna IHM  
// Version de scriptage: ref90.24-52
//
// MAJ: Pierre Lefebvre (June 02, 2021)
//      --> FA-6153 (fix pour module Relations) n'est pas encore résolu et donc au lieu de générer Error on génère Warning.
//      --> Ajout du test sur le module Comptes car seulement Clients et Relations étaient couverts.
//      --> Ajout d'information additionelle dans les Logs.
//
 
function TCVE_4078_EditDelNote_ValidateWarnigErrorMessageWhenTryToSaveNote()
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();
    var moduleName = "";
    var clientNumber800272 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "numberClient800272", language + client);
    var txtNoteTCVE4078 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "txtNoteTCVE4078", language + client);
    var txtNoteEtape3TCVE4078 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "txtNoteEtape3TCVE4078", language + client);
    var dteOldNoteClt800272 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "dteOldNoteClt800272", language + client);
    var errorMessage1TCVE4078 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "ErrorMessage1TCVE4078", language + client);
    var errorMessage2TCVE4078 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "ErrorMessage2TCVE4078", language + client);
    var warningMessageTCVE4078 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "WarningMessageTCVE4078", language + client);

    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/browse/TCVE-4078", "Cas de test sur Jira: TCVE-4078");
    Log.AppendFolder("Preparation of test envionment on " + vServerClients + " for client " + client + " using username " + userName + ".");        
    Log.AppendFolder("Environment Setup.");
    
    Login(vServerClients, userName , psw, language);  

    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();

    Log.PopLogFolder();    
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerClients + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute); 
                                 
    //******************* Étape 1: (FA-5362) Validation que la création d'une nouvelle note pour un client ne suprime pas une note plus ancienne ******************
    Log.AppendFolder("Étape 1: (FA-5362) Validation que la création d'une nouvelle note pour un client ne suprime pas une note plus ancienne.");
    Log.Link("https://jira.croesus.com/browse/FA-5362", "Cas de Jira: FA-5362");  
    //*************************************************************************************************************************************************************
    
    Log.AppendFolder("Setup."); 
    Log.Message("From the Clients module, select client " + clientNumber800272 + ".");   
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");     
    Get_MainWindow().Maximize();
       
    Search_Client(clientNumber800272);
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");         
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber800272, 10).Click();
    Get_ClientsBar_BtnInfo().Click();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["TabItem_fc72", true]);
    Get_WinInfo_Notes_TabGrid().Click();
    Get_WinDetailedInfo().Parent.Position(100, 100, 1525, 900);
    Log.PopLogFolder();

    // Step 1a: Create 5 notes for same client      
    Log.AppendFolder("Step 1a: Add 5 notes for client " + clientNumber800272 + ".");
    
    var txtNoteArray = new Array();
   
    for (currentNote = 1; currentNote < 6; currentNote++)
    {
      Log.AppendFolder("Adding note #" + currentNote + ".");
      AddNote(txtNoteTCVE4078 + currentNote);  
      CheckNote(txtNoteTCVE4078 + currentNote);  
      txtNoteArray.push(txtNoteTCVE4078 + currentNote);
      Log.PopLogFolder();         
    }
    
    Log.Message("The added notes were the following: " + txtNoteArray.join(", "));
    Log.PopLogFolder();
    
    // Step 1b: Ensure adding a new note doesn't delete previously entered note
    Log.AppendFolder("Step 1b: Ensure adding a new note doesn't delete previously entered note.");
    Log.Message("Select note 'note4'.");
    Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", txtNoteArray[3], 10).Click();
       
    Log.Message("Double-Click on header 'Date de création' in order to sort notes from most to least recent.");
    Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().DblClick();
       
    Log.Message("Click on 'Ajouter' button to add another note with the text '" + txtNoteEtape3TCVE4078 + "' and Save.");
    AddNote(txtNoteEtape3TCVE4078);
    CheckNote(txtNoteEtape3TCVE4078); 
    Log.PopLogFolder();
    
    // Step 1c : Validate that Double-Clicking on existing note and saving doesn't modify the original note.
    Log.AppendFolder("Step 1c: Validate that double-clicking on existing note and saving doesn't modify the original note.");
    Log.Message("Double-Click on note 'note2' to open the edition window and select Save.");
    Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", txtNoteArray[1], 10).Click();
    Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", txtNoteArray[1], 10).DblClick();
    WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["NoteDetailWindow_2d5e", true]); 
    WaitObject(Get_CroesusApp(), "Uid", "TextBox_e970");
    aqObject.CheckProperty(Get_WinCRUANote_GrpNote_TxtNote(), "Text", cmpEqual, txtNoteArray[1]);
    Get_WinCRUANote_BtnSave().Click();     
    WaitObject(Get_CroesusApp(), "Uid", "NoteDataGrid_ddf6");    
    Log.Message("Validate that no error dialogs are displayed.");
    
    var errorDialogBoxDisplayed = Get_DlgError().Exists;
    
    if (errorDialogBoxDisplayed)
    {
      Log.Error("An error dialog was displayed. This is not expected (FA-5362).");
      Log.Message("Closing error dialog.");
      Get_DlgError().Click(Get_DlgError().get_ActualWidth()/2, Get_DlgError().get_ActualHeight()-45);
    }
    else
    {
      Log.Checkpoint("No error dialog was displayed as expected.");
    }
    
    Log.PopLogFolder();

    // Step 1d: Add another note and save. Select older note and validate that it cannot be deleted.
    Log.AppendFolder("Step 1d: Add another note and save. Select older note and validate that it cannot be deleted.");
    Get_WinInfo_Notes_TabGrid_BtnAdd().Click();       
    Get_WinCRUANote_GrpNote_TxtNote().Click()
    Get_WinCRUANote_GrpNote_TxtNote().set_Text(txtNoteTCVE4078 + currentNote);
    Get_WinCRUANote().Click();  
    Get_WinCRUANote_BtnSave().Click();          
    Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", dteOldNoteClt800272, 10).Click();
    Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", dteOldNoteClt800272, 10).Keys("[Del]");
    
    Log.Message("Validate that 'Sauvegarder' button is greyed out and that the older note cannot be deleted.");
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "IsEnabled", cmpEqual, false);
    Log.Message("Validate that older note still exists and hasn't been deleted.");      
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", dteOldNoteClt800272, 10), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", dteOldNoteClt800272, 10), "VisibleOnScreen", cmpEqual, true);

    Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", txtNoteTCVE4078 + currentNote, 10).Click();
    CheckNote(txtNoteTCVE4078 + currentNote); 
    txtNoteArray.push(txtNoteTCVE4078 + currentNote);       
    txtNoteArray.push(txtNoteEtape3TCVE4078);
    currentNote++;
    Get_WinDetailedInfo_BtnCancel().Click(); 
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071"); 
    Log.PopLogFolder();
    Log.PopLogFolder();
            
    errorCountAfterExecution = Log.ErrCount;
    var errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 1: (FA-5362) Validation que la création d'une nouvelle note pour un client ne suprime pas une note plus ancienne' completed successfully with " + errorsStep + " errors.", "", pmNormal, boldAttribute);
    }
    else
    {
      Log.Error("***** 'Étape 1: (FA-5362) Validation que la création d'une nouvelle note pour un client ne suprime pas une note plus ancienne' completed with " + errorsStep + " errors.", "", pmNormal, boldAttribute, Sys.Process("TestComplete"));
      errorCountAfterExecution = --errorCountAfterExecution;
    }
    
    errorCountBeforeExecution = errorCountAfterExecution;
     
    //********************************** Étape 2: FA-5565 Validation du nouveau message d'erreur générique. ************************************************************
    Log.AppendFolder("Étape 2: (FA-5565) Validation du nouveau message d'erreur générique dans le module Clients. Validation de l'absence du message d'avertissement.");
    Log.Link("https://jira.croesus.com/browse/FA-5565", "Cas de Jira: FA-5565");  
    //******************************************************************************************************************************************************************

    var cfFrameworkServerServiceName = "cfframeworkserver";
        
    Log.AppendFolder("Setup.");
    moduleName = "Clients";  
    Log.Message("Right-Click on client and add a note. Enter text for note but do not select the 'Sauvegarder' button.");
    ValidateErrorMessageWhenTryingToSaveNote(txtNoteTCVE4078 + currentNote, moduleName, cfFrameworkServerServiceName, errorMessage1TCVE4078, errorMessage2TCVE4078, warningMessageTCVE4078);             
    Log.PopLogFolder();
    Log.PopLogFolder();
    
    errorCountAfterExecution = Log.ErrCount;
    errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 2: (FA-5565) Validation du nouveau message d'erreur générique dans le module Clients. Validation de l'absence du message d'avertissement.' completed successfully with " + errorsStep + " errors.", "", pmNormal, boldAttribute);
    }
    else
    {
      Log.Error("***** 'Étape 2: (FA-5565) Validation du nouveau message d'erreur générique dans le module Clients. Validation de l'absence du message d'avertissement.' completed with " + errorsStep + " errors.", "", pmNormal, boldAttribute, Sys.Process("TestComplete"));
      errorCountAfterExecution = --errorCountAfterExecution;
    }     
    
    errorCountBeforeExecution = errorCountAfterExecution;

    //********************************** Étape 3: FA-5565 Validation du nouveau message d'erreur générique. ************************************************************
    Log.AppendFolder("Étape 3: (FA-5565) Validation du nouveau message d'erreur générique dans le module Comptes. Validation de l'absence du message d'avertissement.");
    Log.Link("https://jira.croesus.com/browse/FA-5565", "Cas de Jira: FA-5565");  
    //******************************************************************************************************************************************************************
        
    Log.AppendFolder("Setup.");
    Log.Message("Launch Creosus Desktop and navigate to Accounts module.");
    Login(vServerClients, userName, psw, language);
    moduleName = "Accounts";
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071")     
    Get_MainWindow().Maximize();  
    Log.Message("Right-Click on account and add a note. Enter text for note but do not select the 'Sauvegarder' button.");
    ValidateErrorMessageWhenTryingToSaveNote(txtNoteTCVE4078 + currentNote, moduleName, cfFrameworkServerServiceName, errorMessage1TCVE4078, errorMessage2TCVE4078, warningMessageTCVE4078);             
    Log.PopLogFolder();
    Log.PopLogFolder();
    
    errorCountAfterExecution = Log.ErrCount;
    errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 3: (FA-5565) Validation du nouveau message d'erreur générique dans le module Comptes. Validation de l'absence du message d'avertissement.' completed successfully with " + errorsStep + " errors.", "", pmNormal, boldAttribute);
    }
    else
    {
      Log.Error("***** 'Étape 3: (FA-5565) Validation du nouveau message d'erreur générique dans le module Comptes. Validation de l'absence du message d'avertissement.' completed with " + errorsStep + " errors.", "", pmNormal, boldAttribute, Sys.Process("TestComplete"));
      errorCountAfterExecution = --errorCountAfterExecution;
    }     
    
    errorCountBeforeExecution = errorCountAfterExecution;    
        
    //********************************** Étape 4: FA-6153 Validation du nouveau message d'erreur générique. **************************************************************
    Log.AppendFolder("Étape 4: (FA-6153) Validation du nouveau message d'erreur générique dans le module Relations. Validation de l'absence du message d'avertissement.");
    Log.Link("https://jira.croesus.com/browse/FA-6153", "Cas de Jira: FA-6153");  
    //********************************************************************************************************************************************************************                

    Log.AppendFolder("Setup.");
    Log.Message("Launch Creosus Desktop and navigate to Relationships module.");
    Login(vServerClients, userName, psw, language);
    moduleName = "Relationships";
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);  
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071")     
    Get_MainWindow().Maximize();

    Log.PopLogFolder();       
    Log.Message("Select Relationship and Right-Click to add a note. Enter text without selecting Save.");
    ValidateErrorMessageWhenTryingToSaveNote(txtNoteTCVE4078 + currentNote, moduleName, cfFrameworkServerServiceName, errorMessage1TCVE4078, errorMessage2TCVE4078, warningMessageTCVE4078); 
    Log.PopLogFolder();
    
    errorCountAfterExecution = Log.ErrCount;
    errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 4: (FA-6153) Validation du nouveau message d'erreur générique dans le module Relations. Validation de l'absence du message d'avertissement.' completed successfully with " + errorsStep + " errors.", "", pmNormal, boldAttribute);
    }
    else
    {
      Log.Error("***** 'Étape 4: (FA-6153) Validation du nouveau message d'erreur générique dans le module Relations. Validation de l'absence du message d'avertissement.' completed with " + errorsStep + " errors.", "", pmNormal, boldAttribute, Sys.Process("TestComplete"));
      errorCountAfterExecution = --errorCountAfterExecution;
    }  
  }
  
  catch(e) 
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
     
  finally
  {
    Log.PopLogFolder();
    Log.PopLogFolder();
    Log.AppendFolder("Restore default configuration.");
    Log.Message("Delete the created notes: " + txtNoteArray.join(", "));
    ResetData(txtNoteArray);       
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

function ResetData(noteArray)
{
  for(currentNote = 0; currentNote < noteArray.length; currentNote++)
  {
    Delete_Note(noteArray[currentNote], vServerClients);
  }
}

function AddNote(txtNote)
{
   Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
   WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["NoteDetailWindow_2d5e", true]); 
   WaitObject(Get_CroesusApp(), "Uid", "TextBox_e970");
   Get_WinCRUANote_GrpNote_TxtNote().Click();
   Get_WinCRUANote_GrpNote_TxtNote().set_Text(txtNote);
   Get_WinCRUANote().Click();
   Get_WinCRUANote_BtnSave().WaitProperty("IsEnabled", true, 30000);   
   Get_WinCRUANote_BtnSave().Click();     
   WaitObject(Get_CroesusApp(), "Uid", "NoteDataGrid_ddf6");    
}

function CheckNote(searchNote)
{
  Log.Message("Validate if '" + searchNote + "' exists in Note Grid.");
  var searchNoteObject = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", searchNote, 10);
  aqObject.CheckProperty(searchNoteObject, "Exists", cmpEqual, true);
  aqObject.CheckProperty(searchNoteObject, "VisibleOnScreen", cmpEqual, true);
  aqObject.CheckProperty(searchNoteObject.DataContext.DataItem, "Comment", cmpEqual, searchNote);
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(), "wText", cmpEqual, searchNote);
}

function ValidateErrorMessageWhenTryingToSaveNote(note, moduleName, cfFrameworkServerServiceName, errorMessage1TCVE4078, errorMessage2TCVE4078, warningMessageTCVE4078)
{
  Log.AppendFolder("Enter new note but do not save. Stop cfFrameworkServer service and return to Croesus Desktop to validate the messages returned.");
  Log.AppendFolder("Enter new note without saving.");
  Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsSelected(true);
  Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsActive(true);
  Get_RelationshipsClientsAccountsBar().ClickR();
  Get_RelationshipsClientsAccountsBar().ClickR();   
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
  WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["NoteDetailWindow_2d5e", true]); 
  WaitObject(Get_CroesusApp(), "Uid", "TextBox_e970");
  Get_WinCRUANote_GrpNote_TxtNote().Click();
  Get_WinCRUANote_GrpNote_TxtNote().set_Text(note);
  Get_WinCRUANote().Click();
  aqObject.CheckProperty(Get_WinCRUANote_GrpNote_TxtNote(), "Text", cmpEqual, note);
  
  Log.PopLogFolder();     
  Log.AppendFolder("Open vServer administrative console and stop cfFrameworkServer service.");
  
  if (StopService(vServerClients, cfFrameworkServerServiceName))
  {
    Log.Checkpoint("The service '" + cfFrameworkServerServiceName + "' was stopped.");
  }
  else
  {
    Log.Error("The service '" + cfFrameworkServerServiceName + "' was not stopped.");
  }
  
  Log.PopLogFolder();
  Get_WinCRUANote_BtnSave().Click();       
  Log.AppendFolder("Return to Croesus Desktop and validate received messages.");   
  Log.Message("Validate that 2 error messages are displayed and that no warning is displayed.");
   
  var warningDialogBoxDisplayed = Get_DlgWarning().Exists && Get_DlgWarning().Visible; // Valider bug: Existance d'une boite d'avertissement
  var errorDialogBox1Displayed = isErrorDialog1Displayed().Exists;                     // Valider la boite d'erreur qui est en dessous
  var errorDialogBox2Displayed = Get_DlgError().Exists && Get_DlgError().Visible;      // Valider la boite d'erreur qui est au dessus  
  
  // Scenario PASS: Warning = false, Error1 = true, Error2 = true
  if ((warningDialogBoxDisplayed == false) && (errorDialogBox1Displayed == true) && (errorDialogBox2Displayed == true))
  {
    Log.Checkpoint("The warning dialog box was not displayed as expected.");
    Log.Checkpoint("The error message located underneath was displayed as expected.");
    Log.Checkpoint("The error message located on top was displayed as expected.")
    aqObject.CheckProperty(getErrorDialog1(), "CommentTag", cmpEqual, errorMessage1TCVE4078);
    aqObject.CheckProperty(Get_DlgError_LblMessage1(), "Text", cmpEqual, errorMessage2TCVE4078);
    Get_DlgError_Btn_OK().Click();
    Get_DlgError().WaitProperty("Exists", false, 10000);    
  }
  // Scenario Warning: Module = Relationships, Warning = true, Error1 = false, Error2 = true
  else if ( ((moduleName == "Relationships") && (warningDialogBoxDisplayed == true)) && ((errorDialogBox1Displayed == false) && (errorDialogBox2Displayed == true)) )
  {
    Log.Warning("The warning dialog box '" + Get_DlgWarning_LblMessage1().Text + "' was displayed instead of the generic error message. This is not expected and pertains to FA-6153.");
    Log.Checkpoint("The error message located on top was displayed as expected.");
    aqObject.CheckProperty(Get_DlgError_LblMessage1(), "Text", cmpEqual, errorMessage2TCVE4078);
    Get_DlgError_Btn_OK().Click();
    Get_DlgError().WaitProperty("Exists", false, 10000);
  }
  // Remaining scenarios
  else
  { 
    if (warningDialogBoxDisplayed)
    {            
      Log.Error("The warning dialog box '" + Get_DlgWarning_LblMessage1().Text + "' was displayed instead of the generic error message. This is not expected and pertains to FA-5565.");
      aqObject.CheckProperty(Get_DlgWarning_LblMessage1(), "Text", cmpEqual, warningMessageTCVE4078);
    }
    else
    {
      Log.Checkpoint("The warning dialog box was not displayed as expected."); 
    }
       
    if (errorDialogBox1Displayed)
    {            
      Log.Checkpoint("The error message located underneath was displayed as expected.");
      aqObject.CheckProperty(getErrorDialog1(), "CommentTag", cmpEqual, errorMessage1TCVE4078);      
    }
    else
    {
      Log.Error("The error message supposed to be displayed underneath was not displayed. This is not expected.");
    }
        
    if (errorDialogBox2Displayed)
    {            
      Log.Checkpoint("The error message located on top was displayed as expected.");
      aqObject.CheckProperty(Get_DlgError_LblMessage1(), "Text", cmpEqual, errorMessage2TCVE4078);
      Get_DlgError_Btn_OK().Click();
      Get_DlgError().WaitProperty("Exists", false, 10000);
    }
    else
    {
      Log.Error("The error message supposed to be displayed on top was not displayed. This is not expected.");     
    }    
  }
          
  Log.Message("Open vServer administrative console and start cfFrameworkServer service.");
  
  if (StartService(vServerClients, cfFrameworkServerServiceName))
  {
    Log.Checkpoint("The service '" + cfFrameworkServerServiceName + "' is running.");
  }
  else
  {
    Log.Error("The service '" + cfFrameworkServerServiceName + "' is not running."); 
  }
  
  Log.PopLogFolder();
  Log.PopLogFolder();
}

function isErrorDialog1Displayed()
{
  var wndCaptionError = (language == 'french') ? "Erreur" : "Error";
  var processName = Sys.Process("CroesusClient");
  var windowObject = processName.FindChild(["wndCaption", "Enabled"], [wndCaptionError, false], 0);
  
  return (windowObject);
}

function getErrorDialog1()
{
  var wndCaption = (language == 'french') ? "Erreur" : "Error";

  return (Get_CroesusApp().WPFObject("HwndSource: BaseWindow", wndCaption, 2).WPFObject("BaseWindow", wndCaption, 1));
}

function ScrollUp(GridObject)
{
  var width = GridObject.get_ActualWidth();
  var height = GridObject.get_ActualHeight();
  
  GridObject.Click(width - 12, height - 64);
}

function ScrollDown(GridObject)
{
  var width = GridObject.get_ActualWidth();
  var height = GridObject.get_ActualHeight();
  
  GridObject.Click(width - 12, height - 22);
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
