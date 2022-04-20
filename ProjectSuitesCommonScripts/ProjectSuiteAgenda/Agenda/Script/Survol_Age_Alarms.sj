//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Age_Schedule
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par MenuBar_ToolsAgenda. 
 Vérifier la présence des contrôles et des étiquetés pour l’onglet "Alarms". */

function Survol_Age_Alarms()
{
    Login(vServerAgenda, userName, psw, language);  
    
    Get_MenuBar_Tools().OpenMenu();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
    Get_MenuBar_Tools_Agenda().Click();
    
    Get_WinAgenda_ButtonBar_BtnAlarms().Click();
    WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda, "Survol_Age_Alarms", 3, language), true]);
    
    //Les points de vérifications
    Check_WinAgendaCommon_Properties(language);// la fonction est dans le script Survol_Age_Schedule
    Check_Alarms_Properties(language);
    
    //Fermeture de la fenêtre Agenda
    Get_WinAgenda_BtnCancel().Click();
    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();
    }
    else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
    }
}

function Check_Alarms_Properties(language)
{
  //Vérifier quel onglet est sélectionné  
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, false);
    
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Alarms",3,language));
    
  //Les boutons 
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnMark().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",4,language));
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnMark(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnMark(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsEnabled", cmpEqual, true);
    
  //Afficher les entêtes de colonnes par défaut et Vérifier le texte 
  Get_WinAgenda_TabAlarms_ChName().ClickR()
  Get_WinAgendaGridHeader_ContextualMenu_UseDefaultConfiguration().Click()
    
  aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChName().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",6,language));
  aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChUpdate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",7,language));
  aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",8,language));
    
  //Afficher tous les entêtes de colonnes et Vérifier le texte     
  Add_AllColumns();
  Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Maximize(); //Agrandir la fenêtre pour ne pas scroller 
    
  aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChName().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",6,language));
  aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChTime().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",10,language));
  if( client == "US" ){
    Log.Message("USDEV-341");
  } 
  aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChIACode().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",11,language));
  aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChExpirationDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",12,language));
  aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChAccountNo().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",13,language));
  aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChUpdate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",7,language));
  aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",8,language));
    
  Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Restore();
}

function Add_AllColumns()
{
  Get_WinAgenda_TabAlarms_ChName().ClickR();
  Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
  var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount
  //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
  aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 4); 
  for(i=1; i<=count; i++) {
    Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
    Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 100).Click(); 
    Get_WinAgenda_TabAlarms_ChName().ClickR();
  }
}

