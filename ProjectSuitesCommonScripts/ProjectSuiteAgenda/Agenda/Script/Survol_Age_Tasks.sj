//USEUNIT Agenda_Get_functions
//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Age_Schedule
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par MenuBar_ToolsAgenda. 
 Vérifier la présence des contrôles et des étiquetés pour l’onglet "Tasks".*/

function Survol_Age_Tasks()
{
    var tasks = GetData(filePath_Agenda, "Survol_Age_Tasks", 3, language);
    var winTitle = GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language);
  
    Login(vServerAgenda, userName, psw, language);
    Get_MenuBar_Tools().OpenMenu();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
    Get_MenuBar_Tools_Agenda().Click();
  
    Get_WinAgenda_ButtonBar_BtnTasks().Click();
    WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", tasks, true]);
  
    Check_WinAgendaCommon_Properties(language)// // la fonction est dans Survol_Age_Schedule
    Check_Tasks_Properties(language);
  
    //Fermeture de la fenêtre Agenda
    var nbTries = 0;
    do {
        Get_WinAgenda_BtnCancel().Click();
    } while((++nbTries) < 3 && !(WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", winTitle], 60000)))

    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", winTitle]))
        Close_Croesus_AltQ();
    else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
    }
}


function Check_Tasks_Properties(language)
{
  //Vérifier quel onglet est sélectionné  
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",3,language));
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_LblSearchDescription(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",4,language));
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_TxtSearchDescriptionForTasksTab(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_TxtSearchDescriptionForTasksTab(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrevious(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrevious(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnNext(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnNext(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDetailedInfo(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDetailedInfo(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpCalendar(), "Header", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",6,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpCalendar_MonthCalendar(), "IsVisible", cmpEqual, true);
  
  //Les entête des colonnes      
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_ChType(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",7,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_ChClient(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",8,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_ChDescription(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",9,language));
  
  //Information
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation(), "Header", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",12,language)); 
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblType(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",13,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtType(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtType(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblDate(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",14,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtDate(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtDate(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblPriority(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",15,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtPriority(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtPriority(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblClient(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",16,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtClient(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtClient(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblDescription(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",17,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtDescription(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtDescription(), "IsVisible", cmpEqual, true);

  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblStatus(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",18,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtStatus(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtStatus(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblDuration(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",19,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtDuration(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtDuration(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblLastUpdate(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",20,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtLastUpdate(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtLastUpdate(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblAccountNo(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",21,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtAccountNo(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtAccountNo(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblFrequency(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",22,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtFrequency(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtFrequency(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblAssignee(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",23,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtAssignee(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtAssignee(), "IsVisible", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnAdd(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",25,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnAdd(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnAdd(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnEdit(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",26,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnEdit(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnEdit(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnDelete(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",27,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnDelete(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnDelete(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnCompleted(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",28,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnCompleted(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnCompleted(), "IsEnabled", cmpEqual, false);
}

