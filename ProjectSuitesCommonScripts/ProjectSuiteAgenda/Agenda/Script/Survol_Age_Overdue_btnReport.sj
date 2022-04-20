//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Age_Schedule_btnReport
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par btnConfigure 
 A partir de  l’onglet "Overdue" afficher la fenêtre  "Report". Vérifier le texte et la présence des contrôles*/

function Survol_Age_Overdue_btnReport()
{
  Login(vServerAgenda, userName , psw ,language);
  
  //afficher la fenêtre « Agenda »
  Get_MenuBar_Tools().OpenMenu();
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
  Get_MenuBar_Tools_Agenda().Click();
  
  Get_WinAgenda_ButtonBar_BtnOverdue().Click(); 
  WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda,"Survol_Age_Overdue",3,language), true]);
  Get_WinAgenda_BtnReport().Click();
  WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [ GetData(filePath_Agenda,"Survol_Age_btnReport",2,language), true]);
  //Les points de vérifications 
  Check_btnReports_Properties(language); // la fonction est dans le script Survol_Age_Schedule_btnReport
      
  Get_WinReports_BtnClose().Keys("[Esc]");
  Get_WinAgenda().Close();
   if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda,"Survol_Age_Schedule",2,language)])){
       Get_MainWindow().SetFocus();
       Close_Croesus_X();
   }
   else {
       Log.Error("La fenêtre Agenda n'était pas fermée.");
       Terminate_CroesusProcess();
   }
  
}