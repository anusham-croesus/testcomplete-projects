﻿//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Agenda_Get_functions
//USEUNIT CommonCheckpoints

 /* Description : A partir du module « Clients » , afficher la fenêtre « Agenda » en cliquant sur MenuBar -Tools- btnAgenda. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements */

 function Survol_Cli_MenuBar_ToolsAgenda()
{
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click()
  
  Get_MenuBar_Tools().OpenMenu()
  Get_MenuBar_Tools_Agenda().Click()
  
  //Les points de vérification
  Check_WinAgenda_Properties(language);
   
  //Fermeture de la fenêtre Agenda
  Get_WinAgenda_BtnCancel().Click();
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
      Get_MainWindow().SetFocus();
      Close_Croesus_AltF4();
  }
  else {
      Log.Error("La fenêtre Agenda n'était pas fermée.");
      Terminate_CroesusProcess();
  }
}
