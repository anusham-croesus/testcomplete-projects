//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

 
/* Description : Aller au module "Comptes" en cliquant sur BarModules-btnAccounts. 
 Afficher la fenêtre « Agenda » avec Ctl+Shift+L. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Tâches, Activités échues, Anniversaires, Alarmes, Traitements. Fermer la fenêtre en cliquant sur X */
function Survol_Acc_Agenda_Ctrl_Maj_L()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_MainWindow().Keys("^L");
  
  Check_WinAgenda_Properties(language);

  Get_WinAgenda().Close();
  Get_MainWindow().SetFocus();
  Close_Croesus_AltQ();
}