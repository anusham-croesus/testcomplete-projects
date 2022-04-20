//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

//
// Précondition: Se connecter avec 'COPERN'.
//   
// 1- Choisir le module compte --> Le module compte s'ouvre correctement.
// 2- Sélectionner un compte --> Le compte est bien sélectionné.
// 3- Cliquer sur le bouton 'Info' et ensuite sur le bouton 'Ajouter' --> La fenêtre 'Ajouter une note' s'ouvre correctement.
// 4- Cliquer sur le bouton 'Date & Heure' --> L'heure et la date sont insérées sur la portion gauche de la fenêtre 'Ajouter une note'.
// 5- Ajouter une phrase prédéfinie ensuite cliquer sur le bouton 'Sauvegarder' --> La phrase prédéfinie est ajoutée et la fenêtre 'Ajouter une note' est fermée.
// 6- Cliquer sur le bouton 'Info' et ensuite ouvrir la note crée au préalable --> La fenêtre 'Info' s'ouvre avec la date et l'heure ainsi que la phrase prédéfinie.
//        
// Auteur: Sana Ayaz
// Anomalie: CROES-923    
// Version de scriptage:	ef90-09-9--V9-croesus-co7x-1_4_546
//

function CR1501_923_ValidationOfTheOperationOfTheButtonDateAndTimeWhenEnteringANoteWithInfo()
{      
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();
    var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
    var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
    var accountNumber = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "numberAccount800283RE", language+client);
    var textNote = " " + ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "PortTextAddNotTestCROES838", language+client) + ". ";
    var textPredefined = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "textphrasePredefiniCROES842", language+client);
    
    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-923", "Cas de tests JIRA CROES-923");
    Log.AppendFolder("Preparation of test envionment on " + vServerAccounts + " for client " + client + " using username " + userName + ".");    
                
    Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);

    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
  
    Log.AppendFolder("Environment Setup.");       
    Get_ModulesBar_BtnAccounts().Click();
    SearchAccount(accountNumber);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNumber, 10).Click();
    Get_AccountsBar_BtnInfo().Click();
    Get_WinInfo_Notes_TabGrid().Click();
    Get_WinInfo_Notes_TabGrid_BtnAdd().Click()
         
    // Add note to account 800283-RE
    WaitObject(Get_WinCRUANote(), "UID", "NoteSentenceDataGrid_ae74")
    Get_WinCRUANote_GrpNote_BtnDateTime().Click();

    var expectedDateTime = aqString.Concat("[", aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d %H:%M:"));    
    aqObject.CheckProperty(Get_WinCRUANote_GrpNote_TxtNote(), "wText", cmpStartsWith, expectedDateTime);
          
    Get_WinCRUANote_GrpNote_TxtNote().Click()
    Get_WinCRUANote_GrpNote_TxtNote().Keys(textNote);        
    Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textPredefined, 10).Click();
    Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
    WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
    var actualTextNote = Get_WinCRUANote_GrpNote_TxtNote().wText;
    Log.Message("The text added to the note was: " + actualTextNote);
    Get_WinCRUANote_BtnSave().Click();
    Get_WinDetailedInfo_BtnOK().Click();  
        
    Get_ModulesBar_BtnAccounts().Click();
    SearchAccount(accountNumber);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNumber, 10).Click();
    Get_AccountsBar_BtnInfo().Click();
    Get_WinInfo_Notes_TabGrid().Click();
    
    Log.PopLogFolder();
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerAccounts + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);                
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(), "wText", cmpStartsWith, expectedDateTime);
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(), "wText", cmpContains, textNote);
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(), "wText", cmpEndsWith, textPredefined);
        
    var actualNoteObject = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", actualTextNote, 10)
  
    if (actualNoteObject.Exists)
    {
      var index = actualNoteObject.Record.index;
      var actualNote = VarToString(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.Comment.OleValue);
      var comparisonResult = aqString.Find(actualNote, expectedDateTime);
                            
      if (comparisonResult != -1)
      {
        Log.Message("Substring '" + expectedDateTime + "' was found in string '" + actualNote + "' at position " + comparisonResult);
      }
      else
      {
        Log.Error("There are no occurrences of '" + expectedDateTime + "' in '" + actualNote + "'");
      }          
    }
    else 
    {
      Log.Error("The note that was previously added cannot be found.");
    }     
  }
    
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));       
  }
    
  finally
  {
    Log.AppendFolder("Restore environment to default configuration.");
    Terminate_CroesusProcess();
    Delete_Note(textNote, vServerAccounts);

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
