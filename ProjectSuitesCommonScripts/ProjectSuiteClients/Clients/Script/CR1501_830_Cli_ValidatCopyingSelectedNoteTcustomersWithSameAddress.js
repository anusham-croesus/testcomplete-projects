//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

//
// Validation de la copie d'note d'un Client vers une racine du même Client.
// Activer la PREF_ADDRESS_GROUPING = 2 (pour activer le bouton Copier dans la fenêtre Info / Clients) (MG: s'applique pour une BD de BNC)
//   
//  1- Choisir le module Client.      
//  2- Sélectionner un Client principal ayant plusieurs personnes à la même adresse.
//  3- Cliquer sur le bouton 'Info'.
//  4- Ajouter une note au Client principal.
//  5- Sélectionner la note et cliquer sur le bouton 'Copier'.
//  6- Cliquer sur le bouton 'Copier'.
//  7- Fermer la fenêtre 'Info' du Client.
//  8- Ouvrir la fenêtre 'Info' du Client principal et sélectionner une racine secondaire.
//      
// MAJ: Pierre Lefebvre (June 10, 2021)
//      --> Utilisation de WPFControlText au lieu de Items.
//      --> Enlever les secondes de tous les timestamps.
//      --> Correction du formatage pour DateTimeToFormatStr(expectedDateHeureLessSecond, "%Y/%m/%d %H:%M")
//      --> Convertion en format string pour aqConvert.DateTimeToFormatStr(aqDateTime.AddSeconds(aqDateTime.Now(), -1), "%Y/%m/%d %H:%M")
//      --> Déplacement de la génération des timestamps dateCreationCROES830 et expectedDateHeureLessSecond APRÈS Get_WinCRUANote_GrpNote_BtnDateTime().Click() pour limiter le délai
//      --> Enlever les étapes duplicative dans Catch et Finally
//      --> Correction de l'indentation du code Javascript
//      --> Amélioration des Logs
//

function CR1501_830_Cli_ValidatCopyingSelectedNoteTcustomersWithSameAddress()
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();
    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
    var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800083", language + client);
    var rootClientNumber = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "nameRacine800083", language + client);
    var rootsIndicator = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "roots", language + client);
    var expectedNoteTextCROES830 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "PortTextAddNotTestCROES830", language + client);
    var expectedNotePredefinedSentenceCROES830 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language + client);
    var expectedNoteCreatedByCROES830 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "createdByNoteCROES830", language + client);

    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-830", "Cas de tests JIRA CROES-830");
    Log.AppendFolder("Preparation of test envionment on " + vServerClients + " for client " + client + " using username " + userNameKEYNEJ + ".");                           
         
    // Mettre la PREF_ADDRESS_GROUPING à la valeur 2
    Log.AppendFolder("Provision PREF_ADDRESS_GROUPING to 2.");
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ADDRESS_GROUPING", "2", vServerClients);
    RestartServices(vServerClients);

    Log.PopLogFolder();
    Log.AppendFolder("Environment Setup.");
         
    Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
         
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
    
    Log.PopLogFolder();
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerClients + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);    

    // 1- Creation of note for principal Client
    Log.AppendFolder("STEP 1: Creation of note for principal Client.");    
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
    Search_Client(clientNumber);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10).ClickR();
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
    WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74");
    Get_WinCRUANote_GrpNote_BtnDateTime().Click();
     
    var expectedCreationDateTimeCROES830 = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d %H:%M");
    var expectedCreationDateTimeLessOneSecondCROES830 = aqConvert.DateTimeToFormatStr(aqDateTime.AddSeconds(aqDateTime.Now(), -1), "%Y/%m/%d %H:%M");
    Log.Message("The creation date/time of the note is: " + expectedCreationDateTimeCROES830);
    Log.Message("The creation date/time of the note minus 1 second is: " + expectedCreationDateTimeLessOneSecondCROES830);
                       
    Get_WinCRUANote_GrpNote_TxtNote().Click();
    Get_WinCRUANote_GrpNote_TxtNote().Keys(expectedNoteTextCROES830);
    Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", expectedNotePredefinedSentenceCROES830, 10).Click();
    Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
    WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74");
    
    var actualNoteTextAddedCROES830 = Get_WinCRUANote_GrpNote_TxtNote().Text;
    Log.Message("The note that was added has the text: " + actualNoteTextAddedCROES830);
    Get_WinCRUANote_TxtCreationDateForPositionAndSecurity();
    Get_WinCRUANote_BtnSave().Click();
    Log.PopLogFolder();

    // 2- Copy note from principal Client to secondary root 
    Log.AppendFolder("STEP 2: Copying of note from principal Client to secondary root.");     
    Search_Client(clientNumber);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10).DblClick();
    Get_WinInfo_Notes_TabGrid().Click();
    Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(actualNoteTextAddedCROES830), 10).Click();
    Get_WinDetailedInfo_TabInfo_GrpNotes_TabGrid_BtnCopy().Click();
    Get_DlgConfirmation_BtnCopy().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["Button", "PART_Yes"]);
    Get_WinDetailedInfo_BtnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"]);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", rootsIndicator, 10).Find("OriginalValue", rootClientNumber, 10).Click();
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", rootsIndicator, 10).Find("OriginalValue", rootClientNumber, 10).DblClick();
    Log.PopLogFolder();

    // 3- Validation of copied note from principal Client to secondary root 
    Log.AppendFolder("STEP 3: Validation of copied note from principal Client to secondary root.");    
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(), "wText", cmpEqual, actualNoteTextAddedCROES830);
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(), "wText", cmpContains, expectedNoteTextCROES830);
    
    var actualNoteTextObjectCROES830 = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(actualNoteTextAddedCROES830), 10);
    
    if (actualNoteTextObjectCROES830.Exists)
    {
      var actualNoteIndexCROES830 = actualNoteTextObjectCROES830.Record.index;
      var actualNoteEffectiveDateCROES830 = Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(actualNoteIndexCROES830).DataItem.EffectiveDate;
      var actualNoteCreationDateTimeCROES830 = Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", actualNoteIndexCROES830 + 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 2).WPFControlText;
      var actualNoteCreatedByCROES830 = VarToString(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(actualNoteIndexCROES830).DataItem.FullName.OleValue);
      var actualNoteTextCROES830=VarToString(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(actualNoteIndexCROES830).DataItem.Comment.OleValue);
      
      actualNoteCreationDateTimeCROES830 = aqString.Remove(actualNoteCreationDateTimeCROES830, actualNoteCreationDateTimeCROES830.length - 3, 3);              
      
      if (actualNoteCreationDateTimeCROES830 != expectedCreationDateTimeCROES830)  
      {
        Log.Message("Note actual and expected Date/Time are not equal. Comparing actual Date/Time with expected Date/Time minus 1 second.");
        expectedCreationDateTimeCROES830 = DateTimeToFormatStr(expectedCreationDateTimeLessOneSecondCROES830, "%Y/%m/%d %H:%M");
      }
                         
      CheckEquals(actualNoteEffectiveDateCROES830, null, "Reference date"); 
      CheckEquals(actualNoteCreationDateTimeCROES830, expectedCreationDateTimeCROES830, "Creation date");
      CheckEquals(actualNoteCreatedByCROES830, expectedNoteCreatedByCROES830, "Created by");
      CheckEquals(actualNoteTextCROES830, actualNoteTextAddedCROES830, "Note text");
      Log.Checkpoint("The note was successfully copied from the principal Client to the secondary root.");
    }
    else
    {
      Log.Error("The note was not successfully copied from the principal Client to the secondary root.");
    }
    
    Get_WinDetailedInfo_BtnCancel().Click();
    Log.PopLogFolder();          
  }   
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  
  finally
  {
    Log.AppendFolder("Restauration of environment.");
    Terminate_CroesusProcess();
    Delete_Note(expectedNoteTextCROES830, vServerClients);
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

  Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").SetFocus();
  Get_MenuBar().FindChild("Uid", "CustomizableMenu_3049", 10).Click();  
  Get_SubMenus().FindChild("Uid", "CFMenuItem_cf20", 10).Click();
  croesusBuildVersion = Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").WPFObject("AboutWin").FindChild(propertiesArray, valuesArray, 10).WPFControlText;
  Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").Click();

  return (croesusBuildVersion);  
}