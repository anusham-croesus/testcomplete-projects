//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » avec Ctl+Shift+L. 
 Vérifier la présence des contrôles et des étiquetés pour l’onglet "Horaire". */

function Survol_Age_Schedule()// Il y a une anomalie, pour pouvoir ouvrir la fenêtre d’agenda par touche de clavier, il faut cliquer sur le module tableau de bord encore une fois 
{
  Login(vServerAgenda, userName , psw ,language);
//  delay(2000);

  
  //afficher la fenêtre « Agenda »
  Get_MainWindow().Keys("^L");
  WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language), true]);
  
  Check_WinAgendaCommon_Properties(language)
  
//  Delay(1000);

    
  Check_Schedule_Properties(language);
  
//  Delay(150);
  Get_WinAgenda_BtnCancel().Click();
    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
        Get_MainWindow().SetFocus();
         Close_Croesus_AltQ()
    }
    else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
    }
  
//  Delay(150);
  
//  Get_MainWindow().SetFocus()
//  Close_Croesus_AltQ()
}

function Check_WinAgendaCommon_Properties(language) //La partie commune pour tous les onglets dans la fenêtre Agenda  
{
  aqObject.CheckProperty(Get_WinAgenda().Title, "OleValue", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",2,language));
  
  //les btns de la fenêtre       
  aqObject.CheckProperty(Get_WinAgenda_BtnOk().Content, "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",3,language));
  aqObject.CheckProperty(Get_WinAgenda_BtnOk(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_BtnOk(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_BtnCancel().Content, "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",4,language));
  aqObject.CheckProperty(Get_WinAgenda_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_BtnApply().Content, "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",5,language));
  aqObject.CheckProperty(Get_WinAgenda_BtnApply(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_BtnApply(), "IsEnabled", cmpEqual, true);
  
  //Vérifier le texte de chaque onglet   
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",7,language));  
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",8,language)); 
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",9,language)); 
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",10,language)); 
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",11,language)); 
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",12,language));
  
  
  aqObject.CheckProperty(Get_WinAgenda_LblUser(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",14,language));
  aqObject.CheckProperty(Get_WinAgenda_CmbUser(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_CmbUser(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_BtnConfigure_LblConfigure(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",15,language));
  aqObject.CheckProperty(Get_WinAgenda_BtnConfigure(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_BtnConfigure(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_BtnReport_LblReport(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",16,language));
  aqObject.CheckProperty(Get_WinAgenda_BtnReport(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_BtnReport(), "IsEnabled", cmpEqual, true);
  
  //D'après les commentaires de Mamoudou lafonctionnalité de Synchro Outlook a été décomissionnée, voir FA-872 , c`est la raison de la disparition du bouton Synchroniser.
  /*if (client == "BNC" ){
    aqObject.CheckProperty(Get_WinAgenda_BtnSynchronize_LblSynchronize(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",17,language));
    aqObject.CheckProperty(Get_WinAgenda_BtnSynchronize(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_BtnSynchronize(), "IsEnabled", cmpEqual, true);
  }*/
}
  
function Check_Schedule_Properties(language)
{
  //Vérifier quel onglet est sélectionné  
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",19,language));
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_LblSearchDescription(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",20,language));
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_TxtSearchDescriptionForScheduleTab(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_TxtSearchDescriptionForScheduleTab(), "IsVisible", cmpEqual, true);
  
  //les boutons 
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
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpCalendar(), "Header", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",22,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpCalendar_MonthCalendar(), "IsVisible", cmpEqual, true);
  
  //Les entête des colonnes      
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_ChTime(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",23,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_ChDuration(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",24,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_ChType(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",25,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_ChClient(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",26,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_ChDescription(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",27,language));
  
  //Le regroupement  Information
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation(), "Header", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",30,language)); 
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblType(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",31,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtType(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtType(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblDate(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",32,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtDate(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtDate(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblPriority(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",33,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtPriority(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtPriority(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblClient(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",34,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtClient(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtClient(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblDescription(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",35,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtDescription(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtDescription(), "IsVisible", cmpEqual, true);

  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblStatus(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",36,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtStatus(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtStatus(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblTime(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",37,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtTime(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtTime(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblReminder(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",38,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtReminder(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtReminder(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblAccountNo(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",39,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtAccountNo(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtAccountNo(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblFrequency(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",40,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtFrequency(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtFrequency(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblDuration(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",41,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtDuration(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtDuration(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblLastUpdate(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",42,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtLastUpdate(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtLastUpdate(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblAssignee(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",43,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtAssignee(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtAssignee(), "IsVisible", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnAdd(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",45,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnAdd(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnAdd(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnEdit(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",46,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnEdit(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnEdit(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnDelete(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",47,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnDelete(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnDelete(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnCompleted(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",48,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnCompleted(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnCompleted(), "IsEnabled", cmpEqual, false);
}
