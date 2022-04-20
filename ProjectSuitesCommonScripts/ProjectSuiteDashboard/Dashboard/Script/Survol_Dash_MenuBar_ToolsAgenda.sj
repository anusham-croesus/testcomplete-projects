//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints

 
/* Description :Aller au module "Tableau de bord" en cliquant sur BarModules-btnDashboard. 
 Afficher la fenêtre « Agenda » en cliquant sur MenuBar -Tools- btnAgenda. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements. Fermer la fenêtre en cliquant sur le btn Cancel */
function Survol_Dash_MenuBar_ToolsAgenda()
{
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  Get_MenuBar_Tools().OpenMenu();
  Get_MenuBar_Tools_Agenda().Click();

  //Check_WinAgenda_Properties(language)
    
  Get_WinAgenda_BtnCancel().Click();
  Close_Croesus_X();
}
