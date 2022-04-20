//USEUNIT Agenda_Get_functions
//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Age_Schedule
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par MenuBar_ToolsAgenda. 
 Vérifier la présence des contrôles et des étiquetés pour l’onglet "Overdue".*/

function Survol_Age_Overdue()
{
  Login(vServerAgenda, userName , psw ,language);  
  Get_MenuBar_Tools().OpenMenu();
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
  Get_MenuBar_Tools_Agenda().Click();
  
  Get_WinAgenda_ButtonBar_BtnOverdue().Click();
  WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda,"Survol_Age_Overdue",3,language), true]);
  //Delay(1000);
  
  //Les points de vérifications 
  Check_WinAgendaCommon_Properties(language)// // la fonction est dans Survol_Age_Schedule
  Check_Overdue_Properties(language);
      
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

function Check_Overdue_Properties(language)
{

    //Vérifier quel onglet est sélectionné  
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, false);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Overdue",3,language));
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_LblOverdueEvents(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",4,language));
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_CmbOverdueEvents(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_CmbOverdueEvents(), "IsEnabled", cmpEqual, true);
    
    //Les boutons
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnComplete().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",5,language));
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnComplete(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnComplete(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnReschedule().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",6,language));
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnReschedule(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnReschedule(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnCancel().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",7,language));
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnCancel(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDelete().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",8,language));
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDelete(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDelete(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsEnabled", cmpEqual, true);
  
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsEnabled", cmpEqual, true);
  
    //Afficher les entêtes de colonnes par défaut et Vérifier le texte 
    Get_WinAgenda_TabOverdue_ChDate().ClickR()
    Get_WinAgendaGridHeader_ContextualMenu_UseDefaultConfiguration().Click()
    
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",10,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChTime().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",11,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChDuration().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",12,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChType().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",13,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChClient().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",14,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChClientNo().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",15,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",16,language));
    
    
    //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
    //Get_WinAgenda_TabOverdue_ChDate().ClickR()
    //Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
    //aqObject.CheckProperty(Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("ContextMenu", "", 1), "ChildCount", cmpEqual, 10); //En réalité il a y en 6 seulement   
    
    //Afficher tous les entêtes de colonnes et Vérifier le texte 
    Add_AllColumns();
    Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Maximize();
    
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",10,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChUpdateDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",18,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChStatus().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",19,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChPriority().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",20,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChFrequency().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",21,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChCreationDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",22,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChCompletionDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",23,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChTime().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",11,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChDuration().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",12,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChType().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",13,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChClient().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",14,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChClientNo().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",15,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",16,language));
    
    Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Restore();
  
}

function Add_AllColumns()
{
    Get_WinAgenda_TabOverdue_ChDate().ClickR();
    Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
    for(i=1; i<=6; i++)
    {
      Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
      Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 100).Click(); 
      Get_WinAgenda_TabOverdue_ChDate().ClickR();
    }  
}

