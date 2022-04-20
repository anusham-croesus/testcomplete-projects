//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Age_Schedule_btnReport
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par btnConfigure 
 A partir de  l’onglet "Overdue" afficher la fenêtre  "Rescheduled" en cliquant sur le bouton btnReschedule. Vérifier le texte et la présence des contrôles*/

function Survol_Age_Overdue_btnRescheduled()
{
  Login(vServerAgenda, userName , psw ,language);
  
  //afficher la fenêtre « Agenda »
  Get_MenuBar_Tools().OpenMenu();
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
  Get_MenuBar_Tools_Agenda().Click();
  
  Get_WinAgenda_ButtonBar_BtnOverdue().Click(); 
  WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda, "Survol_Age_Schedule", 9, language), true]);
//  Delay(1000);
  Get_WinAgenda_PadHeaderBar_BtnReschedule().Click()
  WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [ GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",2,language), true]);
//  Delay(150);
  //Les points de vérifications 
  Check_Overdue_BtnReschedule_Properties(language); 
  
  Get_WinRescheduled_BtnCancel().Click();      
 // Get_WinAgenda_BtnCancel().Click();
//  Delay(150);


Get_WinAgenda_BtnCancel().Click();
    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
        Get_MainWindow().SetFocus();
         Close_Croesus_X();
    }
    else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
    }


  
//  Get_MainWindow().SetFocus()
//  Close_Croesus_X();
}

function Check_Overdue_BtnReschedule_Properties(language)
{
  aqObject.CheckProperty(Get_WinRescheduled(), "Title", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",2,language));
  
  aqObject.CheckProperty(Get_WinRescheduled_BtnOK().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",3,language));
  aqObject.CheckProperty(Get_WinRescheduled_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRescheduled_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinRescheduled_BtnCancel().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",4,language));
  aqObject.CheckProperty(Get_WinRescheduled_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRescheduled_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinRescheduled_LblOldDate(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",6,language));
  aqObject.CheckProperty(Get_WinRescheduled_TxtOldDate(), "IsVIsible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRescheduled_TxtOldDate(), "IsReadOnly", cmpEqual, true);
  
//  if (client == "BNC"){//Les modifications dues aux changements dans la BD 
//    aqObject.CheckProperty(Get_WinRescheduled_LblOldTime(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",7,language));
//    aqObject.CheckProperty(Get_WinRescheduled_TxtOldTime(), "IsVIsible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinRescheduled_TxtOldTime(), "IsReadOnly", cmpEqual, true);
//  }
  
  aqObject.CheckProperty(Get_WinRescheduled_LblNewDate(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",8,language));
  aqObject.CheckProperty(Get_WinRescheduled_DtpNewDate(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRescheduled_DtpNewDate(), "IsReadOnly", cmpEqual, false);
  
//  if (client == "BNC" ){//Les modifications dues aux changements dans la BD 
//    aqObject.CheckProperty(Get_WinRescheduled_LblNewTime(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",9,language));
//    aqObject.CheckProperty(Get_WinRescheduled_CmbNewTime(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinRescheduled_CmbNewTime(), "IsReadOnly", cmpEqual, false);
//  }
}