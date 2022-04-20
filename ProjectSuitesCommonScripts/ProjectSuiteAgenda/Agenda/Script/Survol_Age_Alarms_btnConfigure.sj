//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Age_Schedule_btnConfigure
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par btnConfigure 
 A partir de  l’onglet "Alarms" afficher la fenêtre  "Work As" (btnConfigure). Vérifier le texte et la présence des contrôles*/

function Survol_Age_Alarms_btnConfigure()
{
  Login(vServerAgenda, userName, psw, language);
    
  //Afficher la fenêtre « Agenda »
  Get_MenuBar_Tools().OpenMenu();
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
  Get_MenuBar_Tools_Agenda().Click();
    
  Get_WinAgenda_ButtonBar_BtnAlarms().Click();
  WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda, "Survol_Age_Alarms", 3, language), true]);
    
  Get_WinAgenda_BtnConfigure().Click();
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["UserSelectionWindow_f6ea", true]);
    
  //Les points de vérifications 
  //Check_btnConfigure_Properties(language); // la fonction est dans le script Survol_Age_Schedule_btnConfigure
    
  //Fermeture de la fenêtre User Selection
  Get_WinUserSelection().Close();
  if (!WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "UserSelectionWindow_f6ea")){
      Log.Error("La fenêtre 'User Selection' n'était pas fermée.");
      Terminate_CroesusProcess();
      return;
  }
    
  //Fermeture de la fenêtre Agenda
  Get_WinAgenda_BtnCancel().Click();
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
      Get_MainWindow().SetFocus();
      Close_Croesus_SysMenu();
  }
  else {
      Log.Error("La fenêtre Agenda n'était pas fermée.");
      Terminate_CroesusProcess();
  }
}