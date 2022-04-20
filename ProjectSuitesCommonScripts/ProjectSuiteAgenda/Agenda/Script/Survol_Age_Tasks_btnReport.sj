//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Age_Schedule_btnReport
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par btnConfigure 
 A partir de  l’onglet "Tasks" afficher la fenêtre  "Report". Vérifier le texte et la présence des contrôles*/

function Survol_Age_Tasks_btnReport()
{
  var tasks =GetData(filePath_Agenda,"Survol_Age_Tasks",3,language);
  var winTitle=GetData(filePath_Agenda,"Survol_Age_Schedule",2,language);
  var rapport=GetData(filePath_Agenda,"Survol_Age_btnReport",2,language);
  
  Login(vServerAgenda, userName , psw ,language);
  
  //afficher la fenêtre « Agenda »
  Get_MenuBar_Tools().OpenMenu();
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
  Get_MenuBar_Tools_Agenda().Click();
  
  Get_WinAgenda_ButtonBar_BtnTasks().Click(); 
  WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", tasks, true]); 
  Get_WinAgenda_BtnReport().Click();
  WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [rapport , true]);
  
  //Les points de vérifications 
  Check_btnReports_Properties(language); // la fonction est dans le script Survol_Age_Schedule_btnReport
      
   Get_WinReports().Close();
   Get_WinAgenda_BtnCancel().Click();
  
  //Fermeture de la fenêtre Agenda
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", winTitle])){
     Close_Croesus_X();
  }
  else {
     Log.Error("La fenêtre Agenda n'était pas fermée.");
     Terminate_CroesusProcess();
  }  
}