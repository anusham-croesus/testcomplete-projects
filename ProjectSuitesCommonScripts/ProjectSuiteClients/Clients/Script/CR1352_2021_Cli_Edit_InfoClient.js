//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter

//
// Validation de l'edition des information de Client.
//
// Analyste d'assurance qualité: Karima Mehiguene
// Analyste d'automatisation: Youlia Raisper
//
// MAJ: Abdel Matmat (06/02/2020)
//      --> Modification suite à TCVE-524
//
// MAJ: Pierre Lefebvre (June 10, 2021)
//      --> Correction de l'erreur de logique (Get_WinDetailedInfo() ne devrait pas avoir ! devant) dans while (numberOftries < 5 && Get_WinDetailedInfo().Exists)
//      --> Déplacement du rétablissement des données originales pour le Client de la section Try vers la section Finally pour que l'information soit restaurée lors d'une exception
//      --> Correction de l'indentation du code Javascript
//      --> Amélioration des Logs
 
function CR1352_2021_Cli_Edit_InfoClient() 
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();    
    var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
    var editFullName = "CR1352_FullName";
    var editShortName = "CR1352_SHORTNAME";
    var editType = GetData(filePath_Clients, "CR1352", 233, language);
    var editLanguage = GetData(filePath_Clients, "CR1352", 234, language);   
    var editGender = GetData(filePath_Clients, "CR1352", 235, language);    
    var editDateOfBirth = GetData(filePath_Clients, "CR1352", 236, language); 
    var editCurrency = "USD";
    var editSin = "111111111";
    var editBn = "TEST_2021_BN";
    var editBnProvincial = "TEST_2021_BNPROV";
    var confirmationMessage = GetData(filePath_Clients, "CR1352", 237, language);    
    var clientNumber = (client == "US" || client == "TD" || client == "CIBC" ) ? "800214" : "900294";
     
    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2021", "Cas de tests JIRA CROES-2021");
    Log.AppendFolder("Preparation of test envionment on " + vServerClients + " for client " + client + " using username " + userName + ".");
    
    // Mettre la PREF_HIDE_SIN à la valeur YES
    Log.AppendFolder("Provision PREF_HIDE_SIN to YES.");
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_HIDE_SIN", "YES", vServerClients);
    RestartServices(vServerClients);   
    
    Log.PopLogFolder();
    Log.AppendFolder("Environment Setup.");
    
    Login(vServerClients, userName, psw, language);
    
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
    
    Log.PopLogFolder();
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerClients + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);        

    // 1- Valider que le champ NAS est masqué et grisé lorsque la pref "PREF_HIDE_SIN" est à YES (la valeur par défaut)
    Log.AppendFolder("ÉTAPE 1: Validation du champ NAS lorsque 'PREF_HIDE_SIN' est à YES.", "", pmNormal, boldAttribute);    
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
    Search_Client(clientNumber);    
    Get_ClientsBar_BtnInfo().Click();
    WaitObject(Get_CroesusApp(), "WindowMetricTag", "CLIENT_NOTEBOOK", 2000);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient().IsReadOnly;
    Log.PopLogFolder();
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient(), "IsReadOnly", cmpEqual, true);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient(), "Text", cmpEqual, "");

    // 2- Valider l'édition de l'information d'un Client
    Log.AppendFolder("ÉTAPE 2: Validation de l'édition de l'information d'un Client.", "", pmNormal, boldAttribute);            
    Terminate_CroesusProcess();
    Activate_Inactivate_Pref('COPERN', "PREF_EDIT_REAL_CLIENT", "YES", vServerClients);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_HIDE_SIN", "No", vServerClients); //Modification du script suite à TCVE-524
    RestartServices(vServerClients);
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    Search_Client(clientNumber);
    Get_ClientsBar_BtnInfo().Click();
    WaitObject(Get_CroesusApp(), "WindowMetricTag", "CLIENT_NOTEBOOK", 2000);
    
    // Récupérer les données du Client avant la modification pour pouvoir remettre l'information à l'état original 
    var originalFullName = Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Text;
    var originalShortName = Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().Text;     
    var originalType = Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForClient().Text;
    var originalLanguage = Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage().Text;
    var originalGender = Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClient().Text;
    var originalDateOfBirth = Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient().StringValue;
    var originalCurrency = Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency().Text;
    var originalSin = Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient().Text;
    var originalBn = Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClient().Text;   
    var originalBnProvincial = Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClient().Text;
         
    // Modifier les champs du Client
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(editFullName);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().Keys(editShortName);    
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForClient().set_Text(editType);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage().set_Text(editLanguage);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClient().set_Text(editGender);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient().set_StringValue(editDateOfBirth);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency().set_Text(editCurrency);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient().set_Text(editSin);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClient().set_Text(editBn);   
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClient().set_Text(editBnProvincial);            
    Get_WinDetailedInfo_BtnApply().Click();
        
    // Un message de confirmation est affiché. Si le message de confirmation est présent, simplement cliquer sur 'Oui'.
    // Dans TCVE-735, soit que le message sera soit modifié ou soit complètement enlevé. 
    SetAutoTimeOut(10000);
    
    if (Get_DlgConfirmation().Exists)
    {
      Log.Message("Un message de confirmation est affiché avec le message: " + Get_DlgConfirmation_LblMessage1());
      Log.Message("Dans TCVE-735, soit que le message sera soit modifié ou soit complètement enlevé.");
      aqObject.CheckProperty(Get_DlgConfirmation_LblMessage1(), "Text", cmpEqual, confirmationMessage);
      Get_DlgConfirmation_BtnYes1().Click();
    }
        
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 30000);  
    Get_WinDetailedInfo_BtnOK().Click();
    Delay(5000);
    
    var numberOfTries = 0;
      
    while (numberOfTries < 5 && Get_WinDetailedInfo().Exists)
    {
      Get_WinDetailedInfo_BtnOK().Click();
      numberOfTries++;
      Delay(1000);
    }
    
    RestoreAutoTimeOut();
                   
    Search_Client(clientNumber);             
    Get_ClientsBar_BtnInfo().Click();
    WaitObject(Get_CroesusApp(), "WindowMetricTag", "CLIENT_NOTEBOOK", 2000);
    Log.PopLogFolder();
                
    // Valider les changements   
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "Text", cmpEqual, editFullName);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName(), "Text", cmpEqual, editShortName);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForClient(),  "Text", cmpEqual,editType);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage(), "Text", cmpEqual, editLanguage);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClient(), "Text", cmpEqual, editGender);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient(), "StringValue", cmpEqual, editDateOfBirth);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency(), "Text", cmpEqual, editCurrency);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient(), "Text", cmpEqual, editSin);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClient(), "Text", cmpEqual, editBn);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClient(), "Text", cmpEqual, editBnProvincial);
  }  
    
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
   
  finally
  {
    Log.AppendFolder("Restauration of environment.");
    Log.AppendFolder("Remettre les données du Client à l'état original");
    
    if (Get_WinDetailedInfo().Exists == false)
    {
      Search_Client(clientNumber);             
      Get_ClientsBar_BtnInfo().Click();
      WaitObject(Get_CroesusApp(), "WindowMetricTag", "CLIENT_NOTEBOOK", 2000); 
    }

    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(originalFullName);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().Keys(originalShortName);    
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForClient().set_Text(originalType);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage().set_Text(originalLanguage);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClient().set_Text(originalGender);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient().set_StringValue(originalDateOfBirth);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency().set_Text(originalCurrency);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient().set_Text(originalSin);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClient().set_Text(originalBn);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClient().set_Text(originalBnProvincial); 
    Get_WinDetailedInfo_BtnApply().Click();    
   
    SetAutoTimeOut(10000);
    
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 30000);
    Get_WinDetailedInfo_BtnOK().Click();
    Delay(5000);
        
    var numberOfTries=0;
      
    while (numberOfTries < 5 && Get_WinDetailedInfo().Exists)
    {
      Get_WinDetailedInfo_BtnOK().Click();
      numberOfTries++;
      Delay(1000);
    }
        
    RestoreAutoTimeOut();
    Log.PopLogFolder();
    
    Log.AppendFolder("Terminate Croesus process");
    Terminate_CroesusProcess();
    Log.PopLogFolder();
    
    Log.AppendFolder("Remettre les préférences à leur valeure originale.");
    Activate_Inactivate_Pref('COPERN',"PREF_EDIT_REAL_CLIENT", "NO", vServerClients);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_HIDE_SIN", "NO", vServerClients);
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


