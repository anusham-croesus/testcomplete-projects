//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Age_Schedule
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par MenuBar_ToolsAgenda. 
 Vérifier la présence des contrôles et des étiquetés pour l’onglet "Files Processing". */

function Survol_Age_FilesProcessing()
{
  Login(vServerAgenda, userName , psw ,language);  
  Get_MenuBar_Tools().OpenMenu();
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
  Get_MenuBar_Tools_Agenda().Click();
  
  Get_WinAgenda_ButtonBar_BtnFilesProcessing().Click();
  WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda,"Survol_Age_FilesProcessing",3,language), true]);
  //Delay(1000);
  
  //Les points de vérifications 
  Check_WinAgendaCommon_Properties(language)// // la fonction est dans Survol_Age_Schedule
  Check_FilesProcessing_Properties(language);

  Get_WinAgenda_BtnCancel().Click();
   if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda,"Survol_Age_Schedule",2,language)])){
       Get_MainWindow().SetFocus();
       Close_Croesus_MenuBar();
   }
   else {
       Log.Error("La fenêtre Agenda n'était pas fermée.");
       Terminate_CroesusProcess();
   }
}

function Check_FilesProcessing_Properties(language)
{

    //Vérifier quel onglet est sélectionné  
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_FilesProcessing",3,language));
    
     //Les boutons  
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsEnabled", cmpEqual, true);
  
    //Afficher les entêtes de colonnes par défaut et Vérifier le texte 
    Get_WinAgenda_TabFilesProcessing_ChUpdate().ClickR()
    Get_WinAgendaGridHeader_ContextualMenu_UseDefaultConfiguration().Click()
    
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChUpdate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",5,language));
    if(client == "US" ){
    Log.Message("USDEV-341")}
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChIACode().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",6,language));
    Log.Message("Karima a dit que c'est une ancienne anomalie, on la laisse comme ca en attendant une réponse de l'équipe produit/Dev");
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",7,language));
    
    //Afficher tous les entêtes de colonnes et Vérifier le texte       
    Add_AllColumns();
    Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Maximize();//Agrandir la fenêtre pour ne pas scroller 
    
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChUpdate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",5,language));
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChUserNum().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",9,language));
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChTime().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",10,language));
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChName().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",11,language));
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChExpirationDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",12,language));
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChAccountNo().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",13,language));
    if( client== "US"){
    Log.Message("Pour le code de CP d'aprés Sofia c'est une anomalie en cours d'analyse");}
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChIACode().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",6,language));
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",7,language));
    
    Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Restore();
  
}

function Add_AllColumns()
{
    Get_WinAgenda_TabFilesProcessing_ChUpdate().ClickR();
    Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
    var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount
    //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 6); 
    for(i=1; i<=count; i++)
    {
      Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
      Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 100).Click(); 
      Get_WinAgenda_TabFilesProcessing_ChUpdate().ClickR();
    }  
}

