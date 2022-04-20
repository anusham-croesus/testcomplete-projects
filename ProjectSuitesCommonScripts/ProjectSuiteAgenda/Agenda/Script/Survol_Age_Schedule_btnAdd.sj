//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par btnConfigure 
 A partir de  l’onglet "Horaire" afficher la fenêtre  "Information" (btnAdd). Vérifier le texte et la présence des contrôles*/

function Survol_Age_Schedule_btnAdd()
{
  Login(vServerAgenda, userName , psw ,language);
  
  //afficher la fenêtre « Agenda »
  Get_MenuBar_Tools().OpenMenu();
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
  Get_MenuBar_Tools_Agenda().Click();
  
  Get_WinAgenda_ButtonBar_BtnSchedule().Click();  
//  Delay(150);
WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda, "Survol_Age_Schedule",7, language), true]);
    
Get_WinAgenda_TabSchedule_GrpInformation_BtnAdd().Click();


WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [GetData(filePath_Agenda, "Survol_Age_Schedule",30, language), true]);
//  Delay(150);
  //Les points de vérifications 
  Check_Schedule_btnAdd_Properties(language);
   
  // Fermeture de la fenêtre Information (Laquelle on ouvre en cliquant sur le bouton Add) 
  Get_WinAddEditAnEvent_BtnCancelForSchedule().Click();
  
  // Fermeture de la fenêtre Agenda
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

function Check_Schedule_btnAdd_Properties(language)
{
   aqObject.CheckProperty(Get_WinAddEditAnEvent(), "Title", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",2,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnOKForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",3,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnOKForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnOKForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnCancelForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",4,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnCancelForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnCancelForSchedule(), "IsEnabled", cmpEqual, true);
     
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule(), "Header", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",6,language));
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblTypeForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",7,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDateForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",8,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblPriorityForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",9,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbPriorityForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbPriorityForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblClientForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",10,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtClientForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtClientForSchedule(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnClientForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnClientForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDescriptionForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",11,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtDescriptionForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtDescriptionForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblStatusForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",12,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbStatusForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbStatusForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblTimeForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",13,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTimeForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTimeForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblReminderForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",14,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbReminderForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbReminderForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblAccountNoForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",15,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAccountNoForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAccountNoForSchedule(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAccountNoForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAccountNoForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblFrequencyForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",16,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbFrequencyForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbFrequencyForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDurationForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",17,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbDurationForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbDurationForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblLastUpdateForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",18,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtLastUpdateForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtLastUpdateForSchedule(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblAssigneeForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",19,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAssigneeForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAssigneeForSchedule(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAssigneeForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAssigneeForSchedule(), "IsEnabled", cmpEqual, true);
   
}