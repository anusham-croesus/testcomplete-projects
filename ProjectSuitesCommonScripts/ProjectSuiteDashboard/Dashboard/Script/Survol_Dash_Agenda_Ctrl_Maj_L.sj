//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints

 
/* Description :Aller au module "Tableau de board" en cliquant sur BarModules-btnDashboard. 
 Afficher la fenêtre « Agenda » avec Ctl+Shift+L. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Tâches, Activités échues, Anniversaires, Alarmes, Traitements. Fermer la fenêtre en cliquant sur X */
function Survol_Dash_Agenda_Ctrl_Maj_L()
{
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  //Get_MainWindow().Keys("^L");  
  var numberOftries=0;  
  while ( numberOftries < 5 && !Get_WinAgenda().Exists){
    Get_MainWindow().Keys("^L");
    numberOftries++;
  } 
  
  Check_WinAgenda_Properties(language)
  
  Get_WinAgenda().Close();
  Get_MainWindow().SetFocus();
  Close_Croesus_AltQ();
}